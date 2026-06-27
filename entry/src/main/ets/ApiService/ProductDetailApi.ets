import { ProductItem } from '../model/ProductDetailModel'
import { HttpClient } from '../utils/HttpClient'


export class ProductDetailApi{
  static async getProductDetail():Promise<ProductItem[]>{
    return await HttpClient.get<ProductItem[]>('/products_detail')
  }
}