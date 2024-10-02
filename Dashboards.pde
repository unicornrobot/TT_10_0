////DASHBOARD/////


void draw_dashboard(int dashboardId){
 //background(0,0,0,100); 


      if (offline){ 
        offlineData(); //RUN ONLY ONCE
      }
       


//set up all parameters
tuftAreas = new IntList[5];
listColors = new color[5];
listColors2 = new color[5];
color listColor ;
color listColor2 ;
averages = new int[5];

  
//Check if not empty
if(touchData0.size() >0){
//Add all data to an array
  tuftAreas[0] = touchData0;
  tuftAreas[1] = touchData1;
  tuftAreas[2] = touchData2;
  tuftAreas[3] = touchData3;
  tuftAreas[4] = touchData4; //<>//


  int sum0 = touchData0.sum(); int avg0 = sum0/touchData0.size();
  int sum1 = touchData1.sum(); int avg1 = sum1/touchData1.size();
  int sum2 = touchData2.sum(); int avg2 = sum2/touchData2.size();
  int sum3 = touchData3.sum(); int avg3 = sum3/touchData3.size();
  int sum4 = touchData4.sum(); int avg4 = sum4/touchData4.size();
  
  magicnumbers = avg0+"-"+avg1+"-"+avg2+"-"+avg3+"-"+avg4;

//STORE AVERAGES  
  averages[0] = avg0;
  averages[1] = avg1;
  averages[2] = avg2;
  averages[3] = avg3;
  averages[4] = avg4;
}  

float[] hueRangeLow = new float[5];
float[] hueRangeHigh = new float[5];
hueRangeLow[0] = 0;
hueRangeHigh[0] = 0;
   
  //Draw the average readings   
  //draw_elements_averages(height-(height*0.05));

//INITIALISE VALUE FOR ALL DATA POINTS
int value = 0;



//////////////////////////////////////
///MAIN LOOP AROUND EACH 5 SEGMENTS///
//////////////////////////////////////
for (int i = 0; i < tuftAreas.length; i++) {
  //for (int i = 0; i < 2; i++) {

    //Set the colours
    listColors[i] = color(hue2[i], sat2[i], bri2[i]);//
    listColors2[i] = color(hue[i+1], sat[i+1], bri[i+1], 30-(i*2));//
    listColor = listColors[i];
    listColor2 = listColors2[i];
   // println(listColors[i]);
   
   //Set the contents of the lists to values
   IntList values = tuftAreas[i];


/////////////// 
//MAIN VALUES LOOP
//////////////
for (int k = 0; k < values.size(); k+=valueIncrement) {//(default = 25) skip every nth item in array / / smaller = more data
  value = values.get(k);
  //strokeWeight(3);
  
float xPos = width*0.5;
float yPos = height*0.5;
 
/////DASH 1/////
if (dashboardId == 1){

drawRadialGraph(listColor, k, height/2 ,i, value, xPos,yPos);
drawPentagonMan(listColor,value, 4, 10, i,k*2, xPos,yPos);
//drawArcs(listColor, value, 0.5,100, k, displayWidth*0.8, displayHeight*0.6);
drawRadar(listColor, k, value, xPos, yPos);

//drawDnaHue(i,k,value, displayHeight*0.38);

//drawPulseLines(values, height-160, listColor);
//drawVases(listColor, i,k,value, width/2,height/2,width/2,height/2);

}//End if dash 1
  
//Dash 2
if (dashboardId==2){
  drawRadialGraph(listColor, k, height/10, i, value, width*0.2,height*0.6);
  drawPentagonMan(listColor,value, 2, 10, i,k, width*0.5,height*0.8);//(color col,float value, float scale, int alpha, int i, float k, float xPos, float yPos){
  drawArcs(listColor, value, 0.3, 100, k, width*0.8, height*0.6);
}//end dash 2
  

  } //end values loop (items in the arrays)

}  //end tuft areas loop (main 5 segments)

//DO OUTSIDE OF LOOP
if (dashboardId == 1){
//showResultsText(width*0.73,height*0.01); 
showResultsText(width*0.5,height*0.02);
loadBackgroundImage(20);
}

//Dash 2
if (dashboardId==3){
  //gotoScreen = 3;
   
}//end dash 2



//Ensure this happens only once!! 
if (!hasRunOnce) { 
  
  //if(!offline){
    //Save the result to a local folder
    if(saveImage == true){
      saveFrame("data/"+ "output-"+ magicnumbers+ ".png");
      //SAVE TEXT FILE OF DATA 
      //saveIntListsToFile("data/data-"+magicnumbers+".txt",touchData0,touchData1,touchData2,touchData3,touchData4);
    }
  //SET FLAG
    hasRunOnce = true;
  //}
    //SET FLAG
   hasRunOnce = true;//(first time it runs, savedScreen2 is false, which sets it to true, which stops the loop...

//background(lastReadingImg);
}
  }
  
