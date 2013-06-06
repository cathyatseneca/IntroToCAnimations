PFont codeFont;
PFont flowchartFont;
AnimationObject main;
AnimationObject outWindow;
int lineNumber;
AnimationObject chart;
float velocity;
float stepPauseTime;
class AnimationObject{
  int x_;
  int y_;  
};
class Code extends AnimationObject{
  String [] code_;
  int numLines_;
  int highlight_;
  int width_;
  int topMargin_;
  int leftMargin_;
  int fontsize_;
  Code(){
    numLines_=0;
    setLocation(650,30);
    code_=new string[20];
    highlight_=0;
    width_=530;
    topMargin_=0;
    leftMargin_=30;
    fontsize_=32;
  }
  Code(int x,int y){
    numLines_=0;
    setLocation(x,y);
    code_=new string[20];
    highlight_=0;
    width_=530;
    topMargin_=0;
    leftMargin_=30;
    fontsize_=32;
  }
  void setLocation(int x,int y){
    x_=x;
    y_=y;
  }
  void setHighlight(int line){
    highlight_=line;
  }
  void add(String line){
    code_[numLines_]=line;
    numLines_++;
  }
  void add(String line, int idx){
    if(idx >=0 && idx < numLines_){
      code_[idx];
    }
  }
  void setFontSize(int sz){
    fontsize_=sz;
  }
  void draw(){
    if(highlight_!=0){
      stroke(193,255,193);
      fill(193,255,193);
      rect(x_,y_+topMargin_+(highlight_-1)*(fontsize_+4)-2,width_,fontsize_);
    }
    fill(color(0,0,0));
    textAlign(LEFT);
    textFont(codeFont);
    textSize(fontsize_);
    for(int i=0;i<numLines_;i++){
      text(code_[i], x_+leftMargin_, y_+topMargin_+(i)*(fontsize_+4), 600, fontsize_);
    }

  }
};



class Output extends AnimationObject{

  String prompt_;
  String [] output_;
  boolean [] showPrompt_;
  int numLines_;
  int fontsize_;
  int width_;
  int topMargin_;
  int leftMargin_;
  Output(){
    prompt_="matrix% ";
    numLines_=1;
    setLocation(650,380);
    output_=new string[20];
    showPrompt_=new boolean[20];
    width_=530;
    topMargin_=20;
    leftMargin_=10;
    fontsize_=32;
    for(int i=0;i<20;i++){
      output_[i]="a.out";
      showPrompt_[i]=false;
    }      
    showPrompt_[0]=true;
  }
  Output(int x,int y){
    prompt_="matrix% ";
    showPrompt_=new boolean[20];
    numLines_=1;
    setLocation(x,y);
    output_=new string[20];
    width_=530;
    topMargin_=0;
    leftMargin_=30;
    fontsize_=32;
    for(int i=0;i<20;i++){
      output_[i]="a.out";
      showPrompt_[i]=false;
    }      
    showPrompt_[0]=true;
  }
  void setLocation(int x,int y){
    x_=x;
    y_=y;
  }
  void add(String line){
    code_[numLines_]=line;
    numLines_++;
  }
  void add(String line, int idx){
    if(idx >=0 && idx < numLines_){
      code_[idx];
    }
  }
  void setFontSize(int sz){
    fontsize_=sz;
  }
  void draw(){
     strokeWeight(1);
     stroke(0,0,0);
     fill(255,255,255);
     rect(x_,y_,530,300);
     fill(color(0,0,0));
     textAlign(LEFT);
     textFont(codeFont);
     textSize(fontsize_);
     for(int i=0;i<numLines_;i++){
       if(showPrompt_[i]){
         text(prompt_, x_+leftMargin_, y_+topMargin_+(i)*(fontsize_+4), 600, fontsize_);
         text(output_[i], x_+leftMargin_+prompt_.length()*(fontsize_/1.7), y_+topMargin_+(i)*(fontsize_+4), 600, fontsize_);
       }
       else{
         text(output_[i], x_+leftMargin_, y_+topMargin_+(i)*(fontsize_+4), 600, fontsize_);
       }
     }
  }
};

