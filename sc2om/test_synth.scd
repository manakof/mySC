s.makeWindow;
s.boot;

(SynthDef(\test_synth,{
  |freq=330,amp=0.6,pan=0|
  var source,env;
  source = SinOsc.ar(freq);
  env = EnvGen.kr(Env.perc(),doneAction:2);
  source = source * env;
  Out.ar(0,Pan2.ar(source,pan,amp));
}).store;
)


a = Synth(\test_synth);
