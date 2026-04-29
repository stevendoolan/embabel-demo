# Feed the Birds EDM Remix
# Style: electronic, Mood: uplifting

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Atmospheric intro with melody, harmony, and minimal percussion
    2.times do
      use_synth :prophet
      play :c2, release: 16, cutoff: 85, amp: 0.5
      
      in_thread do
        use_synth :prophet
        play_chord chord(:c3, :major7), cutoff: 85, release: 16, amp: 0.4
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :dark_ambience
          chords_prog = (ring chord(:c3, :major7), chord(:g2, :sus4))
          2.times do
            play_chord chords_prog.tick, cutoff: 80, release: 4, amp: 0.3
            sleep 2
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          use_synth :saw
          melody = (ring :g4, :g4, :fs4, :e4, :g4, :e4, :d4, :c4)
          releases = (ring 0.4, 0.2, 0.5, 0.2, 0.4, 0.2, 0.5, 1.0)
          cutoffs = (ring 95, 100, 90, 105, 95, 100, 90, 85)
          8.times do
            play melody.tick, release: releases.look, cutoff: cutoffs.look, amp: 0.9
            sleep 0.5
          end
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 65, release: 8, amp: 0.5
        sleep 2
        play :g2, cutoff: 70, release: 2, amp: 0.4
        sleep 1
        play :c2, cutoff: 65, release: 1, amp: 0.45
        sleep 1
      end
      
      in_thread do
        8.times do
          sample :hat_psych, amp: 0.25, rate: 1.2
          sleep 0.25
          sample :hat_psych, amp: 0.15, rate: 1.3
          sleep 0.25
        end
      end
    end
    
    # Transition drone
    use_synth :fm
    play :c2, cutoff: 90, release: 8, amp: 0.6, divisor: 4, depth: 15
    in_thread do
      use_synth :hollow
      play_chord chord(:c3, :major7), cutoff: 85, release: 8, amp: 0.5
    end
    in_thread do
      use_synth :bass_foundation
      play :c2, cutoff: 60, release: 8, amp: 0.55
    end
    sleep 4
    
    # Section 2: Energetic pluck melody with bass and building rhythm
    3.times do
      use_synth :prophet
      play :c2, release: 12, cutoff: 80, amp: 0.4
      
      in_thread do
        use_synth :prophet
        play_chord chord(:c3, :major7), cutoff: 90, release: 12, amp: 0.45
      end
      
      in_thread do
        with_fx :lpf, cutoff: 100, mix: 0.25 do
          use_synth :dark_ambience
          chords_prog = knit(chord(:c3, :major7), 2, chord(:f3, :major7), 2, chord(:g3, :sus4), 2, chord(:c3, :major7), 2)
          cutoffs = (line 85, 110, steps: 8)
          8.times do
            play_chord chords_prog.tick, cutoff: cutoffs.look, release: 0.5, amp: 0.35
            sleep 0.5
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.25 do
          with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
            use_synth :pluck
            melody = (ring :g4, :g4, :fs4, :e4, :g4, :e4, :d4, :c4)
            cutoffs = (line 90, 120, steps: 8)
            8.times do
              play melody.tick, release: 0.3, cutoff: cutoffs.tick, amp: 1.0
              sleep 0.5
            end
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 85, mix: 0.25 do
          use_synth :tb303
          bass_pattern = (ring :c2, :c2, :g2, :c2, :f2, :g2, :c2, :c2)
          cutoffs = (line 70, 90, steps: 8)
          8.times do
            play bass_pattern.tick, cutoff: cutoffs.tick, release: 0.5, res: 0.7, amp: 0.5
            sleep 0.5
          end
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 100, mix: 0.25 do
          4.times do
            sample :bd_haus, amp: 0.5
            sample :hat_psych, amp: 0.3, rate: 1.2
            sleep 0.25
            sample :hat_psych, amp: 0.2, rate: 1.3
            sleep 0.25
            sample :elec_snare, amp: 0.4
            sample :hat_psych, amp: 0.3, rate: 1.2
            sleep 0.25
            sample :hat_psych, amp: 0.2, rate: 1.3
            sleep 0.25
          end
        end
      end
    end
    
    # Transition drone
    use_synth :saw
    play :c2, cutoff: 95, release: 8, amp: 0.6
    in_thread do
      use_synth :hollow
      play_chord chord(:f3, :major7), cutoff: 90, release: 8, amp: 0.5
    end
    in_thread do
      use_synth :bass_foundation
      play :g2, cutoff: 70, release: 8, amp: 0.5
    end
    sleep 4
    
    # Section 3: Peak energy with beep lead, full percussion, and pumping bass
    4.times do
      use_synth :fm
      play :c2, release: 10, cutoff: 85, amp: 0.3, divisor: 6, depth: 18
      
      in_thread do
        use_synth :prophet
        play_chord chord(:c3, :major7), cutoff: 95, release: 10, amp: 0.5
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          use_synth :hollow
          arp_notes = (scale :c3, :major_pentatonic)
          8.times do
            play arp_notes.tick, cutoff: rrand(95, 115), release: 0.2, amp: 0.4
            sleep 0.5
          end
        end
      end
      
      in_thread do
        use_synth :beep
        melody = (ring :g5, :g5, :fs5, :e5, :g5, :e5, :d5, :c5)
        cutoffs = (ring 110, 115, 105, 120, 110, 115, 100, 95)
        8.times do |i|
          play melody.tick, release: 0.2, cutoff: cutoffs.look, amp: 0.95
          sleep 0.5
        end
      end
      
      in_thread do
        use_synth :chipbass
        bass_notes = (ring :c2, :c3, :c2, :g2, :c2, :c3, :f2, :g2)
        releases = (ring 0.4, 0.3, 0.4, 0.6, 0.4, 0.3, 0.5, 0.7)
        8.times do |i|
          amp_val = (i % 2 == 0) ? 0.55 : 0.35
          play bass_notes.tick, cutoff: 80, release: releases.look, amp: amp_val
          sleep 0.5
        end
      end
      
      in_thread do
        4.times do |i|
          sample :bd_haus, amp: 0.6
          sample :hat_psych, amp: 0.35, rate: 1.2
          sleep 0.125
          sample :hat_psych, amp: 0.25, rate: 1.4
          sleep 0.125
          
          if i == 1 || i == 3
            sample :elec_snare, amp: 0.5
            sample :elec_cymbal, amp: 0.4, rate: 1.5
          end
          
          sample :hat_psych, amp: 0.3, rate: 1.3
          sleep 0.125
          sample :hat_psych, amp: 0.2, rate: 1.5
          sleep 0.125
          
          sample :bd_haus, amp: 0.55
          sample :hat_psych, amp: 0.35, rate: 1.2
          sleep 0.125
          sample :hat_psych, amp: 0.25, rate: 1.4
          sleep 0.125
          
          if i == 1 || i == 3
            sample :elec_snare, amp: 0.45
          end
          
          sample :hat_psych, amp: 0.3, rate: 1.3
          sleep 0.125
          sample :hat_psych, amp: 0.2, rate: 1.5
          sleep 0.125
        end
      end
    end
    
    # Final transition drone to close
    use_synth :prophet
    play :c2, cutoff: 90, release: 12, amp: 0.7
    in_thread do
      use_synth :prophet
      play_chord chord(:c3, :major7), cutoff: 85, release: 12, amp: 0.55
    end
    in_thread do
      use_synth :bass_foundation
      play :c2, cutoff: 65, release: 12, amp: 0.55
    end
    sleep 4
    
  end
end