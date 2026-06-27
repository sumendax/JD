//专门用于发起网络请求的工具类
import { http } from '@kit.NetworkKit'
import { JSON } from '@kit.ArkTS'

type HttpHeader=Record<string,string>

export class HttpClient{
  //基础的URl地址
  private static BASE_URL='http://10.0.2.2:3000'
  //通过用的请求方法
  private static request<R>(
    uri:string,//请求的资源
    method:http.RequestMethod=http.RequestMethod.GET,//请求方式（默认get）
    data?:Object,//请求体
    headers?:HttpHeader,//请求头
  ){
    //创建请求对象
    let httpRequest=http.createHttp()
    //发起请求
    return httpRequest.request(`${HttpClient.BASE_URL}${uri}`,{
      method:method,
      extraData:data===undefined?undefined:JSON.stringify(data),
      header:HttpClient.buildHeaders(headers),
      readTimeout:10000,//请求超时时间
      connectTimeout:10000,//连接超时时间
    }).then((res:http.HttpResponse)=>{
      //获取状态码
      let responseCode=res.responseCode
      if (responseCode>=200 && responseCode<300) {
        //获取响应体
        let result=res.result
        if (result!==undefined) {
          return JSON.parse(result as string) as R//把JSON字符串转换为对象（默认为object|null对象）
        }else {
          return undefined as R
        }
      }else {
        throw Error('网络请求失败：'+responseCode)
      }
    })
  }

//构建默认请求头，同时将用户传递的请求头和默认请求头合并
  private static buildHeaders(headers?:HttpHeader):HttpHeader{
    //默认请求头
    let  result:HttpHeader={
      'Content-Type':'application/json'
    }
    //判断请求头是否为空
    if (headers===undefined){
      return result
    }
    //遍历调用者传递来的请求头，和result默认请求头合并
    let keys=Object.keys(headers)
    keys.forEach((key:string)=>{
      result[key]=headers[key]
    })
    return result
  }
//发送get请求（便捷快速请求）
  public static get<R>(url:string,headers?:HttpHeader):Promise<R>{
    return HttpClient.request<R>(url,http.RequestMethod.GET,undefined,headers)
  }
//发送post请求（便捷快速请求）
  public static post<R>(url:string,data?:Object,headers?:HttpHeader):Promise<R>{
    return HttpClient.request<R>(url,http.RequestMethod.POST,data,headers)
  }
//发送put请求（便捷快速请求）
  public static put<R>(url:string,data?:Object,headers?:HttpHeader):Promise<R>{
    return HttpClient.request<R>(url,http.RequestMethod.PUT,data,headers)
  }
//发送delete请求（便捷快速请求）
  public static delete<R>(url:string,data?:Object,headers?:HttpHeader):Promise<R>{
    return HttpClient.request<R>(url,http.RequestMethod.DELETE,data,headers)
  }
}