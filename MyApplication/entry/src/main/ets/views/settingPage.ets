import { preferences } from '@kit.ArkData';

@Entry
@Component
struct SettingPage {
  @State savedWords: Array<Array<string>> = [];
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({savedWords: this.savedWords}),
  });

  aboutToAppear(): void {
    let dataPreferences: preferences.Preferences = preferences.getPreferencesSync(getContext(), {name:'word'});
    let str = dataPreferences.getSync('savedWords', '[]');
    this.savedWords = JSON.parse(str.toString())
  }

  build() {
    Column() {
      Row() {
        Image($r("app.media.avatar"))
          .width(60)
          .height(60)
          .margin({left:36})
        Text('昵称')
          .fontSize(20)
          .fontWeight(600)
          .margin({left:48})
      }
      .width('85%')
      .margin({top:'20%',bottom:'5%'})
      .padding({top:12,left:8,right:8,bottom:12})
      .borderRadius(16)
      .shadow({ radius: 16, color: Color.Gray, offsetX: 0, offsetY: 2})
      .backgroundColor("#ffffffff")

      List() {
        ListItem() {
          Button('生词本', {type: ButtonType.Normal})
            .width('80%')
            .fontColor(Color.Black)
            .margin({left:'10%', top:24})
            .borderRadius(8)
            .shadow({ radius: 8, color: Color.Gray, offsetX: 0, offsetY: 2})
            .backgroundColor("#ffffffff")
            .onClick(() => {
              let dataPreferences: preferences.Preferences = preferences.getPreferencesSync(getContext(), {name:'word'});
              let str = dataPreferences.getSync('savedWords', '[]');
              this.savedWords = JSON.parse(str.toString())
              this.dialogController.open();
            })
        }
        ListItem() {
          Button('更新词库', {type: ButtonType.Normal})
            .width('80%')
            .fontColor(Color.Black)
            .margin({left:'10%', top:24})
            .borderRadius(8)
            .shadow({ radius: 8, color: Color.Gray, offsetX: 0, offsetY: 2})
            .backgroundColor("#ffffffff")
        }
        ListItem() {
          Button('关于我们', {type: ButtonType.Normal})
            .width('80%')
            .fontColor(Color.Black)
            .margin({left:'10%', top:24})
            .borderRadius(8)
            .shadow({ radius: 8, color: Color.Gray, offsetX: 0, offsetY: 2})
            .backgroundColor("#ffffffff")
        }
      }
      .height('60%')
    }
    }
}

@CustomDialog
struct CustomDialogExample {
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({savedWords:this.savedWords}),
  });
  @Prop savedWords: Array<Array<string>> = [];

  build() {
    Column() {
      Column() {

          List() {
            ForEach(this.savedWords, (arr:Array<string>)=>{
              ListItem() {
                word({word:arr[0], meaning:arr[1]})
              }
            })

          }
          .scrollBar(BarState.Off)

        }
        .height('100%')
        .width('100%')
        // .backgroundColor(Color.Blue)
        .borderRadius(24)
        .padding({top:8,left:8,right:8,bottom:8})
        .shadow({ radius: 24, color: Color.Gray, offsetX: 4, offsetY: 4})
      }
      .height('90%')
      .width('100%')
      // .backgroundColor(Color.Red)
      .padding({
        top: 8,
        bottom: 8,
        left: 8,
        right: 8
      })
    }
}

@Component
struct word {
  @Prop word: string;
  @Prop meaning: string;

  build() {
    Column() {
      // 单词显示
      Text(this.word)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .margin({ top: 0, left: 32, right: 16, bottom: 8 })
        .width("100%")

      // 中文释义
      Text(this.meaning)
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .margin({ left: 96, right: 16, bottom: 8 })
        .width("100%")
    }
    .width('100%')
    .backgroundColor("#fff5f5f5")
    .borderRadius(8)
    .margin({bottom:16})
  }
}

export default SettingPage;