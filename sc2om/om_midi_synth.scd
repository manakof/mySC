s.boot;
s.makeWindow
{SinOsc.ar(440)}.play

(
var notes, on, off;
MIDIClient.init;
MIDIIn.connectAll;
notes = Array.newClear(128);    // array has one slot per possible MIDI note
on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    notes[num] = Synth(\default, [\freq, num.midicps,
        \amp, veloc * 0.00315]);

       
"note_on :"+[veloc,num,chan,src].postln;

});
off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    notes[num].release;
  "note_off :"+ [veloc,num,chan,src].postln;
});
q = { on.free; off.free; };
)



// when done:
q.value;


