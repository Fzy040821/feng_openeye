import { ViewStateConstant } from '../Const/ViewStateConstant'
import { CommonSkeleton } from '../skelton/CommonSkeleton'

@Component
export struct StateComponent{
  @Prop viewState: string//view当前状态
  //页面区域的组件
  @BuilderParam viewContent:()=>void
  retryCallback?:()=>void
  //是否骨架屏幕
  private showSkeleton: boolean = false

  build() {
    Stack(){
      if(this.viewState != ViewStateConstant.VIEW_STATE_SUCCESS){
        this.holderContent()
      }else {
        this.viewContent()
      }
    }
  }
/**
 * 占位组件
 */
  @Builder
  holderContent(){
    if(this.showSkeleton && this.viewState == ViewStateConstant.VIEW_STATE_LOADING){
      CommonSkeleton()
    }else {
      Column(){
        Image(this.convertImage())
          .width($r('app.float.size_100'))
          .height($r('app.float.size_100'))

        Text(this.convertValue())
          .fontSize($r('app.float.size_text_15'))
          .fontColor($r('app.color.color_666'))
          .margin($r('app.float.size_10'))

        if(this.viewState != ViewStateConstant.VIEW_STATE_LOADING){
          Button($r('app.string.press_retry'))
            .width($r('app.float.size_120'))
            .height($r('app.float.size_35'))
            .backgroundColor($r('app.color.color_red'))
            .fontColor($r('app.color.color_fff'))
            .onClick(()=>{
              this.retryCallback?.()
            })
        }

      }
    }
  }

  /**
   * 转换文案
   */
  convertValue(){
    switch (this.viewState){
      case ViewStateConstant.VIEW_STATE_LOADING:
        return $r('app.string.loading')
        break
      case ViewStateConstant.VIEW_STATE_ERROR:
        return $r('app.string.load_error')
        break
      case ViewStateConstant.VIEW_STATE_NETWORK_ERROR:
        return $r('app.string.net_error')
        break
      case ViewStateConstant.VIEW_STATE_EMPTY:
        return $r('app.string.load_emtpy')
        break
      default:
        return $r('app.string.load_success')
    }
  }

  /**
   * 转换图片
   */
  convertImage(){

    switch (this.viewState){
      case ViewStateConstant.VIEW_STATE_LOADING:
        return $r('app.media.loading')

      case ViewStateConstant.VIEW_STATE_ERROR:
        return $r('app.media.common_empty_content')

      case ViewStateConstant.VIEW_STATE_NETWORK_ERROR:
        return $r('app.media.timeout')

      case ViewStateConstant.VIEW_STATE_EMPTY:
        return $r('app.media.common_empty_content')

      default:
        return $r('app.media.loading')
    }
  }
}