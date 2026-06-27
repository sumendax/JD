// 优惠券信息
export interface Coupon {
  id: number;
  name: string;
  amount: number;
  condition: number;
}

// 商品规格（SKU）信息
export interface Spec {
  id: string;          // 注意：根据数据，这里的 id 是字符串类型
  name: string;
  price: number;
  originalPrice: number;
  stock: number;
  image: string;
}

// 物流配送信息
export interface Delivery {
  address: string;
  freight: number;
  desc: string;
}

// 用户评论信息
export interface ProductComment {
  id: number;
  userName: string;
  avatar: string;
  rate: number;
  content: string;
  spec: string;
  images: string[];
  createTime: string;  // 日期字符串，如 "2026-04-27"
}

// 商品详情（图文详情）
export interface ProductDetail {
  type: string;
  images: string[];
}

// 商品主体信息
export interface ProductItem {
  id: number;
  title: string;
  price:number
  bannerImages: string[];
  coupons: Coupon[];
  specs: Spec[];
  delivery: Delivery;
  comments: ProductComment[];
  detail: ProductDetail;
}
