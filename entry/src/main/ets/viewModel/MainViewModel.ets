import { TabItem } from '../model/TabItem'

export class MainViewModel{

  static tabTitle:Array<TabItem>=[
    {
      index:0,
      title: '首页',
      imageSelect: $r('app.media.icon_sel_home'),
      imageUnSelect: $r('app.media.icon_unsel_home')
    },
    {
      index:1,
      title: '发现',
      imageSelect: $r('app.media.icon_sel_find'),
      imageUnSelect: $r('app.media.icon_unsel_find')
    },
    {
      index:2,
      title: '热门',
      imageSelect: $r('app.media.icon_sel_hot'),
      imageUnSelect: $r('app.media.icon_unsel_hot')
    },
    {
      index:3,
      title: '我的',
      imageSelect: $r('app.media.icon_sel_mine'),
      imageUnSelect: $r('app.media.icon_unsel_mine')
    },
  ]
}