//END of draw_dashboard function

//////////////////
/////////////////
////FUNCTIONS////
/////////////////
//////////////////

void drawVases(color col, int i, int k, float value, int x, int y, int w, int h){
  float centreX = width/1.15-(value/2);
  float centreY = height/1.5-(k*0.35)+(i*35);
  
  fill(col);
  pushMatrix();
  translate(0,0);
  //BEST//float spreadX = (100+(i*(width/5))-(value/2));//BEST FULLSCREEN
  
  //float spreadX = (50+(i*(displayWidth/9))-(value/2)); ///BEST 800x600
  //rect (spreadX, height-k, value, 8,height*2/5);//FULL HEIGHT
  //rect (spreadX, (height*0.9)-(k)+(i*6), value, 1,30);//STAGGERED
 
 //COMBINED TOP/BOTTOM
 //rect (centreX, centreY, value, 1, 5); ///COMBINED ////x,y,w,h,corner radius
  rect((width/2)-(value/2), (k*1.5)+(i*5), value, 5, 5); //CENTRE JUSTIFIED /// BEST HORIZ SPACED - rect((width/2)-(value/2), (k*1.5)+(i*5), value, 5, 5);
  
  
  ///COMBINED LEFT/RIGHT
  //rect((k*1.5)+(i*5), (height/2)-(value/2), 5, value, 5); //CENTRE JUSTIFIED /// BEST VERTICAL SPACED - rect((k*1.5)+(i*5), (height/2)-(value/2), 5, value, 5); 
  ////
  
  
  //rect(height/2+(i*2), (height/2)-(value/2), value, 1, 5); //CENTRE JUSTIFIED
  
  //5 separate horizontal bars for each element evenly distributed across the Xaxis
   ///////////float spreadX = (100+(i*(displayWidth/5))-(value/2));//BEST FULLSCREEN
   //float spreadX = (50+(i*(displayWidth/9))-(value/2)); ///BEST 800x600
   
   //rect (spreadX, height-(k)*0.35, value, 8,30);
   //rect (spreadX, height-100-(k)+(i*5), value, 8,30);//STAGGERED
   //rect (spreadX, displayHeight-50-(k), value, 8,30);//FULL HEIGHT
   //rect (spreadX, displayHeight-k, value, 8,displayHeight*2/tuftAreas[i].size());//FULL HEIGHT
   
    //VERTICAL BAR FOR ALL COLORS
   //rect(200-(value/2), (k*0.5)+(i*5), value,3); //CENTRE JUSTIFIED

   
  popMatrix();
}


//PENTAGON MAN
void drawPentagonMan(color col,float value, float scale, int alpha, int i, float k, float xPos, float yPos){
       //pentagon man
  int sideCount = 5;
   float angleSize = TWO_PI/sideCount;
  //print(angleSize);
   float vertX, vertY;
   //float offset = PI/10;//ensures rotation is equal (0.314...)
   float offset = 2.2;
   //float scale = 4;
   //println(scale);
   
   int angle = 5;
float[] angles = new float[angle];
   
  float angle0 = 1*angleSize - offset;
  float angle1 = 2*angleSize - offset;
  float angle2 = 3*angleSize - offset;
  float angle3 = 4*angleSize - offset;
  float angle4 = 5*angleSize - offset;
  
  float resize = 0.3*scale;//Size of arm circles
  float armSize = 0.1*scale;//Arm Length 
  
  //for pentagon man
  angles[0] = angle0;
  angles[1] = angle1;
  angles[2] = angle2;
  angles[3] = angle3;
  angles[4] = angle4;
  
  pushMatrix();
      translate(xPos,yPos);//POSITION ON SCREEN
      //int alpha = 30;
      vertX = cos(angles[i]) * k * armSize - offset;
      vertY = sin(angles[i]) * k * armSize - offset;
      //strokeWeight(averages[i]/10);
      strokeWeight(4);
      stroke(col,alpha);//color and alpha
      noFill();
      //fill(listColors[i],alpha);//color and alpha
      float td0 = value*resize;// GET array value and resize // *4 resize good
      ellipse(vertX, vertY, td0,td0);   
 popMatrix(); 
}



