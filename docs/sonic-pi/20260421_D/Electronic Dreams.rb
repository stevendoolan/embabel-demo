# Electronic Dreams
# Style: Dreamy Electronic | Mood: Uplifting Journey | Time: 4/4

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Dreamy opening in Am - Minimal beats with FM melody and ambient pads
    3.times do
      in_thread do
        use_synth :fm
        play :a2, release: 16, divisor: 2, depth: 8, cutoff: 85, amp: 0.4
      end

      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :prophet
          play_chord chord(:a3, :minor), cutoff: 85, release: 16, amp: 0.25

          use_synth :dark_ambience
          play :a2, cutoff: 90, release: 16, amp: 0.22
        end
      end

      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          use_synth :fm
          melody_notes = (ring :a4, :c5, :e5, :a5, :g5, :e5, :c5, :a4)
          cutoffs = (line 90, 115, steps: 8)

          8.times do
            play melody_notes.tick, release: 0.3, cutoff: cutoffs.look, amp: 0.9
            sleep 0.5
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.3 do
          use_synth :saw
          evolving_cutoff = (line 80, 110, steps: 16)
          16.times do
            play (ring :a3, :c4, :e4).tick, cutoff: evolving_cutoff.look, release: 0.3, amp: 0.2
            sleep 0.25
          end
        end
      end

      in_thread do
        8.times do
          sample :elec_hollow_kick, amp: 0.5, rate: 0.9
          sample :hat_psych, amp: 0.2, rate: 1.2
          sleep 0.5
          sample :elec_tick, amp: 0.15, rate: rrand(0.8, 1.4) if one_in(3)
          sleep 0.5
        end
      end

      sleep 8
    end

    # Transition drone - bridges to Section 2
    use_synth :prophet
    play :a2, cutoff: 90, release: 10, amp: 0.6

    in_thread do
      use_synth :prophet
      play_chord chord(:a3, :minor), cutoff: 88, release: 10, amp: 0.25
    end

    in_thread do
      2.times do
        sample :elec_blip, amp: 0.25, rate: 0.7
        sleep 1
      end
    end

    sleep 4

    # Section 2: Building intensity in Am - Faster rhythms with Prophet synth
    2.times do
      in_thread do
        use_synth :prophet
        play :a2, release: 12, cutoff: 88, amp: 0.4
      end

      in_thread do
        use_synth :dark_ambience
        play_chord chord(:a3, :minor7), cutoff: 90, release: 12, amp: 0.3
      end

      in_thread do
        with_fx :lpf, cutoff: 110 do
          with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
            use_synth :prophet
            melody_pattern = (knit :a4, 2, :c5, 2, :e5, 3, :d5, 1, :c5, 2, :a4, 2, :g4, 2, :a4, 2)

            16.times do
              play melody_pattern.tick, release: 0.2, cutoff: rrand(95, 115), amp: 0.85
              sleep 0.25
            end
          end
        end
      end

      in_thread do
        with_fx :hpf, cutoff: 100 do
          16.times do
            sample :elec_hollow_kick, amp: 0.5, rate: 0.85
            sample :hat_psych, amp: 0.25, rate: 1.3
            sleep 0.25
            sample :hat_psych, amp: 0.18, rate: 1.5
            sample :elec_tick, amp: 0.2, rate: rrand(1.0, 1.6) if spread(3, 8).tick
            sleep 0.25
          end
        end
      end

      sleep 4

      in_thread do
        use_synth :prophet
        play_chord chord(:f3, :major), cutoff: 85, release: 8, amp: 0.28
      end

      sleep 2

      in_thread do
        use_synth :saw
        play_chord chord(:g3, :major), cutoff: 92, release: 6, amp: 0.26
      end

      sleep 2
    end

    # Transition drone - key change to C major
    use_synth :fm
    play :c3, cutoff: 92, release: 8, divisor: 3, depth: 12, amp: 0.6

    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c3, :major), cutoff: 88, release: 8, amp: 0.3
    end

    in_thread do
      4.times do
        sample :elec_blip, amp: 0.3, rate: rrand(0.6, 1.2)
        sleep 0.5
        sample :elec_tick, amp: 0.25, rate: rrand(1.2, 1.8)
        sleep 0.5
      end
    end

    sleep 4

    # Section 3: Uplifting C major - Full groove with Blade synth
    3.times do
      in_thread do
        use_synth :blade
        play :c3, release: 14, cutoff: 100, amp: 0.4
      end

      in_thread do
        use_synth :prophet
        play_chord chord(:c4, :major), cutoff: 95, release: 14, amp: 0.32
      end

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :blade
          c_major_melody = (ring :c5, :e5, :g5, :c6, :b5, :g5, :e5, :c5)
          dynamic_cutoffs = (line 85, 125, steps: 8)

          8.times do
            play c_major_melody.tick, release: 0.25, cutoff: dynamic_cutoffs.look, amp: 0.95
            sleep 0.5
          end
        end
      end

      in_thread do
        use_synth :saw
        modulating_cutoff = (line 85, 115, steps: 16)
        16.times do
          play (ring :c3, :e3, :g3, :c4).tick, cutoff: modulating_cutoff.look, release: 0.25, amp: 0.25
          sleep 0.25
        end
      end

      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          8.times do
            sample :elec_hollow_kick, amp: 0.55, rate: 0.9
            sample :hat_psych, amp: 0.3, rate: 1.4
            sleep 0.25
            sample :elec_tick, amp: 0.25, rate: 1.5 if one_in(2)
            sleep 0.25
            sample :hat_psych, amp: 0.22, rate: 1.6
            sample :elec_blip, amp: 0.35, rate: 0.8
            sleep 0.25
            sample :hat_psych, amp: 0.28, rate: 1.3
            sample :elec_tick, amp: 0.3, rate: rrand(1.0, 1.8) if spread(5, 8).look
            sleep 0.25
          end
        end
      end

      sleep 8
    end

    # Final fadeout - gentle resolution with sparse beats
    use_synth :prophet
    play :c3, cutoff: 88, release: 12, amp: 0.5

    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c3, :major), cutoff: 85, release: 12, amp: 0.28
    end

    in_thread do
      6.times do
        sample :elec_hollow_kick, amp: 0.4, rate: 0.85
        sample :elec_blip, amp: 0.25, rate: rrand(0.5, 1.0)
        sleep 1
      end
    end

    sleep 6

  end
end