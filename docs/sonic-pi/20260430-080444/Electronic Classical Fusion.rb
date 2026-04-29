# Electronic Classical Fusion
# Style: Electronic Classical Fusion
# Mood: Ethereal and atmospheric

use_debug false
use_bpm 120

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Ethereal opening with sparse percussion and foundation harmony
    2.times do
      in_thread do
        use_synth :prophet
        play :c2, release: 16, cutoff: 85, amp: 0.5
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :dark_ambience
          play_chord chord(:c2, :major), cutoff: 85, release: 16, amp: 0.4
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 70, release: 8, amp: 0.6
        sleep 8
        use_synth :subpulse
        bass_pattern = (ring :c2, :c2, :g2, :g2)
        4.times do
          play bass_pattern.tick, cutoff: 75, release: 1.8, amp: 0.55
          sleep 2
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          melody_notes = (ring :c4, :e4, :g4, :a4, :g4, :e4, :d4, :c4)
          cutoffs = (line 90, 115, steps: 8)
          use_synth :prophet
          8.times do
            play melody_notes.tick, release: 0.8, cutoff: cutoffs.look, amp: 0.9
            sleep 1
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :sine
          chords_section1 = (knit chord(:c3, :major), 4, chord(:a3, :minor), 2, chord(:f3, :major), 2)
          8.times do
            play_chord chords_section1.tick, cutoff: (line 88, 105, steps: 8).look, release: 1.5, amp: 0.4
            sleep 2
          end
        end
      end
      
      in_thread do
        8.times do |b|
          sample :bd_haus, amp: (b == 0) ? 0.6 : 0.5
          sample :drum_cymbal_closed, amp: 0.25 if b % 2 == 1
          sleep 1
        end
        4.times do
          sample :bd_haus, amp: 0.5
          sample :hat_psych, amp: 0.2
          sleep 0.5
          sample :elec_snare, amp: 0.4
          sample :drum_cymbal_closed, amp: 0.25
          sleep 0.5
        end
      end
      
      in_thread do
        sleep 8
        use_synth :prophet
        4.times do
          play (scale :c4, :major).choose, release: 0.4, cutoff: rrand(95, 110), amp: 0.85
          sleep 0.5
          play (scale :c5, :major).choose, release: 0.3, cutoff: rrand(100, 120), amp: 0.9
          sleep 0.5
        end
      end
      
      sleep 16
    end
    
    # Transition drone between Section 1 and Section 2
    use_synth :hollow
    play :g2, cutoff: 88, release: 10, amp: 0.6
    sleep 4
    
    # Section 2: Building intensity with layered harmonies and tighter percussion
    3.times do
      in_thread do
        use_synth :fm
        play :c2, release: 12, cutoff: 90, divisor: 8, depth: 15, amp: 0.4
      end
      
      in_thread do
        use_synth :fm
        play_chord chord(:c2, :major), cutoff: 92, release: 12, divisor: 8, depth: 10, amp: 0.35
      end
      
      in_thread do
        with_fx :lpf, cutoff: 85, mix: 0.25 do
          use_synth :tb303
          walking_bass = (ring :c2, :e2, :g2, :e2, :d2, :b1, :g1, :c2)
          8.times do
            play walking_bass.tick, cutoff: 80, release: 0.8, res: 0.7, amp: 0.6
            sleep 1
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.25 do
          use_synth :supersaw
          arpeggios = (ring :e4, :g4, :c5, :e5, :d5, :b4, :g4, :e4)
          8.times do
            play arpeggios.tick, release: 0.5, cutoff: (line 100, 130, steps: 8).look, amp: 0.95
            sleep 0.5
            play arpeggios.look - 12, release: 0.2, cutoff: 85, amp: 0.8
            sleep 0.5
          end
        end
      end
      
      in_thread do
        use_synth :sine
        progression = (knit chord(:c3, :major), 2, chord(:g3, :major), 2, chord(:a3, :minor), 2, chord(:f3, :major), 2)
        8.times do
          chord_notes = progression.tick
          chord_notes.each do |note|
            play note, cutoff: (line 95, 120, steps: 8).look, release: 0.3, amp: 0.45
            sleep 0.25
          end
          sleep 0.5
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.2 do
          8.times do |b|
            sample :bd_haus, amp: (b == 0) ? 0.7 : 0.6 if spread(3, 8)[b]
            sample :drum_cymbal_closed, amp: 0.3
            sleep 0.5
            sample :elec_snare, amp: 0.5 if b % 2 == 1
            sample :hat_psych, amp: 0.25 if one_in(3)
            sample :drum_cymbal_closed, amp: 0.25
            sleep 0.5
          end
        end
      end
      
      sleep 16
    end
    
    # Transition drone between Section 2 and Section 3
    use_synth :prophet
    play :c2, cutoff: 92, release: 12, amp: 0.6
    sleep 4
    
    # Section 3: Ethereal resolution with slower pacing and refined dynamics
    2.times do
      in_thread do
        use_synth :prophet
        play :c2, release: 14, cutoff: 80, amp: 0.45
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.35 do
          use_synth :dark_ambience
          play_chord chord(:c2, :major), cutoff: 82, release: 14, amp: 0.5
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 65, release: 16, amp: 0.65
        sleep 8
        use_synth :subpulse
        resolution_bass = (knit :c2, 4, :f2, 2, :g2, 2)
        8.times do
          play resolution_bass.tick, cutoff: 70, release: 1.5, amp: 0.5
          sleep 1
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          with_fx :echo, phase: 1, decay: 1.5, mix: 0.2 do
            use_synth :hollow
            final_melody = (knit :c4, 2, :e4, 2, :g4, 2, :c5, 2, :a4, 2, :f4, 2, :d4, 2, :c4, 2)
            16.times do
              play final_melody.tick, release: 1.2, cutoff: rrand(88, 105), amp: 0.9
              sleep 1
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.35 do
          use_synth :sine
          final_chords = (knit chord(:c3, :major), 4, chord(:f3, :major), 4, chord(:g3, :major), 4, chord(:c3, :major), 4)
          16.times do
            play_chord final_chords.tick, cutoff: rrand(85, 100), release: 1.8, amp: 0.4
            sleep 2
          end
        end
      end
      
      in_thread do
        16.times do |b|
          sample :bd_haus, amp: (b == 0) ? 0.65 : 0.55 if b % 2 == 0
          sample :drum_cymbal_closed, amp: 0.3 if b % 2 == 1
          sample :hat_psych, amp: 0.23 if b % 4 == 3
          sleep 1
        end
      end
      
      sleep 32
    end
    
    # Final resolution with sparse percussion fade
    in_thread do
      use_synth :prophet
      play_chord chord(:c3, :major), release: 8, cutoff: 85, amp: 0.7
    end
    
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c2, :major), cutoff: 80, release: 8, amp: 0.6
    end
    
    in_thread do
      use_synth :bass_foundation
      play :c2, cutoff: 65, release: 8, amp: 0.6
    end
    
    in_thread do
      8.times do |b|
        sample :bd_haus, amp: 0.4 if b % 4 == 0
        sample :drum_cymbal_closed, amp: 0.2
        sleep 1
      end
    end
    
    sleep 8
    
  end
end