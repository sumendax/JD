import { Category } from '../model/CategoryModel';
import { HttpClient } from '../utils/HttpClient';


export class CategoryApi{
  static async getCategory():Promise<Category[]>{
    return await HttpClient.get<Category[]>('/category_tree')
  }
}