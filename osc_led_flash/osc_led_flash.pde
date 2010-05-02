//----------------------Arduino code-------------------------


int message = 0;     //  This will hold one byte of the serial message
int redLEDPin = 9;   //  What pin is the red LED connected to?
int yellowLEDPin = 8;
int redLED = 0;          //  The value/brightness of the LED, can be 0-255
int yellowLED = 0
int redValue = 0;
int yellowValue = 0;

void setup() {  
  Serial.begin(9600);  //set serial to 9600 baud rate
}

void loop(){
    if (Serial.available() > 2) { //  Check if there is a new message
     // message = Serial.read();    //  Put the serial input into the messag
     redValue = Serial.read();
     yellowValue = Serial.read();
     
     message = 'R';
 // Serial.println(message);
//  Serial.println(value, DEC);
   
   if (message == 'R'){  //  If a capitol R is received...
     redLED = redValue;       //  Set redLED to 255 (on)
     yellowLED = yellowValue;
   }
   if (message == 'r'){  //  If a lowercase r is received...
     redLED = 0;         //  Set redLED to 0 (off)
     yellowLED = 0;
   }

 }   
analogWrite(redLEDPin, redLED);  //  Write an analog value between 0-255
analogWrite(yellowLEDPin, yellowLED);
}

//----------------------------end Arduino code--------------------------------
