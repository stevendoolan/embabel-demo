# Java User Group Dance Anthem
# Electronic | Energetic | 128 BPM | Key of C | 4/4 Time

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Opening energy - supersaw lead, major7 chords, four-on-the-floor beat
    2.times do
      use_synth :prophet
      play :c2, release: 16, cutoff: 85, amp: 0.5

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :prophet
          play_chord chord(:c3, :major7), cutoff: 85, release: 16, amp: 0.25
        end
      end

      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.3 do
          with_fx :reverb, room: 0.25, mix: 0.25 do
            use_synth :supersaw
            notes = (ring :c4, :e4, :g4, :c5, :g4, :e4, :d4, :e4)
            16.times do
              play notes.tick, release: 0.15, cutoff: (line 90, 120, steps: 16).look, amp: 0.9
              sleep 0.25
            end
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :mod_sine
          chords = knit(chord(:c3, :major7), 8, chord(:a3, :minor7), 8)
          16.times do
            play_chord chords.tick, cutoff: (line 80, 100, steps: 16).look, release: 0.25, amp: 0.25
            sleep 0.25
          end
        end
      end

      16.times do
        sample :bd_haus, amp: 0.6
        sample :hat_cab, amp: 0.25
        sleep 0.25
        sample :hat_cab, amp: 0.2
        sleep 0.25
        sample :elec_hi_snare, amp: 0.5
        sample :hat_cab, amp: 0.25
        sleep 0.25
        sample :hat_cab, amp: 0.2
        sleep 0.25
      end
    end

    # Transition drone - FM synth with F major7 pad
    use_synth :fm
    play :c2, cutoff: 90, release: 10, divisor: 4, depth: 18, amp: 0.6
    use_synth :prophet
    play_chord chord(:f3, :major7), cutoff: 90, release: 8, amp: 0.4

    4.times do
      sample :bd_haus, amp: 0.5
      sleep 1
    end

    # Section 2: Build intensity - saw synth melody, sus chord progression, syncopated percussion
    3.times do
      use_synth :prophet
      play :c2, release: 16, cutoff: 80, amp: 0.4

      in_thread do
        use_synth :fm
        play_chord chord(:c3, :sus2), cutoff: 88, release: 16, divisor: 2, depth: 12, amp: 0.25
      end

      in_thread do
        use_synth :saw
        melody = (knit :c4, 2, :e4, 2, :g4, 2, :a4, 1, :g4, 1, :f4, 2, :e4, 2, :d4, 2, :c4, 2)
        16.times do
          play melody.tick, release: 0.2, cutoff: rrand(95, 115), amp: 0.85
          sleep 0.25
        end
      end

      in_thread do
        use_synth :prophet
        chord_prog = knit(chord(:c3, :sus2), 4, chord(:f3, :major7), 4, chord(:g3, :sus4), 4, chord(:a3, :minor7), 4)
        16.times do
          play_chord chord_prog.tick, cutoff: rrand(85, 105), release: 0.3, amp: 0.3
          sleep 0.25
        end
      end

      with_fx :reverb, room: 0.25, mix: 0.25 do
        16.times do
          sample :bd_haus, amp: 0.65
          sample :hat_cab, amp: 0.3
          sleep 0.25
          sample :hat_cab, amp: 0.2
          sleep 0.125
          sample :hat_cab, amp: 0.15 if one_in(2)
          sleep 0.125
          sample :elec_hi_snare, amp: 0.55
          sample :hat_cab, amp: 0.3
          sleep 0.25
          sample :hat_cab, amp: 0.2
          sample :elec_cymbal, amp: 0.3 if spread(3, 8).tick
          sleep 0.25
        end
      end
    end

    # Transition drone - sus4 to major7 resolution with rapid hi-hats
    use_synth :prophet
    play :c2, cutoff: 95, release: 10, amp: 0.6
    use_synth :mod_sine
    play_chord chord(:g3, :sus4), cutoff: 90, release: 6, amp: 0.35

    4.times do
      sample :bd_haus, amp: 0.6
      sample :hat_cab, amp: 0.25
      sleep 0.25
      sample :hat_cab, amp: 0.2
      sleep 0.25
    end

    use_synth :mod_sine
    play_chord chord(:g3, :major7), cutoff: 95, release: 6, amp: 0.35

    4.times do
      sample :bd_haus, amp: 0.6
      sample :hat_cab, amp: 0.25
      sleep 0.25
      sample :hat_cab, amp: 0.2
      sleep 0.25
    end

    # Section 3: Peak energy - fast prophet lead, layered major7 chords, rapid hi-hat pattern
    4.times do
      use_synth :fm
      play :c2, release: 16, cutoff: 88, divisor: 3, depth: 22, amp: 0.5

      in_thread do
        use_synth :prophet
        play_chord chord(:c3, :major7), cutoff: 92, release: 16, amp: 0.3
      end

      in_thread do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          use_synth :prophet
          fast_notes = (ring :c5, :e5, :g5, :c6, :b5, :a5, :g5, :e5)
          32.times do
            play fast_notes.tick, release: 0.1, cutoff: (line 100, 130, steps: 32).look, amp: 0.95
            sleep 0.125
          end
        end
      end

      in_thread do
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.25 do
          use_synth :fm
          fast_chords = ring(chord(:c4, :major7), chord(:f4, :major7), chord(:g4, :sus4), chord(:a4, :minor7))
          32.times do
            play_chord fast_chords.tick, cutoff: (line 90, 120, steps: 32).look, release: 0.15, divisor: 3, depth: 10, amp: 0.25
            sleep 0.125
          end
        end
      end

      32.times do
        sample :bd_haus, amp: 0.7
        sample :hat_cab, amp: 0.35
        sleep 0.125
        sample :hat_cab, amp: 0.25
        sleep 0.125
        sample :elec_hi_snare, amp: 0.6
        sample :hat_cab, amp: 0.35
        sleep 0.125
        sample :hat_cab, amp: 0.25
        sample :elec_cymbal, amp: 0.35 if spread(5, 16).tick
        sleep 0.125
      end
    end

    # Final resolution - sustained major7 chords with sparse kicks
    use_synth :supersaw
    play :c3, cutoff: 100, release: 12, amp: 0.7
    use_synth :prophet
    play_chord chord(:c3, :major7), cutoff: 95, release: 12, amp: 0.4
    use_synth :mod_sine
    play_chord chord(:c2, :major7), cutoff: 80, release: 12, amp: 0.2

    8.times do
      sample :bd_haus, amp: 0.5
      sample :elec_cymbal, amp: 0.25
      sleep 1
    end

  end
end