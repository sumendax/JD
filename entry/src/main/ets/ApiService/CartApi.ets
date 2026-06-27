import { CartModel } from '../model/ShoppingCarModel'
import { HttpClient } from '../utils/HttpClient'

export class CartApi{
  //获取购物车的所有数据
  static async getCarts():Promise<CartModel[]>{
    return await HttpClient.get<CartModel[]>('/cart')
  }

  static async addCart(cartItem:CartModel):Promise<CartModel>{
    return await HttpClient.post<CartModel>('/cart',cartItem)
  }
}