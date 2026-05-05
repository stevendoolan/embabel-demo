# Smooth Croon
# A jazz composition in F major, 72 BPM, 4/4 time
# Smooth jazz mood with warm harmony and gentle swing

use_debug false
use_bpm 72

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Smooth jazz intro with Rhodes piano, organ harmony, walking bass, and gentle drums
    2.times do
      in_thread do
        use_synth :rhodey
        play :f2, release: 12, cutoff: 95, amp: 0.5
        
        with_fx :reverb, room: 0.25, mix: 0.3 do
          melody_notes = (ring :f4, :a4, :c5, :e5, :d5, :c5, :a4, :f4)
          cutoffs = (ring 100, 95, 110, 105, 100, 95, 90, 85)
          
          8.times do
            play melody_notes.tick, cutoff: cutoffs.look, release: 0.8, amp: 0.95
            sleep 0.5
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :organ_tonewheel
          play_chord chord(:f3, :major7), cutoff: 95, release: 12, amp: 0.5
          
          chord_progression = [
            chord(:f3, :major7),
            chord(:a3, :m7),
            chord(:d3, :m7),
            chord(:g3, '7')
          ]
          
          4.times do |i|
            play_chord chord_progression[i], cutoff: 100, release: 2.5, amp: 0.6
            sleep 1
          end
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :f2, cutoff: 70, release: 8, amp: 0.7
        
        bass_walk = (ring :f2, :a2, :c3, :a2, :f2, :g2, :a2, :c3)
        
        8.times do
          play bass_walk.tick, cutoff: 75, release: 0.8, amp: 0.6
          sleep 0.5
        end
      end
      
      in_thread do
        8.times do
          sample :drum_bass_soft, amp: 0.6
          sample :drum_cymbal_soft, amp: 0.35
          sleep 0.5
          sample :drum_cymbal_soft, amp: 0.25
          sleep 0.25
          sample :drum_cymbal_soft, amp: 0.3
          sleep 0.25
        end
      end
      
      sleep 4
    end
    
    # Transition: Warm sustained drone bridges sections
    use_synth :fm
    play :f3, cutoff: 90, release: 10, amp: 0.6
    sleep 4
    
    # Section 2: Piano comping with ninth chord voicings, syncopated bass, and building drums
    2.times do
      in_thread do
        use_synth :piano
        play :f2, release: 10, cutoff: 100, amp: 0.4
        
        with_fx :lpf, cutoff: 110, mix: 0.3 do
          with_fx :echo, phase: 0.75, decay: 1.5, mix: 0.2 do
            jazz_phrase = (knit :f4, 2, :a4, 1, :c5, 2, :e5, 1, :d5, 1, :c5, 1)
            
            8.times do
              play jazz_phrase.tick, cutoff: rrand(95, 115), release: 0.6, amp: 1.0
              sleep 0.5
            end
          end
        end
      end
      
      in_thread do
        use_synth :piano
        play_chord chord(:f2, :major7), cutoff: 95, release: 10, amp: 0.45
        
        with_fx :lpf, cutoff: 105, mix: 0.3 do
          jazz_chords = [
            chord(:f3, :maj9),
            chord(:c3, '9'),
            chord(:d3, :m9),
            chord(:g3, '7-9')
          ]
          
          cutoff_line = (line 90, 110, steps: 8)
          
          8.times do |i|
            chord_idx = i % 4
            play_chord jazz_chords[chord_idx], cutoff: cutoff_line.tick, release: 0.8, amp: 0.65
            sleep 0.5
          end
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :f1, cutoff: 68, release: 10, amp: 0.7
        
        with_fx :lpf, cutoff: 85, mix: 0.3 do
          walking_pattern = (ring :f2, :e2, :d2, :c2, :f2, :g2, :a2, :c3)
          
          8.times do
            play walking_pattern.tick, cutoff: rrand(70, 80), release: 0.6, amp: 0.65
            sleep 0.5
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          8.times do
            sample :drum_bass_soft, amp: 0.7
            sample :hat_cats, amp: 0.4
            sleep 0.5
            sample :drum_snare_soft, amp: 0.55
            sample :hat_cats, amp: 0.35
            sleep 0.25
            sample :hat_cats, amp: 0.3
            sleep 0.25
          end
        end
      end
      
      sleep 4
    end
    
    # Transition: Smooth Rhodes sustain
    use_synth :rhodey
    play :f3, cutoff: 85, release: 12, amp: 0.6
    sleep 4
    
    # Section 3: Finale with sine wave melody, rich harmony, walking bass resolution, and full swing drums
    3.times do
      in_thread do
        use_synth :sine
        play :f2, release: 14, cutoff: 90, amp: 0.5
        
        resolution = (ring :f4, :g4, :a4, :as4, :c5, :d5, :c5, :a4)
        dynamic_cutoff = (line 85, 120, steps: 8)
        
        8.times do
          play resolution.tick, cutoff: dynamic_cutoff.tick, release: 0.9, amp: 1.0
          sleep 0.5
        end
      end
      
      in_thread do
        use_synth :fm
        play_chord chord(:f2, :major7), cutoff: 85, release: 14, amp: 0.5
        
        use_synth :organ_tonewheel
        
        resolution_chords = [
          chord(:f3, :maj9),
          chord(:g3, :m7),
          chord(:a3, :m7),
          chord(:as3, :major7),
          chord(:c4, :maj9),
          chord(:d3, :m9),
          chord(:c3, '9'),
          chord(:f3, :major7)
        ]
        
        dynamic_cutoff = (line 90, 115, steps: 8)
        
        8.times do |i|
          play_chord resolution_chords[i], cutoff: dynamic_cutoff.tick, release: 1.2, amp: 0.7
          sleep 0.5
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :f1, cutoff: 65, release: 12, amp: 0.75
        
        resolution_bass = (ring :f2, :g2, :a2, :as2, :c3, :d3, :c3, :a2)
        
        8.times do
          play resolution_bass.tick, cutoff: (line 70, 85, steps: 8).tick, release: 0.9, amp: 0.6
          sleep 0.5
        end
      end
      
      in_thread do
        8.times do
          sample :drum_bass_soft, amp: 0.8
          sample :drum_cymbal_soft, amp: 0.45
          sleep 0.25
          sample :drum_cymbal_soft, amp: 0.3
          sleep 0.25
          sample :drum_snare_soft, amp: 0.6
          sample :drum_cymbal_soft, amp: 0.35
          sleep 0.25
          sample :drum_cymbal_soft, amp: 0.25
          sample :drum_snare_soft, amp: 0.4 if one_in(3)
          sleep 0.25
        end
      end
      
      sleep 4
    end
    
    # Final fadeout with deep harmonic resolution
    use_synth :fm
    play_chord chord(:f3, :maj9), cutoff: 80, release: 16, amp: 0.6
    play :f1, cutoff: 60, release: 16, amp: 0.7
    sleep 4
    
  end
end