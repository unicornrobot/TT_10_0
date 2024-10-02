////////////////
//////UI///////
//////////////

///TITLE SCREEN
void drawScreenZero() { // MENU SCREEN
background(colorMode); 
  //reset graph positions
  xPos = 0;
  lastxPos0= 0;lastxPos1= 0;lastxPos2= 0;lastxPos3= 0;lastxPos4= 0;

 //RESET TOUCH DATA
 
  touchData0.clear();
  touchData1.clear();
  touchData2.clear();
  touchData3.clear();
  touchData4.clear();

//reset screen saved status
savedScreen1 = false;
savedScreen2 = false;
hasRunOnce = false;
menuUp = false;

  if (offline){
    gotoScreen = 2; //jump to sample results if offline
  } else { 
    //Draw start screen
    gotoScreen = 0;
//Check for touch of all 5 segments
  isPartHandPresent(); 
//isAllhandPresent();
  }
/*
///DETECT INDIVIDUAL ELEMENTS AND JUMP TO SCREENS
////
   if (sensor0 > 30){//IF ORANGE IS TOUCHED
    gotoScreen = 3; 
  }
     if (sensor1 > 20){//IF RED IS TOUCHED
    gotoScreen = 4; 
     } 
     if (sensor2 > 20){//IF BLUE IS TOUCHED
    gotoScreen = 5; 
  }
     if (sensor3 > 20){//IF LIME IS TOUCHED
    gotoScreen = 6; 
  }
     if (sensor4 > 40){//IF PINK IS TOUCHED
    gotoScreen = 7; 
  }
  
  */
}
 
//SCREEN ONE
//READING DATA
void drawScreenOne() { 
  //redraw();
   if( btnStatus == 1){
      gotoScreen = 2;// 2 = readings / 9 = pre-reading screen
      }

if (!readingFinished){
  processData();
  //drawGraphs(); ///THIS FUNCTION DICTATES WHEN THE READING IS FINISHED (Reached other side of screen)
  drawReadings();
  //drawWeave();
  
 //RADIALS 
  rotatingBars();
        //circles();
  drawPentagons();
          //concentricCircles();
  
  spiral();
        //drawStars(); 

  //isTouched = false;
}

}

//screen 9
void drawScreenPreRead(){ 
//btnAction();
//btnScreen();  
   if(!hasRunOnce){
   background(colorMode); 
   fill(255);
    text("hello", 50,50);
     
 }

hasRunOnce = true;

//btnScreen();
}




///SCREEN TWO -OUTPUTS
//DISPLAY RESULTS
void drawScreenTwo() { // SHOW RESULTS
 //<>// //<>//
 /// OUTPUT
 ///////////


 if(!hasRunOnce){
   background(colorMode); 
     draw_dashboard(dashboardId);//SWITCH DASHBOARDS
     
     addNewDataArrays();
     saveDataArrays();
 }
hasRunOnce = true;
  //btnAction(); 
  btnScreen();
//noHand =false;


 ///////////////////
}//end screen two


/////ELEMENTS SCREENS////////


void drawScreenOrange(){

 // btnAction();
  btnScreen();
  fill(0,0,100);
  textSize(50);
  //text("EARTH",width/2,height/2);
  textSize(25);
 
  //Draw Arcs
 if(!hasDrawnOnce){
background(colorMode); 
   //println(hasDrawnOnce);
  for (int i=0;i < 5;i++){
    listColors[i] = color(hue2[i], sat2[i], bri2[i], 30);// //<>// //<>//
    for (int k=0;k < tuftAreas[i].size();k+=valueIncrement){
     //
     drawArcs(listColors[i], tuftAreas[i].get(k), 1, 100, k, width*0.5, height*0.5);
    }
    hasDrawnOnce=true;
  }
  
 }

 
 
 }



void drawScreenRed(){
  //btnAction();
   btnScreen();
  //fill(0,0,100);
  //text("FIRE",width/2,50);
  //concentricCircles();
  
   //Draw Radial Graph
 if(!hasDrawnOnce){
background(colorMode); 
  for (int i=0;i < 5;i++){
    listColors[i] = color(hue2[i], sat2[i], bri2[i], 10);//
    for (int k=0;k < tuftAreas[i].size();k+=valueIncrement){
     float value = tuftAreas[i].get(k);
     //drawRadialGraph(listColors[i], i,k, values, displayWidth*0.5, displayHeight*0.5);
     drawPulseLines(value, k, 100, listColors[i]);//value, loop, yOffset, col

    }
      hasDrawnOnce=true; //<>// //<>//
  }

 }


}

