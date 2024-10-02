///////////
///HELPER_FUNCS////
//////////

boolean menuUp = false;
//Physical Button Handler

void btnAction(){
//check for tuft and send to screen x
//hasDrawnOnce = false; //resets the drawn state

  if (mousePressed){
        //println("mouse pressed");
        //gotoScreen = 3;
        if (!menuUp){
          drawLogo(width*0.5,height*0.9, 40);
          menuUp = true;
        } 
   }
   
   

//BUTTON HAND PRESS
if (btnStatus == 1) {   
    //gotoScreen=0;
    drawLogo(width*0.5,height*0.9, 5);
    menuUp = true; //<>// //<>//
    hasDrawnOnce=false;
    //btnScreen();
    //dashNum=2;
    gotoScreen=2; //Needed to show logo popup
    //draw_dashboard(1);
}else {
    //menuUp = false;
  } 

}//end btnAction

void btnScreen(){
//println("check button");
int pressThreshold = 50;
if(!allTouched){
  if (sensor0 >pressThreshold){
    hasDrawnOnce=false;
      gotoScreen = 3; //<>// //<>//
   }
   if (sensor1 >pressThreshold){
     hasDrawnOnce=false;
      gotoScreen = 4;
   }
   if (sensor2 >pressThreshold){
     hasDrawnOnce=false;
      gotoScreen = 5;
   }
   if (sensor3 >pressThreshold){
     hasDrawnOnce=false;
      gotoScreen = 6;
   }
   if (sensor4 >pressThreshold){
     hasDrawnOnce=false;
      gotoScreen = 7;
   }  
   if (btnStatus == 1){
     println("btnStatus " + btnStatus);
     hasDrawnOnce=false; //<>// //<>//
      gotoScreen = 2;//GOTO READING
   }
 }
}

void isAllhandPresent(){
  if (sensor2 >0 && sensor3 >0){
    allTouched = true; }
    else{
    allTouched = false;
  } 
  if(debug){println(allTouched);}
}



//TEST IF HAND IS PRESENT FOR START
void isPartHandPresent(){
  
  if (  sensor2 > 1 && sensor3 > 1 ){ // TOUCH IS TRUE IF BLUE and LIME TOUCHED 
  //if ( sensor0 > 1 && sensor1 > 1 && sensor2 > 1 && sensor3 > 1 && sensor4 >1){ // TOUCH IS TRUE if anything over 2 
    partTouched = true;
    gotoScreen = 1; // Go to reading screen
  }else {
    drawTitleScreen();
  }
  
}

void isHandAndBtnPresent(){
  
  if ( btnStatus == 1 && sensor0 > 1 && sensor1 > 1 ){ // TOUCH IS TRUE if RED AND ORANGE
    //isTouched = true;
    println("return");
    gotoScreen = 0; // Go to reading screen
  }
  
}

 //<>// //<>// //<>// //<>// //<>// //<>//

//SPLIT TEXT

String[] splitText(String input, float maxWidth) {
  String[] words = input.split(" ");
  String[] lines = new String[0];
  String currentLine = "";

  for (String word : words) {
    String testLine = currentLine + word + " ";
    float testWidth = textWidth(testLine);
    
    if (testWidth <= maxWidth) {
      currentLine = testLine;
    } else {
      // The current line has exceeded the bounding width, so start a new line
      lines = append(lines, currentLine);
      currentLine = word + " ";
    } 
  }
  
  // Add the remaining text as the last line
  lines = append(lines, currentLine);
  lines = append(lines, "\n\n");//2 new lines

  return lines;
}


//Save text file
void saveIntListsToFile(String filename, IntList... lists) {
  PrintWriter writer = createWriter(filename);

  if (writer != null) {
    for (IntList list : lists) {
      for (int i = 0; i < list.size(); i++) {
        writer.print(list.get(i)+",");
      }
      // Separate each list with a blank line
      writer.println("*");
    }
    writer.flush();
    writer.close();
    //println("IntLists saved to " + filename);
  } else {
    println("Error: Unable to create the file.");
  }
}


String getRandomItem(String[] items) {
  // Generate a random index within the range of the array length
  int randomIndex = int(random(items.length));
  // Return the item at the random index
  return items[randomIndex];
}

//LOAD BACKGROUND IMAGE
void loadBackgroundImage(int tintAlpha){
if(saveImage == true){
  PImage lastReadingImg;
  String imgPath = "capture-"+ magicnumbers+ ".png";
  lastReadingImg = loadImage(imgPath);
  //println(imgPath);
  tint(0,0,100,tintAlpha);
  if (lastReadingImg != null){
    image(lastReadingImg,0,0);
  }
  
}//end saveimage
}
