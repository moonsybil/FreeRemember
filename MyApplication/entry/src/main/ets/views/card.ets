interface SentenceType {
  text: string;
  meaning: string;
}

@Component
struct WordCard {
  @Prop word: string;
  @Prop meaning: string;
  @Prop sentences: Array<SentenceType>;
  @Prop showMeaning: Visibility

  build() {
    Scroll() {
      Column() {
        // 单词显示
        Text(this.word)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Start)
          .margin({ top: 16, left: 16, right: 16, bottom: 16 })
          .width("100%")

        // 中文释义
        Text(this.meaning)
          .fontSize(16)
          .textAlign(TextAlign.Start)
          .margin({ left: 16+16, right: 16, bottom: 16 })
          .width("100%")
          .visibility(this.showMeaning)

        // 例句
        ForEach(this.sentences, (sentence:SentenceType, index) => {
          Column() {
            Text('  '+sentence.text)
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .textAlign(TextAlign.Start)
              .margin({ left: 16, right: 16, bottom: 8 })
              .width("100%")
            Text('  '+sentence.meaning)
              .fontSize(16)
              .textAlign(TextAlign.Start)
              .margin({ left: 16, right: 16, bottom: 20 })
              .lineHeight(22)
              .width("100%")
              .visibility(this.showMeaning)
          }
          .width("100%")
        })
      }
      .width('100%')
      .height('auto') // 自适应高度
      .backgroundColor("#F6F8FA")
      .borderRadius(8) // 圆角
      // .margin({ top: 10 })
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    }
    .borderRadius(8) // 圆角
    .shadow({ radius: 10, color: Color.Gray, offsetX: 0, offsetY: 4 })
    .scrollBar(BarState.Off)
  }
}

export default WordCard;