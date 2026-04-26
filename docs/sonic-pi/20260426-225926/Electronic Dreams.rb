use_debug false

# Electronic Dreams
# Style: Ambient Electronic
# Mood: Dreamy and Atmospheric

use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Dreamy opening in Am — sparse percussion, FM melody, Prophet harmony
    2.times do
      in_thread do
        use_synth :fm
        play :a2, release: 16, divisor: 4, depth: 15, cutoff: 85, amp: 0.5
        
        with_fx :reverb, room: 0.25, mix: 0.3 do
          melody_notes = (ring :a4, :c5, :e5, :a5, :g5, :e5, :c5, :d5, :a4, :c5, :e5, :g5, :a5, :e5, :d5, :c5)
          16.times do
            play melody_notes.tick, cutoff: (line 90, 110, steps: 16).tick, release: 0.25, amp: 0.9
            sleep 0.25
          end
        end
      end
      
      in_thread do
        use_synth :prophet
        play_chord chord(:a3, :minor), cutoff: 85, release: 16, amp: 0.6
        
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :dark_ambience
          am_progression = (ring chord(:a3, :minor), chord(:f3, :major), chord(:c3, :major), chord(:g3, :major))
          4.times do
            play_chord am_progression.tick, cutoff: (line 80, 95, steps: 4).tick, release: 4, amp: 0.5
            sleep 4
          end
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 100, mix: 0.3 do
          with_fx :reverb, room: 0.2, mix: 0.25 do
            16.times do
              sample :bd_haus, amp: 0.5, cutoff: 90
              sample :hat_psych, amp: 0.25, rate: 1.2
              sleep 0.5
              sample :hat_psych, amp: 0.15, rate: 1.1
              sleep 0.5
            end
          end
        end
      end
      
      sleep 16
    end
    
    # Transition drone — bridges to key change section
    use_synth :prophet
    play :a2, cutoff: 90, release: 10, amp: 0.6
    
    in_thread do
      use_synth :hollow
      play_chord chord(:a3, :minor), cutoff: 88, release: 10, amp: 0.55
    end
    
    in_thread do
      4.times do
        sample :bd_haus, amp: 0.55, cutoff: 95
        sleep 0.5
        sample :elec_tick, amp: 0.3, rate: 2
        sleep 0.5
      end
    end
    
    sleep 4
    
    # Section 2: Key change to C major — full beat, Prophet melody, evolving harmony
    3.times do
      in_thread do
        use_synth :prophet
        play :c3, release: 12, cutoff: 88, amp: 0.4
        
        with_fx :lpf, cutoff: 110, mix: 0.3 do
          with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.25 do
            c_scale = (ring :c5, :e5, :g5, :c6, :b5, :g5, :e5, :d5, :c5, :g4, :e5, :d5, :c5, :e5, :g5, :b5)
            16.times do
              play c_scale.tick, cutoff: rrand(95, 115), release: 0.2, amp: 0.95
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        use_synth :prophet
        play_chord chord(:c3, :major), cutoff: 90, release: 12, amp: 0.65
        
        use_synth :dark_ambience
        c_progression = knit(chord(:c3, :major), 1, chord(:g3, :major), 1, chord(:a3, :minor), 1, chord(:f3, :major), 1)
        c_progression.length.times do
          play_chord c_progression.tick, cutoff: (line 85, 110, steps: 16).tick, release: 4, amp: 0.5
          sleep 4
        end
      end
      
      in_thread do
        16.times do |i|
          sample :bd_haus, amp: (i == 0) ? 0.6 : 0.5, cutoff: 100
          sample :hat_psych, amp: 0.3, rate: 1.3
          sleep 0.25
          
          sample :hat_psych, amp: 0.2, rate: 1.2
          sleep 0.25
          
          sample :elec_hi_snare, amp: 0.5, rate: 1.1
          sample :hat_psych, amp: 0.3, rate: 1.3
          sleep 0.25
          
          sample :hat_psych, amp: 0.2, rate: 1.2
          sample :elec_tick, amp: 0.25, rate: 2.5 if one_in(4)
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Transition drone — sustains into climax
    use_synth :fm
    play :c3, cutoff: 92, release: 10, divisor: 5, depth: 18, amp: 0.55
    
    in_thread do
      use_synth :hollow
      play_chord chord(:c3, :major7), cutoff: 92, release: 10, amp: 0.6
    end
    
    in_thread do
      4.times do
        sample :bd_haus, amp: 0.55, cutoff: 98
        sample :elec_tick, amp: 0.35, rate: 2.2
        sleep 0.5
        sample :elec_tick, amp: 0.25, rate: 2.5
        sleep 0.5
      end
    end
    
    sleep 4
    
    # Section 3: Climax — dense percussion, Blade melody, lush harmony
    2.times do
      in_thread do
        use_synth :blade
        play :c3, release: 14, cutoff: 100, vibrato_rate: 2, amp: 0.45
        
        dreamy_phrase = (knit :c5, 2, :e5, 2, :g5, 3, :c6, 1, :b5, 2, :g5, 2, :e5, 2, :d5, 2)
        dreamy_phrase.length.times do
          play dreamy_phrase.tick, cutoff: (line 85, 120, steps: 16).tick, release: 0.3, amp: 1.0
          sleep 0.25
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.4 do
          use_synth :hollow
          play_chord chord(:c3, :major7), cutoff: 95, release: 14, amp: 0.7
          
          use_synth :prophet
          climax_chords = (knit chord(:c3, :major), 2, chord(:e3, :minor), 2, chord(:g3, :major), 2, chord(:a3, :minor), 2)
          climax_chords.length.times do
            play_chord climax_chords.tick, cutoff: (line 90, 120, steps: 8).tick, release: 2, amp: 0.55
            sleep 2
          end
        end
      end
      
      in_thread do
        16.times do |i|
          sample :bd_haus, amp: (i == 0) ? 0.7 : 0.6, cutoff: 105
          sample :hat_psych, amp: 0.35, rate: 1.4, pan: rrand(-0.3, 0.3)
          sleep 0.25
          
          sample :hat_psych, amp: 0.25, rate: 1.3, pan: rrand(-0.3, 0.3)
          sample :elec_tick, amp: 0.35, rate: 3 if spread(3, 8).tick
          sleep 0.25
          
          sample :elec_hi_snare, amp: 0.6, rate: 1.15
          sample :hat_psych, amp: 0.35, rate: 1.4, pan: rrand(-0.3, 0.3)
          sample :elec_tick, amp: 0.3, rate: 2.8
          sleep 0.25
          
          sample :hat_psych, amp: 0.25, rate: 1.3, pan: rrand(-0.3, 0.3)
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Final fadeout — sparse beats dissolve with sustaining drone
    use_synth :prophet
    play :c3, cutoff: 85, release: 8, amp: 0.5
    
    in_thread do
      use_synth :hollow
      play_chord chord(:c3, :major7), cutoff: 85, release: 8, amp: 0.5
    end
    
    in_thread do
      8.times do |i|
        sample :bd_haus, amp: 0.4 - (i * 0.05), cutoff: 92
        sample :hat_psych, amp: 0.2 - (i * 0.02), rate: 1.1
        sleep 0.5
        sample :hat_psych, amp: 0.1 - (i * 0.01), rate: 1.0
        sleep 0.5
      end
    end
    
    sleep 8
    
  end
end