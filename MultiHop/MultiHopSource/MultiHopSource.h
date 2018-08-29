#ifndef MULTIHOPSOURCE_H
 #define MULTIHOPSOURCE_H
 
 enum {
   AM_MULTIHOPSOURCE = 6,
   TIMER_PERIOD_MILLI = 250
 };
 
typedef nx_struct MultiHopSourceMsg {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
  nx_uint16_t data;
} MultiHopSourceMsg;


 #endif
