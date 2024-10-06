/////////////////////////
//  Tellatuft 10
////**** USE "Tellatuft-data-source-esp32" ARDUINO SKETCH **** 

//TO DO//
// Save Data to JSONObject and file -DONE 
//Develop gallery to show previous readings
//navigate to the gallery
//return to the reading

//TO FIX
//pink reading is weird if chosen after red reading - check color array

//Controls
//..//
//g = graphs overlayed for each reading
//..//


///////////////////////////
////////CONFIG////////////
////////////////1/////////
boolean offline = true; //TESTING OFFLINE
//DASHBOARD 
int dashboardId = 1; //Dashboard output number - set in UI
int valueIncrement = 7;
int speed = 5;//lower slower
boolean saveImage = false;
boolean isRPI = false;
int scale = 0;
int colorMode = 0;//0=Black , 360=White
boolean debug = false;
boolean fullscreen =true;
/////////////////////////


import processing.serial.*;
import java.util.Random;
import processing.data.JSONArray;
import processing.data.JSONObject;

ArrayList<ArrayList<ArrayList<Integer>>> allDataArrays;
ArrayList<Integer> colors;
int arraySize = 5;
int numElements = 200;
float graphHeight = height*0.7;
boolean saveDataComplete = false;
String dataFilePath = "data/data.json";


//SERIAL
static final int PORT_INDEX = 4, BAUDS = 9600;//9600//115200 ?
String serialData = "";
String[] sensorData; //contains the serialdata
String magicnumbers; //to hold a string of all the final average readings

Serial myPort;        // The serial port
float sensor0,sensor1,sensor2,sensor3,sensor4;// Incoming serial data
int btnStatus;// Incoming serial data

boolean newData = false;

boolean savedScreen1 = false; 
boolean savedScreen2 = false; //status of saved image when completed.
boolean hasRunOnce = false;
boolean hasDrawnOnce = false;
boolean noHand = true;
boolean readingFinished = false;



//Interface
int gotoScreen;
int len0,len1,len2,len3,len4 =0;

float touch0,touchBar0,hand0 = 0;
float touch1,touchBar1,hand1 = 0;
float touch2,touchBar2,hand2 = 0;
float touch3,touchBar3,hand3= 0 ;
float touch4,touchBar4,hand4 = 0;

// Initialise arrays of user data for 'reading' 
IntList touchData0 = new IntList(); 
IntList touchData1 = new IntList(); 
IntList touchData2 = new IntList(); 
IntList touchData3 = new IntList(); 
IntList touchData4 = new IntList(); 

int sum0,sum1,sum2,sum3,sum4; //  sums
int avg0,avg1,avg2,avg3,avg4; //  averages

boolean partTouched = false;
boolean allTouched = false;
//timer
int interval = 100; // Check every 10th of a  second
int lastCheckTime = 0;

PFont introFont;
PFont resultsFont;

//tellatuft logo colours

int hue[] = {0, 177, 347, 35, 316,70};
float sat[] = {0, 100,100,100,70,100};
float bri[] = {0, 50,80,90,80,80};

            //orange,red,blue,lime,pink
int hue2[] = {35, 347, 177, 70,316};
float sat2[] = {100,100,100,100,70};
float bri2[] = {90,80,50,80,80};

int hue3[] = {35, 347, 177, 70,316};
int sat3[] = {100,100,100,70,100};
int bri3[] = {50,80,90,80,80};


int hue4[] = {35, 347, 177, 70,316};
float sat4[] = {100,100,100,100,70};
float bri4[] = {90,80,50,80,80};


IntList[] tuftAreas;
float[] angles;
color[] listColors;
color[] listColors2;
int[] averages;
String[] elements = { "Earth","Fire","Water","Air","Ether"};

///////////

