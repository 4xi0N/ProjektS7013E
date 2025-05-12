#include <math.h> // This is so we can use pi
// This is the number of points in the sine lookup table, please see Wikipedia for further info
#define WAVESIZE 1024

// create an array of all the values from the sine lookup table. The array is empty, with allocated space in memory
uint16_t waveform[WAVESIZE];

void setup() {
  //Turns out the DAC does not run rail-to-rail, limited @ about 0.5-2.7 V
  pinMode(DAC0,OUTPUT);
  //Voltage signal input right after DAC-output to confirm this
  pinMode(A0,INPUT);
  Serial.begin(115200);
  analogReadResolution(12);
  analogWriteResolution(12);

  for (int i = 0; i < WAVESIZE; i++) {
    float angle = 2.0 * PI * i / WAVESIZE;
    // Generate a sine wave scaled to 0-4095. The mid value is 2047.
    waveform[i] = (uint16_t)(2047 + 2047 * sin(angle));
  }
}

void loop() {
  // set the AC-frequency
  int frequency = 3;
  //Calulate the period time in microseconds
  unsigned long periodTime = (1.0/frequency)*1000000;
  unsigned long stepDelay = periodTime/WAVESIZE;

  for (int i = 0; i < WAVESIZE; i++) {
    analogWrite(DAC0, waveform[i]);
    int voltage = analogRead(A0);
    // Print every 64th sample to reduce the number of data points
    if (i % 16 == 0) {
      Serial.println(voltage);
    }
    delayMicroseconds(stepDelay);
  }
}
