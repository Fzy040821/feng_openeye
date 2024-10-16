import { CommonTopBar } from '../../views/CommonTopBar';

@Entry
@Component
export struct HomePage {
  @State message: string = '首页';

  build() {
   Column(){
     CommonTopBar({title:'首页' , backButton:false , alpha:1}).align(Alignment.TopStart)
   }
    .height('100%')
    .width('100%')
  }
}