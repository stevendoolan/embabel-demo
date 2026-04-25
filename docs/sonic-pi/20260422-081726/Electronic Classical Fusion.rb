# Electronic Classical Fusion - Atmospheric Journey Through D Major and F# Minor

use_debug false
use_bpm 128

with_fx :level, amp: 0.85 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening in D major - atmospheric foundation with sparse percussion
    2.times do
      in_thread do
        use_synth :fm
        play :d2, release: 16, divisor: 4, depth: 15, cutoff: 85, amp: 0.5
      end
      
      in_thread do
        use_synth :prophet
        play_chord chord(:d3, :major), cutoff: 85, release: 16, amp: 0.3
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          melody_notes = (ring :d4, :fs4, :a4, :d5, :cs5, :a4, :fs4, :e4)
          16.times do
            use_synth :fm
            play melody_notes.tick, release: 0.2, cutoff: (line 90, 120, steps: 16).look, divisor: 2, depth: 8, amp: 0.9
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          chords_progression = (knit chord(:d3, :major), 4, chord(:a2, :major), 4, chord(:g3, :major), 4, chord(:a2, :major), 4)
          4.times do
            use_synth :organ_tonewheel
            play_chord chords_progression.tick, cutoff: (line 80, 100, steps: 4).look, release: 3.5, amp: 0.4
            sleep 4
          end
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.25 do
        16.times do
          sample :bd_haus, amp: 0.6 if spread(3, 16).tick
          sleep 0.25
          sample :hat_psych, amp: 0.3, rate: 1.2 if spread(7, 16).look
          sleep 0.25
          sample :elec_snare, amp: 0.5 if spread(2, 16).look
          sleep 0.25
          sample :hat_psych, amp: 0.25, rate: 1.1
          sleep 0.25
        end
      end
    end
    
    # Transition drone - bridges to next section
    use_synth :prophet
    play :d2, cutoff: 90, release: 10, amp: 0.6
    use_synth :supersaw
    play_chord chord(:d2, :major), cutoff: 90, release: 10, amp: 0.35
    4.times do
      sample :bd_haus, amp: 0.5
      sleep 0.5
      sample :hat_psych, amp: 0.2, rate: 1.1
      sleep 0.5
    end
    
    # Section 2: Building intensity in D major with layered voicings
    3.times do
      in_thread do
        use_synth :prophet
        play :d2, release: 12, cutoff: 88, amp: 0.4
      end
      
      in_thread do
        use_synth :supersaw
        play_chord chord(:d2, :major), cutoff: 88, release: 12, amp: 0.35
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.3 do
          harmony_notes = (knit :d4, 2, :a4, 2, :fs4, 1, :g4, 1, :a4, 2, :d5, 4, :cs5, 2, :b4, 2)
          16.times do
            use_synth :prophet
            play harmony_notes.tick, release: 0.15, cutoff: rrand(95, 115), amp: 0.85
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 95, mix: 0.3 do
          harmony_chords = (ring chord(:d3, :major), chord(:a3, :major), chord(:fs3, :minor), chord(:g3, :major))
          4.times do
            use_synth :prophet
            play_chord harmony_chords.tick, cutoff: rrand(85, 105), release: 3.8, amp: 0.4
            sleep 4
          end
        end
      end
      
      with_fx :hpf, cutoff: 100, mix: 0.25 do
        16.times do
          sample :bd_haus, amp: 0.7
          sample :hat_psych, amp: 0.35, rate: 1.2
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.3
          sleep 0.25
          sample :elec_snare, amp: 0.6
          sample :hat_psych, amp: 0.35, rate: 1.1
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.25
          sleep 0.25
        end
      end
    end
    
    # Transition drone with key change preparation
    use_synth :fm
    play :fs2, cutoff: 85, release: 12, divisor: 3, depth: 18, amp: 0.6
    use_synth :organ_tonewheel
    play_chord chord(:fs2, :minor), cutoff: 85, release: 12, amp: 0.4
    4.times do
      sample :bd_haus, amp: 0.6
      sample :hat_psych, amp: 0.3, rate: 1.2
      sleep 0.5
      sample :elec_snare, amp: 0.55
      sample :drum_cymbal_closed, amp: 0.3
      sleep 0.5
    end
    
    # Section 3: Key change to F# minor - dynamic climax with full intensity
    4.times do
      in_thread do
        use_synth :fm
        play :fs2, release: 14, cutoff: 80, divisor: 5, depth: 12, amp: 0.45
      end
      
      in_thread do
        use_synth :supersaw
        play_chord chord(:fs2, :minor), cutoff: 82, release: 14, amp: 0.4
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.25 do
          with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.2 do
            fs_minor_melody = (ring :fs4, :a4, :cs5, :e5, :fs5, :e5, :cs5, :b4, :a4, :gs4, :fs4, :e4, :cs4, :e4, :fs4, :a4)
            16.times do
              use_synth :pluck
              play fs_minor_melody.tick, release: 0.3, cutoff: (line 100, 130, steps: 16).look, amp: 1.0
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.45 do
          fs_minor_progression = (ring chord(:fs3, :minor), chord(:cs3, :major), chord(:d3, :major), chord(:e3, :major))
          4.times do
            use_synth :prophet
            play_chord fs_minor_progression.tick, cutoff: (line 85, 115, steps: 4).look, release: 3.5, amp: 0.45
            sleep 4
          end
        end
      end
      
      16.times do
        sample :bd_haus, amp: 0.7
        sample :hat_psych, amp: 0.4, rate: 1.3
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.35, rate: 1.1
        sleep 0.25
        sample :elec_snare, amp: 0.65
        sample :hat_psych, amp: 0.4, rate: 1.2
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.3
        sample :hat_psych, amp: 0.35, rate: 1.1 if one_in(3)
        sleep 0.25
      end
    end
    
    # Final transition drone - resolution
    use_synth :prophet
    play :fs2, cutoff: 95, release: 16, amp: 0.7
    use_synth :organ_tonewheel
    play_chord chord(:fs2, :minor), cutoff: 95, release: 16, amp: 0.45
    8.times do
      sample :bd_haus, amp: 0.6
      sample :hat_psych, amp: 0.3, rate: 1.1
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.25
      sleep 0.5
    end
    
  end
end