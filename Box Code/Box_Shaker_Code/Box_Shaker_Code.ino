/*
stepper test sketch 

FROM LJ on #MakerGear IRC

connect enable pin to arduino pin 10
connect step pin to arduino pin 9
connect direction pin to arduino pin 8

At full stepping, 5 millisecond delay time gives 1 rpm
So at half stepping, 2.5 milliseconds delay time gives 1 rpm
so at 1/4 stepping, 1.25 milliseconds delay time gives 1 rpm
so at 1/8 stepping, 0.625 milliseconds delay time gives 1 rpm
so at 1/16 stepping, 0.3125 milliseconds delay time gives 1 rpm

NOTE:
delay(1);                // means delay 1 millisecond
delayMicroseconds(1);    // means delay 1 MICROsecond

So, use microseconds as the units!



Timing

The Arduino delayMicroseconds() function creates the shortest delay possible from within the Arduino language. The shortest delay possible is about 2 us (microseconds).
For shorter delays use assembly language call 'nop' (no operation). Each 'nop' statement executes in one machine cycle (at 16 MHz) yielding a 62.5 ns (nanosecond) delay.
  __asm__("nop\n\t"); 

  __asm__("nop\n\t""nop\n\t""nop\n\t""nop\n\t");  \\ gang them up like this

*/

// MOTOR 1
int ms1 = 8;
int ms2 = 9;
int ms3 = 10;
int en1 = 11;
int step1 = 3;
int dir1 = 4;
/*
// MOTOR 2
int en2 = 8;
int step2 = 7;
int dir2 = 6;

// MOTOR 3
int en3 = 5;
int step3 = 4;
int dir3 = 3;

// MOTOR 4
int en4 = 2;
int step4 = 1;
int dir4 = 0;

*/
// Don't forget to count!
int count = 0;


// The setup() method runs once, when the sketch starts
void setup()   {                
  // initialize the digital pin as an output:
  pinMode(en1, OUTPUT);     
  pinMode(step1, OUTPUT);     
  pinMode(dir1, OUTPUT);  
  pinMode(ms1, OUTPUT);
  pinMode(ms2, OUTPUT);
  pinMode(ms3, OUTPUT);
//  pinMode(en2, OUTPUT);     
//  pinMode(step2, OUTPUT);     
//  pinMode(dir2, OUTPUT);  
//  pinMode(en3, OUTPUT);     
//  pinMode(step3, OUTPUT);     
//  pinMode(dir3, OUTPUT);  
//  pinMode(en4, OUTPUT);     
//  pinMode(step4, OUTPUT);     
//  pinMode(dir4, OUTPUT);  
  digitalWrite(en1, LOW);
  digitalWrite(step1, LOW);
  digitalWrite(dir1, LOW);
  digitalWrite(ms1, HIGH);
  digitalWrite(ms2, HIGH);
  digitalWrite(ms3, HIGH);
//  digitalWrite(en2, LOW);
//  digitalWrite(step2, LOW);
//  digitalWrite(dir2, HIGH);
//  digitalWrite(en3, LOW);
//  digitalWrite(step3, LOW);
//  digitalWrite(dir3, HIGH);
//  digitalWrite(en4, LOW);
//  digitalWrite(step4, LOW);
//  digitalWrite(dir4, HIGH);
  // open the serial port at 9600 bps:
    //  Serial.begin(9600);

}


void stepWithPause(int pause) {
  digitalWrite(step1, HIGH);
//  digitalWrite(step2, HIGH);
//  digitalWrite(step3, HIGH);
//  digitalWrite(step4, HIGH);
  delayMicroseconds(pause);
  // Add 500 nanoseconds! So we have 312.5 microseconds. This means 8 * 62.5 ns. 
//  __asm__("nop\n\t""nop\n\t""nop\n\t""nop\n\t""nop\n\t""nop\n\t""nop\n\t""nop\n\t");
  digitalWrite(step1, LOW);
//  digitalWrite(step2, LOW);
//  digitalWrite(step3, LOW);
//  digitalWrite(step4, LOW);
}


// the loop() method runs over and over again,
// as long as the Arduino has power
void loop()                     
{
  
  // 20 revolutions in 17.2 sec with 256 microsecond pause between steps, with 1/16th stepping
  // 298 is exactly 1 Hz.
  // 149 is exactly 2 Hz.
  // 596 is exactly 1/2 Hz.
  
  int regularPause = 67;
  
//  digitalWrite(enx, LOW);
//  digitalWrite(dirx, HIGH);
//  // HOW LONG DOES IT TAKE TO RUN THIS COMMAND?
// This is where the work gets done!
  int numberOfSteps = 3200;

//  // Accelerate from zero to full speed in the first revolution!!
  if (count < numberOfSteps) {
    for (count=0; count<numberOfSteps/10; count++) {stepWithPause(regularPause * 10);}
    for (; count<2*numberOfSteps/10; count++) {stepWithPause(regularPause * 9);}
    for (; count<3*numberOfSteps/10; count++) {stepWithPause(regularPause * 8);}
    for (; count<4*numberOfSteps/10; count++) {stepWithPause(regularPause * 7);}
    for (; count<5*numberOfSteps/10; count++) {stepWithPause(regularPause * 6);}
    for (; count<6*numberOfSteps/10; count++) {stepWithPause(regularPause * 5);}
    for (; count<7*numberOfSteps/10; count++) {stepWithPause(regularPause * 4);}
    for (; count<8*numberOfSteps/10; count++) {stepWithPause(regularPause * 3);}
    for (; count<9*numberOfSteps/10; count++) {stepWithPause(regularPause * 2);}
    for (; count<10*numberOfSteps/10; count++) {stepWithPause(regularPause * 1.5);}
  }
  
  
  stepWithPause(regularPause);
  
}


