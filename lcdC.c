#include <reg51.h>
sfr ldata = 0x90; //P1=LCD data pins
sbit rs = P2^0;
sbit rw = P2^1;
sbit en = P2^2;
sbit busy = P1^7;
void main(){
lcdcmd(0x38);
lcdcmd(0x0E);
lcdcmd(0x01);
lcdcmd(0x06);
lcdcmd(0x86); //line 1, position 6
lcdcmd('M');
lcdcmd('D');
lcdcmd('E');
}
void lcdcmd(unsigned char value){
lcdready(); //check the LCD busy flag
ldata = value; //put the value on the pins
rs = 0;
rw = 0;
en = 1; //strobe the enable pin
MSDelay(1);
en = 0;
return;
	}
void lcddata(unsigned char value){
lcdready(); //check the LCD busy flag
ldata = value; //put the value on the pins
rs = 1;
rw = 0;
en = 1; //strobe the enable pin
MSDelay(1);
en = 0;
return;
}
void lcdready(){
busy = 1; //make the busy pin at input
rs = 0;
rw = 1;
while(busy==1){ //wait here for busy flag
en = 0; //strobe the enable pin
MSDelay(1);
en = 1;
}
void lcddata(unsigned int itime){
unsigned int i, j;
for(i=0;i<itime;i++)
for(j=0;j<1275;j++);
}