#include <Timer.h>
#include "MultiHopInter.h"
#include <printf.h>
 
configuration MultiHopInterAppC {
}
implementation {
   components MainC;
   components LedsC;
   components SerialPrintfC;
   components MultiHopInterC as App;
   components new TimerMilliC() as Timer0;
   components ActiveMessageC;
   components new AMSenderC(AM_MULTIHOPINTER);
   components new AMReceiverC(AM_MULTIHOPINTER); 	

   App.Boot -> MainC;
   App.Leds -> LedsC;
   App.Timer0 -> Timer0;
   App.Packet -> AMSenderC;
   App.AMPacket -> AMSenderC;
   App.AMSend -> AMSenderC;
   App.AMControl -> ActiveMessageC;
   App.Receive -> AMReceiverC;
 }