void drawTextBox(String s,float x, float y, int fontSize, color backColour, color frontColour){
  
  float h=fontSize+20;
  float w=s.length()*fontSize/2 - (fontSize*2);
  
  stroke(backColour);
  fill(backColour);
  rect(x-w/2,y-h/2,w,h);  
  stroke(frontColour);
  fill(frontColour);
  textAlign(CENTER);
  textSize(fontSize);
  text(s,x-w/2,y-fontSize/2,w,fontSize);
  ellipseMode(CENTER);
}
void drawTextDiamond(String s,float x, float y, int fontSize, color backColour, color frontColour){
  float w=s.length()*fontSize/1.7;
  stroke(backColour);
  fill(backColour);
  quad(x,y-(fontSize+10),x+(w-20),y,x,y+(fontSize+10),x-(w-20),y);
  
  fill(frontColour);
  textAlign(CENTER);
  textSize(fontSize);
  text(s,x-w/2,y-fontSize/2,w,fontSize);

}
class Node{
  int x_;
  int y_;
  int nodeType_;
  String nodeText_;
  color [] nodeBack_;
  int state_;
  float lastBGColorSwap_;
  int colorIdx_;
  Node(int x,int y,int nodeType,String s){
    x_=x;
    y_=y;
    nodeType_=nodeType;
    nodeText_=s;
    nodeBack_=new color[2];
    nodeBack_[1]=color(255,255,0);
    nodeBack_[0]=color(255,255,255);
    state_=0;
    colorIdx_=0;
    lastBGColorSwap_=millis();
  }
  Node(int x,int y){
    x_=x;
    y_=y;
    nodeType_=0;
    nodeText_="";
    nodeBack_=new color[2];
    nodeBack_[1]=color(255,255,0);
    nodeBack_[0]=color(255,255,255);
    colorIdx_=0;
    state_=0;
    lastBGColorSwap_=millis();
  }
  void set(int x,int y){
    x_=x;
    y_=y;
  }
  void setState(int state){
    state_=state;
    lastBGColorSwap_=millis();
    if(state_!=0){
      colorIdx_=1;
    }
    else{
      colorIdx_=0;
    }
  }
  void setText(String nodeText){
    nodeText_=nodeText;
  }
  void setColour(color c){
    nodeBack_=c;
  }
  int nodeType(){return nodeType_;}
  int x(){return x_;}
  int y(){return y_;}
  void draw(){
    if(state_==1){
      float elapsedTime=millis() - lastBGColorSwap_;
      if(elapsedTime > 500){ 
        lastBGColorSwap_=millis();
        colorIdx_=(colorIdx_==0)?1:0;
      }
    }
    if(nodeType_==1){
      drawTextBox(nodeText_,x_,y_,36,nodeBack_[colorIdx_],color(0,0,0));
    }
    else if(nodeType_==2){
      drawTextDiamond(nodeText_,x_,y_,36,nodeBack_[colorIdx_],color(0,0,0));
    }
  }
};
class Link{
  Node start_;
  Node end_;
  int labelXOffset_;
  int labelYOffset_;
  String state_;
  boolean drawLabel_;
  int fontSize_;
  Link(Node s,Node e){
    start_=s;
    end_=e;
    labelXOffset_=0;
    labelYOffset_=0;
    state_="";
    drawLabel_=false;    
    fontSize_=14;
  }
  Link(Node s,Node e,int xoff, int yoff,String label){
    start_=s;
    end_=e;
    labelXOffset_=xoff;
    labelYOffset_=yoff;
    state_=label;
    drawLabel_=true;
    fontSize_=14;
  }
  void draw(){
    int x1=start_.x();
    int y1=start_.y();
    int x2=end_.x();
    int y2=end_.y();
    line(x1,y1,x2,y2);  
    if(drawLabel_){
      fill(color(255,255,255));
      textAlign(LEFT);
      textSize(fontSize_);
      text(state_,x1+labelXOffset_,y1+labelYOffset_,60,14);
    }
  }
};
class FlowChart extends AnimationObject{
  Node [] chart_;
  Link [] links_;
  int [] path_;
  int numNodes_;
  int numLinks_;
  int numPath_;
  int highlighterNext_;
  int highlighterState_;  //0 no highlights, 1 - on link, 2 at node
  float highlighterX_;
  float highlighterY_;
  int numOnPath_;
  float lastUpdate_;
  color backColour_;
  color frontColour_;
  color textColour_;
  float timeSinceLastStateChange_;
  int tipX_;
  int tipY_;
  FlowChart(){
    x_=20;
    y_=20;
    backColour_=color(0,0,255);
    frontColour_=color(255,255,255);
    textColour_=color(0,0,0);
    chart_=new Node[20];
    links_=new Link[30];
    path_=new int[30];
    numNodes_=0;
    numLinks_=0;
    numOnPath_=0;
    highlighterState_=1;
  }
  void addNode(int x, int y, int type, String s){
    chart_[numNodes_]=new Node(x,y,type,s);
    numNodes_++;
  }
  void addNode(int x, int y){
    chart_[numNodes_]=new Node(x,y);
    numNodes_++;
  }
  void addLink(int start, int end){
    links_[numLinks_]=new Link(chart_[start],chart_[end]);
    numLinks_++;
  }
  void addLink(int start, int end,int offx,int offy,String s){
    links_[numLinks_]=new Link(chart_[start],chart_[end],offx,offy,s);
    numLinks_++;
  }
  void addPath(int nodeNumber){
    path_[numOnPath_]=nodeNumber;
    numOnPath_++;
  }
  void setFontSize(int sz){
    fontSize_=sz;
  }
  void startAnimation(){
    highlighterNext_=1;
    highlighterState_=1;
    highlighterX_=chart_[1].x()-chart_[0].x();
    highlighterY_=chart_[1].y()-chart_[0].y();
    tipX_=chart_[0].x();
    tipY_=chart_[0].y();
    lastUpdate_=millis();
    timeSinceLastStateChange_=0;  
  }
  void draw(){
    int x1,y1,x2,y2;
    float currTime=millis();
    float elapsedTime=currTime-lastUpdate_;
    timeSinceLastStateChange_+=elapsedTime;
    textFont(flowchartFont);
    strokeWeight(1);
    stroke(backColour_);
    fill(backColour_);  
    rect(x_,y_,600,660);
    
    stroke(255,255,0);
    strokeWeight(15);
    for(int i=0;i<highlighterNext_-1;i++){
       x1=chart_[path_[i]].x();
       y1=chart_[path_[i]].y();
       x2=chart_[path_[i+1]].x();
       y2=chart_[path_[i+1]].y();
       line(x1,y1,x2,y2);
    }
    if(highlighterState_!=0){
      if(highlighterState_==1){    
        x1=chart_[path_[highlighterNext_-1]].x();
        y1=chart_[path_[highlighterNext_-1]].y();

        tipX_=tipX_+velocity*(elapsedTime/1000)*highlighterX_;
        tipY_=tipY_+velocity*(elapsedTime/1000)*highlighterY_;   
       
        line(x1,y1,tipX_,tipY_);
        int m1=tipX_-x1;
        int m2=tipY_-y1;
       // println(highlighterX_ + " " + highlighterY_+" , "+m1 + " " + m2);
        if(highlighterX_*highlighterX_+highlighterY_*highlighterY_ < m1*m1+m2*m2){
          if(chart_[highlighterNext_].nodeType() != 0){
            highlighterState_=2;
            timeSinceLastStateChange_=0;
            chart_[highlighterNext_].setState(1);
          }
          highlighterNext_++;
          if(highlighterNext_ == numOnPath_){
            highlighterState_=0;
            timeSinceLastStateChange_=0;
          }
          else{
            tipX_=chart_[highlighterNext_-1].x();
            tipY_=chart_[highlighterNext_-1].y();
            highlighterX_=chart_[highlighterNext_].x()-chart_[highlighterNext_-1].x();
            highlighterY_=chart_[highlighterNext_].y()-chart_[highlighterNext_-1].y();
          }
        }

      }
      else if(highlighterState_==2){
        if(timeSinceLastStateChange_ > stepPauseTime){
          timeSinceLastStateChange_=0;
          highlighterState_=1;
          chart_[highlighterNext_-1].setState(2);
        }
      }
      
    }

    stroke(frontColour_);
    strokeWeight(5);
    fill(frontColour_);
    for(int i=0;i<numLinks_;i++){
      links_[i].draw();
    }
    for(int i=0;i<numNodes_;i++){
      chart_[i].draw();
    }
    lastUpdate_=currTime;
  }

};
class TimeEvent{
  float time_;    //time event should occur in seconds since start of program
  AnimationObject updateObject_;
  int param_;
  
};
class TimeLine{
  TimeEvent [] events_;
  int numEvents_;
  TimeLine(){
    events_=new TimeEvent[60];
    numEvents_=0;
  }
  void addEvent(TimeEvent e){
    if(numEvents_ < 60){
      events_[numEvents_]=e;
      numEvents_++;
    }
  }
  void sort(){
    TimeEvent curr;
    int i,j;
    for(i=1;i<numEvents_;i++){
      curr=events_[i];
      for(j=i;j>0 && events_[j-1] > curr;j--){
        events_[j]=events_[j-1];
      }
      events_[j]=curr;
    }
  }
};

