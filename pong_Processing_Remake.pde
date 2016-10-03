PImage title_img,start_button_img;//定义图片对象
int start_state=1;//控制开始变量

void setup(){
  size(800,600);//分辨率
  background(0);//背景颜色
  title_img=loadImage("title.png");start_button_img=loadImage("start_button.png");//匹配图片资源
}

void draw(){
  
  if(start_state==1){
  start_page();//开始页面
  }
  
  if(start_state==2){
    game_page();//游戏页面
  }
}

int start_tint=1;//开始闪烁变量
int start_tint_plus=5;//渐变增加量

//-------------------------------------启动页面------------------------------------------
void start_page(){
  
  //默认状态
  background(0);
  tint(255,start_tint);//开始按钮透明度
  image(start_button_img,300,387);//开始按钮贴图
  tint(255,255);//标题透明度
  image(title_img,228,145);//标题贴图
  start_tint=start_tint+start_tint_plus;//按钮透明度变化实现闪烁效果
  if (start_tint>255){
    start_tint_plus=-5;
  }
  if (start_tint<1){
    start_tint_plus=5;
  }
  
  //感受点击
  if (mousePressed==true&&mouseX>300&&mouseX<500&&mouseY>387&&mouseY<455){
    start_state=2;
  }
}

//-------------------------------------游戏页面------------------------------------------
void game_page(){
  background(255);
}