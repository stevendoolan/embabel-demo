use_debug false
use_bpm 128

# Feed the Birds (EDM Remix)
# Style: Uplifting EDM with lush pads and punchy beats

with_fx :level, amp: 0.8 do
  
  # Main melody and counter-melody
  live_loop :edm_melody do
    with_fx :reverb, room: 0.4, mix: 0.4 do
      use_synth :saw
      
      2.times do
        play :c5, cutoff: 110, release: 0.4, amp: 1.3
        sleep 0.5
        play :c5, cutoff: 100, release: 0.3, amp: 1.2
        sleep 0.5
        play :b4, cutoff: 95, release: 0.6, amp: 1.2
        sleep 1
        play :g4, cutoff: 105, release: 0.4, amp: 1.3
        sleep 0.5
        play :c5, cutoff: 100, release: 0.3, amp: 1.2
        sleep 0.5
        play :g4, cutoff: 90, release: 0.4, amp: 1.2
        sleep 0.5
        play :f4, cutoff: 95, release: 0.6, amp: 1.2
        sleep 0.5
      end
    end
  end
  
  # Arpeggio layer
  live_loop :arp_layer do
    with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.3 do
      use_synth :beep
      notes = (ring :c4, :e4, :g4, :c5, :e5, :g4, :c5, :e4)
      
      16.times do
        play notes.tick, cutoff: (line 80, 120, steps: 16).look, release: 0.15, amp: 1.1
        sleep 0.25
      end
    end
  end
  
  # Chiplead counter-melody
  live_loop :chip_counter do
    use_synth :chiplead
    
    play :e5, cutoff: 100, release: 0.3, amp: 1.2
    sleep 1
    play :d5, cutoff: 95, release: 0.3, amp: 1.1
    sleep 0.5
    play :c5, cutoff: 90, release: 0.3, amp: 1.1
    sleep 0.5
    
    play :g5, cutoff: 110, release: 0.3, amp: 1.3
    sleep 1
    play :e5, cutoff: 100, release: 0.3, amp: 1.2
    sleep 1
    
    play :f5, cutoff: 105, release: 0.3, amp: 1.2
    sleep 1
    play :d5, cutoff: 95, release: 0.3, amp: 1.1
    sleep 0.5
    play :c5, cutoff: 90, release: 0.3, amp: 1.1
    sleep 0.5
    
    play :e5, cutoff: 100, release: 0.6, amp: 1.2
    sleep 2
  end
  
  # Sustained pad chords and atmospheric layers
  live_loop :pad_chords do
    with_fx :reverb, room: 0.4, mix: 0.4 do
      use_synth :supersaw
      
      chords_progression = [
        chord(:c3, :major),
        chord(:c3, :major),
        chord(:g3, :major),
        chord(:g3, :major)
      ]
      
      4.times do
        play_chord chords_progression.tick, cutoff: (line 85, 105, steps: 4).look, release: 3.8, amp: 0.5
        sleep 4
      end
    end
  end
  
  # Hollow atmospheric layer
  live_loop :hollow_atmosphere do
    use_synth :hollow
    harmony_notes = (ring :c3, :e3, :g3, :c4, :g3, :e3, :g3, :b3)
    
    16.times do
      play harmony_notes.tick, cutoff: (line 80, 110, steps: 16).look, release: 0.4, amp: 0.4
      sleep 0.5
    end
  end
  
  # Bass synth
  live_loop :bass do
    use_synth :fm
    bass_notes = (ring :c2, :c2, :g2, :g2)
    
    4.times do
      play bass_notes.tick, cutoff: 85, release: 0.9, amp: 1.5
      sleep 1
    end
  end
  
  # Four-on-the-floor EDM beat
  live_loop :edm_beat do
    with_fx :hpf, cutoff: 100 do
      with_fx :reverb, room: 0.2, mix: 0.25 do
        sample :bd_haus, amp: 0.8, cutoff: 90
        sleep 0.5
        sample :hat_cats, amp: 0.3, rate: 1.2
        sleep 0.5
        
        sample :bd_haus, amp: 0.6, cutoff: 90
        sample :elec_hi_snare, amp: 0.6, cutoff: 100
        sleep 0.5
        sample :hat_cats, amp: 0.3, rate: 1.2
        sleep 0.5
        
        sample :bd_haus, amp: 0.6, cutoff: 90
        sleep 0.5
        sample :hat_cats, amp: 0.3, rate: 1.2
        sleep 0.5
        
        sample :bd_haus, amp: 0.6, cutoff: 90
        sample :elec_hi_snare, amp: 0.6, cutoff: 100
        sleep 0.5
        sample :hat_cats, amp: 0.3, rate: 1.2
        sleep 0.5
      end
    end
  end
  
  # Additional hi-hat texture and cymbal accents
  live_loop :percussion_fills do
    with_fx :lpf, cutoff: 95, mix: 0.3 do
      8.times do |i|
        sample :hat_cats, amp: 0.25, rate: 1.3, pan: (line -0.3, 0.3, steps: 8).tick
        sleep 0.25
        
        if i == 7
          sample :elec_cymbal, amp: 0.4, rate: 0.9 if one_in(2)
        end
      end
    end
  end
  
end