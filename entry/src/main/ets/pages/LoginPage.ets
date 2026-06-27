
@Builder
export function LoginPageBuilder(){
  LoginPage()
}


@ComponentV2
struct LoginPage{
  @Local Phonenumber:string=''
  @Local codeColor:string=''
  @Local enable:boolean=false
  @Local code:string=''
  @Consumer() islogin:boolean=false
  private tabsController:TabsController|undefined=undefined
  @Consumer() navPathStack:NavPathStack|undefined=undefined
  build() {
    NavDestination(){
      Column(){
        Stack({alignContent:Alignment.Start}){
          Image($r(`app.media.topbackleft`))
            .width(25)
            .height(25)
            .onClick(()=>{
              this.navPathStack?.pop()
            })
          Text('京东注册登录')
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(50)

        TextInput({placeholder:'请输入手机号码',text:$$this.Phonenumber})
          .borderWidth({bottom:1})
          .borderColor({bottom:'#f0f0f0'})
          .backgroundColor(Color.Transparent)
          .onChange((text:string)=>{
            this.Phonenumber=text
            if (this.Phonenumber.length===11) {
              this.codeColor='#ff0000'
              this.enable=true
            }else {
              this.codeColor='#000000'
            }
          })

        Row(){
          TextInput({placeholder:'请输入验证码'})
            .borderWidth({bottom:1})
            .borderColor({bottom:'#f0f0f0'})
            .backgroundColor(Color.Transparent)
            .width('70%')
          Divider()
            .vertical(true)
            .height(30)
            .color('#f0f0f0')
            .strokeWidth(2)
          Text('获取验证码')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .fontColor(this.codeColor)
            .enabled(this.enable)
            .onClick(()=>{
              this.code='123456'
            })
        }
        .width('100%')
        .borderWidth({bottom:1})
        .borderColor({bottom:'#f0f0f0'})

        Button()
          .width('90%')
          .height(50)
          .borderRadius(15)
          .onClick(()=>{
            if (this.Phonenumber==='12345678901' && this.code==='098765') {
              this.islogin=true
              this.navPathStack?.pop()
              this.tabsController?.changeIndex(3)
            }else {
              this.islogin=false
            }
          })

      }
      .padding({left:15,right:15})
    }
    .hideTitleBar(true)
    .hideToolBar(true)
  }
}