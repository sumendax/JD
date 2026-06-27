import { HomeApi } from '../ApiService/HomeApi'
import { GenericDataSource } from '../comment/GenericDataSource'
import { Menus, RecommendGoods, SeckillGoods } from '../model/HomeModel'


//home页面中和ui相关数据和数据处理逻辑
@ObservedV2
 export class HomeViewModel{
  @Trace menus:Menus[][]=[]
  @Trace secKillGoods:SeckillGoods[]=[]
  @Trace recommendGoods:RecommendGoods[]=[]
  @Trace datasource:GenericDataSource<RecommendGoods>=new GenericDataSource<RecommendGoods>()

  async loadHomeData(){
    this.getMenus()
    this.getSeckillGoods()
    this.getRecommendGoods()
  }
  async getMenus(){
    this.menus=await HomeApi.getMenus()

  }
  async getSeckillGoods(){
    this.secKillGoods=await HomeApi.getSecKillGoods()

  }
  async getRecommendGoods(){
    this.recommendGoods=await HomeApi.getRecommendGoods()
    this.datasource.append(...this.recommendGoods)
  }
}

