#include <math.h>            // for PI
#define WAVESIZE 256        // sine table length

uint16_t waveform[WAVESIZE];

const unsigned long READ_INTERVAL = 100;  // sample every 100 ms
unsigned long lastReadTime = 0;

void setup() {
  pinMode(DAC0, OUTPUT);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);
  Serial.begin(115200);
  analogReadResolution(12);
  analogWriteResolution(12);

  // build sine lookup table (0–4095)
  for (int i = 0; i < WAVESIZE; i++) {
    float angle = 2.0 * PI * i / WAVESIZE;
    waveform[i] = (uint16_t)(2048 + 2048 * sin(angle));
  }

  lastReadTime = millis();  // initialize the read-timer
}

void loop() {
  // generate a 1 kHz sine wave
  const int frequency = 1000;
  unsigned long periodUS = (1.0f / frequency) * 1e6;  
  unsigned long stepDelay = periodUS / WAVESIZE;

  for (int i = 0; i < WAVESIZE; i++) {
    analogWrite(DAC0, waveform[i]);

    // once per second, sample A0 and print
    if (millis() - lastReadTime >= READ_INTERVAL) {
      int voltage_salt = analogRead(A0);
      int voltage_temp = analogRead(A1);
      Serial.print(voltage_salt);
      Serial.print(",");
      Serial.println(voltage_temp);
      lastReadTime += READ_INTERVAL;
      // if you’d rather reset exactly to “now”, use:
      // lastReadTime = millis();
    }

    delayMicroseconds(stepDelay);
  }
}
