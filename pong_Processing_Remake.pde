//音乐库文件(minim)
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PImage title_img,start_button_img;//定义图片对象
int start_state=1;//控制开始变量
Minim minim;//创建音频类
AudioPlayer start_audio;//创建一个音乐播放器

void setup(){
  size(800,600);//分辨率
  background(0);//背景颜色
  title_img=loadImage("title.png");start_button_img=loadImage("start_button.png");//匹配图片资源
  minim = new Minim(this);//创建声音对象
  start_audio = minim.loadFile("start_audio.mp3", 2048);//载入音频
  start_audio.loop();//开始循环播放背景音乐
}

void draw(){
  if(start_state==2){
    game_page();//游戏页面
  }
  if(start_state==1){
    start_page();//开始页面
  }
  
  println(start_state);
}



//-------------------------------------启动页面------------------------------------------

int start_tint=1;//开始闪烁变量
int start_tint_plus=5;//渐变增加量


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

float ball_x=100;
float ball_y=100;
float ball_speed=4;
float ball_x_speed=4;
float ball_y_speed=4;
int ball_x_direction=1;
int ball_y_direction=1;
int play_1_y=300;
int play_2_y=300;
int play_speed=5;
int who=1;


void game_page(){
  //start_audio.pause();//结束启动页音乐
  background(0);
  
  //键盘控制板子2中点坐标
  if(keyPressed==true){
    if(keyCode==UP){
      play_2_y=play_2_y-play_speed;
    }
    if(keyCode==DOWN){
      play_2_y=play_2_y+play_speed;
    }
  }
  
  //鼠标控制板子1中点坐标
  if(mouseY>play_1_y){
    play_1_y=play_1_y+play_speed;
  }
  if(mouseY<play_1_y){
    play_1_y=play_1_y-play_speed;
  }
  
  //球在出界零界点与板子坐标的运算
  if(ball_x>775||ball_x<25){
    float zhengfu=random(0,1);
    if(play_1_y+40>ball_y&&play_1_y-40<ball_y&&who==2){
      if(zhengfu>0.5){
        ball_y_direction=1;
        ball_y_speed=ball_y_direction*ball_speed;
      }
      else{
        ball_y_direction=-1;
        ball_y_speed=ball_y_direction*ball_speed;
      }
      ball_x_direction=-ball_x_direction;
      ball_x_speed=ball_x_direction*ball_speed;
      who=1;
    }
    if(play_2_y+40>ball_y&&play_2_y-40<ball_y&&who==1){
      if(zhengfu>0.5){
        ball_y_direction=1;
        ball_y_speed=ball_y_direction*ball_speed;
      }
      else{
        ball_y_direction=-1;
        ball_y_speed=ball_y_direction*ball_speed;
      }
      ball_x_direction=-ball_x_direction;
      ball_x_speed=ball_x_direction*ball_speed;
      who=2;
    }
  }
  
  //球出界重新发球
  if(ball_x>width||ball_x<0){
    ball_x=100;
    ball_y=100;
    ball_x_speed=4;
    ball_y_speed=4;
    ball_x_direction=1;
    ball_y_direction=1;
    play_1_y=300;
    play_2_y=300;
    play_speed=5;
    who=1;
  }
  
  //球碰上下两边反弹
  if(ball_y>height||ball_y<0){
    ball_y_direction=-ball_y_direction;
    ball_y_speed=ball_y_direction*ball_speed;
  }
  
  //计算一轮之后球的坐标
  ball_x=ball_x+ball_x_speed;
  ball_y=ball_y+ball_y_speed;
  
  //画出球和板子
  fill(255);
  rectMode(CENTER);
  rect(0,play_1_y,30,80);
  rect(800,play_2_y,30,80);
  ellipse(ball_x,ball_y,20,20);
  if(mousePressed==true){
    start_state=1;
  }
}