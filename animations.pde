///////////////////////
/// ANIMATIONS
//////////////////////

float centreShapeX = width/2;//width/2;
float centreShapeY = height/2;
int screenHeightOffset = height*5;

// draw a continuous line.
int lastxPos0=1;int lastheight0=0;
int lastxPos1=1;int lastheight1=0;
int lastxPos2=1;int lastheight2=0;
int lastxPos3=1;int lastheight3=0;
int lastxPos4=1;int lastheight4=0;
int xPos = 1;         // horizontal position of the graph 

void concentricCircles(){
  noFill();
  stroke(0,100,0,50);
  
  int[] sensors = new int [5];
  sensors[4] = int(sensor0);
  sensors[3] = int(sensor1);
  sensors[2]= int(sensor2);
  sensors[1] = int(sensor3);
  sensors[0] = int(sensor4);
/*
  for (int c=0;c<5;c++){
    float circleSize = map(sensors[c], 0,100, 10,200);
    ellipse (circleX*c,circleY*c, circleSize,circleSize);
  }
*/ 
    
}


//RADAR style visualisation
void rotatingBars(){ 
  //noStroke();
   float bar0 = map(sensor0,0,100,20,screenHeightOffset);
   float bar1 = map(sensor1,0,100,20,screenHeightOffset);
   float bar2 = map(sensor2,0,100,20,screenHeightOffset);
   float bar3 = map(sensor3,0,100,20,screenHeightOffset);
   float bar4 = map(sensor4,0,100,20,screenHeightOffset);
  
  drawBars(bar0,35,100,100);
  drawBars(bar1,347,100,100);
  drawBars(bar2,177,100,60);
  drawBars(bar3,70,100,100);
  drawBars(bar4,316,70,100);
}

void drawBars(float bardata, int barHue, int barSat, int barBri ){
  float barX = width*0.5;
  float barY = height*0.5;
  strokeWeight(1);
  
  if (frameCount % 1 == 0) {
    noFill(); 
    stroke(barHue,barSat,barBri,30);
    pushMatrix();
    translate(barX, barY);
    rotate(radians(frameCount * 2  % 360));
    rect(10, 0, bardata/2, 5,20);
    
     //Blank out with bars
     /*
    rotate(radians(frameCount * 0.5  % 360));
    fill(0,100,100,0);
    rect(0, 10, 0, 0);
    */
    popMatrix();
  }  
}


//Concentric circles

void circles(){
float circleX = width*0.5;
float circleY = height*0.5;
  
  float circle0 = map(sensor0, 0,360, 10,screenHeightOffset);
  float circle1 = map(sensor1, 0,360, 10,screenHeightOffset);
  float circle2 = map(sensor2, 0,360, 10,screenHeightOffset);
  float circle3 = map(sensor3, 0,360, 10,screenHeightOffset);
  float circle4 = map(sensor4, 0,360, 10,screenHeightOffset);
  

  fill(35,100,100,0.5);//HSB,Alpha, (ORANGE)
  ellipse (circleX,circleY, circle0,circle0);
  
  fill(347,100,100,0.5);//RED
  ellipse (circleX,circleY, circle1,circle1);
  
  fill(177,100,60,0.5);//TURQUOSE
  ellipse (circleX,circleY, circle2,circle2);
  
  fill(70,100,100,0.5);//LIME
  ellipse (circleX,circleY, circle3,circle3);
  
  fill(316,70,100,0.5);//PINK
  ellipse (circleX,circleY, circle4,circle4);
}

 //Rotating pentagon
  
  
  
void drawPentagons() {

  float polygonX = width*0.5;
  float polygonY = height*0.5;
  pushMatrix();
  translate(polygonX, polygonY);
  rotate(frameCount / 100); //Speed  - lower is faster
  //set size
  float shape0 = map(sensor0, 0,360, 10,polygonY);
  float shape1 = map(sensor1, 0,360, 10,polygonY);
  float shape2 = map(sensor2, 0,360, 10,polygonY);
  float shape3 = map(sensor3, 0,360, 10,polygonY);
  float shape4 = map(sensor4, 0,360, 10,polygonY);
  
  //draw pentagons
  polygon(0, 0, shape0, 5, 35, 100,100, 2);  
  polygon(0, 0, shape1, 5, 347,100,100,2); 
  polygon(0, 0, shape2, 5, 177,100,60,2); 
  polygon(0, 0, shape3, 5, 70,100,100, 2); 
  polygon(0, 0, shape4, 5, 316,60,100, 2); 
  
  popMatrix();
}


