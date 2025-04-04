

void setup() {
  // put your setup code here, to run once:
  pinMode(A0,INPUT);
  pinMode(13,OUTPUT);
  digitalWrite(13,HIGH);
  Serial.begin(115200);
  analogReadResolution(12);
}

void loop() {
  // put your main code here, to run repeatedly:
  int voltage = analogRead(A0);
  Serial.print(voltage);
  Serial.println();

  delay(100);
}
