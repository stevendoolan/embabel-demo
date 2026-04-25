# Feed the Birds (EDM Remix)
# Uplifting electronic melody in C major

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Intro - Gentle saw lead with warm pad foundation and minimal beat
    2.times do
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          use_synth :saw
          melody = (ring :c4, :c4, :b3, :a3, :c4, :a3, :g3)
          durations = (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3)
          cutoffs = (line 90, 110, steps: 7)

          7.times do
            play melody.tick, cutoff: cutoffs.look, release: durations.look * 0.6, amp: 0.8
            sleep durations.look
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :dark_ambience
          chords_prog = [chord(:c3, :major), chord(:g2, :major), chord(:a2, :minor), chord(:f3, :major)]
          durations = [3, 3, 3, 3]

          4.times do
            play_chord chords_prog.tick, cutoff: 95, release: 2.5, amp: 0.3
            sleep durations.look
          end
        end
      end

      in_thread do
        with_fx :hpf, cutoff: 100 do
          7.times do
            sample :bd_haus, amp: 0.5
            sample :hat_bdu, amp: 0.2
            sleep 0.5
            sample :hat_bdu, amp: 0.15
            sleep 0.5
          end
        end
      end

      sleep 12
    end

    # Transition: Build-up with sustained chord and cymbal swell
    use_synth :supersaw
    play chord(:c4, :major), cutoff: 95, release: 3, amp: 0.7
    use_synth :hollow
    play_chord chord(:c2, :major), cutoff: 85, release: 3.5, amp: 0.3
    sample :elec_cymbal, amp: 0.4, rate: 0.8
    sleep 4

    # Section 2: Drop - Energetic supersaw with rhythmic blade chords and full four-on-the-floor
    3.times do
      in_thread do
        with_fx :lpf, cutoff: 120 do
          with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
            use_synth :supersaw
            melody = (ring :c5, :c5, :b4, :a4, :c5, :a4, :g4)
            durations = (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3)

            7.times do
              play melody.tick, cutoff: rrand(100, 120), release: 0.3, amp: 0.9, detune: 0.1
              sleep durations.look
            end
          end
        end
      end

      in_thread do
        use_synth :blade
        chords_prog = [chord(:c3, :major), chord(:g2, :major), chord(:a2, :minor), chord(:f3, :major)]

        4.times do
          current_chord = chords_prog.tick
          3.times do
            play_chord current_chord, cutoff: (line 100, 115, steps: 3).look, release: 0.2, amp: 0.35
            sleep 1
          end
          sleep 0
        end
      end

      in_thread do
        7.times do
          sample :bd_haus, amp: 0.6
          sample :hat_bdu, amp: 0.3
          sleep 0.25
          sample :hat_bdu, amp: 0.2
          sleep 0.25

          sample :elec_hi_snare, amp: 0.45
          sample :hat_bdu, amp: 0.3
          sleep 0.25
          sample :hat_bdu, amp: 0.2
          sleep 0.25

          sample :bd_haus, amp: 0.6
          sample :hat_bdu, amp: 0.3
          sleep 0.25
          sample :hat_bdu, amp: 0.2
          sleep 0.25

          sample :elec_hi_snare, amp: 0.45
          sample :hat_bdu, amp: 0.3
          sleep 0.25
          sample :hat_bdu, amp: 0.2
          sleep 0.25
        end
      end

      sleep 12
    end

    # Transition: Breakdown with pluck and sparse kick
    use_synth :pluck
    play :g4, cutoff: 80, release: 2, amp: 0.7
    use_synth :hollow
    play_chord chord(:g2, :major), cutoff: 88, release: 3.5, amp: 0.3
    2.times do
      sample :bd_haus, amp: 0.4
      sleep 1
    end
    sample :drum_cymbal_closed, amp: 0.3
    sleep 2

    # Section 3: Outro - Pluck melody with layered pads and simplified beat
    2.times do
      in_thread do
        use_synth :pluck
        melody = (ring :c4, :c4, :b3, :a3, :c4, :a3, :g3, :c3)
        durations = (ring 1.25, 0.25, 1.5, 0.25, 1, 0.25, 1.5, 1.5)

        8.times do
          play melody.tick, cutoff: rrand(85, 105), release: 0.2, amp: 0.85
          sleep durations.look
        end
      end

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :dark_ambience
          chords_prog = [chord(:c3, :major), chord(:f3, :major), chord(:g2, :major), chord(:c2, :major)]
          durations = [1.5, 1.5, 1.5, 3]
          cutoffs = (line 90, 105, steps: 4)

          4.times do
            play_chord chords_prog.tick, cutoff: cutoffs.look, release: 1.2, amp: 0.3
            sleep durations.look
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.2, mix: 0.25 do
          8.times do
            sample :bd_haus, amp: 0.5
            sample :hat_bdu, amp: 0.25
            sleep 0.625

            sample :elec_hi_snare, amp: 0.4 if one_in(2)
            sample :hat_bdu, amp: 0.2
            sleep 0.625

            sample :bd_haus, amp: 0.5
            sample :drum_cymbal_closed, amp: 0.25
            sleep 0.625

            sample :hat_bdu, amp: 0.2
            sleep 0.625
          end
        end
      end

      sleep 7.5
    end

  end
end