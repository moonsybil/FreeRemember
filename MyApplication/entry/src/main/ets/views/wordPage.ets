import WordCard from "../views/card"
import { preferences } from '@kit.ArkData';

// 定义单词和例句的数据模型
interface WordInfo {
  word: string;
  meaning: string;
  sentences: Array<SentenceType>;
  meaningOptions: Array<string>;
  correctOptionIndex: number;
}

interface SentenceType {
  text: string;
  meaning: string;
}

@Entry
@Component
struct WordPage {
  @State words: Array<WordInfo> = [];
  @State showMeaning: Visibility = Visibility.Hidden
  @State currentCardIndex: number = 0;
  @State meaningOptions: Array<string> = ['1','2','3','4'];
  @State isLiked: boolean = false;
  @State visible: boolean = false;
  @State selectedOptionIndex: number = -1;
  @State savedWords: Array<Array<string>> = [];

  aboutToAppear() {
    this.fetchData();
  }

  fetchData() {
    // 模拟网络请求延迟
    setTimeout(() => {
      // 模拟从服务器获取的数据
      const responseData: Array<WordInfo> = [
        {
          word: 'ambitious',
          meaning: 'adj.有雄心的；有抱负的',
          sentences: [
            { text: 'He is ambitious and hardworking.', meaning: '他有雄心且勤奋。' },
            { text: 'She had always been ambitious and determined to succeed.', meaning: '她一直雄心勃勃，决心要成功。' },
            { text: 'The company is very ambitious about its future.', meaning: '该公司对其未来非常有信心。' },
          ],
          meaningOptions: ['懒惰的', '有雄心的', '悲观的', '乐观的'],
          correctOptionIndex: 1
        },
        {
          word: 'collaborate',
          meaning: 'vi.合作；协作',
          sentences: [
            { text: 'The two companies have decided to collaborate on the project.', meaning: '这两家公司已决定在该项目上合作。' },
            { text: 'They collaborate closely with several other departments.', meaning: '他们与几个其他部门紧密合作。' },
            { text: 'We need to collaborate more closely with our suppliers.', meaning: '我们需要与供应商更紧密地合作。' },
          ],
          meaningOptions: ['竞争', '合作', '独立', '对抗'],
          correctOptionIndex: 1
        },
        {
          word: 'diligent',
          meaning: 'adj.勤奋的；勤勉的',
          sentences: [
            { text: 'She was known for being diligent and hardworking.', meaning: '她以勤奋和努力工作而闻名。' },
            { text: 'The diligent student always arrived early to class.', meaning: '这个勤奋的学生总是早早到教室。' },
            { text: 'He is diligent in his work and never shirks his duties.', meaning: '他在工作中很勤奋，从不推卸责任。' },
          ],
          meaningOptions: ['懒惰的', '勤奋的', '马虎的', '粗心的'],
          correctOptionIndex: 1
        },
        {
          word: 'eloquent',
          meaning: 'adj.雄辩的；口才好的',
          sentences: [
            { text: 'He was an eloquent speaker and easily persuaded the committee.', meaning: '他是个雄辩的演说家，轻易说服了委员会。' },
            { text: 'She is very eloquent and can express herself clearly.', meaning: '她口才很好，能够清晰地表达自己。' },
            { text: 'The president made an eloquent speech at the ceremony.', meaning: '总统在典礼上发表了一篇雄辩的演讲。' },
          ],
          meaningOptions: ['沉默的', '口才好的', '笨拙的', '害羞的'],
          correctOptionIndex: 1
        },
        {
          word: 'frugal',
          meaning: 'adj.节俭的；朴素的',
          sentences: [
            { text: 'She lived a frugal life and saved a lot of money.', meaning: '她过着节俭的生活，存了很多钱。' },
            { text: 'He is known for his frugal lifestyle.', meaning: '他以节俭的生活方式著称。' },
            { text: 'They adopted a frugal diet and lost weight.', meaning: '他们采取了朴素的饮食，减轻了体重。' },
          ],
          meaningOptions: ['奢侈的', '节俭的', '浪费的', '豪华的'],
          correctOptionIndex: 1
        }
      ];

      // 更新状态
      this.words = responseData;
      this.meaningOptions = this.words[0].meaningOptions;
      this.selectedOptionIndex = -1;
    }, 1000); // 延迟1秒模拟网络请求
  }

  build() {
    Column() {
      Column() {
        Text('种一棵树最好的时间是十年前，其次是现在。')
          .fontSize(16)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height('4%')
          .margin({top: 12})
      }
      List() {
        ForEach(this.words, (word:WordInfo)=>{
          ListItem() {
            WordCard({
              word: word.word,
              meaning: word.meaning,
              sentences: word.sentences,
              showMeaning: this.showMeaning
            }).width('100%').height('95%').id('wordCard')
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .height('55%')
      .scrollBar(BarState.Off)
      .onScrollIndex((start,end,center)=>{
        this.currentCardIndex = center
      })
      .onScrollStop(()=>{
        console.log("List-onScrollStop", this.currentCardIndex)
        this.meaningOptions = this.words[this.currentCardIndex].meaningOptions;
        this.selectedOptionIndex = -1;
        this.isLiked = false
      })

      List() {
        ForEach(this.meaningOptions, (option:string, index:number)=>{
          ListItem() {
            Button(option, { type: ButtonType.Normal })
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(400)
              .backgroundColor( this.selectedOptionIndex!=-1 && index==this.words[this.currentCardIndex].correctOptionIndex ? "#ffbeeaca" : index==this.selectedOptionIndex ? "#fffab1b1" : "#ffeeebeb")
              .width('90%')
              .margin({left:'5%', bottom:12})
              .borderRadius(8)
              .shadow({ radius: 8, color: Color.Gray, offsetX: 0, offsetY: 2 })
              .enabled(this.selectedOptionIndex == -1)
              .onClick(()=>{
                this.selectedOptionIndex = index;
              })
          }
        })
      }

      Column() {
        Row() {
          Image(this.isLiked?$r('app.media.like_activated'):$r('app.media.like_gray'))
            .width(32)
            .height(32)
            .margin({ right:'20%'})
            .onClick(()=>{
              this.isLiked = this.isLiked ? false : true

              if (this.isLiked) {
                this.savedWords.push([this.words[this.currentCardIndex].word, this.words[this.currentCardIndex].meaning])
                console.info(this.savedWords.toString())
              }
              else {
                this.savedWords.pop()
                console.info(this.savedWords.toString())
              }
              let dataPreferences: preferences.Preferences = preferences.getPreferencesSync(getContext(), {name:'word'});
              dataPreferences.putSync('savedWords', JSON.stringify(this.savedWords));
            })
          Image(this.visible?$r("app.media.hide"):$r('app.media.show'))
            .width(42)
            .height(42)
            .onClick(()=>{
              this.visible = this.visible ? false : true
              if (this.visible) {
                this.showMeaning = Visibility.Visible
              }
              else {
                this.showMeaning = Visibility.Hidden
              }
            })
        }
      }
      .margin({top:12})
    }
  }
}

export default WordPage;
