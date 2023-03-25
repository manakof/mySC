s.boot;
s.makeWindow;
s.scope;
s.dumpOSC;
s.queryAllNodes();

thisProcess.openUDPPort(3000);
thisProcess.openPorts;
NetAddr.langPort
NetAddr.localAddr
  /*-- superCollider --*/
//n = NetAddr("127.0.0.1",57120);
//n = NetAddr("localhost",57110);
  /*--  old mac --*/
//n = NetAddr.new("192.168.0.10",12345);
  /*--  new mac --*/
//n = NetAddr.new("192.168.0.10",12345);
  /*-- local --*/
n = NetAddr.new("localhost",12345);

(
SynthDef(\my_test,{|freq=330,pan=0,amp=0.5 |
  var source,env;
  freq = Line.kr(50.0,freq,1);
  pan = SinOsc.kr(3);
  source = Saw.ar(freq);
  env = Env.perc(0.9,0.9,2.5,-8);
  source = source * EnvGen.ar(env,doneAction:2);
  Out.ar(0,Pan2.ar(source,pan,amp));
  SendReply.kr(Impulse.kr(30),'/my_test',[freq,amp,pan]);
}).store;
)

(
SynthDef("my_trig",{
  SendTrig.kr(Dust.kr(1.0),0,0.9);
}).send(s);
)
(
 f = OSCFunc({|msg,time,addr,recvPort|msg.postln;n.sendMsg("/sc/test",msg[3])},"/my_test");
)
f.free;
a = Synth(\my_test);
p = Pbind(\instrument,\my_test).play;
p.stop;