class Coordinator{
  Code main_;
  Output outWindow_;
  FlowChart chart_;
   
};
void setup(){
   size(1200,700);
   background(255,255,255);
   codeFont=createFont("monospace");
   flowchartFont=createFont("sans-serif");
   main =new Code();
   main.add("int main(void){");
   main.add("  int x = 10;");
   main.add("  printf(\"start\");");
   main.add("  if(x > 0){");
   main.add("    printf(\"positive\");");
   main.add("  }");
   main.add("  printf(\"all done\");");
   main.add("  return 0;");
   main.add("}");
  lineNumber=1;
  main.setFontSize(20);
  outWindow=new Output();
  outWindow.setFontSize(20);
  chart=new FlowChart();
  stepPauseTime = 4000;
  chart.addNode(200,100);  //0
  chart.addNode(200,175,1,"printf(\"start\");");
  chart.addNode(200,300,2,"x > 0");
  chart.addNode(450,300);  //3
  chart.addNode(450,375,1,"printf(\"positive\");");
  chart.addNode(450,450); //5
  chart.addNode(200,450); //6
  chart.addNode(200,525,1,"printf(\"alldone\");");
  chart.addNode(200,600); //8
  chart.addLink(0,1);
  chart.addLink(1,2);
  chart.addLink(2,3,100,-20,"true");
  chart.addLink(3,4);
  chart.addLink(4,5);
  chart.addLink(5,6);
  chart.addLink(2,6,10,50,"false");
  chart.addLink(6,7);
  chart.addLink(7,8);
  chart.addPath(0); 
  chart.addPath(1); 
  chart.addPath(2); 
  chart.addPath(3); 
  chart.addPath(4); 
  chart.addPath(5); 
  chart.addPath(6); 
  chart.addPath(7);
  chart.addPath(8);
  velocity=0.5;
  //frameRate(1);
}
void draw(){
 
    background(255,255,255);
    main.setHighlight(lineNumber);
    main.draw();
 /*   lineNumber=lineNumber+1;
    if(lineNumber> 18){
      lineNumber=0;
    }*/
    outWindow.draw();
    chart.draw();
}

