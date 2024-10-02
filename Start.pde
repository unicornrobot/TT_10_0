//////START///////

void drawTitleScreen(){
     
  drawLogo(width*0.5, height*0.20, 80);//x,y,alpha
   
  //TEXT
  textSize(20);
if(colorMode == 0){fill(0,0,100);}
if(colorMode == 360){fill(0,100,0);}
  textAlign(CENTER);
  text("Discover your unique elemental signature.",width/2,height/2-100);
 // textAlign(CENTER,BOTTOM);
  text("Your individual map will be drawn from your touch,",width/2,height/2-70);
  text("revealing your symbiotic connection to the universe.",width/2,height/2-40);
  fill(248,6,60);
  text("Place your hand on the tuft to start the reading",width/2,height/2+30);
  //text("TellaTuft",width/2-60,height/2);
  
  float heightOffset = height/1.1;
  float widthOffset = 30;

  text("EARTH",width/5*0.4,heightOffset);

  text("WATER",width/5*1.4,heightOffset);

  text("AIR",width/5*2.4,heightOffset);

  text("FIRE",width/5*3.4,heightOffset);
  
  text("AETHER",width/5*4.5,heightOffset);
  
  
  //ELEMENTS
  noFill();
  strokeWeight(5);
  //ORANGE EARTH
  stroke(35,100,90); 
  //FIXED
  //triangle(50,400,100,500,150,400);//x,y,x,y,x,y,x,y
  //DYNAMIC 
  //triangle(width/5+25,heightOffset-50,width/5+75,heightOffset-150,width/5+125,heightOffset-50);//x,y,x,y,x,y,x,y
  triangle(width/5*0.2,heightOffset-50,width/5*0.2+50,heightOffset-150,width/5*0.2+100,heightOffset-50);//x,y,x,y,x,y,x,y
  line(width/5*0.2+10,heightOffset-100,width/5*0.2+85,heightOffset-100);
  
 //BLUE WATER
  stroke(177,100,50);
  //triangle(200,400,250,500,300,400);
  triangle(width/5*1.2,heightOffset-150,width/5*1.2+50,heightOffset-50,width/5*1.2+100,heightOffset-150);//x,y,x,y,x,y,x,y
  
  
  //PINK AIR
  stroke(316,70,80);
  //triangle(350,500,400,400,450,500);
  triangle(width/5*2.2,heightOffset-50,width/5*2.2+50,heightOffset-150,width/5*2.2+100,heightOffset-50);//x,y,x,y,x,y,x,y
  
  //line(360,450,440,450);
  line(width/5*2.2+10,heightOffset-100,width/5*2.2+85,heightOffset-100);
  
  
  //RED FIRE
  stroke(347,100,80);
  //triangle(500,500,550,400,600,500);
  triangle(width/5*3.2,heightOffset-150,width/5*3.2+50,heightOffset-50,width/5*3.2+100,heightOffset-150);//x,y,x,y,x,y,x,y
  
  
  //LIME AETHER
  stroke(70,100,80);
  //triangle(500,500,550,400,600,500);
  //ellipse(700,450,100,100);
  ellipse(width/5*4.5,heightOffset-100,100,100);//x,y,x,y,x,y,x,y
  
  //line(510,450,590,450);
 
  
  //line(660,450,740,450);
  
}
