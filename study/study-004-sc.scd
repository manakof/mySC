s.boot;
s.makeWindow;

thisProcess.openUDPPort(3000);
// old mac
//b = NetAddr.new("192.168.0.10",12345);
// new mac/
//b = NetAddr.new("192.168.0.10",12345);
// local
b = NetAddr.new("localhost",12345);

(
SynthDef(\my_test,{|freq=330,pan=0,amp=0.5 |
  var source,env;
  source = Saw(freq);
  env = EnvGen.ar(Env.perc(),doneAction:2);
  Out.ar(0,Pan2.ar(source*env,pan,amp));
}).store;
)

b.sendMsg("/sc/test","my_num");



