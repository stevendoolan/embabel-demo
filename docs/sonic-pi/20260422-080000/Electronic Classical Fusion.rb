# Electronic Classical Fusion
# Dramatic electronic piece in C major, 4/4 time

use_debug false
use_bpm 120

with_fx :level, amp: 0.85 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Piano introduction with atmospheric foundation
    2.times do
      in_thread do
        use_synth :fm
        play :c2, release: 16, divisor: 4, depth: 20, cutoff: 85, amp: 0.4
      end

      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.35 do
          use_synth :prophet
          play_chord chord(:c3, :major), cutoff: 85, release: 16, amp: 0.3

          use_synth :kalimba
          harmony_notes = (ring :c3, :g3, :e3, :g3, :c3, :e3, :g3, :e3)
          16.times do
            play harmony_notes.tick, cutoff: (line 85, 105, steps: 16).look, release: 0.6, amp: 0.35
            sleep 0.25
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          16.times do
            sample :drum_bass_hard, amp: 0.6
            sample :hat_psych, amp: 0.3
            sleep 0.5
            sample :hat_psych, amp: 0.2
            sleep 0.25
            sample :elec_tick, amp: 0.25 if one_in(3)
            sleep 0.25
          end
        end
      end

      with_fx :lpf, cutoff: 110, mix: 0.3 do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          use_synth :piano
          notes = (ring :c4, :e4, :g4, :c5, :b4, :g4, :e4, :d4)
          16.times do
            play notes.tick, release: 0.8, cutoff: (line 90, 120, steps: 16).look, amp: 0.9
            sleep 0.25
          end
        end
      end
    end

    # Transition drone — bridges to Section 2
    use_synth :prophet
    play :c2, cutoff: 90, release: 8, amp: 0.6
    sleep 4

    # Section 2: FM synth builds intensity with arpeggiated patterns
    3.times do
      in_thread do
        use_synth :fm
        play :c2, release: 12, divisor: 3, depth: 18, cutoff: 80, amp: 0.5
      end

      in_thread do
        use_synth :prophet
        chords_prog = (ring chord(:c3, :major), chord(:a2, :minor), chord(:f3, :major))

        use_synth :hollow
        play_chord chords_prog[0], cutoff: 82, release: 12, amp: 0.25

        use_synth :prophet
        play_chord chords_prog[0], cutoff: 90, release: 4, amp: 0.4
        sleep 4

        play_chord chords_prog[1], cutoff: 95, release: 4, amp: 0.45
        sleep 4

        play_chord chords_prog[2], cutoff: 88, release: 4, amp: 0.45

        use_synth :kalimba
        8.times do
          play (scale :f3, :major).tick, cutoff: rrand(90, 110), release: 0.3, amp: 0.4
          sleep 0.25
        end
      end

      in_thread do
        with_fx :hpf, cutoff: 100, mix: 0.3 do
          16.times do
            sample :drum_bass_hard, amp: 0.7
            sample :hat_psych, amp: 0.35
            sleep 0.25
            sample :hat_psych, amp: 0.25
            sleep 0.25
            sample :elec_snare, amp: 0.6
            sample :hat_psych, amp: 0.35
            sample :elec_tick, amp: 0.3 if spread(3, 8).tick
            sleep 0.25
            sample :hat_psych, amp: 0.25
            sleep 0.25
          end
        end
      end

      use_synth :fm
      melody = (ring :c5, :e5, :g5, :e5, :a5, :g5, :f5, :e5, :d5, :c5, :b4, :c5)
      16.times do
        play melody.tick, release: 0.15, cutoff: rrand(95, 115), divisor: 1.5, depth: 4, amp: 0.95
        sleep 0.25
      end
    end

    # Transition drone — bridges to Section 3
    use_synth :saw
    play :c2, cutoff: 85, release: 10, amp: 0.6
    sleep 4

    # Section 3: Dramatic climax with saw synth and harmonic layers
    2.times do
      in_thread do
        use_synth :prophet
        play :c2, release: 16, cutoff: 75, amp: 0.5
      end

      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.4 do
          use_synth :hollow
          play_chord chord(:c3, :major), cutoff: 80, release: 16, amp: 0.3

          use_synth :prophet
          climax_chords = (knit chord(:c3, :major), 4, chord(:e3, :minor), 4, chord(:f3, :major), 4, chord(:g3, :major7), 4)

          16.times do
            play_chord climax_chords.tick, cutoff: (line 95, 120, steps: 16).look, release: 0.25, amp: 0.5
            sleep 0.25
          end
        end
      end

      in_thread do
        16.times do
          sample :drum_bass_hard, amp: 0.85
          sample :hat_psych, amp: 0.4
          sample :elec_tick, amp: 0.35
          sleep 0.125
          sample :hat_psych, amp: 0.3
          sleep 0.125
          sample :elec_snare, amp: 0.75
          sample :hat_psych, amp: 0.4
          sleep 0.125
          sample :hat_psych, amp: 0.3
          sample :elec_tick, amp: 0.35 if one_in(2)
          sleep 0.125
          sample :drum_bass_hard, amp: 0.75
          sample :hat_psych, amp: 0.4
          sleep 0.125
          sample :hat_psych, amp: 0.3
          sleep 0.125
          sample :elec_snare, amp: 0.7
          sample :hat_psych, amp: 0.4
          sample :elec_tick, amp: 0.4
          sleep 0.125
          sample :hat_psych, amp: 0.3
          sleep 0.125
        end
      end

      with_fx :reverb, room: 0.3, mix: 0.25 do
        use_synth :saw
        climax_notes = (knit :c5, 2, :e5, 2, :g5, 2, :c6, 2, :b5, 2, :a5, 2, :g5, 2, :f5, 2)
        16.times do
          play climax_notes.tick, release: 0.3, cutoff: (line 100, 130, steps: 16).look, amp: 1.0
          sleep 0.25
        end
      end
    end

    # Final resolution
    use_synth :fm
    play :c2, release: 12, divisor: 2, depth: 25, cutoff: 90, amp: 0.7

    use_synth :hollow
    play_chord chord(:c3, :major), cutoff: 85, release: 12, amp: 0.35

    use_synth :prophet
    play_chord chord(:c2, :major), cutoff: 90, release: 12, amp: 0.45

    sleep 8

  end
end