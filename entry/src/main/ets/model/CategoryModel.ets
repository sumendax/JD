
export interface Category{
  id:string
  title:string
  children:CategoryGroup[]
}
export interface CategoryGroup{
  id:string
  parentId:string
  title:string
  items:CategoryItem[]
}
export interface CategoryItem{
  id:string
  parentId:string
  title:string
  image:string
}
export interface RightSection{
  id:string
  parentId:string
  parentIndex:number
  title:string
  items:CategoryItem[]
}