//----------------------Arduino code-------------------------


int message = 0;     //  This will hold one byte of the serial message
int redLEDPin = 9;   //  What pin is the red LED connected to?
int greenLEDPin = 10;
int blueLEDPin = 11;

int redLED = 0;          //  The value/brightness of the LED, can be 0-255
int greenLED = 0;
int blueLED = 0;

int redValue = 0;
int greenValue = 0;
int blueValue = 0;

void setup() {  
  Serial.begin(9600);  //set serial to 9600 baud rate
 // Serial.flush();
}

void loop(){
    // look for start of message
    if (Serial.available() > 3) {
  //    if (Serial.read() == 'R') {
       redValue = Serial.read(); 
       greenValue = Serial.read();
       blueValue = Serial.read(); 
    //  }
    //  Serial.println
      Serial.print(redValue);
      Serial.print(greenValue);
      Serial.print(blueValue);
      Serial.println('\n');
       message = 'R';
   // Serial.println(message);
  //  Serial.println(value, DEC);
   
    if (message == 'R'){  //  If a capitol R is received...
       redLED = redValue;       //  Set redLED to 255 (on)
       greenLED = greenValue;
       blueLED = blueValue;
    }
    if (message == 'r'){  //  If a lowercase r is received...
         redLED = 0;         //  Set redLED to 0 (off)
         greenLED = 0;
         blueLED = 0;
    }
      
    analogWrite(redLEDPin, redLED);  //  Write an analog value between 0-255
    analogWrite(greenLEDPin, greenLED);
    analogWrite(blueLEDPin, blueLED);
  }
}

//----------------------------end Arduino code--------------------------------
