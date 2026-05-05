# Electronic Dreams
# Style: Electronic ambient | Mood: Dreamy and atmospheric

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Dreamy opening in Am - all instruments enter together
    3.times do
      # Sustained drone foundation
      use_synth :prophet
      play :a2, release: 12, cutoff: 85, amp: 0.5
      
      in_thread do
        # Harmony layer - hollow pads
        use_synth :dark_ambience
        play :a2, cutoff: 85, release: 12, amp: 0.3
        
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :hollow
          chords = knit(chord(:a3, :minor), 2, chord(:f3, :major), 1, chord(:c3, :major), 1)
          4.times do
            play_chord chords.tick, cutoff: 90, release: 3.5, amp: 0.5
            sleep 4
          end
        end
      end
      
      in_thread do
        # Bass foundation
        use_synth :bass_foundation
        play :a1, cutoff: 70, release: 8, amp: 0.65
        sleep 4
        
        use_synth :tb303
        play :a2, cutoff: 65, release: 0.8, res: 0.7, amp: 0.5
        sleep 1
        play :e2, cutoff: 65, release: 0.8, res: 0.7, amp: 0.5
        sleep 1
        play :a2, cutoff: 65, release: 0.8, res: 0.7, amp: 0.5
        sleep 1
        play :c3, cutoff: 65, release: 0.8, res: 0.7, amp: 0.5
        sleep 1
      end
      
      in_thread do
        # Percussion - simple foundation
        4.times do
          sample :bd_haus, amp: 0.6
          sleep 0.5
          sample :elec_snare, amp: 0.45
          sleep 0.5
        end
      end
      
      # Melody on top - blade synth
      with_fx :reverb, room: 0.25, mix: 0.3 do
        use_synth :blade
        melody_notes = (ring :a4, :c5, :e5, :a5, :g5, :e5, :c5, :a4)
        cutoff_values = (line 85, 115, steps: 16)
        
        16.times do
          play melody_notes.tick, cutoff: cutoff_values.look, release: 0.2, amp: 0.9
          sleep 0.25
        end
      end
    end
    
    # Transition drone - bridges to Section 2
    use_synth :fm
    play :a2, cutoff: 90, release: 10, divisor: 3, depth: 12, amp: 0.6
    sleep 4
    
    # Section 2: Key change to C major - building intensity
    3.times do
      # Sustained drone foundation
      use_synth :fm
      play :c3, release: 14, cutoff: 88, divisor: 2, depth: 18, amp: 0.5
      
      in_thread do
        # Harmony - piano and hollow
        use_synth :hollow
        play :c2, cutoff: 80, release: 14, amp: 0.3
        
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :piano
          chords = knit(chord(:c3, :major), 2, chord(:g3, :major), 1, chord(:f3, :major), 1)
          cutoff_vals = (line 85, 115, steps: 4)
          4.times do
            play_chord chords.tick, cutoff: cutoff_vals.look, release: 3.5, amp: 0.55
            sleep 4
          end
        end
      end
      
      in_thread do
        # Bass - rhythmic foundation
        use_synth :bass_foundation
        play :c2, cutoff: 75, release: 6, amp: 0.65
        sleep 4
        
        with_fx :lpf, cutoff: 85, mix: 0.8 do
          use_synth :tb303
          bass_notes = (ring :c2, :g2, :c2, :e2)
          4.times do
            play bass_notes.tick, cutoff: 70, release: 0.7, res: 0.75, amp: 0.55
            sleep 1
          end
        end
      end
      
      in_thread do
        # Percussion - building intensity
        with_fx :hpf, cutoff: 100 do
          4.times do
            sample :bd_haus, amp: 0.7
            sample :hat_psych, amp: 0.3
            sleep 0.25
            sample :hat_psych, amp: 0.2
            sleep 0.25
            sample :elec_snare, amp: 0.55
            sample :hat_psych, amp: 0.3
            sleep 0.25
            sample :hat_psych, amp: 0.2
            sleep 0.25
          end
        end
      end
      
      # Melody on top - prophet synth
      with_fx :lpf, cutoff: 110 do
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.2 do
          use_synth :prophet
          melody_notes = (ring :c5, :e5, :g5, :c6, :b5, :g5, :e5, :c5)
          cutoff_values = (line 90, 125, steps: 16)
          
          16.times do
            play melody_notes.tick, cutoff: cutoff_values.look, release: 0.15, amp: 0.95
            sleep 0.25
          end
        end
      end
    end
    
    # Transition drone - bridges to Section 3
    use_synth :blade
    play :c3, cutoff: 95, release: 10, amp: 0.6
    sleep 4
    
    # Section 3: Dreamlike resolution in C major
    2.times do
      # Sustained drone foundation
      use_synth :prophet
      play :c2, release: 16, cutoff: 80, amp: 0.4
      
      in_thread do
        # Harmony - layered hollow and piano
        use_synth :dark_ambience
        play :c2, cutoff: 82, release: 16, amp: 0.3
        
        use_synth :hollow
        chords = knit(chord(:c3, :major), 2, chord(:e3, :minor), 1, chord(:f3, :major), 1)
        4.times do
          play_chord chords.tick, cutoff: 95, release: 3.8, amp: 0.5
          sleep 2
          use_synth :piano
          play_chord chords.look, cutoff: 100, release: 1.5, amp: 0.4
          sleep 2
        end
      end
      
      in_thread do
        # Bass - deep sustained root
        use_synth :bass_foundation
        play :c1, cutoff: 68, release: 12, amp: 0.65
        sleep 8
        
        use_synth :tb303
        bass_notes = (knit :c2, 2, :e2, 2, :g2, 2, :c2, 2)
        8.times do
          play bass_notes.tick, cutoff: 72, release: 0.6, res: 0.7, amp: 0.5
          sleep 1
        end
      end
      
      in_thread do
        # Percussion - full rhythmic texture
        4.times do
          sample :bd_haus, amp: 0.7
          sample :hat_psych, amp: 0.35
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
          sample :elec_snare, amp: 0.6
          sample :hat_psych, amp: 0.35
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sample :elec_cymbal, amp: 0.35 if one_in(4)
          sleep 0.25
        end
      end
      
      # Melody on top - fm synth
      with_fx :reverb, room: 0.3, mix: 0.35 do
        use_synth :fm
        melody_notes = (knit :c4, 2, :e4, 2, :g4, 2, :e4, 1, :c4, 1)
        cutoff_values = (line 95, 120, steps: 16)
        
        16.times do
          play melody_notes.tick, cutoff: cutoff_values.look, release: 0.25, divisor: 1.5, depth: 8, amp: 0.85
          sleep 0.25
        end
      end
    end
    
    # Final sustaining resolution - all layers fade together
    use_synth :blade
    play :c3, cutoff: 85, release: 12, amp: 0.5
    
    use_synth :hollow
    play_chord chord(:c3, :major), cutoff: 85, release: 12, amp: 0.5
    
    use_synth :fm
    play :c1, cutoff: 70, release: 16, divisor: 1.5, depth: 6, amp: 0.6
    
    sample :elec_cymbal, amp: 0.4
    
    sleep 8
    
  end
end