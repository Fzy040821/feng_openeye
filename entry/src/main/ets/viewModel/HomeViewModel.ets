import { getHomeListAxios, getHomeListAxios1 } from '../http/ApiService';
import axiosClient from '../http/AxiosRequest';
import { HomeModel, HomeModelIssueListItemList } from '../model/HomeModel';
import { BaseViewModel, ResultCallback } from './BaseViewModel';

export class HomeViewModel extends BaseViewModel{
  private date: string = ''
  revertDate() {
    this.date = ""
  }

  getDate() {
    return this.date
  }

  /**
   * 获取首页列表数据-axios客户端请求
   * @param stateCallback  状态返回
   * @param resultCallback  结果返回
   */
  async getHomeList(resultCallback?: ResultCallback<HomeModelIssueListItemList[]>) {
    await this.httpRequest()
      .promise(getHomeListAxios(this.date), this.date == "" ?true : false)
      .then(result => {
        let items = result.issueList[0].itemList
        let list = items.filter((item) => item.type == "video")
        if (this.date == "") {
          let bannerList: HomeModelIssueListItemList[]
          let bannerBean: HomeModelIssueListItemList = {}
          bannerList = items.filter((item) => item.type == "banner2")
          if (bannerList.length > 0) {
            bannerBean = { bannerList: bannerList, type: "banner" }
            list.unshift(bannerBean)
          }
        }
        resultCallback?.(list)
        //分页
        //this.spliteDate(result.nextPageUrl)
      })
  }

  async getHomeList1(resultCallback?: ResultCallback<HomeModelIssueListItemList[]>) {
    await this.httpRequest()
      .promise(getHomeListAxios1(this.date), this.date == "" ?true : false)
      .then(result => {
        let items = result.issueList[0].itemList
        let list = items.filter((item) => item.type == "video")
        if (this.date == "") {
          let bannerList: HomeModelIssueListItemList[]
          let bannerBean: HomeModelIssueListItemList = {}
          bannerList = items.filter((item) => item.type == "banner2")
          if (bannerList.length > 0) {
            bannerBean = { bannerList: bannerList, type: "banner" }
            list.unshift(bannerBean)
          }
        }
        resultCallback?.(list)
        //分页
        //this.spliteDate(result.nextPageUrl)
      })
  }
}
let homeViewModel = new HomeViewModel()

export default homeViewModel as HomeViewModel