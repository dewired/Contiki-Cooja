#include <Timer.h>
 #include "MultiHopDest.h"
#include <printf.h>
 
 configuration MultiHopDestAppC {
 }
 implementation {
   components MainC;
   components LedsC;
   components MultiHopDestC as App;
   components new TimerMilliC() as Timer0;
   components ActiveMessageC;
   components new AMSenderC(AM_MULTIHOPDEST);
   components new AMReceiverC(AM_MULTIHOPDEST); 	
   components SerialPrintfC,SerialStartC;

   App.Boot -> MainC;
   App.Leds -> LedsC;
   App.Timer0 -> Timer0;
   App.Packet -> AMSenderC;
   App.AMPacket -> AMSenderC;
   App.AMSend -> AMSenderC;
   App.AMControl -> ActiveMessageC;
   App.Receive -> AMReceiverC;
 }
