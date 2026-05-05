# Electronic Classical Fusion
# Style: Electronic Classical Fusion
# Mood: Dramatic, atmospheric, evolving

use_debug false
use_bpm 120

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening in Am - Sparse atmospheric foundation
    2.times do
      in_thread do
        use_synth :fm
        play :a2, release: 16, cutoff: 85, divisor: 3, depth: 12, amp: 0.5
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.35 do
          use_synth :hollow
          play_chord chord(:a2, :minor), cutoff: 85, release: 16, amp: 0.4
          use_synth :dark_ambience
          play :a2, cutoff: 90, release: 14, amp: 0.3
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :a1, cutoff: 70, release: 8, amp: 0.6
        sleep 4
        play :e2, cutoff: 68, release: 4, amp: 0.55
        sleep 2
        play :a1, cutoff: 72, release: 2, amp: 0.5
        sleep 2
      end
      
      in_thread do
        4.times do
          sample :elec_soft_kick, amp: 0.6
          sample :elec_tick, amp: 0.2
          sleep 0.5
          sample :elec_tick, amp: 0.15
          sleep 0.25
          sample :drum_cymbal_soft, amp: 0.3 if one_in(4)
          sleep 0.25
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.3 do
        use_synth :piano
        notes = (ring :a3, :c4, :e4, :a4, :e4, :c4, :b3, :gs3)
        16.times do
          play notes.tick, cutoff: rrand(90, 110), release: 0.8, amp: 0.9
          sleep 0.25
        end
      end
    end
    
    # Transition drone
    use_synth :prophet
    play :a2, cutoff: 90, release: 12, amp: 0.6
    in_thread do
      use_synth :fm
      play :a1, cutoff: 65, release: 12, divisor: 2, depth: 4, amp: 0.5
    end
    in_thread do
      use_synth :hollow
      play_chord chord(:a2, :minor), cutoff: 88, release: 12, amp: 0.4
    end
    sleep 4
    
    # Section 2: Building intensity in Am - Walking bass and driving rhythm
    3.times do
      in_thread do
        use_synth :prophet
        play :a2, release: 12, cutoff: 80, amp: 0.3
      end
      
      in_thread do
        use_synth :dark_ambience
        play :a2, cutoff: 92, release: 12, amp: 0.4
      end
      
      in_thread do
        use_synth :bass_foundation
        bass_line = (ring :a1, :c2, :d2, :e2)
        4.times do
          play bass_line.tick, cutoff: 75, release: 0.8, amp: 0.6
          sleep 1
        end
        use_synth :tb303
        4.times do
          play :a1, cutoff: 80, release: 0.5, res: 0.8, amp: 0.5
          sleep 0.5
          sleep 0.5
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          4.times do
            sample :elec_soft_kick, amp: 0.7
            sample :hat_psych, amp: 0.25
            sleep 0.25
            sample :hat_psych, amp: 0.2
            sleep 0.25
            sample :elec_snare, amp: 0.5
            sample :hat_psych, amp: 0.25
            sleep 0.25
            sample :drum_tom_mid_soft, amp: 0.4 if spread(3, 8).tick
            sample :hat_psych, amp: 0.2
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 95 do
          use_synth :organ_tonewheel
          chords_prog = (ring chord(:a3, :minor), chord(:f3, :major), chord(:g3, :major), chord(:a3, :minor))
          4.times do
            play_chord chords_prog.tick, cutoff: 100, release: 3.8, amp: 0.5
            sleep 4
          end
        end
      end
      
      with_fx :lpf, cutoff: 100 do
        with_fx :reverb, room: 0.2, mix: 0.25 do
          use_synth :mod_saw
          melody = (ring :a3, :c4, :d4, :e4, :e4, :d4, :c4, :b3)
          cutoffs = (line 85, 120, steps: 16)
          16.times do
            play melody.tick, cutoff: cutoffs.look, release: 0.2, amp: 0.95
            sleep 0.25
          end
        end
      end
    end
    
    # Transition to key change
    use_synth :fm
    play :g2, cutoff: 95, release: 14, divisor: 2, depth: 15, amp: 0.6
    in_thread do
      use_synth :fm
      play :g1, cutoff: 70, release: 14, divisor: 3, depth: 6, amp: 0.55
    end
    in_thread do
      use_synth :hollow
      play_chord chord(:g2, :major7), cutoff: 93, release: 14, amp: 0.5
    end
    in_thread do
      sample :drum_cymbal_soft, amp: 0.5
    end
    sleep 4
    
    # Section 3: Key change to C major - Full intensity climax
    3.times do
      in_thread do
        use_synth :dsaw
        play :c2, release: 14, cutoff: 75, amp: 0.3
      end
      
      in_thread do
        use_synth :dark_ambience
        play :c2, cutoff: 88, release: 14, amp: 0.4
      end
      
      in_thread do
        with_fx :lpf, cutoff: 85 do
          use_synth :bass_foundation
          c_major_bass = (ring :c2, :e2, :g2, :c2, :b1, :g1, :e2, :d2)
          8.times do
            play c_major_bass.tick, cutoff: 78, release: 0.6, amp: 0.65
            sleep 0.5
          end
          use_synth :tb303
          4.times do
            play :c2, cutoff: 85, release: 0.4, res: 0.85, amp: 0.55
            sleep 1
          end
        end
      end
      
      in_thread do
        4.times do
          sample :elec_soft_kick, amp: 0.8
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
          sample :elec_snare, amp: 0.6
          sample :hat_psych, amp: 0.3
          sample :drum_tom_mid_soft, amp: 0.45 if one_in(3)
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sample :elec_tick, amp: 0.3 if spread(5, 8).look
          sleep 0.25
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          use_synth :saw
          c_progression = (ring chord(:c3, :major), chord(:g3, :major), chord(:a3, :minor), chord(:f3, :major))
          4.times do
            play_chord c_progression.tick, cutoff: (line 90, 115, steps: 4).look, release: 3.5, amp: 0.55
            sleep 4
          end
        end
      end
      
      with_fx :lpf, cutoff: 110 do
        use_synth :fm
        climax_notes = (ring :c4, :e4, :g4, :c5, :b4, :g4, :e4, :d4)
        cutoff_mod = (line 100, 130, steps: 16)
        16.times do
          play climax_notes.tick, cutoff: cutoff_mod.look, release: 0.15, divisor: 0.5, depth: 8, amp: 1.0
          sleep 0.25
        end
      end
    end
    
    # Transition to finale
    use_synth :prophet
    play :c3, cutoff: 100, release: 12, amp: 0.65
    in_thread do
      use_synth :bass_foundation
      play :c1, cutoff: 68, release: 12, amp: 0.6
    end
    in_thread do
      use_synth :hollow
      play_chord chord(:c3, :sus4), cutoff: 98, release: 12, amp: 0.5
    end
    in_thread do
      sample :drum_cymbal_soft, amp: 0.55
      sample :elec_soft_kick, amp: 0.7
    end
    sleep 4
    
    # Section 4: Finale in C - Crisp staccato resolution
    2.times do
      in_thread do
        use_synth :fm
        play :c2, release: 16, cutoff: 90, divisor: 4, depth: 20, amp: 0.35
      end
      
      in_thread do
        use_synth :dark_ambience
        play :c2, cutoff: 85, release: 16, amp: 0.45
      end
      
      in_thread do
        use_synth :fm
        play :c1, cutoff: 65, release: 12, divisor: 4, depth: 8, amp: 0.6
        sleep 4
        use_synth :bass_foundation
        finale_bass = (ring :c2, :g2, :e2, :c2)
        8.times do
          play finale_bass.tick, cutoff: 75, release: 0.4, amp: 0.6
          sleep 0.5
        end
        sleep 4
      end
      
      in_thread do
        4.times do
          sample :elec_soft_kick, amp: 0.75
          sample :elec_tick, amp: 0.35
          sleep 0.25
          sample :elec_tick, amp: 0.25
          sleep 0.25
          sample :elec_snare, amp: 0.65
          sample :elec_tick, amp: 0.3
          sleep 0.25
          sample :drum_cymbal_soft, amp: 0.4 if spread(2, 8).tick
          sample :elec_tick, amp: 0.25
          sleep 0.25
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.35 do
          use_synth :organ_tonewheel
          finale_chords = (ring chord(:c3, :major7), chord(:g3, '7'), chord(:a3, :minor7), chord(:f3, :major7))
          4.times do
            play_chord finale_chords.tick, cutoff: 105, release: 3.8, amp: 0.6
            sleep 4
          end
        end
      end
      
      with_fx :reverb, room: 0.3, mix: 0.35 do
        use_synth :beep
        finale = (ring :c4, :g4, :e4, :c5, :g4, :e4, :d4, :c4)
        16.times do
          play finale.tick, cutoff: rrand(95, 115), release: 0.1, amp: 0.95
          sleep 0.25
        end
      end
    end
    
    # Final fadeout
    use_synth :prophet
    play :c2, cutoff: 85, release: 16, amp: 0.5
    use_synth :bass_foundation
    play :c1, cutoff: 70, release: 16, amp: 0.55
    use_synth :hollow
    play_chord chord(:c2, :major7), cutoff: 82, release: 16, amp: 0.4
    use_synth :dark_ambience
    play :c1, cutoff: 80, release: 16, amp: 0.3
    sample :elec_soft_kick, amp: 0.6
    sample :drum_cymbal_soft, amp: 0.45
    sleep 8
    
  end
end