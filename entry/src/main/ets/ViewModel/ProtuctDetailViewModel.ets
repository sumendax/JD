import { ProductDetailApi } from '../ApiService/ProductDetailApi'
import { Coupon, Delivery, ProductDetail, ProductComment, ProductItem, Spec } from '../model/ProductDetailModel'


@ObservedV2
export class ProductDetailViewModel{
  @Trace title:string=''
  @Trace bannerImages:string[]=[]
  @Trace specs:Spec[]=[]
  @Trace isShowSheet:boolean=false
  @Trace currentSpec:Spec|undefined=undefined
  @Trace coupons:Coupon[]=[]
  @Trace delivery:Delivery|undefined=undefined
  @Trace comments:ProductComment[]|undefined=undefined
  @Trace detail:ProductDetail|undefined=undefined
  @Trace price:number=0


  public async getProductDetail(){
    let productDetail:ProductItem[]=await ProductDetailApi.getProductDetail()
    this.title=productDetail[0].title
    this.bannerImages=productDetail[0].bannerImages
    this.specs=productDetail[0].specs
    this.currentSpec=this.specs[0]
    this.coupons=productDetail[0].coupons
    this.delivery=productDetail[0].delivery
    this.comments=productDetail[0].comments
    this.detail=productDetail[0].detail
    this.price=productDetail[0].price
  }
}
