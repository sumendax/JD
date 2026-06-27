import { CartModel } from "../model/ShoppingCarModel"
import { CartViewModel } from "../ViewModel/CartViewModel"

@ComponentV2
export struct shoppingcarpage{
  @Local cartViewModel:CartViewModel=new CartViewModel()

  aboutToAppear(): void {
    this.cartViewModel.getCarts()
  }

  build() {
    Column(){
      List(){
        ForEach(this.cartViewModel.carts,(cartItem:CartModel)=>{
          ListItem(){
            Row({space:10}){
              Image(cartItem.image)
                .width(100)
                .height(100)
              Column({space:5}){
                Text(cartItem.name)
                Text('数量:'+cartItem.quantity)
                Text('¥'+cartItem.price)
                  .fontColor(Color.Red)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
              }
              .height('100%')
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.Center)
            }
            .height(120)
            .width('100%')
            .padding(10)
            .backgroundColor(Color.White)
            .margin(10)
            .borderRadius(15)
          }
        })
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f6f6f6')
  }
}