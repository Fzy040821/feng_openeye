/**
 * 欢迎页
 */
import { router } from '@kit.ArkUI';
import { RoutePath } from '../route/RoutePath';

@Entry
@Component
struct SplashPage {
  @State message: string = 'Hello World';
  aboutToAppear(): void {

    setTimeout(()=>{
      //业务跳转
      router.replaceUrl({url: RoutePath.MainPage})
    },2000)

  }
  build() {
   Stack(){
     Image($r('app.media.landing_image')).objectFit(ImageFit.ScaleDown)
   }.width('100%').height('100%').backgroundColor(Color.White)

  }
}