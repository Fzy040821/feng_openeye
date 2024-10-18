import { CommonType } from '../model/typeAlias/TypeAlias'

export type StateCallback = (state: string) => void
/**
 * 定义回调函数类型
 */
export type ResultCallback<T> = (result: T) => void

export class BaseViewModel {

  /**
   * 发起网络请求
   * @returns
   */
  httpRequest<T>(requestPromise: Promise<T>): Promise<T> {
    return new Promise<T>((resolve , reject)=>{
      requestPromise.then((res)=>{
        resolve(res)
      }).catch((err: CommonType)=>{
        reject(err)
      })
    })
  }
}