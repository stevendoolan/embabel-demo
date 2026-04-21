# Smooth Croon
# Jazz in F major, 72 BPM, 4/4 time

use_debug false
use_bpm 72

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Smooth piano intro with atmospheric drone, warm organ harmony, gentle brushed drums
    2.times do
      in_thread do
        use_synth :fm
        play :f2, release: 16, cutoff: 85, amp: 0.4

        with_fx :reverb, room: 0.25, mix: 0.3 do
          use_synth :piano
          notes = (ring :f4, :a4, :c5, :e5, :d5, :c5, :a4, :g4)
          8.times do
            play notes.tick, release: 0.8, cutoff: rrand(90, 110), amp: 0.85
            sleep 0.5
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :organ_tonewheel
          play_chord chord(:f3, :major7), cutoff: 95, release: 8, amp: 0.3
          sleep 4
          play_chord chord(:c3, :major7), cutoff: 92, release: 8, amp: 0.25
          sleep 4
        end
      end

      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          8.times do
            sample :drum_bass_soft, amp: 0.4
            sample :drum_cymbal_soft, rate: 0.9, amp: 0.2
            sleep 0.5
            sample :hat_gem, amp: 0.15
            sleep 0.5
          end
        end
      end

      sleep 8
    end

    # Transition: Prophet drone with hollow harmony and cymbal sustain
    use_synth :prophet
    play :f3, cutoff: 90, release: 8, amp: 0.6

    in_thread do
      use_synth :hollow
      play_chord chord(:f3, :major7), cutoff: 88, release: 8, amp: 0.35
    end

    in_thread do
      sample :drum_cymbal_soft, rate: 0.85, sustain: 3, release: 1, amp: 0.25
    end

    sleep 4

    # Section 2: Rhodey lead with walking bassline, FM harmony pads, walking rhythm drums
    3.times do
      in_thread do
        use_synth :prophet
        play :f2, release: 12, cutoff: 80, amp: 0.25

        with_fx :lpf, cutoff: 110 do
          with_fx :echo, phase: 0.75, decay: 1.5, mix: 0.2 do
            use_synth :rhodey
            melody = (knit :f4, 2, :a4, 1, :c5, 1, :e5, 2, :d5, 1, :c5, 1, :a4, 2, :g4, 2, :f4, 2, :a4, 2)
            melody.length.times do
              play melody.tick, release: 0.4, cutoff: (line 95, 115, steps: 16).look, amp: 0.9
              sleep 0.5
            end
          end
        end
      end

      in_thread do
        use_synth :fm
        chords_prog = knit(chord(:f3, :major7), 1, chord(:bf3, :dom7), 1, chord(:c3, :dom9), 1, chord(:f3, :major7), 1)
        4.times do
          play_chord chords_prog.tick, cutoff: (line 85, 105, steps: 4).look, release: 7, divisor: 2, depth: 6, amp: 0.25
          sleep 2
        end
      end

      in_thread do
        16.times do |i|
          sample :drum_bass_soft, amp: (i % 4 == 0) ? 0.5 : 0.4
          sample :drum_cymbal_soft, rate: 0.9, amp: 0.25
          sleep 0.25
          sample :hat_gem, amp: 0.2
          sleep 0.25
          sample :drum_snare_soft, amp: 0.35, rate: 1.1 if spread(3, 8).tick
          sleep 0.5
        end
      end

      sleep 8
    end

    # Transition: Long FM drone with organ sustain and cymbal swell
    use_synth :fm
    play :f3, cutoff: 88, release: 10, divisor: 3, depth: 15, amp: 0.55

    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:f3, :major7), cutoff: 90, release: 10, amp: 0.3
    end

    in_thread do
      sample :drum_cymbal_soft, rate: 0.8, amp: 0.3, sustain: 4, release: 1
    end

    sleep 5

    # Section 3: FM synth finale with layered harmony and tighter hi-hat patterns
    2.times do
      in_thread do
        use_synth :fm
        play :f2, release: 14, cutoff: 82, divisor: 4, depth: 18, amp: 0.3

        use_synth :fm
        jazz_phrase = (ring :f4, :a4, :c5, :e5, :f5, :e5, :d5, :c5, :bf4, :a4, :g4, :f4, :e4, :f4, :a4, :c5)
        16.times do
          play jazz_phrase.tick, release: 0.3, cutoff: (line 85, 120, steps: 16).look, divisor: 2, depth: 8, amp: 0.95
          sleep 0.25
        end
      end

      in_thread do
        use_synth :hollow
        play_chord chord(:f3, :major7), cutoff: 88, release: 12, amp: 0.25

        with_fx :lpf, cutoff: 95 do
          use_synth :fm
          jazz_chords = (ring chord(:f3, :major7), chord(:a3, :minor7), chord(:d3, :minor7), chord(:g3, :dom9))
          4.times do
            play_chord jazz_chords.tick, cutoff: (line 82, 100, steps: 4).look, release: 1, divisor: 3, depth: 8, amp: 0.35
            sleep 1
          end
        end
      end

      in_thread do
        with_fx :hpf, cutoff: 100 do
          32.times do |i|
            sample :drum_bass_soft, amp: 0.5 if i % 4 == 0
            sample :hat_gem, amp: (i % 2 == 0) ? 0.25 : 0.15
            sleep 0.125
            sample :drum_snare_soft, amp: 0.4, rate: 1.05 if i % 8 == 4
            sleep 0.125
          end
        end
      end

      sleep 4
    end

    # Outro: Final sustained chord wash with cymbal
    use_synth :prophet
    with_fx :reverb, room: 0.3, mix: 0.35 do
      play_chord chord(:f3, :major7), release: 8, cutoff: 95, amp: 0.7
    end

    in_thread do
      use_synth :organ_tonewheel
      with_fx :reverb, room: 0.35, mix: 0.4 do
        play_chord chord(:f2, :major7), cutoff: 92, release: 8, amp: 0.4
      end
    end

    in_thread do
      with_fx :reverb, room: 0.3, mix: 0.3 do
        sample :drum_cymbal_soft, rate: 0.85, amp: 0.35, sustain: 6, release: 2
      end
    end

    sleep 8

  end
end