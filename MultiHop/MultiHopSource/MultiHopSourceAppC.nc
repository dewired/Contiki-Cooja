#include <Timer.h>
 #include "MultiHopSource.h"
#include <printf.h>
 
 configuration MultiHopSourceAppC {
 }
 implementation {
   components MainC;
   components LedsC;
   components MultiHopSourceC as App;
   components new TimerMilliC() as Timer0;
   components ActiveMessageC;
   components new AMSenderC(AM_MULTIHOPSOURCE); 	
   components SerialPrintfC,SerialStartC;

   App.Boot -> MainC;
   App.Leds -> LedsC;
   App.Timer0 -> Timer0;
   App.Packet -> AMSenderC;
   App.AMPacket -> AMSenderC;
   App.AMSend -> AMSenderC;
   App.AMControl -> ActiveMessageC;
 }
