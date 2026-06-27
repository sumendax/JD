import { CategoryApi } from '../ApiService/CategoryApi'
import { Category, CategoryGroup, RightSection } from '../model/CategoryModel'

@ObservedV2
export class CategoryViewModel{
  @Trace categorys:Category[]=[]
  @Trace categoryGroups:CategoryGroup[]=[]
  @Trace currentIndex:number=0
  @Trace rightSections:RightSection[]=[]

  async getCategorys(){
    let categorys=await CategoryApi.getCategory()
    this.categorys=categorys
    this.categorys.forEach((catgory:Category,index:number)=>{
      catgory.children.forEach((categoryGroup:CategoryGroup)=>{
        this.rightSections.push({
          id:categoryGroup.id,
          parentId:categoryGroup.parentId,
          parentIndex:index,
          title:categoryGroup.title,
          items:categoryGroup.items,
        })
      })
    })
  }
}