void drawScreenBlue(){
 //btnAction();
 btnScreen();
  // background(203,82,69,100); 
  //fill(0,0,100);
  //text("WATER",width/2,50);
  
  
  //Draw pentagon man (ripples)
 if(!hasDrawnOnce){
background(colorMode); 
  for (int i=0;i < 5;i++){
    listColors[i] = color(hue2[i], sat2[i], bri2[i], 30);//
    for (int k=0;k < tuftAreas[i].size();k+=valueIncrement){
      float value = tuftAreas[i].get(k);
      drawPentagonMan(listColors[i],value,4, 30, i,k, width/2,height/2);
    }
      hasDrawnOnce=true;
  }

 }

}
void drawScreenLime(){
 // btnAction();
  btnScreen();
  // background(62,97,81,100); 

  //fill(0,0,100);
  //text("AETHER",width/2,50);
  
  
    //Draw DNA hue
 if(!hasDrawnOnce){
background(colorMode); 
  for (int i=0;i < 5;i++){
    listColors2[i] = color(hue2[i], sat2[i], bri2[i], 30);//
    
    for (int k=0;k < tuftAreas[i].size();k+=valueIncrement){
      int value = tuftAreas[i].get(k);
      drawDnaHue(i,k,value,100, height/5, 0);//...alpha,spread,heightoffset
    }
     hasDrawnOnce=true;
  }

 }
  

}
void drawScreenPink(){
//btnAction();
btnScreen();
//background(296,77,90,100); 
  //fill(0,0,100);
  //text("AIR",width/2,50);
  //
    //Draw Vases
 if(!hasDrawnOnce){
background(colorMode); 
  for (int i=0;i < 5;i++){
    listColors[i] = color(hue2[i], sat2[i], bri2[i], 30);//
    
    for (int k=0;k < tuftAreas[i].size();k+=valueIncrement){
      int value = tuftAreas[i].get(k);
      drawVases(listColors[i],i,k,value, width/2,height/2,width/2,height/2);
    }
      hasDrawnOnce=true;
  }

 }
}

void drawScreenReading(){
 // btnAction();
  btnScreen();
background(colorMode); 
  //LOAD BACKGROUND IMAGE
 if(!hasDrawnOnce){
  if(saveImage == true){
  PImage lastReadingImg;
  String imgPath = "capture-"+ magicnumbers+ ".png";
  lastReadingImg = loadImage(imgPath);
  //println(imgPath);
  tint(0,0,100,100);
  if (lastReadingImg != null){
    image(lastReadingImg,0,0);
  }
    hasDrawnOnce=true;
 }
  
}//end saveimage
}



void drawScreenGallery(){
  //drawPentagonMan(listColor,value, 10, i,k*2, xPos,yPos);
}


void drawLogo(float xPos, float yPos, float alpha){

pushMatrix();

beginShape(QUAD_STRIP);
int numQuads = 5;
//fill(125);
noStroke();
for (int i = 0; i <= numQuads; i++) {
  float a = map(i, 0, numQuads, 0, TWO_PI)-HALF_PI;//+0.943; //rotation
  float x0 = 0 * cos(a); //size
  float y0 = 0 * sin(a);
  float x1 = 50 * cos(a); //thickness
  float y1 = 50 * sin(a);
  fill(hue[i],sat[i],bri[i],alpha);
  vertex(x0+xPos, y0+yPos);
  vertex(x1+xPos, y1+yPos);
 
}
  endShape();
popMatrix();
}



void keyPressed() {
  
 //to fix multiple key press
 //https://github.com/processing/processing/wiki/Troubleshooting#key-repeat-on-macos-sierra 
 //println(key);
 
  switch(key) {
    case 'g':
    displayGraphs();break;
    
    case '1':
      gotoScreen=3;break;
    case '2':
     gotoScreen=4;break;
    case '3':
    gotoScreen=5;break;
      case '4':
     gotoScreen=6;break;
      case '5':
     gotoScreen=7;break;
      case '6':
     loadBackgroundImage(100);break;
    default:
      // Default action when other keys are pressed
      //println("Other key pressed: " + key);
     // gotoScreen = 0;
      break;
  }
}//end keypressed
