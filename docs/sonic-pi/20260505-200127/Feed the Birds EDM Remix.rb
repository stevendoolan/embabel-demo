# Feed the Birds EDM Remix
# Electronic / Uplifting / 128 BPM / 4/4 time

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening in F major with saw lead, pads, bass, and light drums
    2.times do
      use_synth :prophet
      play :f2, release: 16, cutoff: 85, amp: 0.5
      
      in_thread do
        use_synth :prophet
        play_chord chord(:f3, :major), cutoff: 85, release: 16, amp: 0.5
      end
      
      in_thread do
        use_synth :bass_foundation
        play :f1, cutoff: 65, release: 8, amp: 0.65
        sleep 4
        play :c2, cutoff: 70, release: 4, amp: 0.55
        sleep 4
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          use_synth :saw
          melody_f = (ring :f4, :a4, :c5, :f5, :e5, :c5, :a4, :f4)
          16.times do
            play melody_f.tick, cutoff: (line 90, 120, steps: 16).look, release: 0.2, amp: 0.9
            sleep 0.25
          end
        end
      end
      
      in_thread do
        use_synth :hoover
        chords_f = [chord(:f3, :major), chord(:c3, :major), chord(:a3, :minor), chord(:f3, :major)]
        4.times do
          play_chord chords_f.tick, cutoff: (line 80, 100, steps: 4).look, release: 3.8, amp: 0.5
          sleep 4
        end
      end
      
      in_thread do
        16.times do
          sample :bd_haus, amp: 0.6
          sample :hat_psych, amp: 0.25
          sleep 0.25
          sample :hat_psych, amp: 0.15
          sleep 0.25
          sample :elec_snare, amp: 0.5
          sample :hat_psych, amp: 0.25
          sleep 0.25
          sample :hat_psych, amp: 0.15
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Transition drone — bridges to buildup
    use_synth :fm
    play :f2, cutoff: 95, release: 8, divisor: 2, depth: 8, amp: 0.6
    
    in_thread do
      use_synth :prophet
      play_chord chord(:f3, :major), cutoff: 90, release: 8, amp: 0.5
    end
    
    in_thread do
      use_synth :bass_foundation
      play :f1, cutoff: 60, release: 6, amp: 0.6
    end
    
    in_thread do
      8.times do
        sample :bd_haus, amp: 0.5
        sleep 0.5
      end
    end
    
    sleep 4
    
    # Section 2: Buildup with supersaw, arpeggiated piano, TB303 bass, and snare rolls
    2.times do
      use_synth :blade
      play :f2, release: 12, cutoff: 90, amp: 0.4
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :prophet
          play_chord chord(:f3, :major), cutoff: 88, release: 12, amp: 0.55
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 85, mix: 0.3 do
          use_synth :tb303
          bass_pattern = (ring :f1, :f1, :c2, :f1, :a1, :f1, :c2, :a1)
          cutoff_line = (line 65, 90, steps: 8)
          8.times do
            play bass_pattern.tick, cutoff: cutoff_line.look, release: 0.8, res: 0.7, amp: 0.6
            sleep 1
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.25 do
          use_synth :supersaw
          melody_build = (knit :f4, 2, :a4, 2, :c5, 4, :f5, 4, :e5, 2, :c5, 2)
          melody_build.length.times do
            play melody_build.tick, cutoff: rrand(100, 120), release: 0.15, amp: 0.95
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :piano
          arp_notes = scale(:f3, :major)
          16.times do
            play arp_notes.tick, cutoff: rrand(90, 110), release: 0.15, amp: 0.45
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 100, mix: 0.25 do
          12.times do
            sample :bd_haus, amp: 0.65
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
          4.times do
            sample :elec_snare, amp: 0.4
            sleep 0.125
          end
        end
      end
      
      sleep 16
    end
    
    # Transition drone — key change preparation
    use_synth :prophet
    play :g2, cutoff: 90, release: 10, amp: 0.6
    
    in_thread do
      use_synth :hoover
      play_chord chord(:g3, :major), cutoff: 85, release: 10, amp: 0.5
    end
    
    in_thread do
      use_synth :fm
      play :g1, cutoff: 75, release: 6, divisor: 2, depth: 4, amp: 0.55
    end
    
    in_thread do
      sample :drum_cymbal_open, amp: 0.6
      4.times do
        sample :bd_haus, amp: 0.6
        sleep 0.5
      end
    end
    
    sleep 4
    
    # Section 3: Key change to G major — euphoric climax with blade lead, full pads, driving bass, detailed percussion
    3.times do
      use_synth :fm
      play :g2, release: 14, cutoff: 85, divisor: 3, depth: 12, amp: 0.5
      
      in_thread do
        use_synth :prophet
        play_chord chord(:g3, :major), cutoff: 90, release: 14, amp: 0.6
      end
      
      in_thread do
        use_synth :bass_foundation
        play :g1, cutoff: 70, release: 8, amp: 0.7
        sleep 2
        use_synth :tb303
        syncopated = (knit :g1, 2, :d2, 1, :g1, 1, :b1, 2, :d2, 1, :g1, 1)
        syncopated.length.times do
          play syncopated.tick, cutoff: rrand(70, 85), release: 0.6, res: 0.8, amp: 0.6
          sleep 0.5
        end
        sleep 2
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :blade
          melody_g = (ring :g4, :b4, :d5, :g5, :fs5, :d5, :b4, :g4)
          cutoffs = (line 95, 130, steps: 16)
          16.times do
            play melody_g.tick, cutoff: cutoffs.look, release: 0.2, amp: 1.0
            sleep 0.25
          end
        end
      end
      
      in_thread do
        use_synth :hoover
        chords_g = [chord(:g3, :major), chord(:d3, :major), chord(:e3, :minor), chord(:g3, :major)]
        4.times do
          play_chord chords_g.tick, cutoff: (line 85, 115, steps: 4).look, release: 3.8, amp: 0.5
          sleep 4
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          16.times do
            sample :bd_haus, amp: 0.75
            sample :hat_psych, amp: 0.35
            sleep 0.125
            sample :hat_psych, amp: 0.25
            sleep 0.125
            sample :elec_snare, amp: 0.65
            sample :hat_psych, amp: 0.35
            sample :elec_cymbal, amp: 0.3 if one_in(4)
            sleep 0.125
            sample :hat_psych, amp: 0.25
            sleep 0.125
          end
        end
      end
      
      sleep 16
    end
    
    # Final transition — sustained outro drone with cymbal and kick fadeout
    use_synth :prophet
    play :g2, cutoff: 80, release: 12, amp: 0.7
    
    in_thread do
      use_synth :prophet
      play_chord chord(:g3, :major), cutoff: 80, release: 12, amp: 0.6
    end
    
    in_thread do
      use_synth :bass_foundation
      play :g1, cutoff: 65, release: 12, amp: 0.65
    end
    
    in_thread do
      sample :drum_cymbal_open, amp: 0.5
      6.times do
        sample :bd_haus, amp: (line 0.6, 0.25, steps: 6).tick
        sleep 1
      end
    end
    
    sleep 6
    
  end
end