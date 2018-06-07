import gab.opencv.*;
import processing.video.*;
import java.awt.*;

int overlay= 0;
PImage ears;
PImage Hat;
PImage Moustache;  
PImage UI;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  ears = loadImage ("1.png");
  Hat = loadImage ("2.png");
  Moustache = loadImage ("3.png");

  video.start();
}


void keyPressed()
{
  if (key == ENTER)
  {
    overlay += 1;
  }
}
void draw() {

  if (overlay >= 3)
  {
    overlay = 0;
  }
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );
  tint (255, 255, 255);
  fill(255);
  noStroke();
  rect (0, 180, width, 180);
  scale (0.4);
  image ( ears, 300, 450);
  image ( Hat, 100, 450);
  scale (1);
  image ( Moustache, 500, 450);


  fill (0);
  textAlign(CENTER);
  text ("PRESIONA ENTER PARA CAMBIAR FILTRO", width/2+50, 585);

  noFill();
  scale (2);
  stroke(0, 255, 0);
  strokeWeight(3);  
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  if (overlay == 1)
  {
    for (int i = 0; i < faces.length; i++) {
      tint (247, 176, 225);
      image (ears, faces[i].x+20, faces[i].y-100);
    }
  }
  if (overlay == 0)
  {
    for (int i = 0; i < faces.length; i++) {
      tint (0, 255, 0);
      image (Hat, faces[i].x+20, faces[i].y-100);
    }
  }
  if (overlay == 2)
  {
    for (int i = 0; i < faces.length; i++) {
      tint (255, 170, 170);
      image (Moustache, faces[i].x+40, faces[i].y+100);
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}
