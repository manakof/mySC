(
SynthDef("om_sine",{|midicent velocity time|
  var source,env,freq;
 freq = MidiCent.to_freq(midicent,440);
  source = SinOsc.ar(freq);
  env = EnvGen.ar(Env.perc(attackTime:0.4,releaseTime:2.0,curve:-2.0),doneAction:2);
  Out.ar(0,Pan2.ar(source*env));
}).store;
)

a = Synth(\om_sine,[\midicent ,6000]);
a.free;




MidiCent().to_freq(6000,440)







(
 ~midicent2freq = {|midicent concert_pitch=440|
  concert_pitch * pow(2,(midicent-6900)/1200);
};
)
~midicent2freq.value(6000);

(
~freq2midicent = {|freq,concert_pitch=440|
log2(freq/concert_pitch) * 1200+6900;  
}
)

~freq2midicent.value(262.1);



