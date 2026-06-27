@Entry
@ComponentV2
struct A1{
  @Local array:number[]=[1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0]
  @Local breakPoint:string=''

  gridColSpan(index:number):number|GridColColumnOption{
    if (index===0) {
      return{sm:2,md:4,lg:8,}
    }else if (index===1) {
      return 5
    }else {
      return 1
    }
  }

  build() {
    Column(){
      GridRow({//colums:设置固定列数
        columns:{
          xs:1,
          sm:3,
          md:5,
          lg:7,
        },gutter:5,//栅格间距
      }){
        ForEach(this.array,(item:number,index:number)=>{
          GridCol(){
            Text(`${item}`)
              .width('100%')
              .height(50)
              .textAlign(TextAlign.Center)
              .borderWidth(1)
          }
          .span(this.gridColSpan(index))//栅格占用列数
        })
      }
      .width('100%')
      .onBreakpointChange((breakpoint:string)=>{
        this.breakPoint=breakpoint
      })
    }
    .width('100%')
    .height('100%')

  }


}