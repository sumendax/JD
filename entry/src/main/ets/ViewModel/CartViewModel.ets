import { CartApi } from '../ApiService/CartApi'
import { CartModel } from '../model/ShoppingCarModel'

@ObservedV2
export class CartViewModel{
  @Trace carts:CartModel[]=[]
  async getCarts(){
   this.carts = await CartApi.getCarts()
  }
  async addCart(cartItem:CartModel){
    await CartApi.addCart(cartItem)
  }
}