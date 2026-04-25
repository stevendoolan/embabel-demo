use_debug false
# Electronic Classical Fusion - Dramatic electronic piece in Am → C, 4/4 time

use_bpm 120

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening in Am - atmospheric and dramatic (2x)
    2.times do
      in_thread do
        use_synth :prophet
        play :a2, release: 16, cutoff: 85, amp: 0.5
      end
      
      in_thread do
        use_synth :dark_ambience
        play_chord chord(:a2, :minor), cutoff: 85, release: 16, amp: 0.35
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            use_synth :prophet
            notes = (ring :a3, :c4, :e4, :a4, :g4, :f4, :e4, :d4, :c4, :e4, :d4, :c4, :a3, :c4, :d4, :e4)
            cutoffs = (line 90, 120, steps: 16)
            16.times do
              play notes.tick, cutoff: cutoffs.look, release: 0.2, amp: 0.9
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :hollow
          chords_prog = (knit chord(:a3, :minor), 4, chord(:d3, :minor), 4, chord(:f3, :major), 4, chord(:e3, :major), 4)
          cutoffs = (line 80, 100, steps: 16)
          16.times do
            play_chord chords_prog.tick, cutoff: cutoffs.look, release: 0.8, amp: 0.3
            sleep 0.25
          end
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.25 do
        4.times do |bar|
          sample :bd_haus, amp: bar == 0 ? 0.5 : 0.4
          sample :hat_psych, amp: 0.2
          sleep 0.5
          sample :hat_psych, amp: 0.15
          sleep 0.5
          sample :elec_hi_snare, amp: 0.35
          sample :hat_psych, amp: 0.2
          sleep 0.5
          sample :hat_psych, amp: 0.15
          sleep 0.25
          sample :elec_cymbal, amp: 0.25, rate: 0.8 if one_in(2)
          sleep 0.25
        end
      end
    end
    
    # Transition drone 1
    use_synth :fm
    play :a2, cutoff: 95, release: 10, divisor: 4, depth: 18, amp: 0.6
    use_synth :dark_ambience
    play_chord chord(:a2, :minor), cutoff: 90, release: 10, amp: 0.4
    sleep 4
    
    # Section 2: Building intensity in Am with FM synth (3x)
    3.times do
      in_thread do
        use_synth :fm
        play :a2, release: 12, cutoff: 90, divisor: 6, depth: 20, amp: 0.45
      end
      
      in_thread do
        use_synth :saw
        play :a1, cutoff: 95, release: 12, amp: 0.3
      end
      
      in_thread do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          use_synth :fm
          melody = (ring :e4, :a4, :e5, :d5, :c5, :a4, :c5, :e5, :a4, :g4, :f4, :e4, :d4, :e4, :a3, :a4)
          cutoffs = (line 100, 130, steps: 16)
          16.times do
            play melody.tick, cutoff: cutoffs.look, release: 0.15, divisor: 8, depth: 15, amp: 0.95
            sleep 0.25
          end
        end
      end
      
      in_thread do
        use_synth :hollow
        harmonic_chords = (knit chord(:a3, :minor), 4, chord(:c3, :major), 4, chord(:d3, :minor), 4, chord(:e3, :major), 4)
        cutoffs = (line 85, 110, steps: 16)
        16.times do
          play_chord harmonic_chords.tick, cutoff: cutoffs.look, release: 1.2, amp: 0.4
          sleep 0.25
        end
      end
      
      4.times do |bar|
        sample :bd_haus, amp: bar == 0 ? 0.55 : 0.5
        sample :hat_psych, amp: 0.25
        sleep 0.25
        sample :hat_psych, amp: 0.2
        sleep 0.25
        sample :elec_hi_snare, amp: 0.4
        sample :hat_psych, amp: 0.25
        sleep 0.25
        sample :hat_psych, amp: 0.2
        sleep 0.25
        
        sample :bd_haus, amp: 0.45
        sample :hat_psych, amp: 0.25
        sleep 0.25
        sample :hat_psych, amp: 0.2
        sleep 0.25
        sample :elec_hi_snare, amp: 0.45
        sample :hat_psych, amp: 0.25
        sample :elec_cymbal, amp: 0.35, rate: 1.2 if bar == 3
        sleep 0.25
        sample :hat_psych, amp: 0.2
        sleep 0.25
      end
    end
    
    # Transition drone 2
    use_synth :prophet
    play :c3, cutoff: 88, release: 9, amp: 0.65
    use_synth :dark_ambience
    play_chord chord(:c3, :major), cutoff: 88, release: 9, amp: 0.45
    sleep 4
    
    # Section 3: C major triumphant finale with piano (4x)
    4.times do
      in_thread do
        use_synth :piano
        play :c2, release: 14, cutoff: 80, amp: 0.4
      end
      
      in_thread do
        use_synth :saw
        play :c2, cutoff: 90, release: 14, amp: 0.35
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :piano
          finale = (knit :c4, 2, :e4, 2, :g4, 2, :c5, 2, :b4, 1, :a4, 1, :g4, 2, :f4, 1, :e4, 1, :d4, 1, :c4, 1)
          cutoffs = (line 85, 115, steps: 16)
          16.times do
            play finale.tick, cutoff: cutoffs.look, release: 0.3, amp: 1.0
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.45 do
          use_synth :hollow
          finale_chords = (knit chord(:c3, :major), 4, chord(:f3, :major), 4, chord(:g3, :major), 4, chord(:c4, :major), 4)
          cutoffs = (line 90, 120, steps: 16)
          16.times do
            play_chord finale_chords.tick, cutoff: cutoffs.look, release: 1.5, amp: 0.45
            sleep 0.25
          end
        end
      end
      
      with_fx :hpf, cutoff: 95, mix: 1.0 do
        4.times do |bar|
          sample :bd_haus, amp: bar == 0 ? 0.65 : 0.55
          sample :elec_cymbal, amp: 0.4, rate: 1.0
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
          sample :elec_hi_snare, amp: 0.5
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
          
          sample :bd_haus, amp: 0.5
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sample :bd_haus, amp: 0.45 if spread(1, 2).tick
          sleep 0.25
          sample :elec_hi_snare, amp: 0.55
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
        end
      end
    end
    
    # Final resolution
    use_synth :prophet
    play_chord chord(:c3, :major), release: 6, cutoff: 100, amp: 0.7
    use_synth :dark_ambience
    play_chord chord(:c2, :major), release: 8, cutoff: 95, amp: 0.5
    use_synth :hollow
    play_chord chord(:c3, :major), release: 6, cutoff: 100, amp: 0.4
    sleep 6
    
  end
end