void polygon(float x, float y, float radius, int npoints, int pentHue, int pentSat,int pentBri, int pentAlpha) {
  //noStroke();
  noFill();
  //stroke(0,0,0,20);
  strokeWeight(3);
  float angle = TWO_PI / npoints;
  //fill(pentHue,pentSat,pentBri,pentAlpha); //HSB,Alpha
  stroke(pentHue,pentSat,pentBri,pentAlpha); //HSB,Alpha
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

//SPIRAL
void spiral() {

float t=0;//float r=100;
float spiral0 = map(sensor0, 0,360, 0,360);
float spiral1 = map(sensor1, 0,360, 0,360);
float spiral2 = map(sensor2, 0,360, 0,360);
float spiral3 = map(sensor3, 0,360, 0,360);
float spiral4 = map(sensor4, 0,360, 0,360);
int dotSize = 3;
translate(width/2,height/2);

for(int i=0;i<380;i++){
  float a=i*2*PI/180;
  float r=40*sin(t)+6*a;
  noStroke();
  //fill(10+10*a);
  fill(35,100,100,10);
  ellipse(sensor0*cos(a),sensor1*sin(a),dotSize,dotSize);
  fill(347,100,100,10);  
  ellipse(sensor1*cos(a),sensor2*sin(a),dotSize,dotSize);
  fill(177,100,60,10);  
  ellipse(sensor2*cos(a),sensor3*sin(a),dotSize,dotSize);
  fill(70,100,100,10);  
  ellipse(sensor3*cos(a),sensor4*sin(a),dotSize,dotSize);
  fill(316,60,100,10);  
  ellipse(sensor4*cos(a),sensor0*sin(a),dotSize,dotSize);
}
  t+=0.01;
}



////////
////////
//UNUSED
/////////

//Concentric stars

int starX = width/2;
int starY = height/2;

float star0 = map(sensor0, 0, 100, 3,20);
float star1 = map(sensor1, 0, 100, 3,20);
float star2 = map(sensor2, 0, 100, 3,20);
float star3 = map(sensor3, 0, 100, 3,20);
float star4 = map(sensor4, 0, 100, 3,20);

void drawStars() {
  pushMatrix();
  translate(starX,starY);
   rotate(frameCount / 200.0);
  star(0, 0, 5, 100, 5); 
   //star(0, 0, 5, 80, 5); 
    popMatrix();
}



void star(float x, float y, float radius1, float radius2, int npoints) {
  
 
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);

}


