

void setup() {
  // put your setup code here, to run once:
  pinMode(A0,INPUT);
  pinMode(A1,INPUT);
  pinMode(13,OUTPUT);
  digitalWrite(13,HIGH);
  Serial.begin(115200);
  analogReadResolution(12);
}

void loop() {
  // put your main code here, to run repeatedly:
  int voltage1 = analogRead(A0);
  int voltage2 = analogRead(A1);
  int voltage = voltage2-voltage1;
  Serial.print(voltage);
  Serial.println();

  delay(100);
}
