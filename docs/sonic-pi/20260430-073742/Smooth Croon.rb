# Smooth Croon
# Style: Jazz
# Mood: Smooth

use_debug false
use_bpm 85

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Smooth opening with sine lead, warm organ harmony, light percussion, sustained bass
    2.times do
      # Drone foundation
      use_synth :prophet
      play :f2, release: 16, cutoff: 85, amp: 0.4
      
      in_thread do
        # Harmony: Warm organ pad with major7 chords
        with_fx :reverb, room: 0.35, mix: 0.35 do
          use_synth :organ_tonewheel
          play_chord chord(:f3, :major7), cutoff: 85, release: 16, amp: 0.5
          
          4.times do
            use_synth :rhodey
            play_chord chord(:f3, :major7), cutoff: 90, release: 1.5, amp: 0.6
            sleep 2
            play_chord chord(:g3, :minor7), cutoff: 88, release: 1.5, amp: 0.6
            sleep 2
          end
        end
      end
      
      in_thread do
        # Bass: Sustained root notes foundation
        use_synth :bass_foundation
        play :f2, cutoff: 70, release: 8, amp: 0.7
        sleep 4
        play :c2, cutoff: 68, release: 4, amp: 0.65
        sleep 2
        play :f2, cutoff: 72, release: 2, amp: 0.6
        sleep 2
      end
      
      in_thread do
        # Percussion: Light, sparse jazz groove
        2.times do
          sample :drum_bass_soft, amp: 0.6
          sample :drum_cymbal_soft, amp: 0.35, rate: 0.95
          sleep 0.75
          sample :hat_tap, amp: 0.25
          sleep 0.25
          
          sample :drum_cymbal_soft, amp: 0.3, rate: 0.95
          sleep 0.5
          sample :drum_snare_soft, amp: 0.55, rate: 1.1
          sample :drum_cymbal_soft, amp: 0.35, rate: 0.95
          sleep 0.5
          
          sample :drum_cymbal_soft, amp: 0.3, rate: 0.95
          sleep 0.75
          sample :hat_tap, amp: 0.25
          sleep 0.25
          
          sample :drum_cymbal_soft, amp: 0.32, rate: 0.95
          sleep 0.5
          sample :drum_snare_soft, amp: 0.6, rate: 1.1
          sample :drum_cymbal_soft, amp: 0.35, rate: 0.95
          sample :hat_tap, amp: 0.2 if one_in(3)
          sleep 0.5
        end
      end
      
      # Melody: Smooth sine lead
      with_fx :reverb, room: 0.25, mix: 0.3 do
        use_synth :sine
        melody_notes = (ring :f4, :a4, :c5, :f5, :e5, :c5, :a4, :g4)
        sleep_times = (ring 0.75, 0.25, 0.5, 0.5, 0.75, 0.25, 1, 1)
        
        8.times do
          play melody_notes.tick, release: 0.3, cutoff: rrand(90, 110), amp: 0.9
          sleep sleep_times.look
        end
      end
    end
    
    # Transition drone
    use_synth :fm
    play :f2, release: 10, cutoff: 88, divisor: 4, depth: 12, amp: 0.5
    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:c3, :dom7), cutoff: 82, release: 8, amp: 0.55
    end
    in_thread do
      use_synth :fm
      play :f1, cutoff: 65, release: 4, divisor: 2, depth: 8, amp: 0.6
    end
    in_thread do
      2.times do
        sample :drum_cymbal_soft, amp: 0.25, rate: 0.9
        sleep 1
        sample :hat_tap, amp: 0.2
        sleep 1
      end
    end
    sleep 4
    
    # Section 2: Rhodey warmth, piano harmony, walking bass, active hi-hat
    3.times do
      # Sustained pad underneath
      use_synth :hollow
      play :f3, release: 12, cutoff: 92, amp: 0.3
      
      in_thread do
        # Harmony: Piano voicings with ii-V-I progression
        use_synth :organ_tonewheel
        play_chord chord(:f3, :major7), cutoff: 88, release: 12, amp: 0.5
        
        use_synth :piano
        chords_prog = [chord(:g3, :minor7), chord(:c3, :dom7), chord(:f3, :major7), chord(:d3, :minor7)]
        
        4.times do |i|
          play_chord chords_prog[i], cutoff: (line 85, 105, steps: 4).look, release: 1.8, amp: 0.65
          sleep 2
        end
      end
      
      in_thread do
        # Bass: Walking bass with chromatic approaches
        with_fx :lpf, cutoff: 75, mix: 0.3 do
          use_synth :bass_foundation
          walking_bass = (ring :f2, :a2, :c3, :bf2, :a2, :g2, :e2, :f2)
          releases = (ring 0.6, 0.5, 0.5, 0.6, 0.5, 0.5, 0.7, 0.8)
          
          8.times do
            play walking_bass.tick, cutoff: (line 70, 80, steps: 8).tick, release: releases.look, amp: 0.65
            sleep 1
          end
        end
      end
      
      in_thread do
        # Percussion: Building groove with more hi-hat activity
        2.times do
          sample :drum_bass_soft, amp: 0.65
          sample :drum_cymbal_soft, amp: 0.38, rate: 0.95
          sample :hat_tap, amp: 0.3
          sleep 0.5
          sample :hat_tap, amp: 0.25
          sleep 0.25
          sample :drum_cymbal_soft, amp: 0.3, rate: 0.95
          sleep 0.25
          
          sample :drum_snare_soft, amp: 0.6, rate: 1.1
          sample :drum_cymbal_soft, amp: 0.38, rate: 0.95
          sample :hat_tap, amp: 0.3
          sleep 0.5
          sample :hat_tap, amp: 0.28
          sleep 0.5
          
          sample :drum_bass_soft, amp: 0.5
          sample :drum_cymbal_soft, amp: 0.35, rate: 0.95
          sample :hat_tap, amp: 0.3
          sleep 0.5
          sample :hat_tap, amp: 0.25
          sleep 0.25
          sample :drum_cymbal_soft, amp: 0.3, rate: 0.95
          sample :hat_tap, amp: 0.2
          sleep 0.25
          
          sample :drum_snare_soft, amp: 0.65, rate: 1.1
          sample :drum_cymbal_soft, amp: 0.38, rate: 0.95
          sample :hat_tap, amp: 0.32
          sleep 0.5
          sample :hat_tap, amp: 0.25
          sample :drum_cymbal_soft, amp: 0.28, rate: 0.95 if one_in(2)
          sleep 0.5
        end
      end
      
      # Melody: Rhodey adds warmth
      with_fx :lpf, cutoff: 105, mix: 0.3 do
        with_fx :reverb, room: 0.28, mix: 0.25 do
          use_synth :rhodey
          jazz_phrase = (ring :a4, :c5, :d5, :c5, :bf4, :a4, :g4, :f4)
          timings = (ring 0.5, 0.5, 0.75, 0.25, 0.5, 0.5, 1, 1)
          
          8.times do
            play jazz_phrase.tick, release: 0.4, cutoff: (line 85, 115, steps: 8).tick, amp: 0.95
            sleep timings.look
          end
        end
      end
    end
    
    # Transition drone
    use_synth :prophet
    play :f2, release: 8, cutoff: 90, amp: 0.6
    in_thread do
      use_synth :rhodey
      play_chord chord(:f3, :major7), cutoff: 90, release: 8, amp: 0.6
    end
    in_thread do
      use_synth :bass_foundation
      play :f2, cutoff: 68, release: 4, amp: 0.7
    end
    in_thread do
      2.times do
        sample :drum_cymbal_soft, amp: 0.3, rate: 0.9
        sleep 1
        sample :drum_snare_soft, amp: 0.45, rate: 1.1
        sleep 1
      end
    end
    sleep 4
    
    # Section 3: Piano finale with rich harmony, deep bass slides, full jazz groove
    2.times do
      # Deep drone foundation
      use_synth :fm
      play :f2, release: 14, cutoff: 87, divisor: 5, depth: 18, amp: 0.45
      
      in_thread do
        # Harmony: Rich piano and rhodey blend with extensions
        use_synth :organ_tonewheel
        play_chord chord(:f2, :major7), cutoff: 80, release: 14, amp: 0.5
        
        8.times do |n|
          if n % 2 == 0
            use_synth :piano
            play_chord chord(:f3, :maj9), cutoff: rrand(90, 110), release: 1.5, amp: 0.7
          else
            use_synth :rhodey
            play_chord chord(:c3, :dom7), cutoff: rrand(85, 105), release: 1.5, amp: 0.65
          end
          sleep 1
        end
      end
      
      in_thread do
        # Bass: Deep foundation with slides
        use_synth :fm
        play :f1, cutoff: 65, release: 7, divisor: 3, depth: 10, amp: 0.65
        sleep 2
        
        use_synth :bass_foundation
        play :g2, cutoff: 72, release: 0.6, amp: 0.6
        sleep 1
        play :a2, cutoff: 74, release: 0.6, amp: 0.6
        sleep 1
        play :bf2, cutoff: 76, release: 0.8, amp: 0.65
        sleep 1
        play :c3, cutoff: 75, release: 1.5, amp: 0.7
        sleep 1.5
        play :bf2, cutoff: 72, release: 0.7, amp: 0.6
        sleep 0.5
        play :a2, cutoff: 70, release: 0.5, amp: 0.6
        sleep 0.5
        play :g2, cutoff: 68, release: 0.5, amp: 0.6
        sleep 0.5
        play :f2, cutoff: 70, release: 1, amp: 0.7
        sleep 1
      end
      
      in_thread do
        # Percussion: Full jazz groove for piano finale
        with_fx :reverb, room: 0.25, mix: 0.25 do
          2.times do
            sample :drum_bass_soft, amp: 0.7
            sample :drum_cymbal_soft, amp: 0.4, rate: 0.95
            sample :hat_tap, amp: 0.35
            sleep 0.5
            sample :hat_tap, amp: 0.28
            sleep 0.25
            sample :drum_cymbal_soft, amp: 0.32, rate: 0.95
            sample :hat_tap, amp: 0.25
            sleep 0.25
            
            sample :drum_snare_soft, amp: 0.65, rate: 1.1
            sample :drum_cymbal_soft, amp: 0.4, rate: 0.95
            sample :hat_tap, amp: 0.35
            sleep 0.5
            sample :hat_tap, amp: 0.3
            sleep 0.25
            sample :drum_cymbal_soft, amp: 0.3, rate: 0.95
            sleep 0.25
            
            sample :drum_bass_soft, amp: 0.6
            sample :drum_cymbal_soft, amp: 0.38, rate: 0.95
            sample :hat_tap, amp: 0.35
            sleep 0.5
            sample :hat_tap, amp: 0.28
            sample :drum_bass_soft, amp: 0.45 if one_in(3)
            sleep 0.25
            sample :drum_cymbal_soft, amp: 0.32, rate: 0.95
            sample :hat_tap, amp: 0.25
            sleep 0.25
            
            sample :drum_snare_soft, amp: 0.7, rate: 1.1
            sample :drum_cymbal_soft, amp: 0.4, rate: 0.95
            sample :hat_tap, amp: 0.35
            sleep 0.5
            sample :hat_tap, amp: 0.3
            sleep 0.25
            sample :drum_cymbal_soft, amp: 0.35, rate: 0.95
            sample :hat_tap, amp: 0.28
            sleep 0.25
          end
        end
      end
      
      # Melody: Piano finale with embellishments
      use_synth :piano
      final_melody = (ring :f4, :g4, :a4, :bf4, :c5, :d5, :c5, :bf4, :a4, :g4, :f4, :e4, :f4, :a4, :c5, :f5)
      note_lengths = (ring 0.5, 0.25, 0.25, 0.5, 0.5, 0.75, 0.25, 0.5, 0.25, 0.25, 0.5, 0.5, 0.75, 0.25, 1, 1)
      
      16.times do
        play final_melody.tick, release: 0.35, cutoff: rrand(95, 120), amp: 1.0
        sleep note_lengths.look
      end
    end
    
    # Ending drone - fades into silence
    use_synth :prophet
    play :f2, release: 12, cutoff: 80, amp: 0.5
    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:f2, :major7), cutoff: 75, release: 12, amp: 0.5
    end
    in_thread do
      use_synth :bass_foundation
      play :f1, cutoff: 65, release: 12, amp: 0.7
    end
    in_thread do
      4.times do |i|
        fade_amp = (line 0.35, 0.15, steps: 4).tick
        sample :drum_cymbal_soft, amp: fade_amp, rate: 0.9
        sleep 1
        sample :hat_tap, amp: fade_amp * 0.6
        sleep 1
      end
    end
    sleep 8
    
  end
end