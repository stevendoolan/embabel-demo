use_debug false
use_bpm 120

# Electronic Classical Fusion
# Style: Electronic Classical Fusion
# Mood: Dramatic

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Dramatic opening in Am — atmospheric with piano, fm, organ pads, minimal percussion
    2.times do
      # Long drone sustains underneath
      use_synth :fm
      play :a2, release: 16, divisor: 0.5, depth: 8, cutoff: 85, amp: 0.5
      
      # Bass foundation
      use_synth :bass_foundation
      play :a1, cutoff: 70, release: 8, amp: 0.6
      sleep 4
      
      # Harmony pad
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :organ_tonewheel
          play_chord chord(:a3, :minor7), cutoff: 95, release: 16, amp: 0.5
          
          use_synth :prophet
          8.times do |i|
            play_chord chord(:a3, :minor), cutoff: (line 85, 105, steps: 8).look, release: 2, amp: 0.4
            sleep 2
          end
        end
      end
      
      # Melody with piano
      in_thread do
        with_fx :lpf, cutoff: 100, mix: 0.8 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            use_synth :piano
            notes = (ring :a4, :c5, :e5, :a5, :e5, :c5, :a4, :gs4)
            16.times do |i|
              play notes.tick, release: 0.2, cutoff: (line 90, 120, steps: 16).look, amp: 0.9
              sleep 0.25
            end
          end
        end
      end
      
      # Walking bass pattern
      in_thread do
        sleep 4
        use_synth :tb303
        bass_line = (ring :a1, :c2, :e2, :a2, :e2, :c2, :a1, :gs1)
        8.times do
          play bass_line.tick, cutoff: 75, release: 0.4, amp: 0.55, res: 0.8
          sleep 0.5
        end
      end
      
      # Sparse ceremonial percussion
      in_thread do
        # First measure
        sample :bd_haus, amp: 0.55, cutoff: 90
        sample :elec_bell, amp: 0.25, rate: 0.8
        sleep 1
        sample :hat_psych, amp: 0.2
        sleep 0.5
        sample :hat_psych, amp: 0.15
        sleep 0.5
        
        # Second measure
        sample :bd_haus, amp: 0.5, cutoff: 90
        sleep 0.5
        sample :hat_psych, amp: 0.2
        sleep 0.5
        sample :elec_snare, amp: 0.4
        sample :hat_psych, amp: 0.25
        sleep 0.5
        sample :hat_psych, amp: 0.15
        sleep 0.5
        
        # Third measure
        sample :bd_haus, amp: 0.55, cutoff: 90
        sample :hat_psych, amp: 0.2
        sleep 0.5
        sample :hat_psych, amp: 0.15
        sleep 0.5
        sample :hat_psych, amp: 0.2
        sleep 0.5
        sample :hat_psych, amp: 0.15
        sleep 0.5
        
        # Fourth measure
        sample :bd_haus, amp: 0.5, cutoff: 90
        sleep 0.5
        sample :hat_psych, amp: 0.2
        sleep 0.5
        sample :elec_snare, amp: 0.5
        sample :elec_bell, amp: 0.3, rate: 1.2
        sleep 0.5
        sample :hat_psych, amp: 0.15
        sleep 0.5
      end
      
      sleep 16
    end
    
    # Transition drone — bridges to Section 2 with no silence
    use_synth :prophet
    play :a2, cutoff: 90, release: 8, amp: 0.6
    sample :drum_cymbal_soft, amp: 0.3, rate: 0.9
    sleep 4
    
    # Section 2: Building intensity in Am with saw synth, walking bass, active percussion
    2.times do
      # Drone sustains underneath melodic action
      use_synth :fm
      play :a2, release: 12, divisor: 0.3, depth: 12, cutoff: 80, amp: 0.4
      
      # Sub-bass pedal tone
      use_synth :subpulse
      play :a1, cutoff: 60, release: 12, amp: 0.6
      
      # Harmony with supersaw
      in_thread do
        with_fx :lpf, cutoff: 100, mix: 0.8 do
          use_synth :supersaw
          chords_prog = (knit chord(:a3, :minor7), 2, chord(:f3, :major7), 1, chord(:g3, :major), 1)
          4.times do
            play_chord chords_prog.tick, cutoff: rrand(90, 110), release: 4, amp: 0.4
            sleep 4
          end
        end
      end
      
      # Melody with saw synth
      in_thread do
        use_synth :saw
        melody = (knit :a3, 2, :c4, 2, :e4, 3, :a4, 1, :e4, 2, :c4, 2, :a3, 2, :gs3, 2)
        16.times do |i|
          play melody.tick, release: 0.15, cutoff: rrand(95, 115), amp: 0.95
          sleep 0.25
        end
      end
      
      # Walking bass line
      in_thread do
        with_fx :lpf, cutoff: 85, mix: 0.8 do
          use_synth :tb303
          walking_bass = (knit :a1, 2, :c2, 2, :e2, 2, :a2, 1, :e2, 1, :c2, 2, :a1, 2, :gs1, 2)
          16.times do
            play walking_bass.tick, cutoff: rrand(70, 85), release: 0.3, amp: 0.5, res: 0.85
            sleep 0.25
          end
        end
      end
      
      # Crisp electronic percussion
      in_thread do
        with_fx :hpf, cutoff: 100, mix: 0.8 do
          8.times do
            # Beat 1
            sample :bd_haus, amp: 0.6, cutoff: 95
            sample :hat_psych, amp: 0.25
            sleep 0.25
            sample :hat_psych, amp: 0.15
            sleep 0.25
            
            # Beat 2
            sample :elec_snare, amp: 0.5
            sample :hat_psych, amp: 0.25
            sleep 0.25
            sample :hat_psych, amp: 0.15
            sleep 0.25
          end
        end
      end
      
      sleep 16
    end
    
    # Transition drone — bridges to key change with overlap
    use_synth :prophet
    play :c3, cutoff: 95, release: 10, amp: 0.65
    sample :drum_roll, amp: 0.4, rate: 1.2
    sample :drum_cymbal_soft, amp: 0.35, rate: 1.0
    sleep 4
    
    # Section 3: Key change to C major — triumphant climax with fm, pluck, full percussion
    3.times do
      # Long sustaining drone creates atmosphere
      use_synth :fm
      play :c3, release: 14, divisor: 0.2, depth: 15, cutoff: 75, amp: 0.45
      
      # Deep sustained C root bass
      use_synth :subpulse
      play :c2, cutoff: 65, release: 14, amp: 0.6
      
      # Harmony with organ and prophet
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.3 do
          use_synth :organ_tonewheel
          play_chord chord(:c3, :major7), cutoff: 90, release: 14, amp: 0.55
          
          use_synth :prophet
          progression = (ring chord(:c4, :major7), chord(:a3, :minor7), chord(:f3, :major7), chord(:g3, :major))
          8.times do |i|
            play_chord progression.tick, cutoff: (line 95, 115, steps: 8).look, release: 2, amp: 0.45
            sleep 2
          end
        end
      end
      
      # Melody with pluck
      in_thread do
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.25 do
          use_synth :pluck
          climax_notes = (ring :c5, :e5, :g5, :c6, :g5, :e5, :g5, :e5)
          8.times do
            play climax_notes.tick, release: 0.3, cutoff: (line 100, 130, steps: 8).look, amp: 1.0
            sleep 0.5
          end
        end
      end
      
      # Classical walking bass
      in_thread do
        use_synth :bass_foundation
        climax_bass = (ring :c2, :e2, :g2, :c3, :g2, :e2, :c2, :g1)
        8.times do
          play climax_bass.tick, cutoff: (line 70, 85, steps: 8).look, release: 0.5, amp: 0.6
          sleep 0.5
        end
      end
      
      # Full orchestral-electronic percussion
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.7, cutoff: 100
          sample :hat_psych, amp: 0.3
          sample :elec_bell, amp: 0.35, rate: 1.5
          sleep 0.5
          
          sample :elec_snare, amp: 0.6
          sample :hat_psych, amp: 0.3
          sleep 0.5
        end
      end
      
      sleep 8
      
      # Second phrase with saw
      in_thread do
        use_synth :saw
        phrase2 = (knit :e4, 2, :g4, 2, :c5, 2, :e5, 2)
        8.times do
          play phrase2.tick, release: 0.2, cutoff: rrand(90, 110), amp: 0.9
          sleep 0.5
        end
      end
      
      # Second phrase bass
      in_thread do
        use_synth :tb303
        phrase2_bass = (knit :c2, 4, :g1, 2, :c2, 2)
        8.times do
          play phrase2_bass.tick, cutoff: 80, release: 0.4, amp: 0.55, res: 0.8
          sleep 0.5
        end
      end
      
      # Second phrase percussion
      in_thread do
        2.times do
          sample :bd_haus, amp: 0.65, cutoff: 100
          sample :hat_psych, amp: 0.35
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
          
          sample :elec_snare, amp: 0.65
          sample :hat_psych, amp: 0.35
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
        end
        
        sample :bd_haus, amp: 0.65, cutoff: 100
        sample :drum_cymbal_soft, amp: 0.4, rate: 1.1
        sleep 0.5
        
        sample :elec_snare, amp: 0.7
        sample :hat_psych, amp: 0.3
        sleep 0.5
      end
      
      sleep 8
    end
    
    # Final resolving drone — sustains into silence
    use_synth :prophet
    play :c3, cutoff: 85, release: 12, amp: 0.7
    use_synth :supersaw
    play_chord chord(:c3, :major7), cutoff: 85, release: 12, amp: 0.6
    use_synth :sine
    play :c2, cutoff: 80, release: 12, amp: 0.5
    use_synth :bass_foundation
    play :c2, cutoff: 70, release: 12, amp: 0.6
    sample :bd_haus, amp: 0.5, cutoff: 85
    sample :elec_bell, amp: 0.35, rate: 0.7
    sleep 2
    sample :drum_cymbal_soft, amp: 0.3, rate: 0.85
    sleep 6
    
  end
end