import { TabItem } from '../model/TabItem';
import { MainViewModel } from '../viewModel/MainViewModel';
import { FindPage } from './find/FindPage';
import { HomePage } from './home/HomePage';
import { HotPage } from './hot/HotPage';
import { MinePage } from './mine/MinePage';

@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0
  @Provide homeTabSelIndex: number = 0
  @State loadingTips: string = "加载中..."
  @State loadingShow: boolean = false
  build() {
   Column(){
     Tabs({barPosition: BarPosition.End , index: this.currentIndex}){
       TabContent(){
         HomePage()
       }.tabBar(this.TabBottom(MainViewModel.tabTitle[0] , 0))
       TabContent(){
         FindPage()
       }.tabBar(this.TabBottom(MainViewModel.tabTitle[1] , 1))
       TabContent(){
         HotPage()
       }.tabBar(this.TabBottom(MainViewModel.tabTitle[2] , 2))
       TabContent(){
         MinePage()
       }.tabBar(this.TabBottom(MainViewModel.tabTitle[3] , 3))
     }
     .barMode(BarMode.Fixed)
     .barWidth('100%')
     .scrollable(false)
     .barHeight(56)
     .onChange((index: number)=>{
       this.currentIndex = index;
       this.homeTabSelIndex = index
     })
   }
    .height('100%')
    .width('100%')
  }

  @Builder
  TabBottom(item: TabItem, index: number){
    Column(){
      Image(this.currentIndex === index? item.imageSelect : item.imageUnSelect).width(21).height(21).margin({top: 8 , bottom: 5})

      Text(item.title)
        .width('100%')
        .height(14)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentIndex === index? Color.Red : Color.Gray)
        .textAlign(TextAlign.Center)
        .margin({bottom:7})
    }.justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_f5f5f5'))
  }

}