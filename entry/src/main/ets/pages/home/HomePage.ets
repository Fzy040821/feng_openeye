import axios, { AxiosError, AxiosResponse } from '@ohos/axios';
import { ViewStateConstant } from '../../Const/ViewStateConstant';
import { HomeModelIssueListItemList } from '../../model/HomeModel';
import { RoutePath } from '../../route/RoutePath';
import { Router } from '../../route/Router';
import { CategoryRouteParams } from '../../route/RouterParams';
import { CommonTopBar } from '../../views/CommonTopBar';
import { StateComponent } from '../../views/StateComponent';
import { HomeListItemComponent } from './component/HomeListItemComponent';

@Entry
@Component
export struct HomePage {
  @State viewState: string = ViewStateConstant.VIEW_STATE_LOADING
  @State isRefreshing: boolean = false
  @State dataList: HomeModelIssueListItemList[] = []
  @State showLoading: boolean = false

  aboutToAppear(): void {
    this.loadNet()
  }

  loadNet(){
    //网络请求
    axios<string, AxiosResponse<string>, null>({
      method: "get",
      url: 'http://10.161.9.80:7012/goods/info?category_id=0&currentPage=1&pageSize=10'
    }).then((res: AxiosResponse) => {
      console.info('result:' + JSON.stringify(res.data));
    }).catch((error: AxiosError) => {
      console.error(error.message);
    })
  }

  build() {
   Column(){
     CommonTopBar({title:'首页' , backButton:false , alpha:1}).align(Alignment.TopStart).height(80)

     Stack(){
      StateComponent({
        viewState:this.viewState,
        showSkeleton:true,
        retryCallback:()=>{
          this.loadNet()
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