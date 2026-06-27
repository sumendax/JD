// 联系人数据源类
// 目的：让数据源类支持所有类型，而不仅仅是联系人
// 设：<T> 为数据类型
export class GenericDataSource<T> implements IDataSource {
  // 联系人数组
  private items: T[] = []
  // 数据变化监听器
  private listeners: DataChangeListener[] = []

  constructor(...items: T[]) {
    this.items = items
  }

  // 把数据源转化为数组
  toArray(): T[] {
    return this.items
  }

  // 获取数据总数
  totalCount(): number {
    return this.items.length
  }

  // 获取指定索引位置的数据
  getData(index: number): T {
    return this.items[index]
  }

  // 往数组末尾添加数据
  append(...data: T[]) {
    // 计算添加的位置
    let startIndex = this.items.length
    this.items.push(...data)
    // 通知LazyForEach在我现在在列表的末尾添加了一个元素，你更新一下
    this.notifyDataAdd(startIndex)
  }

  // 往数组指定索引位置添加元素
  insert(index: number, data: T) {
    // 插入一条数据：从index位置开始，删除0个，再往这个位置添加data
    this.items.splice(index, 0, data)
    this.notifyDataAdd(index)
  }

  // 通知LazyForEach添加数据了，更新列表
  private notifyDataAdd(startIndex: number) {
    this.listeners.forEach(listener => {
      listener.onDataAdd(startIndex)
    })
  }

  // 交换两个索引位置的元素
  swap(from: number, to: number) {
    let temp = this.items[from]
    this.items[from] = this.items[to]
    this.items[to] = temp
    this.notifyDataMove(from, to)
  }

  // 通知LazyForEach两个位置元素交换了，更新列表
  private notifyDataMove(from: number, to: number) {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to)
    })
  }

  // 修改指定索引位置的元素
  update(index: number, data: T) {
    this.items.splice(index, 1, data)
    this.notifyDataChange(index)
  }

  // 通知指定索引位置的元素更新了，更新列表
  private notifyDataChange(index: number) {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }

  // 更新：把数组中的元素转化为另一种元素
  // predicate：箭头函数（转换的依据）
  updataAll(callbackfn: (value: T, index: number, array: T[]) => T) {
    // 修改this.items数组中元素，依据：把所有联系人姓名前面加😊
    // map: 把数组中的元素按照依据进行转化
    this.items = this.items.map(callbackfn)
    this.notifyDataReload() //通知列表重新加载
  }

  // 通知列表重写加载
  private notifyDataReload() {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  // 通过指定索引删除数据
  remove(index: number) {
    this.items.splice(index, 1)
    this.notifyDataDelete(index)
  }

  // 通知删除指定位置元素完成，更新列表
  private notifyDataDelete(index: number) {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })
  }

  // 删除满足条件的元素
  removeIf(predicate: (value: T, index: number, array: T[]) => boolean) {
    // 过滤：对每一个元素进行条件判断，把返回为true的元素留下，把返回值为false的元素删除。
    // 条件：把数组中姓名长度为2的留下，其他的删除
    // this.items = this.items.filter((item: Contact, index: number, array: Contact[])=>{
    //   return item.name.length === 2 //true或者false
    // })

    this.items = this.items.filter((value: T, index: number, array: T[]) => !predicate(value, index, array))
    this.notifyDataReload()
  }

  // LazyForEach创建时，会自动创建一个DataChangeListener传递给listener参数
  // 在这里把listener保存到数组中
  registerDataChangeListener(listener: DataChangeListener): void {
    // 判断listener在listeners中是否存在，如果存在返回索引，如果不存在返回-1
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  // LazyForEachx 销毁时执行
  unregisterDataChangeListener(listener: DataChangeListener): void {
    // 从listeners数组中获取listener的索引，如果存在返回具体索引，不存在返回-1
    let index = this.listeners.indexOf(listener)
    if (index >= 0) {
      this.listeners.splice(index, 1)
    }
  }
}

