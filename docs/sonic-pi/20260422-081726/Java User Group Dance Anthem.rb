# Java User Group Dance Anthem
# Electronic, energetic, 128 BPM, Key of C, 4/4 time

use_debug false
use_bpm 128

with_fx :level, amp: 0.85 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening atmospheric layer - melody, harmony, and percussion foundation
    2.times do
      in_thread do
        use_synth :prophet
        play :c2, cutoff: 90, release: 16, amp: 0.35
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          use_synth :prophet
          play_chord chord(:c3, :major), cutoff: 85, release: 16, amp: 0.3
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 100, mix: 1 do
          with_fx :reverb, room: 0.25, mix: 0.25 do
            use_synth :saw
            melody_notes = (ring :c4, :e4, :g4, :c5, :g4, :e4, :d4, :c4)
            16.times do
              play melody_notes.tick, cutoff: (line 80, 120, steps: 16).look, release: 0.2, amp: 0.9
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          use_synth :fm
          harmony_chords = (knit chord(:c3, :major), 2, chord(:f3, :major), 1, chord(:g3, :major), 1)
          4.times do
            play_chord harmony_chords.tick, cutoff: (line 80, 100, steps: 4).look, release: 3.5, amp: 0.4, divisor: 2, depth: 8
            sleep 4
          end
        end
      end
      
      with_fx :hpf, cutoff: 100, mix: 1 do
        16.times do
          sample :bd_haus, amp: 0.5
          sample :hat_cats, amp: 0.25
          sleep 0.25
          sample :hat_cats, amp: 0.2
          sleep 0.25
          sample :elec_hi_snare, amp: 0.45
          sample :hat_cats, amp: 0.25
          sleep 0.25
          sample :hat_cats, amp: 0.2
          sleep 0.25
        end
      end
    end
    
    # Transition drone - bridges to next section
    use_synth :prophet
    play :c3, cutoff: 90, release: 10, amp: 0.5
    4.times do
      sample :bd_haus, amp: 0.4
      sleep 0.5
      sample :elec_hi_snare, amp: 0.35
      sleep 0.5
    end
    
    # Section 2: Build intensity - supersaw melody, chord stabs, fuller percussion
    2.times do
      in_thread do
        use_synth :fm
        play :c2, cutoff: 85, release: 16, amp: 0.3
      end
      
      in_thread do
        use_synth :fm
        play_chord chord(:c2, :major), cutoff: 80, release: 12, amp: 0.35, divisor: 4, depth: 15
      end
      
      in_thread do
        use_synth :supersaw
        melody_high = (knit :c5, 2, :e5, 2, :g5, 2, :c6, 2, :g5, 2, :e5, 2, :f5, 2, :d5, 2)
        16.times do
          play melody_high.tick, cutoff: rrand(90, 115), release: 0.15, amp: 0.95
          sleep 0.25
        end
      end
      
      in_thread do
        use_synth :mod_saw
        stab_chords = (knit chord(:c4, :major), 4, chord(:e4, :minor), 2, chord(:f4, :major), 2, chord(:g4, :major), 4, chord(:a3, :minor), 2, chord(:f4, :major), 2)
        16.times do
          play_chord stab_chords.tick, cutoff: rrand(90, 110), release: 0.3, amp: 0.45, mod_range: 12, mod_phase: 0.25
          sleep 1
        end
      end
      
      16.times do
        sample :bd_haus, amp: 0.6
        sample :hat_cats, amp: 0.3
        sample :elec_cymbal, amp: 0.25 if one_in(4)
        sleep 0.25
        sample :hat_cats, amp: 0.25
        sleep 0.25
        sample :elec_hi_snare, amp: 0.5
        sample :hat_cats, amp: 0.3
        sleep 0.25
        sample :hat_cats, amp: 0.2
        sample :elec_cymbal, amp: 0.2 if one_in(8)
        sleep 0.25
      end
    end
    
    # Transition drone - sustained into final section
    use_synth :prophet
    play_chord chord(:c3, :major7), cutoff: 95, release: 12, amp: 0.5
    4.times do
      sample :bd_haus, amp: 0.5
      sample :hat_cats, amp: 0.25
      sleep 0.5
      sample :elec_hi_snare, amp: 0.45
      sleep 0.5
    end
    
    # Section 3: Peak energy - beep lead, rhythmic chords, full percussion
    3.times do
      in_thread do
        use_synth :prophet
        play :c2, cutoff: 90, release: 16, amp: 0.3
      end
      
      in_thread do
        use_synth :prophet
        play_chord chord(:c2, :major), cutoff: 85, release: 16, amp: 0.3
      end
      
      in_thread do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          use_synth :beep
          peak_melody = (ring :c5, :e5, :g5, :e5, :c5, :d5, :f5, :d5, :c5, :e5, :g5, :c6, :b4, :a4, :g4, :c5)
          16.times do
            play peak_melody.tick, cutoff: (line 100, 130, steps: 16).look, release: 0.12, amp: 1.0
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.25 do
          use_synth :mod_saw
          peak_chords = (ring chord(:c4, :major), chord(:g3, :major), chord(:a3, :minor), chord(:f4, :major))
          16.times do
            play_chord peak_chords.tick, cutoff: (line 95, 120, steps: 16).look, release: 0.25, amp: 0.5, mod_range: 15, mod_phase: 0.125
            sleep 1
          end
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.25 do
        16.times do |i|
          sample :bd_haus, amp: 0.65
          sample :hat_cats, amp: 0.35
          sample :elec_cymbal, amp: 0.3 if i % 4 == 0
          sleep 0.25
          sample :hat_cats, amp: 0.3
          sleep 0.25
          sample :elec_hi_snare, amp: 0.6
          sample :hat_cats, amp: 0.35
          sample :elec_cymbal, amp: 0.25 if i % 8 == 3
          sleep 0.25
          sample :hat_cats, amp: 0.25
          sleep 0.25
        end
      end
    end
    
    # Final outro - fadeout with warm pad resolution
    use_synth :fm
    play_chord chord(:c3, :major), cutoff: 80, release: 16, amp: 0.4, divisor: 3, depth: 20
    8.times do
      sample :bd_haus, amp: 0.35
      sample :hat_cats, amp: 0.2
      sleep 0.5
      sample :elec_hi_snare, amp: 0.3
      sleep 0.5
    end
    
  end
end