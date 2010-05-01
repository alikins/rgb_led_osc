//-----------------Processing code-----------------


import oscP5.*;        //  Load OSC P5 library
import netP5.*;        //  Load net P5 library
import processing.serial.*;    //  Load serial library

Serial arduinoPort;        //  Set arduinoPort as serial connection
OscP5 oscP5;            //  Set oscP5 as OSC connection

int redLED = 0;        //  redLED lets us know if the LED is on or off
int [][] leds = new int[2][2];
int [] led = new int [2];    //  Array allows us to add more toggle buttons in TouchOSC


void setup() {
  frameRate(15);
  size(100,100);        // Processing screen size
  noStroke();            //  We don’t want an outline or Stroke on our graphics
    oscP5 = new OscP5(this,8000);  // Start oscP5, listening for incoming messages at port 8000
    arduinoPort = new Serial(this, Serial.list()[0], 9600);    // Set arduino to 9600 baud
}

void oscEvent(OscMessage theOscMessage) {   //  This runs whenever there is a new OSC message

    String addr = theOscMessage.addrPattern();  //  Creates a string out of the OSC message
    println("osc msg: " + addr);
    println("osc msg.typetag: " + theOscMessage.typetag());
    theOscMessage.printData();
    
    if(addr.indexOf("/1/toggle") !=-1){   // Filters out any toggle buttons
      int i = int((addr.charAt(9) )) - 0x30;   // returns the ASCII number so convert into a real number by subtracting 0x30
      led[i]  = int(theOscMessage.get(0).floatValue());     //  Puts button value into led[i]
      leds[1][0] = int(theOscMessage.get(0).floatValue());
    // Button values can be read by using led[0], led[1], led[2], etc    
    }
    if(addr.indexOf("/1/fader1") !=-1) {
      
//      println("msg: " + addr);
      float firstValue = theOscMessage.get(0).floatValue();
//      println("firstValue: " + firstValue);
      leds[1][1] = int(firstValue*255);
   //   String secondValue = theOscMessage.get(1).stringValue();
    //  println("secondValue: " + secondValue);
     // float thirdValue = theOscMessage.get(2).floatValue();
     // print("### received an osc message /test with typetag ifs.");
   //   println(" values: "+firstValue+", "+secondValue+", "+thirdValue);
    }
}

void draw() {
  
 background(50);        // Sets the background to a dark grey, can be 0-255

  println("leds[1][1]: " + leds[1][1]);
   if(leds[1][0] == 0){        //  If led button 1 if off do....
    //arduinoPort.write("r");    // Sends the character “r” to Arduino
    redLED = 0;        // Sets redLED color to 0, can be 0-255
    arduinoPort.write(redLED);
  }
  
  //println("a: " + leds[1][0] + " b: " + leds[1][1]);
 if(leds[1][0] == 1){        // If led button 1 is ON do...
  //arduinoPort.write("R");    // Send the character “R” to Arduino
  redLED = leds[1][1];        // Sets redLED color to 255, can be 0-255
  arduinoPort.write(redLED);
  }
fill(redLED,0,0);            // Fill rectangle with redLED amount
   ellipse(50, 50, 50, 50);    // Created an ellipse at 50 pixels from the left...
                // 50 pixels from the top and a width of 50 and height of 50 pixels
}

//----------------------------------end processing code------------------------------------
