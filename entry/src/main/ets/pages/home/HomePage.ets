import axios, { AxiosError, AxiosHeaders, AxiosResponse } from '@ohos/axios';
import { ViewStateConstant } from '../../Const/ViewStateConstant';
import { HomeModelIssueListItemList } from '../../model/HomeModel';
import { RoutePath } from '../../route/RoutePath';
import { Router } from '../../route/Router';
import { CategoryRouteParams } from '../../route/RouterParams';
import HomeViewModel from '../../viewModel/HomeViewModel';
import { CommonTopBar } from '../../views/CommonTopBar';
import { StateComponent } from '../../views/StateComponent';
import { HomeListItemComponent } from './component/HomeListItemComponent';

let baseUrl = 'http://10.161.9.80:7012/'
const commonHeader: AxiosHeaders = new AxiosHeaders()
@Entry
@Component
export struct HomePage {
  @State viewState: string = ViewStateConstant.VIEW_STATE_LOADING
  @State isRefreshing: boolean = false
  @State dataList: HomeModelIssueListItemList[] = []
  @State showLoading: boolean = false

  aboutToAppear(): void {
    HomeViewModel.observeState(state=>{
      this.viewState = state
    })
   this.load()
  }
  load(){
    HomeViewModel.getHomeList(
      (result) => {
        this.isRefreshing = false
        if (HomeViewModel.getDate() == "") {
          this.dataList = result
          console.log('12')
        } else {
          this.dataList = [...this.dataList, ...result]
        }
      })
  }

  test(){
    /* axiosClient.get<HomeModel>({
     url: baseUrl + 'api/v2/feed',
     params: {'page':1},
     showLoading:true,
     headers: commonHeader
   }).then((res)=>{
     console.info('res'+JSON.stringify(res))
   })*/


    /*getHomeListAxios(page: number = 1){
      let instance = axios.create({
        baseURL:'http://10.161.9.80:7012',
        timeout:5000,
        headers:{
          'content-type':'application/json;charset=UTF-8 '
        }
      })
    }

    loadNet(){
      //网络请求
      *//*axios<string, AxiosResponse<string>, null>({
        method: "get",
        url: 'http://10.161.9.80:7012/goods/info?category_id=0&currentPage=1&pageSize=10'
      }).then((res: AxiosResponse) => {
        console.info('result:' + JSON.stringify(res.data));
      }).catch((error: AxiosError) => {
        console.error(error.message);
      })*//*

      let instance = axios.create({
        baseURL: 'https://baobab.kaiyanapp.com/',
        timeout: 1000,
      })
      instance.get("api/v2/feed")
        .then((response:AxiosResponse)=>{
          console.log("tatata",JSON.stringify(response.data))
        }).catch((response:AxiosError)=>{
        console.log("tatata",response.message+"")
      })
    }*/
  }



  build() {
   Column(){
     CommonTopBar({title:'首页' , backButton:false , alpha:1}).align(Alignment.TopStart).height(80)

     Stack(){
      StateComponent({
        viewState:this.viewState,
        showSkeleton:true,
        retryCallback:()=>{
          //this.loadNet()
        }
      }){
        Refresh({refreshing: this.isRefreshing , offset:100 , friction:100}){
          List(){
            ForEach(this.dataList , (item: HomeModelIssueListItemList , index: number)=>{
              ListItem(){
                HomeListItemComponent({item: item}).onClick(()=>{
                  Router.push(RoutePath.MainPage , {
                    'id':item.data?.id,
                    'playUrl': item.data?.playUrl
                  } as CategoryRouteParams)
                })
              }
            })
          }

        }
      }
     }.layoutWeight(1)
   }

  }
}