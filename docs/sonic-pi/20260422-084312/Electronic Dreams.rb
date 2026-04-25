# Electronic Dreams
# Style: Electronic | Mood: Dreamy

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Dreamy Introduction in Am
    3.times do
      in_thread do
        use_synth :prophet
        play :a2, release: 12, cutoff: 85, amp: 0.5
      end
      
      in_thread do
        use_synth :bass_foundation
        play :a1, cutoff: 85, release: 12, amp: 0.5
        
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :dark_ambience
          play_chord chord(:a3, :minor), cutoff: 80, release: 10, amp: 0.4
          sleep 4
          
          use_synth :supersaw
          play_chord chord(:c3, :major), cutoff: 90, release: 3, amp: 0.3
          sleep 4
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          16.times do
            sample :bd_tek, amp: 0.5
            sample :hat_psych, amp: 0.25
            sleep 0.25
            sample :hat_psych, amp: 0.2
            sleep 0.25
            sample :elec_hi_snare, amp: 0.4
            sample :hat_psych, amp: 0.25
            sleep 0.25
            sample :hat_psych, amp: 0.2
            sleep 0.25
          end
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.3 do
        use_synth :fm
        melody_notes = (ring :a3, :c4, :e4, :a4, :e4, :c4, :d4, :c4)
        16.times do |i|
          play melody_notes.tick, cutoff: (line 90, 110, steps: 16).look, release: 0.2, divisor: 2, depth: 12, amp: 0.9
          sleep 0.25
        end
      end
    end
    
    # Transition drone to Section 2
    use_synth :hollow
    play :a2, cutoff: 95, release: 10, amp: 0.6
    use_synth :dark_ambience
    play_chord chord(:a3, :minor), cutoff: 95, release: 10, amp: 0.45
    sleep 4
    
    # Section 2: Building Intensity in Am
    3.times do
      in_thread do
        use_synth :fm
        play :a2, release: 10, cutoff: 88, amp: 0.4
      end
      
      in_thread do
        use_synth :bass_foundation
        play :a1, cutoff: 88, release: 10, amp: 0.55
        
        use_synth :supersaw
        harmony_chords = (knit chord(:a3, :minor), 2, chord(:f3, :major), 1, chord(:g3, :major), 1)
        4.times do
          play_chord harmony_chords.tick, cutoff: rrand(90, 110), release: 3.5, amp: 0.4
          sleep 4
        end
      end
      
      in_thread do
        16.times do
          sample :bd_tek, amp: 0.6
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sample :elec_cymbal, amp: 0.2 if one_in(4)
          sleep 0.25
          sample :elec_hi_snare, amp: 0.55
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
        end
      end
      
      use_synth :prophet
      harmony_notes = (knit :a3, 2, :c4, 2, :e4, 2, :g4, 2, :a4, 4, :e4, 4)
      16.times do
        play harmony_notes.tick, cutoff: rrand(95, 115), release: 0.15, amp: 0.95
        sleep 0.25
      end
    end
    
    # Transition drone to Section 3 (key change to C)
    use_synth :prophet
    play :c3, cutoff: 92, release: 12, amp: 0.65
    use_synth :bass_foundation
    play :c2, cutoff: 92, release: 12, amp: 0.6
    use_synth :dark_ambience
    play_chord chord(:c3, :major), cutoff: 95, release: 12, amp: 0.5
    sleep 4
    
    # Section 3: Climactic Dreamy Section in C Major
    4.times do
      in_thread do
        use_synth :prophet
        play :c3, release: 14, cutoff: 90, amp: 0.5
      end
      
      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 90, release: 14, amp: 0.6
        
        with_fx :reverb, room: 0.35, mix: 0.35 do
          use_synth :dark_ambience
          play_chord chord(:c3, :major7), cutoff: 95, release: 12, amp: 0.5
          sleep 4
          
          use_synth :supersaw
          play_chord chord(:e3, :minor), cutoff: 100, release: 3, amp: 0.35
          sleep 4
          
          play_chord chord(:f3, :major), cutoff: 105, release: 3, amp: 0.35
          sleep 4
          
          play_chord chord(:g3, :major), cutoff: 110, release: 3.5, amp: 0.4
          sleep 4
        end
      end
      
      in_thread do
        16.times do
          sample :bd_tek, amp: 0.7
          sample :hat_psych, amp: 0.35
          sleep 0.25
          
          sample :hat_psych, amp: 0.3
          sample :elec_cymbal, amp: 0.25 if spread(3, 8).tick
          sleep 0.25
          
          sample :elec_hi_snare, amp: 0.6
          sample :hat_psych, amp: 0.35
          sleep 0.25
          
          sample :hat_psych, amp: 0.3
          sleep 0.25
        end
      end
      
      with_fx :lpf, cutoff: 115 do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.25 do
          use_synth :hollow
          final_melody = (ring :c4, :e4, :g4, :c5, :b4, :g4, :e4, :d4)
          16.times do |i|
            play final_melody.tick, cutoff: (line 100, 130, steps: 16).look, release: 0.3, amp: 1.0
            sleep 0.25
          end
        end
      end
    end
    
    # Final Fadeout
    in_thread do
      use_synth :fm
      play :c3, release: 16, cutoff: 85, divisor: 3, depth: 15, amp: 0.6
      use_synth :dark_ambience
      play_chord chord(:c3, :major), cutoff: 85, release: 16, amp: 0.6
      use_synth :bass_foundation
      play :c2, cutoff: 80, release: 16, amp: 0.55
    end
    
    8.times do
      sample :bd_tek, amp: 0.4
      sample :hat_psych, amp: 0.2
      sleep 0.5
      sample :hat_psych, amp: 0.15
      sleep 0.5
    end
    
  end
end