void drawDnaHue(int i, int k, int value, int alpha, float spread, float h){
 ///YOUR DNA.HUE READING///
  //float squareSize = 50;
  
    //COLORS BASES ON HSB WHEEL
    //fill(map(value,0,360,340,20),80,80,alpha);
    //COLORS BASED ON TUFT COLORS
    //fill(hue2[i],map(value,0,360,0,sat2[i]),map(value,0,360,0,bri2[i]),alpha);
    //BAR GRAPHS
    fill(hue2[i],map(value,0,360,sat2[i],100),map(value,0,360,bri2[i],100),alpha);
   
  
    //EQUAL SIZED BOXES
    float boxWidth = float(width-valueIncrement) / float(tuftAreas[i].size());
    float xLoc = k * boxWidth;
    float areaWidth = displayWidth/2;
    float areaHeight = displayHeight/spread;
  
   noStroke();
   pushMatrix();
   //translate(displayWidth/2,displayHeight/2);
   translate(0,h);
   
   //all boxes spread equally across the screen
   //rect(10+xLoc+boxWidth,i*(displayHeight/8)+(h), boxWidth*10,areaHeight,1);
   
   //whats this?
   //rect(10+xLoc+boxWidth,i*(displayHeight/6)+70, boxWidth*20,displayHeight/7,10);
   
   //EVENLY SPACED ACROSS DISPLAY HEIGHT 
   //OVERLAPPING FOR DNA EFFECT
   //rect(10+xLoc+boxWidth,i*(displayHeight*0.15)+(displayHeight*0.1), boxWidth*50,displayHeight/7,10);
   
   //CLEAN EQUAL HEIGHT SHAPES FOR WEAVE
   //(x,y,w,h,r) // (increment box xlocation, stagger Yaxis, box size, location,round) 
   //rect(xLoc+boxWidth,(i*(spread)), boxWidth*5,spread,0); 
   
   //DOWNWARD BAR GRAPHS EQUALLY SPREAD HORIONTAL
   rect(xLoc+boxWidth,(i*(spread)), boxWidth*5,value*0.8,5);
   popMatrix(); 
}

///ARCS
void drawArcs(color col, float value, float scale,int alpha, int item, float w, float h){
  pushMatrix();
  translate(w,h);
  noFill();
  strokeWeight(2);
  stroke(col,alpha);
  float arcSize = radians(map(value,0,360,0,180));
  //arc(width/2,height/2,k*0.8,k*0.8,value,value+arcSize,OPEN); //FULL ARCS
  //arc(width-(width/5),height/4,k*0.4,k*0.4,value,value+arcSize,OPEN); //FULL ARCS
  arc(0,0,item*scale,item*scale,value,value+arcSize,OPEN); //FULL ARCS
  
  popMatrix();
}

///RADAR 
void drawRadar(color col, int item, int value, float w, float h){
stroke(col,20);
pushMatrix();
translate(w,h);
rotate(radians(item * 1 % 360));
strokeWeight(1);
line(0, 0, value*1, 50);
popMatrix();
}


//PULSE LINES
void drawPulseLines(float val, float k,  float yOffset, color col) {
  noFill();
  strokeWeight(100);
  stroke(col);//COLOR (inc ALpha)
  beginShape();
  //for (int i = 0; i < list.size(); i++) {  
    float x = map(k, 0, touchData0.size()- 1, 0, width);
    float y = map(val, 0, 360, height-yOffset, 0+yOffset);
    //vertex(x, y + yOffset * 20); //staggered
    vertex(x, y); 
  endShape();
}







//////
//////UNUSED
   //COMBINED VASES
   //float centreX = width/1.15-(value/2);
   //float centreY = height/1.5-(k*0.35)+(i*35);
   //float centreY = height-100-(k)+(i*5); //YPOSITION - SPREAD + (offset)
   //rect (centreX, centreY, value, 5, 30); //x,y,w,h,corner radius
   
    
