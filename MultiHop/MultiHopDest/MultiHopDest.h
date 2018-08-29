#ifndef MULTIHOPDEST_H
 #define MULTIHOPDEST_H
 
 enum {
   AM_MULTIHOPDEST = 6,
   TIMER_PERIOD_MILLI = 250
 };
 
typedef nx_struct MultiHopDestMsg {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
  nx_uint16_t data;
} MultiHopDestMsg;


 #endif
 
