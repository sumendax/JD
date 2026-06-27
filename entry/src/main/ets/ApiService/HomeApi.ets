

import { Menus, RecommendGoods, SeckillGoods } from "../model/HomeModel"
import { HttpClient } from "../utils/HttpClient"


export class HomeApi{
  //网络请求获取推荐商品
  public static async getRecommendGoods() {
    return await HttpClient.get<RecommendGoods[]>('/recommendGoods')
  }
  //网络请求获取秒杀商品
  public static async getSecKillGoods() {
    return await HttpClient.get<SeckillGoods[]>("/seckillGoods")
  }
  //网络请求获取菜单数据
  public static async getMenus():Promise<Menus[][]>{
    let array=await HttpClient.get<Menus[]>("/menus")
    return HomeApi.splitArray(array)
  }

  public static splitArray(array: Menus[]):Menus[][] {
    let menus:Menus[][]=[]
    let rowIndex: number = -1
    let colIndex: number = 0
    for (let i = 0; i < array.length; i++) {
      if (i % 5 == 0) {
        let row: Menus[] = []
        menus.push(row)
        rowIndex++
        colIndex = 0
      }
      menus[rowIndex][colIndex] = array[i]
      colIndex++
    }
    return menus
  }
}