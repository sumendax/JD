
import { Menus,RecommendGoods, SeckillGoods } from "../model/HomeModel"
import { HomeViewModel } from "../ViewModel/HomeViewModel"


@ComponentV2
export struct homepage{
  @Consumer() navPathstack:NavPathStack|undefined=undefined
  @Param tabsController:TabsController|undefined=undefined
  @Local homeViewModel:HomeViewModel=new HomeViewModel()

  async aboutToAppear(){
    this.homeViewModel.loadHomeData()
  }

  build() {
    Column(){
      Row({space:10}){
        Image($r(`app.media.top_category`))
          .height(30)
          .width(30)
          .onClick((event:ClickEvent)=>{
            this.tabsController?.changeIndex(1)
          })
        Search({
          icon:'image/search_icon.png',
          placeholder:'香奈儿香水'
        })
          .height(37)
          .backgroundColor(Color.White)
          .layoutWeight(1)
        Image($r(`app.media.top_me1`))
          .height(35)
          .width(35)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#ffff1b18')
      .padding({left:10,right:10})
      Scroll(){
        Column(){
          Row(){
            Row(){
              Swiper(){
                ForEach(this.homeViewModel.menus,(array:Menus[])=>{
                  Row(){
                    ForEach(array,(item:Menus)=>{
                      Column(){
                        Image(item.icon)
                          .width(45)
                          .height(45)
                        Text(item.name)
                          .fontSize(14)
                      }
                    })
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceEvenly)
                })
              }
              .loop(true)
              .autoPlay(false)
              .itemSpace(5)
              .width('100%')
              .height('100%')
              .indicator(
                Indicator.dot()
                  .selectedItemWidth(20)
                  .selectedColor('#ffff1b18')
                  .itemWidth(15)
              )
            }
            .width('95%')
            .height(100)
            .backgroundColor(Color.White)
            .borderRadius(10)
          }
          .width('100%')
          .height(145)
          .justifyContent(FlexAlign.Center)
          .linearGradient({
            colors:[['#ffff1b18',0.3],['#f6f6f6',0.8]],
            direction:GradientDirection.Bottom
          })
          .backgroundColor('#F6F6F6')


          Row({space:10}){
            Column({space:5}){
              Image($r(`app.media.seckill`))
                .width(90)
              Text('限时低价')
                .fontColor(Color.White)
                .fontWeight(FontWeight.Medium)
              Row(){
                Text('去抢购')
                  .fontSize(12)
                  .fontColor(Color.Red)
                Image($r(`app.media.arrow`))
                  .width(8)
              }
              .backgroundColor(Color.White)
              .padding(5)
              .borderRadius(15)

            }
            .alignItems(HorizontalAlign.Start)


            Row(){
              Scroll(){
                Row({space:5}){
                  ForEach(this.homeViewModel.secKillGoods,(item:SeckillGoods)=>{
                    Column({space:3}){
                      Image(item.image)
                        .borderRadius(5)
                        .width(78)
                        .height(78)
                      Text(`¥${item.price}`)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(Color.Red)
                        .fontSize(16)
                    }
                    .margin({left:10})
                  })
                }
                .height('100%')
                .borderRadius(10)
                .backgroundColor(Color.White)
              }
              .borderRadius(10)
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .borderRadius(10)
            .height('100%')
            .layoutWeight(1)
          }
          .margin({top:5})
          .padding({left:10,top:2,bottom:2,right:2})
          .width('95%')
          .height(120)
          .backgroundColor('#EC5532')
          .borderRadius(10)

          WaterFlow(){
            LazyForEach(this.homeViewModel.datasource,(item:RecommendGoods)=>{
              FlowItem(){
                Column(){
                  Image(item.image)
                    .width('100%')
                    .height(175)
                    .borderRadius({topLeft:10,topRight:10})
                    .objectFit(ImageFit.Contain)

                  Column(){
                    Stack({alignContent:Alignment.TopStart}){
                      if (item.tags.includes('自营')) {
                        Image($r(`app.media.jdzy`))
                          .width(30)
                          .height(15)
                      }
                      Text(item.tags.includes('自营')?'        '+item.title:item.title)
                        .maxLines(2)
                        .textOverflow({overflow:TextOverflow.Ellipsis})
                    }
                    Text('¥'+item.price)
                      .fontColor(Color.Red)
                      .fontSize(22)
                      .fontWeight(FontWeight.Bold)
                    if (item.tags.includes('官方直降15%')) {
                      Text('官方直降15%')
                        .fontColor(Color.Green)
                    }
                    Row(){
                      Text(item.comments_count)
                        .fontSize(14)
                      Text('看相似')
                        .textAlign(TextAlign.Center)
                        .width(42)
                        .height(20)
                        .borderRadius(5)
                        .fontSize(12)
                        .backgroundColor('#f2f2f2')
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.SpaceBetween)
                  }
                  .width('100%')
                  .padding(10)
                  .alignItems(HorizontalAlign.Start)
                }
                .borderRadius(10)
                .backgroundColor(Color.White)
                .alignItems(HorizontalAlign.Start)
              }
              .onClick(()=>{
                this.navPathstack?.pushPath({
                  name:'ProductDetail',
                  param:this.tabsController
                })
              })
            },(item:RecommendGoods)=>item.id+'')
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(10)
          .columnsGap(10)
          .padding(10)
        }
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f6f6f6')
  }
}