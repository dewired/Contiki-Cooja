#include <Timer.h>
#include "MultiHopInter.h"
#include "printf.h"
 
 module MultiHopInterC {
  uses interface Boot;
  uses interface Leds;
  uses interface Timer<TMilli> as Timer0;
  uses interface Packet;
  uses interface AMPacket;
  uses interface AMSend;
  uses interface SplitControl as AMControl;
  uses interface Receive;
}
 
 implementation {

  bool busy = FALSE;
  message_t pkt;
  uint16_t temp;
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

	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
		if (len == sizeof(MultiHopInterMsg)) {
			MultiHopInterMsg* newpkt = (MultiHopInterMsg*)payload;
			temp = newpkt->nodeid;
			if (temp == 1){
				counter = newpkt->counter;		
				call Leds.set(newpkt->counter);
				printf("data number : %u \t received from node 1\n",counter);
				}
			}
		return msg;
	}

	event void Timer0.fired() {
		if (!busy) {
			MultiHopInterMsg* newpkt = (MultiHopInterMsg*)(call Packet.getPayload(&pkt, sizeof(MultiHopInterMsg)));
			newpkt->nodeid = 2;
			newpkt->counter = counter;
		if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(MultiHopInterMsg)) == SUCCESS) {
			busy = TRUE;
//			printf("data number : %u \t sent \n to node 3",counter);
			}
		}
		
	}

		// event void sendDone(message_t* msg, error_t error) {
		// }

	event void AMSend.sendDone(message_t* msg, error_t error) {
		if (&pkt == msg ) {
		  busy = FALSE;
		}
	}
}