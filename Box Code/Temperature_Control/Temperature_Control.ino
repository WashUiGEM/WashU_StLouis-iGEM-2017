/*
This is our code for a temperature sensor controlling a light bulb
in order to regulate heat in oour box
*/
#include <dht.h>

dht DHT;

#define DHT11_PIN 7
int pinOut = 8;

void setup(){
  Serial.begin(9600);
  pinMode(8, OUTPUT);
}

void loop()
{
  int chk = DHT.read11(DHT11_PIN);
  float readTemp = DHT.temperature;
  Serial.print("Temperature = ");
  Serial.println(readTemp);
  Serial.print("Humidity = ");
  Serial.println(DHT.humidity);
  if (readTemp <= 30){
    digitalWrite(pinOut, HIGH);
  }
  else {
    digitalWrite(pinOut, LOW);
  }
  delay(2000);            
}
