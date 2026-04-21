# Smooth Croon
# Jazz style in F major, 4/4 time

use_debug false
use_bpm 75

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Smooth jazz intro with sine melody, piano chords, and light drums
    2.times do
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          use_synth :sine
          melody_notes = (ring :f4, :a4, :c5, :f5, :e5, :c5, :a4, :g4)
          cutoffs = (line 90, 110, steps: 8)

          8.times do
            play melody_notes.tick, cutoff: cutoffs.look, release: 0.8, amp: 0.9
            sleep 0.5
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :piano

          play_chord chord(:f3, :major7), cutoff: 95, release: 2, amp: 0.3
          sleep 2

          play_chord chord(:a3, :minor7), cutoff: 90, release: 2, amp: 0.25
          sleep 2

          play_chord chord(:d3, :minor7), cutoff: 92, release: 2, amp: 0.3
          sleep 2

          play_chord chord(:g3, :minor7), cutoff: 88, release: 2, amp: 0.25
          sleep 2
        end
      end

      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          8.times do
            sample :drum_cymbal_soft, amp: 0.3, rate: 0.9, pan: 0.3
            sample :drum_bass_soft, amp: 0.5 if spread(3, 8).tick
            sleep 0.5
          end
        end
      end

      sleep 8
    end

    # Transition: melody sustained tone, organ pad, minimal percussion
    in_thread do
      use_synth :sine
      play :f5, cutoff: 100, release: 2.5, amp: 0.8
      sleep 3
      play :a4, cutoff: 95, release: 0.8, amp: 0.7
      sleep 1
    end

    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:f3, :major7), cutoff: 85, release: 3.5, amp: 0.25
      sleep 4
    end

    in_thread do
      sample :drum_cymbal_soft, amp: 0.25, rate: 0.85, pan: 0.2, sustain: 3
      sleep 3
      sample :hat_cats, amp: 0.2, rate: 1.2
      sleep 1
    end

    sleep 4

    # Section 2: Rhodes melody, organ pad harmony, building drums
    2.times do
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.3 do
          with_fx :reverb, room: 0.3, mix: 0.25 do
            use_synth :rhodey
            jazz_line = (ring :f4, :a4, :gs4, :g4, :f4, :c5, :a4, :g4,
                              :f4, :e4, :f4, :a4, :c5, :d5, :c5, :a4)

            16.times do
              play jazz_line.tick, cutoff: rrand(85, 105), release: 0.4, amp: 0.85
              sleep 0.25
            end
          end
        end
      end

      in_thread do
        use_synth :organ_tonewheel

        play_chord chord(:f3, :maj9), cutoff: 90, release: 4, amp: 0.3
        sleep 4

        play_chord chord(:d3, :minor7), cutoff: 88, release: 2, amp: 0.25
        sleep 2
        play_chord chord(:g3, :minor7), cutoff: 85, release: 2, amp: 0.25
        sleep 2

        play_chord chord(:c3, :dom7), cutoff: 92, release: 1.5, amp: 0.3
        sleep 1.5
        play_chord chord(:f3, :maj9), cutoff: 90, release: 2.5, amp: 0.25
        sleep 2.5
      end

      in_thread do
        16.times do
          sample :drum_bass_soft, amp: 0.5 if [0, 4, 10, 14].include?(look)
          sample :hat_cats, amp: (ring 0.3, 0.2, 0.25, 0.2).tick, rate: 1.1, pan: rrand(-0.2, 0.2)
          sample :drum_snare_soft, amp: 0.4 if [4, 12].include?(look)
          sample :drum_cymbal_soft, amp: 0.25, rate: 0.9, pan: 0.3 if one_in(4)
          sleep 0.25
        end
      end

      sleep 16
    end

    # Transition: walking bass melody, piano chords, light brush pattern
    in_thread do
      use_synth :rhodey
      play :f3, cutoff: 90, release: 0.6, amp: 0.8
      sleep 0.5
      play :g3, cutoff: 95, release: 0.6, amp: 0.8
      sleep 0.5
      play :a3, cutoff: 100, release: 0.6, amp: 0.8
      sleep 0.5
      play :c4, cutoff: 105, release: 1.5, amp: 0.75
      sleep 1.5
    end

    in_thread do
      use_synth :piano
      play_chord chord(:f3, :major7), cutoff: 95, release: 1.5, amp: 0.3
      sleep 2
      play_chord chord(:c3, :dom7), cutoff: 90, release: 2, amp: 0.25
      sleep 2
    end

    in_thread do
      4.times do
        sample :drum_bass_soft, amp: 0.4
        sample :hat_cats, amp: 0.2, rate: 1.0
        sleep 0.5
      end
    end

    sleep 4

    # Section 3: Finale with alternating sine/rhodey melody, piano/organ blend, full jazz drums
    2.times do
      in_thread do
        use_synth :sine
        phrase1 = (ring :a4, :c5, :f5, :e5)

        4.times do
          play phrase1.tick, cutoff: rrand(95, 115), release: 0.7, amp: 0.9
          sleep 0.5
        end

        use_synth :rhodey
        phrase2 = (ring :d5, :c5, :a4, :f4)

        4.times do
          play phrase2.tick, cutoff: rrand(90, 110), release: 0.5, amp: 0.85
          sleep 0.5
        end
      end

      in_thread do
        use_synth :piano

        play_chord chord(:a3, :minor7), cutoff: rrand(88, 98), release: 2, amp: 0.3
        sleep 2
        play_chord chord(:d3, :minor7), cutoff: rrand(85, 95), release: 2, amp: 0.25
        sleep 2

        use_synth :organ_tonewheel

        play_chord chord(:g3, :minor7), cutoff: 88, release: 1.5, amp: 0.25
        sleep 1.5
        play_chord chord(:c3, '9'), cutoff: 90, release: 2.5, amp: 0.3
        sleep 2.5

        use_synth :piano

        play_chord chord(:f3, :maj9), cutoff: 92, release: 2, amp: 0.3
        sleep 2
      end

      in_thread do
        8.times do
          sample :drum_bass_soft, amp: 0.55 if [0, 4].include?(look)
          sample :drum_cymbal_soft, amp: 0.35, rate: 0.88, pan: 0.25
          sample :hat_cats, amp: 0.25, rate: 1.15, pan: -0.2 if [1, 3, 5, 7].include?(look)
          sleep 0.5
        end

        8.times do
          sample :drum_bass_soft, amp: 0.5 if [0, 4].include?(look)
          sample :drum_snare_soft, amp: 0.45 if [4].include?(look)
          sample :hat_cats, amp: (ring 0.3, 0.2, 0.25, 0.2).tick, rate: 1.1
          sample :drum_cymbal_soft, amp: 0.3, rate: 0.9, pan: 0.3 if [0, 4].include?(look)
          sleep 0.25
        end
      end

      sleep 16
    end

    # Final resolution: warm Fmaj9 chord with gentle ride out
    in_thread do
      use_synth :sine
      play :f4, cutoff: 95, release: 3, amp: 0.85
      sleep 4
    end

    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:f3, :maj9), cutoff: 85, release: 4.5, amp: 0.3
      sleep 4
    end

    in_thread do
      sample :drum_cymbal_soft, amp: 0.3, rate: 0.85, pan: 0.25, sustain: 4
      sample :drum_bass_soft, amp: 0.4
      sleep 4
    end

    sleep 4

  end
end