//----------------------Arduino code-------------------------


int message = 0;     //  This will hold one byte of the serial message
int redLEDPin = 9;   //  What pin is the red LED connected to?
int redLED = 0;          //  The value/brightness of the LED, can be 0-255
int value = 0;

void setup() {  
  Serial.begin(9600);  //set serial to 9600 baud rate
}

void loop(){
    if (Serial.available() > 0) { //  Check if there is a new message
     // message = Serial.read();    //  Put the serial input into the messag
     value = Serial.read();
    message = 'R';
 // Serial.println(message);
//  Serial.println(value, DEC);
   
   if (message == 'R'){  //  If a capitol R is received...
     redLED = value;       //  Set redLED to 255 (on)
   }
   if (message == 'r'){  //  If a lowercase r is received...
     redLED = 0;         //  Set redLED to 0 (off)
   }

 }   
analogWrite(redLEDPin, redLED);  //  Write an analog value between 0-255
}

//----------------------------end Arduino code--------------------------------
