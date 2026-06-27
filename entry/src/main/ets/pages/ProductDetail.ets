import { Coupon, ProductComment, Spec } from "../model/ProductDetailModel"
import { ProductDetailViewModel } from "../ViewModel/ProtuctDetailViewModel"
import { LengthMetrics } from "@kit.ArkUI"
import { CartViewModel } from "../ViewModel/CartViewModel"

@Builder
export function ProductDetailBuilder(){
  ProductDetail()
}

@ComponentV2
struct ProductDetail{
  @Consumer() navPathStack:NavPathStack|undefined=undefined
  @Local productDetailViewModel: ProductDetailViewModel = new ProductDetailViewModel()
  @Local cartViewModel:CartViewModel=new CartViewModel()
  @Local currentIndex:number=0
  @Local alpha:number=0 //顶部标签栏的透明度
  @Local isShowBackShadow:boolean=true
  private scroller:Scroller=new Scroller()
  private tabsController:TabsController|undefined=undefined

  aboutToAppear(): void {
    this.productDetailViewModel.getProductDetail()
    this.cartViewModel.getCarts()
  }

  build() {
    NavDestination(){
      Stack({alignContent:Alignment.Top}){
        Row(){
          Image($r(`app.media.topbackleft`))
            .fillColor(Color.Black)
            .width(25)
            .height(25)
            .onClick(()=>{
              this.navPathStack?.pop()
            })

          this.TopTabBar(0,'商品')
          this.TopTabBar(1,'评论')
          this.TopTabBar(2,'详情')

          Image($r(`app.media.threepoint`))
            .fillColor(Color.Black)
            .width(25)
            .height(25)
        }
        .backgroundColor(Color.White)
        .zIndex(10)
        .width('100%')
        .height(50)
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .opacity(this.alpha)

        List({scroller:this.scroller}){
          ListItem(){
            Column(){
              Column({space:15}){
                Swiper(){
                  ForEach(this.productDetailViewModel.bannerImages,(item:string)=>{
                    Image(item)
                      .width('100%')
                      .objectFit(ImageFit.Contain)
                  })
                }
                .indicator(false)

                Text(this.productDetailViewModel.title)
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
                  .padding({left:10,right:10})
              }
              .backgroundColor(Color.White)
              .width('100%')
              .padding(10)
              .borderRadius(10)

              Column({space:15}){
                Row({space:10}){
                  Text('优惠')
                    .fontSize(15)
                    .fontWeight(FontWeight.Bold)
                  ForEach(this.productDetailViewModel.coupons,(coupon:Coupon)=>{
                    Text(coupon.name)
                      .fontWeight(FontWeight.Lighter)
                      .fontSize(10)
                      .fontColor(Color.Red)
                      .borderColor(Color.Red)
                      .borderWidth(1)
                      .borderRadius(4)
                      .padding({left:10,right:10,top:5,bottom:5})
                  })

                  Blank()

                  Image($r(`app.media.threepoint`))
                    .width(20)
                    .height(20)
                }
                .width('100%')

                Divider()
                  .margin(50)

                Row({space:10}){
                  Text('白条')
                    .fontSize(15)
                    .fontWeight(FontWeight.Bold)
                  Text('京东白条，先用后付')
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)

                  Blank()

                  Image($r(`app.media.threepoint`))
                    .width(20)
                    .height(20)
                }
                .width('100%')
                .padding(10)
              }
              .borderRadius(10)
              .margin({top:10})
              .backgroundColor(Color.White)
              .padding(10)

              Column({space:15}){
                Row({space:10}){
                  Text('已选')
                    .fontSize(15)
                    .fontWeight(FontWeight.Bold)
                  Text(this.productDetailViewModel.currentSpec?.name)
                    .fontSize(15)
                    .fontWeight(FontWeight.Bold)
                  Blank()
                  Image($r(`app.media.threepoint`))
                    .width(10)
                    .height(20)
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
                .padding({left:10,right:10})
                .bindSheet(this.productDetailViewModel.isShowSheet,this.BindSheet(),{
                  showClose:true,
                  dragBar:true,
                  height:'70%',
                  onWillDismiss:()=>{
                    this.productDetailViewModel.isShowSheet=false
                  }
                })
                .onClick(()=>{
                  this.productDetailViewModel.isShowSheet=true
                })

                Divider()
                  .margin(50)

                Row({space:10}){
                  Text('送至')
                    .fontSize(15)
                    .fontWeight(FontWeight.Bold)
                  Column(){
                    Text(this.productDetailViewModel.delivery?.address)
                      .fontSize(15)
                      .fontWeight(FontWeight.Medium)
                    Text(this.productDetailViewModel.delivery?.desc)
                      .fontSize(12)
                      .fontColor(Color.Gray)
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Image($r(`app.media.threepoint`))
                    .width(10)
                    .height(20)
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
                .padding({left:10,right:10})

                Divider()
                  .margin(50)

                Row({space:10}){
                  Text('运费')
                    .fontSize(15)
                    .fontWeight(FontWeight.Bold)
                  Text('包邮')
                    .fontSize(15)

                  Blank()

                  Image($r(`app.media.threepoint`))
                    .width(10)
                    .height(20)
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
                .padding({left:10,right:10})

              }
              .margin({top:10})
              .backgroundColor(Color.White)
              .padding(10)
              .borderRadius(10)
            }

          }
          ListItem(){
            Column(){
              ForEach(this.productDetailViewModel.comments,(comment:ProductComment)=>{
                Column({space:10}){
                  Row({space:10}){
                    Image(comment.avatar)
                      .width(20)
                      .height(20)
                      .borderRadius(5)
                    Text(comment.userName)
                    Rating({
                      indicator:true,
                      rating:comment.rate,
                    })
                      .stars(5)
                      .stepSize(1)

                    Blank()

                    Text(comment.createTime)
                      .fontSize(12)
                      .fontColor(Color.Gray)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)

                  Text(comment.content)
                  Row(){
                    ForEach(comment.images,(img:string)=>{
                      Image(img)
                        .width(50)
                        .height(50)
                        .borderRadius(10)
                    })
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)

                  Divider()
                    .margin(50)

                }
                .width('100%')
                .padding(10)
              })
            }
          }
          ListItem(){
            Column(){
              ForEach(this.productDetailViewModel.detail?.images,(img:string)=>{
                Image(img)
                  .width('100%')
                  .objectFit(ImageFit.Contain)
              })
            }
          }
        }
        .width('100%')
        .onScrollIndex((start:number,end:number)=>{
          if (start===0) {
            this.currentIndex=0
          }else if (start===1) {
            this.currentIndex=1
          }else if (start===2) {
            this.currentIndex=2
          }
        })
        .onDidScroll((offset:number,state:ScrollState)=>{
          let currentOffset=this.scroller.currentOffset().yOffset+offset
          this.alpha=currentOffset/100
        })
      }

    }
    .backgroundColor('#f7f7f7')
    .hideTitleBar(true)
    .hideBackButton(true)
    .toolbarConfiguration(this.BottomToolBar())
    .onReady((ctx:NavDestinationContext)=>{
      this.tabsController=ctx.pathInfo.param as TabsController
    })
  }

  @Builder
  BottomToolBar(){
    Row(){
      Column(){
        Image($r(`app.media.dianpu`))
          .width(25)
          .height(25)
        Text('店铺')
          .fontSize(12)
      }
      Column(){
        Image($r(`app.media.kefu`))
          .width(25)
          .height(25)
        Text('客服')
          .fontSize(12)
      }
      Column(){
        Badge({
          count:this.cartViewModel.carts.length,
          style:{color:Color.Red},
          position:BadgePosition.RightTop,
        }){
          Image($r(`app.media.gouwuche`))
            .width(25)
            .height(25)
            .onClick(()=>{
              this.navPathStack?.pop()
              this.tabsController?.changeIndex(2)
            })
        }
        Text('购物车')
          .fontSize(12)
      }
      Button('加入购物车')
        .backgroundColor('#df3926')
        .fontColor(Color.White)
        .onClick(()=>{
          this.cartViewModel.addCart({
            name:this.productDetailViewModel.title,
            price:this.productDetailViewModel.price,
            quantity:2,
            image:this.productDetailViewModel.bannerImages[0]
          })
          this.cartViewModel.getCarts()
        })
      Button('立即购买')
        .backgroundColor('#f5bf44')
        .fontColor(Color.White)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  TopTabBar(index:number,text:string) {
    Column() {
      Text(text)
        .width('100%')
        .textAlign(TextAlign.Center)
      Divider()
        .strokeWidth(5)
        .color(Color.Transparent)
        .linearGradient(this.currentIndex===index?{
          colors: [['#ff0000', 0], ['#ffffff', 1]],
          direction: GradientDirection.Right,
        }:undefined)
    }
    .width(35)
    .onClick(()=>{
      this.currentIndex=index
      if (this.currentIndex===0) {
        this.scroller.scrollToIndex(0,true)
      }else if (this.currentIndex===1) {
        this.scroller.scrollToIndex(1,true)
      }else if (this.currentIndex===2) {
        this.scroller.scrollToIndex(2,true)
      }
    })
  }

  @Builder
  BindSheet(){
    Column(){
      Row(){
        Image(this.productDetailViewModel.currentSpec?.image)
          .width(100)
          .height(100)
          .borderRadius(10)
        Text(this.productDetailViewModel.currentSpec?.price+'')
          .fontSize(30)
          .fontColor(Color.Red)
          .fontWeight(FontWeight.Bolder)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      Text('已选规格:'+this.productDetailViewModel.currentSpec?.name)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
      Flex({
        direction:FlexDirection.Row,
        wrap:FlexWrap.Wrap,
        space:{
          main:LengthMetrics.vp(10),
          cross:LengthMetrics.vp(10),
        },
      })
      {
        ForEach(this.productDetailViewModel.specs,(spec:Spec)=>{
          Text(spec.name)
            .backgroundColor('#dedede')
            .padding(10)
            .borderRadius(15)
            .onClick(()=>{
              this.productDetailViewModel.currentSpec=spec
            })
        })
      }
    }
  }
}