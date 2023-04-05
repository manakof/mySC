s.boot;
s.makeWindow;
s.scope;
s.freqscope;
s.dumpOSC;
s.queryAllNodes();
/*
thisProcess.openUDPPort(3000);
thisProcess.openPorts;
NetAddr.langPort
NetAddr.localAddr
*/
/*-- superCollider --*/
//n = NetAddr("127.0.0.1",57120);
//n = NetAddr("localhost",57110);
  /*--  old mac --*/
//n = NetAddr.new("192.168.0.10",12345);
  /*--  new mac --*/
n = NetAddr.new("172.20.10.6",12345);
n = NetAddr.new("192.168.122.1",12345);
  /*-- local --*/
n = NetAddr.new("localhost",12345);

(
SynthDef(\my_sin,{|freq(440),pan(0),amp(0.5),atk(0.1),rel(0.5),lev(0.6),cuv(-4.0)|
  var source,env;
  source = Pulse.ar(freq);
  env = Env.perc(atk,rel,lev,cuv);
  source = source * EnvGen.ar(env,doneAction:2);
  Out.ar(0,Pan2.ar(source,pan,amp));
  SendReply.kr(Impulse.kr(1),'/sc/my_sin',[freq,amp,pan,atk,rel,lev,cuv]);
}).store;
)
a = Synth(\my_sin,[\freq,83.midicps]);
(
SynthDef(\my_saw,{|freq=330,pan=0,amp=0.5 ,atk(0.1),rel(0.5),lev(0.6),cuv(-4.0)|
  var source,env;
  source = Saw.ar(freq);
  env = Env.perc(atk,rel,lev,cuv);
  source = source * EnvGen.ar(env,doneAction:2);
  Out.ar(0,Pan2.ar(source,pan,amp));
  SendReply.kr(Impulse.kr(1),'/sc/my_saw',[freq,amp,pan,atk,rel,lev,cuv]);
}).store;
)
a = Synth(\my_saw,[\freq,30]);
(
SynthDef(\my_noise,{|freq=330,pan=0,amp=0.5 ,atk(0.1),rel(0.5),lev(0.6),cuv(-4.0)|
  var source,env;
  source = WhiteNoise.ar(0.5);
  env = Env.perc(atk,rel,lev,cuv);
  source = source * EnvGen.ar(env,doneAction:2);
  Out.ar(0,Pan2.ar(source,pan,amp));
  SendReply.kr(Impulse.kr(1),'/sc/my_noise',[freq,amp,pan,atk,rel,lev,cuv]);
}).store;
)
a = Synth(\my_noise);
(
e.free;
f.free;
g.free;
e = OSCFunc({|msg,time,addr,recvPort|msg.postln;n.sendMsg("/sc/my_sin",msg[3])},"/sc/my_sin");
f = OSCFunc({|msg,time,addr,recvPort|msg.postln;n.sendMsg("/sc/my_saw",msg[3])},"/sc/my_saw");
g = OSCFunc({|msg,time,addr,recvPort|msg.postln;n.sendMsg("/sc/my_noise",msg[3])},"/sc/my_noise");
)
a = Pbind(\instrument,\my_sin,\dur,Pseq([0.8],inf));
b = Pbind(\instrument,\my_saw,\dur,Pseq([1],inf));
c = Pbind(\instrument,\my_noise,\dur,Pseq([1.5],inf));
p = Ppar([a,b,c]).play;
p.stop;
