# Electronic Classical Fusion
# Style: Electronic Classical Fusion
# Mood: Dramatic and atmospheric

use_debug false
use_bpm 120

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening atmospheric statement - Light percussion foundation
    2.times do
      use_synth :prophet
      play 36, release: 16, cutoff: 85, amp: 0.5
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.35 do
          use_synth :dark_ambience
          play_chord chord(:c3, :major), cutoff: 85, release: 16, amp: 8
        end
      end

      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 70, release: 8, amp: 0.7
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.8 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            melody_notes = (ring :c4, :e4, :g4, :c5, :g4, :e4, :d4, :c4)
            cutoffs = (line 90, 120, steps: 16)
            
            16.times do
              play melody_notes.tick, cutoff: cutoffs.look, release: 0.2, amp: 0.9
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.35 do
          use_synth :hollow
          chord_progression = [chord(:c3, :major), chord(:a3, :minor), chord(:f3, :major), chord(:g3, :major)]
          cutoff_sweep = (line 80, 105, steps: 4)
          
          4.times do
            play_chord chord_progression.tick, cutoff: cutoff_sweep.look, release: 3.5, amp: 0.55
            sleep 4
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 75, mix: 0.8 do
          bass_pattern = (ring :c2, :c2, :e2, :g2)
          4.times do
            play bass_pattern.tick, cutoff: 72, release: 3.5, amp: 0.65
            sleep 4
          end
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 100 do
          16.times do
            sample :elec_tick, amp: 0.35, rate: 1.5
            sleep 0.25
            sample :elec_tick, amp: 0.25, rate: 1.2 if one_in(2)
            sleep 0.25
            sample :drum_heavy_kick, amp: 0.5 if spread(3, 8).tick
            sample :hat_zild, amp: 0.3, rate: 1.3
            sleep 0.25
            sample :elec_tick, amp: 0.25, rate: 1.2
            sleep 0.25
          end
        end
      end
      
      sleep 16
    end
    
    # Transition: Prophet drone bridges sections
    use_synth :prophet
    play 36, cutoff: 90, release: 10, amp: 0.6
    sleep 4
    
    # Section 2: Building intensity with arpeggiated chords and stronger kick
    2.times do
      use_synth :prophet
      play 36, release: 16, cutoff: 85, amp: 0.4
      
      in_thread do
        use_synth :dark_ambience
        play_chord chord(:c3, :major), cutoff: 88, release: 16, amp: 9
      end

      in_thread do
        use_synth :tb303
        play :c2, cutoff: 80, release: 7, res: 0.6, amp: 0.7
      end
      
      in_thread do
        use_synth :saw
        melody_notes = (ring :c4, :d4, :e4, :g4, :a4, :g4, :e4, :c4)
        dynamics = (line 80, 125, steps: 16)
        
        16.times do
          play melody_notes.tick, cutoff: dynamics.look, release: 0.15, amp: 0.95
          sleep 0.25
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 100, mix: 0.8 do
          use_synth :mod_sine
          chord_progression = [chord(:c3, :major), chord(:d3, :minor), chord(:e3, :minor), chord(:g3, :major)]
          
          4.times do
            current_chord = chord_progression.tick
            4.times do
              play current_chord.choose, cutoff: rrand(85, 110), release: 0.8, amp: 0.6
              sleep 1
            end
          end
        end
      end
      
      in_thread do
        bass_notes = (ring :c2, :c2, :g2, :c2, :e2, :g2, :f2, :c2)
        8.times do
          play bass_notes.tick, cutoff: 78, release: 1.5, res: 0.5, amp: 0.65
          sleep 2
        end
      end
      
      in_thread do
        16.times do
          sample :drum_heavy_kick, amp: 0.6
          sample :hat_zild, amp: 0.35, rate: 1.4
          sleep 0.25
          sample :elec_tick, amp: 0.4, rate: 1.3
          sleep 0.25
          sample :elec_snare, amp: 0.5
          sample :hat_zild, amp: 0.35, rate: 1.4
          sleep 0.25
          sample :elec_tick, amp: 0.35, rate: 1.2
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Transition: FM drone with longer release
    use_synth :fm
    play 36, cutoff: 95, release: 12, divisor: 6, depth: 20, amp: 0.6
    sleep 4
    
    # Section 3: Climactic finale with full orchestral-inspired percussion
    3.times do
      use_synth :prophet
      play 36, release: 16, cutoff: 80, amp: 0.45
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.4 do
          use_synth :dark_ambience
          play_chord chord(:c3, :major), cutoff: 82, release: 16, amp: 10
        end
      end

      in_thread do
        use_synth :subpulse
        play :c2, cutoff: 75, release: 8, amp: 0.75
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :prophet
          climax_notes = (ring :c5, :e5, :d5, :c5, :g4, :a4, :c5, :d5, :e5, :g5, :e5, :d5, :c5, :g4, :e4, :c4)
          cutoff_sweep = (line 100, 130, steps: 16)
          
          16.times do
            play climax_notes.tick, cutoff: cutoff_sweep.look, release: 0.18, amp: 1.0
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.4 do
          use_synth :hollow
          chord_progression = [chord(:c3, :major), chord(:e3, :minor), chord(:d3, :minor7), chord(:g3, :major)]
          cutoff_evolution = (line 90, 125, steps: 4)
          
          4.times do
            play_chord chord_progression.tick, cutoff: cutoff_evolution.look, release: 3.8, amp: 0.65
            sleep 4
          end
        end
      end
      
      in_thread do
        use_synth :tb303
        climax_bass = (ring :c2, :e2, :g2, :c2, :f2, :g2, :c2, :g2)
        8.times do
          play climax_bass.tick, cutoff: 82, release: 1.8, res: 0.6, amp: 0.7
          sleep 2
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          16.times do |i|
            kick_amp = i == 0 ? 0.7 : 0.6
            sample :drum_heavy_kick, amp: kick_amp
            sample :hat_zild, amp: 0.4, rate: 1.5
            sleep 0.25
            sample :elec_tick, amp: 0.5, rate: 1.4
            sample :hat_zild, amp: 0.3, rate: 1.3 if one_in(2)
            sleep 0.25
            sample :elec_snare, amp: 0.6
            sample :hat_zild, amp: 0.4, rate: 1.5
            sleep 0.25
            sample :elec_tick, amp: 0.45, rate: 1.2
            sample :drum_heavy_kick, amp: 0.5 if spread(5, 16).tick
            sleep 0.25
          end
        end
      end
      
      sleep 16
    end
    
    # Final sustained fade with sparse percussion
    use_synth :prophet
    play 36, cutoff: 90, release: 16, amp: 0.5
    
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c3, :major), cutoff: 90, release: 16, amp: 0.6
      use_synth :hollow
      play_chord chord(:c4, :major), cutoff: 95, release: 16, amp: 0.5
    end

    in_thread do
      use_synth :bass_foundation
      play :c2, cutoff: 65, release: 16, amp: 0.75
    end
    
    in_thread do
      4.times do
        sample :drum_heavy_kick, amp: 0.4
        sleep 1
        sample :elec_tick, amp: 0.3, rate: 1.0
        sleep 1
      end
    end
    
    sleep 8
    
  end
end