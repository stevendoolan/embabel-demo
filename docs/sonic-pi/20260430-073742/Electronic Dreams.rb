# Electronic Dreams
# Style: Dreamy electronic journey
# Mood: Atmospheric and hypnotic

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Dreamy opening in Am - atmospheric foundation with minimal percussion
    2.times do
      in_thread do
        use_synth :fm
        play :a2, release: 16, divisor: 4, depth: 10, cutoff: 85, amp: 0.4
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :dark_ambience
          play_chord chord(:a3, :minor), cutoff: 85, release: 16, amp: 0.4
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :a1, cutoff: 70, release: 8, amp: 0.6
        sleep 4
        with_fx :lpf, cutoff: 75, mix: 0.25 do
          use_synth :tb303
          bass_pattern = (ring :a1, :a1, :e2, :c2)
          4.times do
            play bass_pattern.tick, cutoff: 72, release: 0.8, res: 0.6, amp: 0.5
            sleep 1
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.25 do
          with_fx :reverb, room: 0.25, mix: 0.25 do
            use_synth :fm
            melody_notes = (ring :a4, :c5, :e5, :a5, :g5, :e5, :c5, :a4)
            16.times do |i|
              play melody_notes.tick, cutoff: (line 90, 115, steps: 16).tick, release: 0.3, amp: 0.9
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :hollow
          8.times do |i|
            play_chord chord(:a3, :minor), cutoff: (line 80, 105, steps: 8).tick, release: 0.5, amp: 0.35
            sleep 0.5
          end
        end
      end
      
      16.times do |i|
        sample :bd_haus, amp: (i % 4 == 0 ? 0.5 : 0.35) if spread(8, 16)[i]
        sample :hat_psych, amp: 0.2, rate: 1.2, cutoff: 100
        sample :elec_tick, amp: 0.15, rate: rrand(0.8, 1.5), cutoff: 110 if one_in(6)
        sleep 0.25
      end
    end
    
    # Transition drone - bridges to next section
    use_synth :prophet
    play :a2, cutoff: 90, release: 8, amp: 0.6
    sleep 4
    
    # Section 2: Building intensity with four-on-the-floor - still Am
    2.times do
      in_thread do
        use_synth :blade
        play :a2, release: 12, cutoff: 80, amp: 0.3
      end
      
      in_thread do
        use_synth :prophet
        play_chord chord(:a2, :minor7), cutoff: 90, release: 12, amp: 0.45
      end
      
      in_thread do
        use_synth :bass_foundation
        play :a1, cutoff: 75, release: 6, amp: 0.6
        sleep 2
        use_synth :chipbass
        walking_bass = (knit :a1, 2, :c2, 1, :e2, 1, :g2, 2, :e2, 1, :c2, 1)
        8.times do
          play walking_bass.tick, cutoff: 80, release: 0.5, amp: 0.5
          sleep 0.5
        end
      end
      
      in_thread do
        use_synth :prophet
        harmony = (knit :a3, 4, :c4, 2, :e4, 2, :g4, 4, :e4, 2, :c4, 2)
        16.times do
          play harmony.tick, cutoff: rrand(95, 120), release: 0.25, amp: 0.85
          sleep 0.25
        end
      end
      
      in_thread do
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
          use_synth :hollow
          harmony_progression = (knit chord(:a3, :minor), 4, chord(:c4, :major), 2, chord(:e3, :minor), 2, chord(:g3, :major), 4, chord(:e3, :minor), 2, chord(:c4, :major), 2)
          16.times do
            play_chord harmony_progression.tick, cutoff: rrand(90, 115), release: 0.4, amp: 0.4
            sleep 0.25
          end
        end
      end
      
      with_fx :hpf, cutoff: 90, mix: 0.25 do
        16.times do |i|
          sample :bd_haus, amp: (i % 4 == 0 ? 0.6 : 0.45), cutoff: 95
          sample :hat_psych, amp: (i % 2 == 0 ? 0.25 : 0.15), rate: 1.1, cutoff: 105
          sleep 0.25
          if (i % 4 == 1) or (i % 4 == 3)
            sample :elec_hi_snare, amp: 0.45, cutoff: 100
          end
          sample :elec_tick, amp: 0.2, rate: rrand(1, 2), cutoff: 110 if one_in(8)
          sleep 0.25
        end
      end
    end
    
    # Transition drone with key change preparation
    use_synth :fm
    play :c3, cutoff: 95, release: 10, divisor: 8, depth: 15, amp: 0.5
    sleep 4
    
    # Section 3: Key change to C major - lush resolution with full intensity
    3.times do
      in_thread do
        use_synth :prophet
        play :c3, release: 14, cutoff: 88, amp: 0.35
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.3 do
          use_synth :prophet
          play_chord chord(:c3, :major7), cutoff: 85, release: 14, amp: 0.5
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 78, release: 7, amp: 0.6
        sleep 2
        use_synth :tb303
        c_bass = (ring :c2, :c2, :g2, :e2, :f2, :c2, :g2, :c2)
        8.times do
          play c_bass.tick, cutoff: 75, release: 0.7, res: 0.65, amp: 0.5
          sleep 0.5
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.25 do
          use_synth :blade
          c_major_melody = (ring :c5, :e5, :g5, :c6, :b5, :g5, :e5, :c5, :d5, :f5, :a5, :g5, :e5, :c5, :d5, :e5)
          16.times do |i|
            play c_major_melody.tick, cutoff: (line 85, 125, steps: 16).tick, release: 0.2, amp: 0.95
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.3 do
          use_synth :hollow
          c_major_chords = (ring chord(:c4, :major), chord(:f3, :major), chord(:g3, :major), chord(:a3, :minor))
          16.times do |i|
            play_chord c_major_chords.tick, cutoff: (line 82, 118, steps: 16).tick, release: 0.35, amp: 0.35
            sleep 0.25
          end
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.2 do
        16.times do |i|
          sample :bd_haus, amp: (i % 4 == 0 ? 0.7 : 0.5), cutoff: 100
          sample :hat_psych, amp: 0.3, rate: 1.15, cutoff: 105
          sleep 0.25
          if (i % 4 == 1) or (i % 4 == 3)
            sample :elec_hi_snare, amp: 0.5, cutoff: 100
          elsif one_in(3)
            sample :elec_hi_snare, amp: 0.25, rate: 1.2, cutoff: 105
          end
          sample :elec_tick, amp: 0.25, rate: rrand(0.5, 2), cutoff: 110 if one_in(5)
          sleep 0.25
        end
      end
    end
    
    # Final fade - minimal percussion with sustained drone
    in_thread do
      use_synth :fm
      play :c3, release: 12, divisor: 6, depth: 18, cutoff: 82, amp: 0.4
    end
    
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c3, :major), release: 12, cutoff: 80, amp: 0.4
    end
    
    in_thread do
      use_synth :bass_foundation
      play :c2, cutoff: 70, release: 10, amp: 0.5
    end
    
    8.times do |i|
      sample :bd_haus, amp: (line 0.4, 0.15, steps: 8).tick, cutoff: 95
      sample :hat_psych, amp: (line 0.2, 0.08, steps: 8).look, rate: 1.1, cutoff: 100
      sleep 1
    end
    
  end
end