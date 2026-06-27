
import { Category, CategoryItem, RightSection } from "../model/CategoryModel"
import { CategoryViewModel } from "../ViewModel/CategoryViewmodel"


@ComponentV2
export struct categorypage{
  @Local categorys:Category[]=[]
  rightListScroler:ListScroller=new ListScroller()
  @Param tabsController:TabsController|undefined=undefined
  @Local categoryViewModel:CategoryViewModel=new CategoryViewModel()

  async aboutToAppear(): Promise<void> {
    await this.categoryViewModel.getCategorys()
  }

  build() {
    Column(){
      Row({space:10}){
        Image($r(`app.media.topbackleft`))
          .width(25)
          .height(25)
          .onClick((event:ClickEvent)=>{
            this.tabsController?.changeIndex(0)
          })
        Search({placeholder:'奥克斯空调'})
          .layoutWeight(1)
          .height(35)
      }
      .padding({left:10,right:10})

      Divider()

      Row(){
        List(){
          ForEach(this.categoryViewModel.categorys,(item:Category,index:number)=>{
            ListItem(){
              Text(item.title)
                .width('100%')
                .height(50)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
                .backgroundColor(this.categoryViewModel.currentIndex===index?'#ffffff':'#f8f8f8')
                .onClick(()=>{
                  this.categoryViewModel.currentIndex=index
                  let sectionIndex=this.categoryViewModel.rightSections.findIndex((section:RightSection)=>{
                    return section.parentIndex==this.categoryViewModel.currentIndex
                  })
                  this.rightListScroler.scrollToIndex(sectionIndex,true)
                })
            }
          })
        }
        .width(100)
        .height('100%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Fade)
        List({space:15,scroller:this.rightListScroler}){
          ForEach(this.categoryViewModel.rightSections,(rightSection:RightSection)=>{
            ListItem(){
              Column(){
                Text(rightSection.title)
                  .width('100%')
                  .fontSize(23)
                  .fontWeight(FontWeight.Bold)
                  .margin({left:30,right:10,bottom:10})
                Grid(){
                  ForEach(rightSection.items,(categoryItem:CategoryItem)=>{
                    GridItem(){
                      Column(){
                        Image(categoryItem.image)
                          .width(60)
                          .height(60)
                        Text(categoryItem.title)
                          .fontSize(15)
                          .fontWeight(FontWeight.Medium)
                          .margin({top:5})
                      }
                    }
                  })
                }
                .columnsTemplate('1fr 1fr 1fr')
                .rowsGap(15)
                .columnsGap(15)
              }
              .margin({top:10})
            }
          })
        }
        .height('100%')
        .layoutWeight(1)
        .onScrollIndex((startIndex:number,endIndex:number)=>{
          let section:RightSection=this.categoryViewModel.rightSections[startIndex]
          if (section.parentId!==this.categoryViewModel.categorys[this.categoryViewModel.currentIndex].id) {
            this.categoryViewModel.currentIndex=section.parentIndex
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .height('100%')
    .width('100%')
  }
}