void drawWeave(){
  if (newData) {
    noStroke();
    int alpha = 50;
    int strokeMin = 1;
    int strokeMax = 1 ;
    int screenPosX = 1;
    int screenPosY = displayHeight; //max height
    float graphPoint0 = map(sensor0, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint1 = map(sensor1, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint2 = map(sensor2, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint3 = map(sensor3, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint4 = map(sensor4, 0, 360, screenPosX, screenPosY); //map to the screen height.

    
    //ORANGE
    fill(35,100,90,alpha);
    //strokeWeight(map(int(sensor0),0,360,strokeMin,strokeMax));
    rect(lastxPos0, sensor0, 1, displayHeight - graphPoint0); 
    lastxPos0 = xPos; 
    lastheight0= int(displayHeight-graphPoint0);
    
    //RED
    fill(347,100,80,alpha);     //stroke color
    //strokeWeight(map(int(sensor1),0,360,strokeMin,strokeMax));
    rect(lastxPos1, sensor1, 1, displayHeight - graphPoint1); 
    //rect(lastxPos1, sensor0, 10, sensor1); 
    lastxPos1= xPos;
    lastheight1= int(displayHeight-graphPoint1);
    
    //BLUE
    fill(177,100,50,alpha);     //stroke color
    //strokeWeight(map(int(sensor2),0,360,strokeMin,strokeMax));
    rect(lastxPos2, sensor2, 1, displayHeight - graphPoint2); 
    //rect(lastxPos1, (sensor0+sensor1), 10, sensor2); 
    lastxPos2= xPos;
    lastheight2= int(displayHeight-graphPoint2);
    
    //LIME
    fill(70,100,80,alpha);     //stroke color
    //strokeWeight(map(int(sensor3),0,360,strokeMin,strokeMax));
    rect(lastxPos3, sensor3, 1, displayHeight - graphPoint3); 
    //rect(lastxPos1, (sensor0+sensor1+sensor2), 10, sensor3); 
    lastxPos3= xPos;
    lastheight3= int(displayHeight-graphPoint3);
    
    //PINK
    fill(316,100,80,alpha);     //stroke color
    //strokeWeight(map(int(sensor4),0,360,strokeMin,strokeMax));
    rect(lastxPos4, sensor4, 1, displayHeight - graphPoint4); 
    //rect(lastxPos1, (sensor0+sensor1+sensor2+sensor3), 10, sensor4); 
    lastxPos4= xPos;
    lastheight4= int(displayHeight-graphPoint4);
    
    if (xPos >= width) {
      //go somewhere
    } else {xPos = xPos + 1;}   
  }
}



void drawGraphs(){
  //background(0,0,100,100);
  if (newData) {
    //Drawing a line from Last sensor data to the new one.
    int alpha = 30;
    int strokeMin = 1;
    int strokeMax = 6;
    int screenPosX = 1;
    int screenPosY = displayHeight-20; //max height
    
    //Map data to screen
    float graphPoint0 = map(sensor0, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint1 = map(sensor1, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint2 = map(sensor2, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint3 = map(sensor3, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint4 = map(sensor4, 0, 360, screenPosX, screenPosY); //map to the screen height.
   
   float[] graphPoints;
   graphPoints = new float[5];
   graphPoints[0] = graphPoint0;
   graphPoints[1] = graphPoint1;
   graphPoints[2] = graphPoint2;
   graphPoints[3] = graphPoint3;
   graphPoints[4] = graphPoint4;
   
   /*
   for (int g = 0;g < 5;g++){
     listColors[g] = color(hue2[g], sat2[g], bri2[g]);//
     color listColor = listColors[g];
     stroke(listColor); //<>//
     line(lastxPos0, int(height-graphPoints[g]), xPos, int(height-graphPoints[g])); 
     lastxPos0 = xPos;
   }
   */
   
    
    //ORANGE 
    stroke(35,100,90,alpha);     //stroke color
    //strokeWeight(10);        //stroke wider
    strokeWeight(map(int(sensor0),0,360,strokeMin,strokeMax));
    line(lastxPos0, lastheight0, xPos, displayHeight - graphPoint0); 
    lastxPos0 = xPos; 
    lastheight0= int(displayHeight-graphPoint0);
    
    //RED
    stroke(347,100,80,alpha);     //stroke color
    strokeWeight(map(int(sensor1),0,360,strokeMin,strokeMax));
    line(lastxPos1, lastheight1, xPos, displayHeight - graphPoint1); 
    lastxPos1= xPos;
    lastheight1= int(displayHeight-graphPoint1);
    
    //BLUE
    stroke(177,100,50,alpha);     //stroke color
    strokeWeight(map(int(sensor2),0,360,strokeMin,strokeMax));
    line(lastxPos2, lastheight2, xPos, displayHeight - graphPoint2); 
    lastxPos2= xPos;
    lastheight2= int(displayHeight-graphPoint2);
    
    //LIME
    stroke(70,100,80,alpha);     //stroke color
    strokeWeight(map(int(sensor3),0,360,strokeMin,strokeMax));
    line(lastxPos3, lastheight3, xPos, displayHeight - graphPoint3); 
    lastxPos3= xPos;
    lastheight3= int(displayHeight-graphPoint3);
    
    //PINK
    stroke(316,100,80,alpha);     //stroke color
    strokeWeight(map(int(sensor4),0,360,strokeMin,strokeMax));
    line(lastxPos4, lastheight4, xPos, displayHeight - graphPoint4); 
    lastxPos4= xPos;
    lastheight4= int(displayHeight-graphPoint4);



    // at the edge of the window, go to the results screen:
    if (xPos >= width) {

      
      xPos = 0;
      lastxPos0= 0;lastxPos1= 0;lastxPos2= 0;lastxPos3= 0;lastxPos4= 0;
      
      //Save Reading screen as image (only if not offline mode)
      if (!savedScreen1) {//do it once
        if(!offline){
        //save("/home/pi/sketchbook/" + "reading-"+ (System.currentTimeMillis()/1000) +".png");
        //save("/home/pi/sketchbook/" + "reading-"+ magicnumbers +".png");
       
       if(touchData0.size() >0){
  int sum0 = touchData0.sum(); int avg0 = sum0/touchData0.size();
  int sum1 = touchData1.sum(); int avg1 = sum1/touchData1.size();
  int sum2 = touchData2.sum(); int avg2 = sum2/touchData2.size();
  int sum3 = touchData3.sum(); int avg3 = sum3/touchData3.size();
  int sum4 = touchData4.sum(); int avg4 = sum4/touchData4.size();
  
  magicnumbers = avg0+"-"+avg1+"-"+avg2+"-"+avg3+"-"+avg4;
 
 if (saveImage == true){
     saveFrame("data/" + "capture-" + magicnumbers + ".png");
   }
  }

}
   savedScreen1= true; 
}

      //background(0);  //Clear the screen.
      fill(0,0,100);
      textSize(40);
      textAlign(CENTER);
      text("Processing...",width/2,height*0.1);
      gotoScreen = 2;
    } 
    else {
      // increment the horizontal position:
      //xPos++;
      xPos = xPos + speed; //SPEED (lower is slower -- START WITH 7)

    }
   newData =false;
   
   //print("lastXPos0: ");println(lastxPos0);
 }

}

void drawReadings(){
  //background(0,0,100,100);
  if (newData) {
    //Drawing a line from Last sensor data to the new one.
    int alpha = 30;
    int strokeMin = 1;
    int strokeMax = 6;
    int screenPosX = 1;
    int screenPosY = height; //max height
    
    
    //Map data to screen
    float graphPoint0 = map(sensor0, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint1 = map(sensor1, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint2 = map(sensor2, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint3 = map(sensor3, 0, 360, screenPosX, screenPosY); //map to the screen height.
    float graphPoint4 = map(sensor4, 0, 360, screenPosX, screenPosY); //map to the screen height.
   
    /*for (int i = 0; i < 1; i++) {
      listColors[i] = color(hue2[i], sat2[i], bri2[i]);// 
      //BEST
     rect(200-(graphPoint0/2), height-graphPoint0+(i*5)-430, graphPoint0,3);
    //VERTICAL BAR FOR ALL COLORS
   //rect(200-(value/2), height-(k*0.5)+(i*5)-430, value,3); //CENTRE JUSTIFIED
    }
    */
    
    //GRAPH STYLE  --  CENTRE JUSTIFIED OR MORE 'THREADY'
    float graphStyleJust = height/2;
  
    
    //rect(lastxPos0, graphPoint0, 10, height - graphPoint0); 
    
    //rect((k*1.5)+(i*5), (height/2)-(value/2), 5, value, 5); //CENTRE JUSTIFIED /// BEST VERTICAL SPACED - rect((k*1.5)+(i*5), (height/2)-(value/2), 5, value, 5); 
    int scale = 3;//make the bars larger
    noStroke();
    blendMode(SCREEN);
    
    fill(35,100,90,alpha);     //stroke color
    rect(xPos, (graphStyleJust)-(sensor0/2)*scale, 5, sensor0*scale, 5); ///BEST CENTRE Y JUSTIFIED HEIGHT 
    lastxPos0 = xPos; 
    lastheight0= int(height-graphPoint0);
    
    fill(347,100,80,alpha);     //stroke color
    rect(xPos, (graphStyleJust)-(sensor1/2)*scale, 5, sensor1*scale, 5);
    lastxPos1= xPos;
    lastheight1= int(height-graphPoint1);
    
    fill(177,100,50,alpha);
    rect(xPos, (graphStyleJust)-(sensor2/2)*scale, 5, sensor2*scale, 5);
    lastxPos2= xPos;
    lastheight2= int(height-graphPoint2);
    
    fill(70,100,80,alpha);
    rect(xPos, (graphStyleJust)-(sensor3/2)*scale, 5, sensor3*scale, 5);
    lastxPos2= xPos;
    lastheight3= int(height-graphPoint3);
    
    fill(316,100,80,alpha); 
    rect(xPos, (graphStyleJust)-(sensor4/2)*scale, 5, sensor4*scale, 5);
    lastxPos2= xPos;
    lastheight4= int(height-graphPoint4);


    // at the edge of the window, go to the results screen:
    if (xPos >= width) {
      xPos = 0;
      lastxPos0= 0;lastxPos1= 0;lastxPos2= 0;lastxPos3= 0;lastxPos4= 0;
      
      //Save Reading screen as image (only if not offline mode)
      if (!savedScreen1) {//do it once
        if(!offline){
        //save("/home/pi/sketchbook/" + "reading-"+ (System.currentTimeMillis()/1000) +".png");
        //save("/home/pi/sketchbook/" + "reading-"+ magicnumbers +".png");
       
       if(touchData0.size() >0){
  int sum0 = touchData0.sum(); int avg0 = sum0/touchData0.size();
  int sum1 = touchData1.sum(); int avg1 = sum1/touchData1.size();
  int sum2 = touchData2.sum(); int avg2 = sum2/touchData2.size();
  int sum3 = touchData3.sum(); int avg3 = sum3/touchData3.size();
  int sum4 = touchData4.sum(); int avg4 = sum4/touchData4.size();
  
  magicnumbers = avg0+"-"+avg1+"-"+avg2+"-"+avg3+"-"+avg4;
 
 if (saveImage == true){
     saveFrame("data/" + "capture-" + magicnumbers + ".png");
   }
  }

}
   savedScreen1= true; 
}

///IF READING REACHES END OF SCREEN
      //background(0);  //Clear the screen.
      fill(0,0,100);
      textSize(20);
      textAlign(CENTER);
      text("Press the hand and await...",width/2,height*0.1);

      readingFinished = true; //<>//
      
      //noLoop();
      

    } 
    else {
      // increment the horizontal position:
      //xPos++;

      
     xPos = xPos + speed; //SPEED (lower is slower -- START WITH 7)


    }
   newData =false;
   
   //print("lastXPos0: ");println(lastxPos0);
 }

}
