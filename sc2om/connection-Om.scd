s.boot;
s.makeWindow;
s.quit;

NetAddr.langPort;
NetAddr.localAddr;
thisProcess.openPorts;
s.dumpOSC(0);


thisProcess.openUDPPort(3000);
(
o = OSCFunc({ |msg time addr recvPort|
  [msg, time, addr, recvPort].postln; 
Synth(\om_sine,[\midicent,msg[1]]);
 }, '/om/note');
)

o.free
