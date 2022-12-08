/*
  Read and write settings and calibration data to an external I2C EEPROM
  By: Nathan Seidle
  SparkFun Electronics
  Date: December 11th, 2019
  License: This code is public domain but you buy me a beer if you use this 
  and we meet someday (Beerware license).
  Feel like supporting our work? Buy a board from SparkFun!
  https://www.sparkfun.com/products/14764

  This example demonstrates how to set the various settings for a given EEPROM.
  Read the datasheet! Each EEPROM will have specific values for:
  Overall EEPROM size in bytes (512kbit = 65536, 256kbit = 32768)
  Bytes per page write (64 and 128 are common)
  Whether write polling is supported
  
  The I2C EEPROM should have all its ADR pins set to GND (0). This is default
  on the Qwiic board.

  Hardware Connections:
  Plug the SparkFun Qwiic EEPROM to an Uno, Artemis, or other Qwiic equipped board
  Load this sketch
  Open output window at 115200bps
*/

#include <Wire.h>

#include "SparkFun_External_EEPROM.h" // Click here to get the library: http://librarymanager/All#SparkFun_External_EEPROM
ExternalEEPROM myMem;

void setup()
{
  Serial.begin(115200);
  delay(10);
  Serial.println("I2C EEPROM example");

  Wire.begin();
  Wire.setClock(400000); //Most EEPROMs can run 400kHz and higher

  if (myMem.begin() == false)
  {
    Serial.println("No memory detected. Freezing.");
    while (1);
  }
  Serial.println("Memory detected!");

  //Set settings for this EEPROM
  myMem.setMemorySize(128000); //In bytes. 512kbit = 64kbyte
  myMem.setPageSize(128); //In bytes. Has 128 byte page size.
  myMem.enablePollForWriteComplete(); //Supports I2C polling of write completion
  myMem.setPageWriteTime(5); //5 ms max write time

  Serial.print("Mem size in bytes: ");
  Serial.println(myMem.length());

  Serial.println("Ready to download file. Send it!");
  
  /*byte myValue3 = 0xAD;
  myMem.put(0x10FFE, myValue3); //(location, data)
  
  byte myValue4 = 0xEE;
  myMem.put(0x0FFE, myValue4); //(location, data)
  byte myRead3;
  myMem.get(0x10FFE, myRead3); //location to read, thing to put data into
  Serial.print("I read: ");
  Serial.println(myRead3,HEX);
  myMem.get(0x0FFE, myRead3); //location to read, thing to put data into
  Serial.print("I read: ");
  Serial.println(myRead3,HEX);*/
}

uint32_t addr = 0;
byte incomingByte = 0x00;
byte testByte = 0x00;
//byte buf[1024];
//uint16_t buf_index = 0;
void loop()
{
  if (Serial.available() > 0) {
    //Read byte
    //uint16_t buf_index = 0;
    //for (buf_index = 0; buf_index < 1024; buf_index++) {
    incomingByte = Serial.read();
    //buf[buf_index] = incomingByte;
    //buf_index++;
    //if(buf_index == 1024) {
    //  buf_index = 0; 
    //  for (int i = 0; i < 1024; i++) {
    myMem.put(addr, incomingByte);

    /*myMem.get(addr, testByte);
    if(incomingByte != testByte) {
      Serial.println("Failed to write to eeprom");
    }*/
    
    addr++;
        //if(addr % (uint32_t)10000 == 0)
          //Serial.println(addr);
      
    //Serial.print("Sent 1024 bytes, curr addr: ");
    //Serial.println(addr);
    if(addr == 0x16260)
      Serial.println("Finished writing 90720 bytes");
  }
}
