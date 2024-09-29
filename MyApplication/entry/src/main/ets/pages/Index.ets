import WordPage from "../views/wordPage"
import SettingPage from "../views/settingPage"

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  @Builder TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width(26)
        .height(26)
    }
    .justifyContent(FlexAlign.Center)
    .height(48)
    .width("100%")
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    Column() {
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController,
      }) {
        TabContent() {
          Column() {
            WordPage()
          }
          .margin({top:'auto'})
          .height('100%')
          .backgroundColor("#F6F8FA")
        }
        .tabBar(this.TabBuilder("单词", 0,
          $r('app.media.word'), $r('app.media.word')))

        TabContent() {
          Column() {
            SettingPage()
          }
          .margin({top:'auto'})
          .width('100%')
          .height('100%')
          .backgroundColor("#F6F8FA")
        }
        .tabBar(this.TabBuilder("设置", 1,
          $r('app.media.setting'), $r('app.media.setting')))
      }
      .scrollable(false)
    }
    .width("100%")
    .height("100%")
  }
}

