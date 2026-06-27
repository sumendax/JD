import { categorypage } from './categorypage'
import { homepage } from './homepage'
import { mypage } from './mypage'
import { shoppingcarpage } from './shoppingcarpage'

@Entry
@ComponentV2
struct jd {
  @Provider() navPathStack:NavPathStack=new NavPathStack()
  @Local currentIndex:number=0//当前tabs对应的页面索引
  @Local tabsController:TabsController=new TabsController()
  @Provider() islogin:boolean=false
  build() {
    Column(){
      Navigation(this.navPathStack){
        Tabs({barPosition:BarPosition.End,index:$$this.currentIndex,controller:this.tabsController}){
          TabContent(){
            homepage({
              tabsController:this.tabsController
            })
          }.tabBar(this.tabBarBuilder(0,$r(`app.media.home_selected`),$r(`app.media.home_normal`)))

          TabContent(){
            categorypage({
              tabsController:this.tabsController
            })
          }.tabBar(this.tabBarBuilder(1,$r(`app.media.category_selected`),$r(`app.media.category_normal`)))

          TabContent(){
            shoppingcarpage()
          }.tabBar(this.tabBarBuilder(2,$r(`app.media.shoppingcar_selected`),$r(`app.media.shoppingcar_normal`)))

          TabContent(){
            mypage()
          }.tabBar(this.tabBarBuilder(3,$r(`app.media.me_selected`),$r(`app.media.me_normal`)))
        }
        .scrollable(false)
        .onTabBarClick((index:number)=>{
          if (index===3) {
            this.navPathStack.pushPath({name:'LoginPage',param:this.tabsController})
          }
        })
        .onContentWillChange((currentIndex:number,comingIndex:number)=>{
          if(comingIndex==3){
            if (!this.islogin) {
              return false
            }
          }
          return true
        })
      }
      .hideTitleBar(true)
      .hideToolBar(true)
    }
    .height('100%')
    .width('100%')
  }
  @Builder
  tabBarBuilder(index:number,selectedimg:ResourceStr,normalimg:ResourceStr){
    Column(){
      Image(this.currentIndex===index?selectedimg:normalimg)
    }
  }
}