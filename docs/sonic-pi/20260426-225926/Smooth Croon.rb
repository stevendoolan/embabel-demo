use_debug false
# Smooth Croon
# Jazz in F major, 4/4 time, smooth mood

use_bpm 75

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Piano intro with warm jazz chords
    2.times do
      in_thread do
        use_synth :piano
        play :f2, release: 8, cutoff: 90, amp: 0.4
        
        with_fx :reverb, room: 0.25, mix: 0.3 do
          notes = (ring :f4, :a4, :c5, :f5, :e5, :d5, :c5, :a4, :g4, :f4, :a4, :c5, :d5, :c5, :a4, :f4)
          16.times do
            play notes.tick, release: 0.3, cutoff: rrand(95, 110), amp: 0.9
            sleep 0.5
          end
        end
      end
      
      in_thread do
        use_synth :fm
        play :f2, cutoff: 85, release: 16, amp: 0.5, divisor: 2, depth: 3
        
        with_fx :reverb, room: 0.3, mix: 0.35 do
          chords = [
            chord(:f3, :major9),
            chord(:bf3, '9'),
            chord(:c3, '9'),
            chord(:f3, :major9)
          ]
          
          4.times do |i|
            play_chord chords[i], cutoff: 90, release: 1.8, amp: 0.6
            sleep 2
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          16.times do
            sample :drum_bass_soft, amp: 0.7 if spread(2, 4).tick
            sample :drum_cymbal_soft, amp: 0.35, rate: 0.9
            sleep 0.5
          end
        end
      end
      
      sleep 8
    end
    
    # Transition drone
    use_synth :rhodey
    play :f2, cutoff: 95, release: 10, amp: 0.6
    sleep 4
    
    # Section 2: Rhodes with walking bass feel
    2.times do
      in_thread do
        use_synth :rhodey
        play :f2, release: 10, cutoff: 85, amp: 0.4
        
        with_fx :lpf, cutoff: 110, mix: 0.3 do
          with_fx :echo, phase: 0.75, decay: 1.5, mix: 0.2 do
            melody = (knit :f4, 2, :a4, 1, :c5, 2, :d5, 1, :c5, 2, :a4, 1, :g4, 2, :f4, 2, :e4, 1, :d4, 2, :c4, 1)
            16.times do
              play melody.tick, release: 0.25, cutoff: (line 90, 115, steps: 16).tick, amp: 0.95
              sleep 0.5
            end
          end
        end
      end
      
      in_thread do
        use_synth :organ_tonewheel
        play_chord chord(:f3, :major9), cutoff: 95, release: 12, amp: 0.55
        
        with_fx :lpf, cutoff: 105, mix: 0.3 do
          ext_chords = [
            chord(:f3, :major9),
            chord(:d3, 'm11'),
            chord(:g3, 'm11'),
            chord(:c3, '13'),
            chord(:f3, :major9)
          ]
          
          4.times do |i|
            play_chord ext_chords[i], cutoff: (line 92, 110, steps: 8).tick, release: 1.5, amp: 0.65
            sleep 2
          end
        end
      end
      
      in_thread do
        16.times do
          sample :drum_bass_soft, amp: 0.75 if spread(2, 4).tick
          sample :drum_cymbal_soft, amp: 0.4, rate: 0.9
          sample :drum_snare_soft, amp: 0.5, rate: 0.8 if (look % 2 == 1)
          sleep 0.5
        end
      end
      
      sleep 8
    end
    
    # Transition drone
    use_synth :prophet
    play :f2, cutoff: 88, release: 12, amp: 0.6
    sleep 4
    
    # Section 3: Saw synth builds intensity
    3.times do
      in_thread do
        use_synth :saw
        play :f2, release: 12, cutoff: 80, amp: 0.35
        
        with_fx :reverb, room: 0.3, mix: 0.25 do
          climax = (ring :f4, :g4, :a4, :c5, :d5, :f5, :e5, :d5, :c5, :bf4, :a4, :g4, :a4, :c5, :bf4, :a4)
          cutoffs = (line 85, 120, steps: 16)
          16.times do
            play climax.tick, release: 0.2, cutoff: cutoffs.tick, amp: 1.0
            sleep 0.5
          end
        end
      end
      
      in_thread do
        use_synth :prophet
        play :f2, cutoff: 82, release: 14, amp: 0.5
        
        with_fx :reverb, room: 0.4, mix: 0.4 do
          climax_chords = [
            chord(:f3, '13'),
            chord(:g3, 'm11'),
            chord(:a3, 'm11'),
            chord(:bf3, '13')
          ]
          
          4.times do |i|
            play_chord climax_chords[i], cutoff: (line 88, 115, steps: 12).tick, release: 1.6, amp: 0.7
            sleep 2
          end
        end
      end
      
      in_thread do
        16.times do
          tick_count = tick
          sample :drum_bass_soft, amp: 0.8 if spread(2, 4).look
          sample :drum_cymbal_soft, amp: 0.45, rate: 0.9
          sample :drum_snare_soft, amp: 0.6, rate: 0.8 if (look % 2 == 1)
          sample :hat_psych, amp: 0.3, pan: rrand(-0.3, 0.3) if one_in(3)
          sleep 0.5
        end
      end
      
      sleep 8
    end
    
    # Final resolution
    in_thread do
      use_synth :piano
      play_chord chord(:f3, :major7), release: 8, cutoff: 100, amp: 0.7
    end
    
    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:f3, '13'), release: 8, cutoff: 100, amp: 0.65
    end
    
    in_thread do
      8.times do
        sample :drum_cymbal_soft, amp: (line 0.4, 0.1, steps: 8).tick, rate: 0.85
        sleep 1
      end
    end
    
    sleep 8
    
  end
end