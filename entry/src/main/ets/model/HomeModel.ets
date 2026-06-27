
export interface Menus{
  id:number
  name:string
  icon:string
}
export interface SeckillGoods{
  id:number
  image:string
  price:number
}
export interface RecommendGoods{
  id:number
  title:string
  image:string
  price:string
  original_price:string
  comments_count:string
  positive_rate:string
  tags:string[]
}