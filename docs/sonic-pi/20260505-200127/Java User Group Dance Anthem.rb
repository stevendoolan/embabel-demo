# Java User Group Dance Anthem
# Electronic, energetic, 128 BPM, 4/4 time

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening with tech_saws lead, atmospheric pads, foundation bass, and minimal drums
    3.times do
      in_thread do
        use_synth :prophet
        play :c2, release: 16, cutoff: 85, amp: 0.4
      end
      
      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 70, release: 8, amp: 0.6
        sleep 2
        
        use_synth :subpulse
        bass_pattern1 = (ring :c2, :c2, :g2, :c2)
        4.times do
          play bass_pattern1.tick, cutoff: 65, release: 1, amp: 0.5
          sleep 1
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          use_synth :dark_ambience
          play_chord chord(:c3, :major), cutoff: 85, release: 16, amp: 0.5
        end
      end
      
      in_thread do
        16.times do
          sample :bd_haus, amp: 0.5
          sample :hat_bdu, amp: 0.25 if spread(8, 16).tick
          sleep 0.5
          sample :elec_hi_snare, amp: 0.5 if (spread(2, 4).look)
          sleep 0.5
        end
      end
      
      with_fx :lpf, cutoff: 110, mix: 0.3 do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          use_synth :tech_saws
          melody1 = (ring :c4, :e4, :g4, :c5, :g4, :e4, :c4, :e4)
          cutoffs1 = (line 90, 120, steps: 8)
          
          8.times do
            play melody1.tick, release: 0.2, cutoff: cutoffs1.look, amp: 0.9
            sleep 0.5
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          use_synth :hollow
          8.times do
            play_chord chord(:c3, :major), cutoff: 90, release: 0.4, amp: 0.4
            sleep 0.5
          end
        end
      end
    end
    
    # Transition drone
    use_synth :fm
    play :c2, release: 8, divisor: 3, depth: 15, cutoff: 90, amp: 0.5
    sleep 4
    
    # Section 2: Building intensity with supersaw lead, layered pads, walking bass, and active drums
    3.times do
      in_thread do
        use_synth :blade
        play :c2, release: 12, cutoff: 80, amp: 0.3
      end
      
      in_thread do
        use_synth :fm
        play_chord chord(:c3, :major), cutoff: 80, release: 12, divisor: 2, depth: 8, amp: 0.4
      end
      
      in_thread do
        with_fx :lpf, cutoff: 85, mix: 0.3 do
          use_synth :tb303
          bass_pattern2 = (knit :c2, 4, :e2, 2, :g2, 4, :a2, 2, :g2, 4)
          16.times do
            play bass_pattern2.tick, cutoff: rrand(70, 85), release: 0.4, res: 0.8, amp: 0.55
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 100, mix: 0.3 do
          64.times do
            sample :bd_haus, amp: 0.6
            sample :hat_bdu, amp: 0.3
            sleep 0.25
            sample :elec_tick, amp: 0.2 if one_in(4)
            sleep 0.25
            sample :elec_hi_snare, amp: 0.55
            sample :hat_bdu, amp: 0.3
            sleep 0.25
            sample :hat_bdu, amp: 0.25
            sleep 0.25
          end
        end
      end
      
      use_synth :supersaw
      melody2 = (knit :c4, 2, :e4, 2, :g4, 2, :a4, 1, :g4, 1)
      
      with_fx :echo, phase: 0.75, decay: 1.5, mix: 0.2 do
        16.times do
          play melody2.tick, release: 0.15, cutoff: rrand(95, 115), amp: 0.95
          sleep 0.25
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 100, mix: 0.3 do
          use_synth :hollow
          chords2 = (knit chord(:c3, :major), 2, chord(:g3, :major), 2)
          16.times do
            play_chord chords2.tick, cutoff: (line 85, 105, steps: 16).look, release: 0.2, amp: 0.45
            sleep 0.25
          end
        end
      end
    end
    
    # Transition drone
    use_synth :prophet
    play :c2, release: 8, cutoff: 95, amp: 0.5
    sleep 4
    
    # Section 3: Peak energy with beep stabs, rich harmonic support, punchy bass, and dense drums
    4.times do
      in_thread do
        use_synth :dsaw
        play :c2, release: 10, cutoff: 75, amp: 0.35
      end
      
      in_thread do
        use_synth :fm
        play_chord chord(:c3, :major), cutoff: 75, release: 10, divisor: 3, depth: 12, amp: 0.45
      end
      
      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 75, release: 6, amp: 0.6
        sleep 1
        
        use_synth :tb303
        bass_pattern3 = (ring :c2, :c2, :e2, :c2, :g2, :e2, :c2, :g2)
        7.times do
          play bass_pattern3.tick, cutoff: 80, release: 0.5, res: 0.85, amp: 0.5
          sleep 0.5
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          64.times do
            sample :bd_haus, amp: 0.7
            sample :hat_bdu, amp: 0.35
            sample :elec_tick, amp: 0.25 if spread(3, 8).tick
            sleep 0.25
            sample :hat_bdu, amp: 0.3
            sleep 0.25
            sample :elec_hi_snare, amp: 0.65
            sample :hat_bdu, amp: 0.35
            sleep 0.25
            sample :hat_bdu, amp: 0.3
            sample :elec_tick, amp: 0.3 if one_in(3)
            sleep 0.25
          end
        end
      end
      
      use_synth :beep
      melody3 = (ring :c5, :e5, :g5, :e5, :c5, :g4, :e4, :g4, :c5, :e5, :g5, :a5, :g5, :e5, :c5, :e5)
      cutoffs3 = (line 100, 130, steps: 16)
      
      16.times do
        play melody3.tick, release: 0.1, cutoff: cutoffs3.look, amp: 1.0
        sleep 0.25
      end
      
      in_thread do
        use_synth :hollow
        chords3 = (ring chord(:c3, :major), chord(:c3, :major), chord(:f3, :major), chord(:g3, :major))
        4.times do
          play_chord chords3.tick, cutoff: (line 90, 120, steps: 4).look, release: 0.8, amp: 0.5
          sleep 1
        end
      end
    end
    
    # Final transition drone fadeout
    use_synth :fm
    play :c2, release: 12, divisor: 4, depth: 20, cutoff: 85, amp: 0.4
    sleep 4
    
  end
end