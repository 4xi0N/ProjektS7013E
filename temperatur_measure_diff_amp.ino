

void setup() {
  pinMode(A0,INPUT); // input pin
  pinMode(13,OUTPUT); // output pin
  digitalWrite(13,HIGH); // pin 13, max voltage
  Serial.begin(115200); // bits per second (baud-rate)
  analogReadResolution(12); // bit size range 0-4095
}

void loop() {
  // put your main code here, to run repeatedly:
  int voltage = analogRead(A0); // read the A0 pin
  Serial.print(voltage); // print value to serial port in ASCII text
  Serial.println(); // end print with newline

  delay(100); // 100 ms delay before next loop
}
