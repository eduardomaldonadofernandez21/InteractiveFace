import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

int mainX, mainY, mainW, mainH;

OpenCV opencv;
Capture video;


void setup() {

  size(640, 480);
  verifyCamera();
  noFill();
  strokeWeight(1);
  stroke(0,255,0);

  mainW = mainH = 200;
  mainX = width/2 - mainW/2;
  mainY = height/2 - mainH/2;

  video = new Capture(this, 640, 480);
  video.start();

  opencv = new OpenCV(this, 640, 480);

}


void draw() {

  if (video.available() == true) {
    video.read();
  }   
  
  opencv.loadImage(video);

  image(video, 0, 0);

  //rect(mainX, mainY, mainW, mainH);
  //ellipse(mainX + mainW/2, mainY + mainH/2, 5, 5);

  opencv.calculateOpticalFlow();
  opencv.drawOpticalFlow();
  
  //PVector aveFlow = opencv.getAverageFlowInRegion(mainX, mainY, mainW, mainH);
  //line(mainX + mainW/2, 
  //  mainY + mainH/2, 
  //  mainX + mainW/2 + aveFlow.x*25, 
  //  mainY + mainH/2 + aveFlow.y*25);
}

void verifyCamera(){
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("No hay cámaras disponibles para la captura.");
    exit();
  }
  else {
    println("Camaras disponibles:");
    for (int i = 0; i < cameras.length; i++) println(cameras[i]);
  }
}
