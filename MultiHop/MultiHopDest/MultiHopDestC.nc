#include <Timer.h>
#include "MultiHopDest.h"
#include "printf.h"
 
 module MultiHopDestC {
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

    	event void Timer0.fired() {
	}

	event void AMSend.sendDone(message_t* msg, error_t error) {
	}

	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
		if (len == sizeof(MultiHopDestMsg)) {
			MultiHopDestMsg* newpkt = (MultiHopDestMsg*)payload;	
			//temp = newpkt->data;
			//temp++;
			//printf("Done");
			temp = newpkt->nodeid;
			if (temp == 2){		
				counter = newpkt->counter;		
				call Leds.set(newpkt->counter);
				printf("data number : %u \t received from node 2 \n",counter);
				}
			}
		return msg;
		}
 }
 
