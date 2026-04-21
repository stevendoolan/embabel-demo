# Feed the Birds EDM Remix
# Electronic / Uplifting / 128 BPM

use_debug false
use_bpm 128

with_fx :level, amp: 0.85 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Intro - Atmospheric opening with FM melody, ambient pads, light hi-hats (bars 1-4)
    2.times do
      in_thread do
        use_synth :dark_ambience
        play_chord chord(:c3, :major), cutoff: 85, release: 16, amp: 0.3
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :blade
          chords_prog = (ring chord(:c3, :major), chord(:g3, :major), 
                              chord(:a3, :minor), chord(:f3, :major))
          4.times do
            play_chord chords_prog.tick, cutoff: (line 80, 105, steps: 4).look, release: 3.8, amp: 0.35
            sleep 4
          end
        end
      end
      
      in_thread do
        use_synth :fm
        play :c2, release: 16, cutoff: 85, divisor: 4, depth: 15, amp: 0.3
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          use_synth :fm
          melody_notes = (ring :e4, :g4, :a4, :g4, :e4, :d4, :c4, :d4,
                                :e4, :e4, :d4, :d4, :e4, :g4, :c5, :c5)
          16.times do
            play melody_notes.tick, cutoff: (line 90, 115, steps: 16).look, release: 0.2, amp: 0.9
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 100 do
          16.times do
            sample :hat_bdu, amp: 0.3, rate: 1.2
            sleep 0.25
          end
        end
      end
      
      sleep 16
    end
    
    # Transition drone
    use_synth :prophet
    play :c2, cutoff: 88, release: 8, amp: 0.6
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c3, :major), cutoff: 82, release: 8, amp: 0.5
    end
    sleep 4
    
    # Section 2: Build-up - Prophet melody, layered pads, kick and snare pattern (bars 5-8)
    2.times do
      in_thread do
        use_synth :prophet
        play_chord chord(:c3, :major), cutoff: 88, release: 12, amp: 0.35
      end
      
      in_thread do
        with_fx :lpf, cutoff: 95, mix: 0.3 do
          use_synth :blade
          chords_prog = (ring chord(:c3, :major), chord(:f3, :major), 
                              chord(:g3, :major), chord(:c3, :major))
          4.times do
            play_chord chords_prog.tick, cutoff: (line 85, 110, steps: 4).look, release: 3.5, amp: 0.4
            sleep 4
          end
        end
      end
      
      in_thread do
        use_synth :prophet
        play :c2, release: 12, cutoff: 90, amp: 0.4
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.25 do
          use_synth :prophet
          melody_notes = (ring :c5, :g4, :a4, :c5, :d5, :c5, :a4, :g4,
                                :e4, :g4, :c5, :e5, :d5, :c5, :a4, :g4)
          16.times do
            play melody_notes.tick, cutoff: (line 85, 120, steps: 16).look, release: 0.15, amp: 0.95
            sleep 0.25
          end
        end
      end
      
      in_thread do
        4.times do |bar|
          sample :bd_haus, amp: bar == 0 ? 0.7 : 0.6, cutoff: 100
          sample :hat_bdu, amp: 0.35, rate: 1.2
          sleep 0.25
          sample :hat_bdu, amp: 0.3, rate: 1.2
          sleep 0.25
          
          sample :elec_hi_snare, amp: 0.5, rate: 1.1
          sample :hat_bdu, amp: 0.35, rate: 1.2
          sleep 0.25
          sample :hat_bdu, amp: 0.3, rate: 1.2
          sleep 0.25
          
          sample :bd_haus, amp: 0.6, cutoff: 100
          sample :hat_bdu, amp: 0.35, rate: 1.2
          sleep 0.25
          sample :hat_bdu, amp: 0.3, rate: 1.2
          sleep 0.25
          
          sample :elec_hi_snare, amp: 0.5, rate: 1.1
          sample :hat_bdu, amp: 0.35, rate: 1.2
          sleep 0.25
          sample :hat_bdu, amp: 0.3, rate: 1.2
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Transition drone
    use_synth :fm
    play :a1, cutoff: 85, release: 10, divisor: 3, depth: 18, amp: 0.6
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:a3, :minor), cutoff: 80, release: 10, amp: 0.55
    end
    in_thread do
      sample :drum_cymbal_soft, amp: 0.5
    end
    sleep 4
    
    # Section 3: Drop - Full energy with Supersaw, thick pads, complete drum pattern (bars 9-12)
    3.times do
      in_thread do
        use_synth :dark_ambience
        play_chord chord(:a3, :minor), cutoff: 90, release: 14, amp: 0.4
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.3 do
          use_synth :prophet
          chords_prog = (ring chord(:a3, :minor), chord(:f3, :major), 
                              chord(:c3, :major), chord(:g3, :major))
          4.times do
            play_chord chords_prog.tick, cutoff: (line 88, 115, steps: 4).look, release: 3.8, amp: 0.45
            sleep 4
          end
        end
      end
      
      in_thread do
        use_synth :blade
        arp_notes = scale(:a3, :minor_pentatonic)
        16.times do
          play arp_notes.tick, cutoff: rrand(90, 115), release: 0.3, amp: 0.3
          sleep 0.25
        end
      end
      
      in_thread do
        use_synth :supersaw
        play :a2, release: 14, cutoff: 92, amp: 0.4
      end
      
      in_thread do
        with_fx :reverb, room: 0.28, mix: 0.2 do
          use_synth :supersaw
          melody_notes = (ring :a4, :c5, :d5, :e5, :d5, :c5, :a4, :g4,
                                :a4, :a4, :g4, :g4, :a4, :c5, :e5, :e5)
          16.times do
            play melody_notes.tick, cutoff: rrand(95, 118), release: 0.18, amp: 1.0
            sleep 0.25
          end
        end
      end
      
      in_thread do
        4.times do |bar|
          sample :drum_cymbal_soft, amp: 0.4 if bar == 0
          
          sample :bd_haus, amp: bar == 0 ? 0.8 : 0.7, cutoff: 100
          sample :hat_bdu, amp: 0.4, rate: 1.3
          sleep 0.25
          sample :hat_bdu, amp: 0.35, rate: 1.3
          sleep 0.25
          
          sample :elec_hi_snare, amp: 0.6, rate: 1.15
          sample :hat_bdu, amp: 0.4, rate: 1.3
          sleep 0.25
          sample :hat_bdu, amp: 0.35, rate: 1.3
          sleep 0.25
          
          sample :bd_haus, amp: 0.7, cutoff: 100
          sample :hat_bdu, amp: 0.4, rate: 1.3
          sleep 0.25
          sample :hat_bdu, amp: 0.35, rate: 1.3
          sleep 0.25
          
          sample :elec_hi_snare, amp: 0.6, rate: 1.15
          sample :hat_bdu, amp: 0.4, rate: 1.3
          sample :drum_cymbal_soft, amp: 0.3 if one_in(4)
          sleep 0.25
          sample :hat_bdu, amp: 0.35, rate: 1.3
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Final drone fade
    use_synth :prophet
    play :a2, cutoff: 80, release: 12, amp: 0.5
    in_thread do
      use_synth :prophet
      play_chord chord(:a3, :minor), cutoff: 78, release: 12, amp: 0.4
    end
    in_thread do
      sample :drum_cymbal_soft, amp: 0.5
    end
    sleep 4
    
  end
end