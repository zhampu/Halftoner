import drop.*;
SDrop drop;
PImage img;
import processing.pdf.*;
color elcolor = color(0); 

//int imageHeight = img.height;
//int imageWidth = img.width;
void setup() {
  //fullScreen();
  size(1500,1700);
  frameRate(60);
  drop = new SDrop(this);
  ellipseMode(CENTER); 
  img = loadImage("acme.jpg");
  img.get () ;
  noStroke();
  smooth();
}
void draw() {
   background( 255 );
  fill( elcolor );
   
 //translate(height/2, width/2);
 // rotate(radians(millis() * 0.01));
 // rotate(radians(30));
 //  translate(-height/2, -width/2);

  if(img !=null) {
    for (int y=0;y<img.height;y+=steps) {
      for (int x=0;x<img.width;x+=steps) {
        float val = ( red( img.get(x, y) ) + green( img.get(x, y) ) + blue( img.get(x, y) ) ) / 3;
        float s = map(val, 0, 255, 1, 3 * scl );
        s = (3 * scl) - s;
        pushMatrix();
     
     translate(0.5, 0.5);
     shearX(PI);
     ellipse(x*scl, y*scl, s * dotSize , s * dotSize );
     popMatrix();
      

      }
    }
  }
    

  
}

float dotSize = 1;
float scl = 2;
float steps1 = 3;
float steps = 3;

void keyPressed() {
  switch(key) {
    case('+'): scl+=0.09;break;
    case('-'): scl-=0.09;break;
    case('e'): export();break;
    case('c'): elcolor = color(0, 255, 255);break;
    case('m'): elcolor = color(255, 0, 255);break;
    case('y'): elcolor = color(255, 255, 0);break;
    case('k'): elcolor = color(0);break;
  
  }
  
  
  if (key == CODED) {
    if (keyCode == UP) {
      dotSize+=0.09;
      println(dotSize);
      text(dotSize, 20, 20);
    } else if (keyCode == DOWN) {
      dotSize-=0.09;
      println("dotsize"+dotSize);
    } 
  }
  
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      steps+=0.4;
    } else if (keyCode == RIGHT) {
      steps-=0.4;
    } 
  }
  
  
}


void export() {
  PGraphics exporting = createGraphics(int(img.width * scl) , int(img.height * scl), PDF, "foto-"+int(random(10000))+".pdf");
  exporting.beginDraw();
  exporting.image(img, 0, 0);
  
  exporting.background( 255 );
  exporting.fill( elcolor );
  exporting.noStroke();

  for (int y=0;y<img.height;y+=steps) {
      for (int x=0;x<img.width;x+=steps) {
        float val = ( red( img.get(x, y) ) + green( img.get(x, y) ) + blue( img.get(x, y) ) ) / 4;
        float s = map(val, 0, 255, 1, 3 * scl );
        s = (3 * scl) - s;
        exporting.ellipse(x*scl, y*scl, s * dotSize , s * dotSize );
        
      }
    }
  exporting.endDraw(); // stop and save pdf
  exporting.dispose();
  println("... done exporting.");
}


void dropEvent(DropEvent theDropEvent) {
  println("");
  println("isFile()\t"+theDropEvent.isFile());
  println("isImage()\t"+theDropEvent.isImage());
  println("isURL()\t"+theDropEvent.isURL());
  
  // if the dropped object is an image, then 
  // load the image into our PImage.
  if(theDropEvent.isImage()) {
    println("### loading image ...");
    img = theDropEvent.loadImage();
  }
}
