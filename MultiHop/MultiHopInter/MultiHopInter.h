#ifndef MULTIHOPINTER_H
 #define MULTIHOPINTER_H
 
 enum {
   AM_MULTIHOPINTER = 6,
   TIMER_PERIOD_MILLI = 250
 };
 
typedef nx_struct MultiHopInterMsg {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
  nx_uint16_t data;
} MultiHopInterMsg;


 #endif
