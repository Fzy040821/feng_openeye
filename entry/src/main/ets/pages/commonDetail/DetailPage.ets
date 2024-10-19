import { CommonTopBar } from '../../views/CommonTopBar'
import { VideoComponent } from '../../views/VideoComponent'
import { VideoBottomComponent } from './component/VideoBottomComponent'
import { router } from '@kit.ArkUI'
import { CategoryRouteParams } from '../../route/RouterParams'

@Entry
@Component
struct DetailPage {
  @State isAutoPlay: boolean = true
  @State showControls: boolean = true
  @State playUrl: string = ""
  @State relationId: number = -1
  private controller: VideoController = new VideoController()

  aboutToAppear(): void {
    let routerParams = router.getParams() as CategoryRouteParams
    this.relationId = routerParams.id
    this.playUrl = routerParams.playUrl
  }

  build() {
   Column(){
     //头布局
     CommonTopBar({title:'详情' , alpha:1}).height(50)
     this.headerPlayer()
     VideoBottomComponent({
       relationId: this.relationId,
       onItemClick: (playUrl) => {
         this.playUrl = playUrl
       }
     }).layoutWeight(1)
   }
    .height('100%')
    .width('100%')
  }

  @Builder
  headerPlayer(){
    VideoComponent({showControls:$showControls , playUrl:$playUrl , isAutoPlay:this.isAutoPlay})
      .width('100%')
      .height($r('app.float.size_250'))
  }

}