///HORIZONTAL BAR GRAPH
     //rect(x+20+(i*15), height-value-10, 3,value/0.01);  
     //rect(x+20+(i*15), height-(value/2)-150, 5,value/2); //FLAT BOTTOM
     //rect(x+20+(i*15), height-(value*0.5)-100, 5,value*1); 
     //BEST
     //rect(centreX+20+(i*15), displayHeight-(value/2)-150, 5,value); //CENTRE JUSTIFIED 
 
    //VERTICAL BAR FOR ALL COLORS
   //rect(200-(value/2), height-(k*0.5)+(i*5)-430, value,3); //CENTRE JUSTIFIED
    
     //HORIZONTAL BARS 
   //translate(0,0); //top left
   //noStroke();
   //5 separate horizontal bars for each element evenly distributed across the Xaxis
   ///////////float spreadX = (100+(i*(displayWidth/5))-(value/2));//BEST FULLSCREEN
   //float spreadX = (50+(i*(displayWidth/9))-(value/2)); ///BEST 800x600
   
   //rect (spreadX, height-(k)*0.35, value, 8,30);
   //rect (spreadX, height-100-(k)+(i*5), value, 8,30);//STAGGERED
   //rect (spreadX, displayHeight-50-(k), value, 8,30);//FULL HEIGHT
   //rect (spreadX, displayHeight-k, value, 8,displayHeight*2/tuftAreas[i].size());//FULL HEIGHT

 
///END UNUSED



void drawRadialGraph(color col, int k, float scale, int i, float val, float w, float h){

//colorMode();
//int controlPointNum = 80;
float rad = 50;
//float radVariance = displayHeight/4;//OVERALL SIZE OF GRAPH
//strokeWeight(1);
noFill();

//for (int e=0; e <= tuftAreas.length-1; e++){ 
  //DEBUG println(averages[e]);
  //int controlPointNum = averages[e];
  int numberOfValues = tuftAreas[0].size();
  //println(numberOfValues);
  
  stroke(col,2);
  //noStroke();
  noFill();
  //fill(col);

  
  
  float firstX = 0; // Initialize variables to store the first vertex's position
  float firstY = 0;
  float a = 0;
  float shapeX = 0;
  float shapeY = 0;
  float peaks=0;

  //vertex((width/2+rad), height/2); //first point
  float segments = TWO_PI/numberOfValues;
  beginShape();
  for(int s=0; s<numberOfValues; s++){
   // println(segments);
   
  pushMatrix();
 
    //float randomRad = rad+random(1.5)*radVariance;
    peaks = rad+map(tuftAreas[i].get(s),0,360,0,2)*scale;
    //float peaks = rad+map(value,0,360,0,2)*radVariance;
    a = segments*s;
    //println(peaks);
    shapeX = cos(a)*peaks;
    shapeY = sin(a)*peaks;
    //circle(width/2+x, height/2+y, 10);
    
    if (s == 0) {
    // Store the position of the first vertex
    firstX = shapeX;
    firstY = shapeY;
    //println(firstX,firstY);
    //endShape();
  }
popMatrix();
    curveVertex((w+shapeX), h+shapeY);
}//end for loop
  curveVertex(firstX, firstY);
endShape();
 
a=0;
shapeX = 0;
shapeY = 0;
peaks=0;

}



///FLOWERS
/*
int totalFlowers = 700;
Flower[] myFlower=new Flower[touchData0.size()];

float fx;//
float fy;//
float flowerSize;//FLower main head size
color petalCol;//petal color
float petalNumber;
color flowerCol;//Main flower color

class Flower {
  float x;
  float y;
  float d;
  int petals=int(random(5, 20));//Number of petals
  //int petals=20;
  float a=TWO_PI/petals;
  float petalsd;
  float petalsx;
  float petalsy;
  int alpha =30;

  Flower(float fx, float fy, float flowerSize, color petalCol, color flowerCol, float petalNumber) {
    x=fx;
    y=fy;
    d=flowerSize;

    float a=TWO_PI/petalNumber;
    stroke(-1);//-1 = white 0 = black
    noStroke();
    //strokeWeight(1);  
    //line(x, y, x, height);//draw a stem from random y to the bottom of the screen
    
    //Create petals
    for (int i=0; i<petalNumber; i++) { 
      //SPREAD PETALS EVENLY AROUND FLOWER
      petalsx=d/2*sin(a*i)+x;//
      petalsy=d/2*cos(a*i)+y;
      petalsd=d/2*atan(a);//
      
      fill(petalCol,alpha);//PETAL COLOR /ALPHA
      ellipse(petalsx, petalsy, petalsd, petalsd);//PETALS
      line(fx, fy, petalsx, petalsy); //PETAL LINE 
    }
    
    fill(flowerCol,alpha);//MAIN FLOWER COLOR /ALPHA
    ellipse(x, y, d/1.2, d/1.2);//MAIN FLOWER
  }
}
*/
