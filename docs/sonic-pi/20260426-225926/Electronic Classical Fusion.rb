# Neon Symphony
# Style: Electronic synthwave with evolving soundscapes
# Mood: Energetic and atmospheric

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Opening in A minor - supersaw lead with FM pads and tight percussion
    2.times do
      use_synth :prophet
      play 28, cutoff: 90, release: 16, amp: 0.4
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :fm
          play_chord chord(:a2, :minor), cutoff: 85, release: 16, divisor: 6, depth: 12, amp: 0.6
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            use_synth :supersaw
            melody_a = (ring :a4, :c5, :e5, :a5, :g5, :e5, :c5, :a4, :a4, :e5, :c5, :a4, :g4, :a4, :c5, :e5)
            16.times do
              play melody_a.tick, cutoff: (line 90, 120, steps: 16).look, release: 0.2, amp: 0.9
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :dark_ambience
          chords = knit(chord(:a3, :minor), 4, chord(:c3, :major), 4, chord(:e3, :minor), 4, chord(:a3, :minor), 4)
          16.times do
            play_chord chords.tick, cutoff: (line 80, 100, steps: 16).look, release: 0.8, amp: 0.5
            sleep 1
          end
        end
      end
      
      with_fx :hpf, cutoff: 100, mix: 1.0 do
        16.times do
          sample :bd_tek, amp: 0.7
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.2
          sleep 0.25
          sample :elec_snare, amp: 0.6
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.2
          sleep 0.25
        end
      end
    end

    # Transition drone - bridges to Section 2
    use_synth :fm
    play 28, cutoff: 85, release: 8, divisor: 4, depth: 15, amp: 0.6
    
    in_thread do
      use_synth :hollow
      play_chord chord(:a2, :minor), cutoff: 82, release: 8, amp: 0.55
    end
    
    2.times do
      sample :bd_tek, amp: 0.5
      sleep 1
      sample :drum_cymbal_open, amp: 0.4, rate: 0.9
      sleep 1
    end

    # Section 2: Development - prophet melody with arpeggiated harmonies and cymbal crashes
    2.times do
      use_synth :blade
      play 33, cutoff: 95, release: 16, amp: 0.3
      
      in_thread do
        use_synth :fm
        play_chord chord(:a2, :minor7), cutoff: 88, release: 16, divisor: 5, depth: 14, amp: 0.6
      end
      
      in_thread do
        use_synth :prophet
        harmony = (ring :a3, :c4, :e4, :a4)
        melody_b = (knit :e5, 2, :g5, 2, :a5, 4, :c6, 2, :a5, 2, :g5, 2, :e5, 2)
        16.times do
          play melody_b.tick, cutoff: rrand(95, 115), release: 0.25, amp: 0.95
          play harmony.look, cutoff: 80, release: 0.15, amp: 0.3 if spread(5, 16).look
          sleep 0.25
        end
      end
      
      in_thread do
        use_synth :hollow
        arp_notes = (ring :a2, :c3, :e3, :a3, :e3, :c3)
        16.times do
          play arp_notes.tick, cutoff: rrand(85, 105), release: 0.15, amp: 0.6
          sleep 0.25
        end
      end
      
      16.times do |i|
        sample :bd_tek, amp: 0.8
        sample :hat_psych, amp: 0.35
        sleep 0.25
        sample :hat_psych, amp: 0.25
        sleep 0.25
        sample :elec_snare, amp: 0.7
        sample :hat_psych, amp: 0.35
        sleep 0.25
        sample :hat_psych, amp: 0.25
        sample :drum_cymbal_open, amp: 0.5, rate: 1.2 if spread(3, 16).look
        sleep 0.25
      end
    end

    # Transition drone - bridges to key change section
    use_synth :prophet
    play 36, cutoff: 88, release: 10, amp: 0.6
    
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:a2, :minor), cutoff: 85, release: 10, amp: 0.55
    end
    
    4.times do
      sample :bd_tek, amp: 0.6
      sleep 0.5
      sample :elec_snare, amp: 0.5
      sleep 0.5
    end

    # Section 3: Key change to C major - kalimba melody with lush FM pads and full intensity percussion
    3.times do
      use_synth :fm
      play 36, cutoff: 90, release: 16, divisor: 6, depth: 18, amp: 0.4
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :fm
          play_chord chord(:c3, :major7), cutoff: 90, release: 16, divisor: 7, depth: 16, amp: 0.65
        end
      end
      
      in_thread do
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.25 do
          use_synth :kalimba
          melody_c = (scale :c5, :major_pentatonic)
          pattern = (ring 0, 2, 4, 7, 4, 2, 0, 2, 4, 7, 9, 7, 4, 2, 0, -3)
          16.times do
            note = melody_c[pattern.tick]
            play note, cutoff: (line 100, 130, steps: 16).look, release: 0.3, amp: 1.0
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :hollow
          progression = knit(chord(:c3, :major), 4, chord(:f3, :major), 4, chord(:g3, :major), 4, chord(:c3, :major), 4)
          16.times do
            play_chord progression.tick, cutoff: (line 85, 110, steps: 16).look, release: 0.7, amp: 0.55
            sleep 1
          end
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.25 do
        16.times do |i|
          sample :bd_tek, amp: 0.85
          sample :hat_psych, amp: 0.4
          sleep 0.25
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :elec_snare, amp: 0.75
          sample :hat_psych, amp: 0.4
          sleep 0.25
          sample :hat_psych, amp: 0.3
          sample :drum_cymbal_open, amp: 0.6 if one_in(4)
          sleep 0.25
        end
      end
    end

    # Final sustained pad and sparse outro
    use_synth :prophet
    play 36, cutoff: 85, release: 12, amp: 0.5
    
    in_thread do
      use_synth :fm
      play_chord chord(:c3, :major), cutoff: 88, release: 12, divisor: 6, depth: 15, amp: 0.6
    end
    
    4.times do
      sample :bd_tek, amp: 0.5
      sleep 1
      sample :drum_cymbal_open, amp: 0.4, rate: 0.8
      sleep 1
    end

  end
end