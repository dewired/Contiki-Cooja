// Source node
#include <Timer.h>
#include "MultiHopSource.h"
#include "printf.h"

 
 module MultiHopSourceC {
   uses interface Boot;
   uses interface Leds;
   uses interface Timer<TMilli> as Timer0;
  uses interface Packet;
  uses interface AMPacket;
  uses interface AMSend;
  uses interface SplitControl as AMControl;
}
 
 implementation {

  bool busy = FALSE;
  message_t pkt;
  
	uint8_t counter;

   event void Boot.booted() {
	call AMControl.start();
	}

   event void AMControl.startDone(error_t err) {
	if (err == SUCCESS) {
     	call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
	}
	else {
	call AMControl.start();
	}
}

	event void AMControl.stopDone(error_t err) {
	}

    	event void Timer0.fired() {
		counter++;	
		if (!busy) {
			MultiHopSourceMsg* newpkt = (MultiHopSourceMsg*)(call Packet.getPayload(&pkt, sizeof(MultiHopSourceMsg)));
			//newpkt->data = 1;
			//printf(newpkt->data);
			newpkt->nodeid = 1;
			newpkt->counter = counter;
			if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(MultiHopSourceMsg)) == SUCCESS) {
				busy = TRUE;
				}
		}
	}

	// event void sendDone(message_t* msg, error_t error) {
	// }

	event void AMSend.sendDone(message_t* msg, error_t error) {
		if (&pkt == msg) {
		  busy = FALSE;
		}
	}
}
 