void setup () {
  
  // set the window size:
  //size(768, 1024);//SIZE FOR PORTRAIT PI
    fullScreen();
    //size(800,600); //SIZE FOR SMALLSCREEN PI
  
  //
  colorMode (HSB, 360, 100, 100, 100 ); // mode, rangeH, rangeS, RangeB, rangeAlpha
  background(colorMode);  //0=black , 360=white
  
  allDataArrays = new ArrayList<ArrayList<ArrayList<Integer>>>();
  colorMode (HSB, 360, 100, 100, 100 ); // mode, rangeH, rangeS, RangeB, rangeAlpha
  colors = new ArrayList<Integer>();
  addColors();
  
  if (previousDataExists()) {
    text("loading...",50,50);   
    loadDataArrays();
  }
  
  
  final String[] ports = Serial.list();
  //println(Serial.list());
  if(!offline){
    if (isRPI == true){
      myPort = new Serial(this, "/dev/ttyUSB0", BAUDS);   ////FOR PI/////
      myPort.bufferUntil('\n');
    }else{
      myPort = new Serial(this, ports[PORT_INDEX], BAUDS);//port [3] when USB - port [2] when BT
      myPort.bufferUntil('\n');
      /////FOR MAC USB /// ///dev/cu.SLAB_USBtoUART 
      /////FOR ESP BT // /dev/cu.ESP32test-ESP32SPP
    }
  // A serialEvent() is generated when a newline character is received :
  //myPort.bufferUntil('\n'); //<>//
  
}
  //background(0);      // set inital background:
 
  //font
  introFont = createFont("Futura-Medium", 32);
  //textFont(introFont);
  resultsFont = createFont("Herculanum", 32);
  textFont(resultsFont);
  
  //timer
  lastCheckTime = millis();
  
  delay(1000); //wait for serial event to initialise.
}


void draw () {

  //SCREEN UI
  switch(gotoScreen) {
  case 0: drawScreenZero(); break;
  case 1: drawScreenOne(); break;
  case 2: drawScreenTwo(); break;
  
  case 3: drawScreenOrange(); break; 
  case 4: drawScreenRed(); break;
  case 5: drawScreenBlue(); break;
  case 6: drawScreenLime(); break;
  case 7: drawScreenPink(); break;
  case 8: drawScreenReading();break;
  
  case 9: drawScreenPreRead();break;
  //default: background(0,0,0,100); break; 
  }
  
  //isAllhandPresent();
  //btnScreen();

}//end Draw

void serialEvent (Serial myPort) {
   //println(myPort);
  
if(!offline){  
  // get the ASCII string:
  
  if ( myPort.available() > 0) {  // If data is available,
     serialData = myPort.readStringUntil('\n');         // read it and store it in val
  }
  
  //println(serialData);
  if (serialData != null) {
   // println("serial ok");

    serialData = trim(serialData);// trim off whitespaces.
    
    sensorData = split(serialData, ',');
    //println(sensorData.length); 
    
    //Capture incoming data and split into separate vars
    //EXPECTS DATA IN x,x,x,x,x,x FORMAT    
    /////////////////////////////////////
  //if (sensorData != null){
    if (sensorData.length > 1){ //Error checking for first few bad characters 
    sensor0 = int(sensorData[0]);           // convert to a number.   
    sensor1 = int(sensorData[1]);           // convert to a number.   
    sensor2 = int(sensorData[2]);           // convert to a number.   
    sensor3 = int(sensorData[3]);           // convert to a number.   
    sensor4 = int(sensorData[4]);           // convert to a number.
    
    if (isRPI == true){
      sensor0 = sensor0/2;
      sensor1 = sensor1/2;
      sensor2 = sensor2/2;
      sensor3 = sensor3/2;
      sensor4 = sensor4/2;
    }
   }

    //DEBUG
    if (debug){
    //println(sensor0+" "+sensor1+" "+sensor2+" "+sensor3+" "+sensor4);
    }
    //
    
    //Hand button
    btnStatus = int(sensorData[5]);
    //println(btnStatus);
    newData = true; 
    
    //DEBUG SENSORS//
    //println(serialData); //DEBUG INCOMING SERIAL DATA 
    /////////////////
    /*
    print("timer is running = ");
    println(timer.isRunning()); 
    print("time left: ");println(timer.getTimeLeftUntilFinish());
    print("isTouched: ");println(isTouched);
    print("screen: ");println(gotoScreen);
    */
    
  } else {
    //THIS DOESNT WORK
    //text("Serial error",10,10);
    //println("serial error");
  }
}
}
