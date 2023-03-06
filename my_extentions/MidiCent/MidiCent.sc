
   MidiCent{
       
  * to_freq{|midicent concert_pitch=440|
  ^ concert_pitch * pow(2,(midicent-6900)/1200);
 }
  
 * to_midicent{|freq,concert_pitch=440|
  ^log2(freq/concert_pitch) * 1200+6900;
  }
  
}
  
