# Electronic Dreams
# Upbeat electronic track with evolving synth textures

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Opening in Am - energetic chipbass melody with bass foundation and four-on-the-floor
    2.times do
      with_fx :lpf, cutoff: 100 do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          in_thread do
            use_synth :chipbass
            melody_notes = (ring :a3, :c4, :e4, :a4, :g4, :e4, :c4, :a3)
            cutoffs = (line 80, 120, steps: 8)

            8.times do
              play melody_notes.tick, cutoff: cutoffs.look, release: 0.2, amp: 0.9
              sleep 0.5
            end
          end

          in_thread do
            use_synth :bass_foundation
            play :a1, cutoff: 90, release: 4, amp: 0.3

            use_synth :dark_ambience
            play_chord chord(:a3, :minor), cutoff: 85, release: 4, amp: 0.2
            sleep 4

            use_synth :bass_foundation
            play :a1, cutoff: 90, release: 4, amp: 0.3

            use_synth :fm
            play_chord chord(:c3, :major), cutoff: 95, release: 4, amp: 0.15
            sleep 4
          end

          in_thread do
            with_fx :hpf, cutoff: 100 do
              8.times do
                sample :bd_haus, amp: 0.6
                sample :hat_psych, amp: 0.25
                sleep 0.25
                sample :hat_psych, amp: 0.2
                sleep 0.25
                sample :elec_hi_snare, amp: 0.5, rate: 1.2
                sample :hat_psych, amp: 0.25
                sleep 0.25
                sample :hat_psych, amp: 0.2
                sleep 0.25
              end
            end
          end
        end
      end
    end

    # Transition 1 - build tension
    use_synth :supersaw
    play :e4, cutoff: 90, release: 2, amp: 0.7
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:e3, :minor), cutoff: 90, release: 2, amp: 0.25
    end
    in_thread do
      sample :bd_haus, amp: 0.55
      sleep 1
      sample :elec_cymbal, amp: 0.3, rate: 0.9
    end
    sleep 2

    use_synth :supersaw
    play :a4, cutoff: 110, release: 2, amp: 0.8
    in_thread do
      use_synth :bass_highend
      play :a2, cutoff: 100, release: 2, amp: 0.3
    end
    in_thread do
      sample :bd_haus, amp: 0.55
      sample :elec_hi_snare, amp: 0.45
      sleep 1
      sample :elec_blip, amp: 0.25, rate: 2 if one_in(2)
    end
    sleep 2

    # Section 2: Intensify with supersaw in Am - richer harmonic layers and electronic fills
    2.times do
      in_thread do
        use_synth :supersaw
        melody_pattern = (knit :a3, 2, :c4, 2, :e4, 2, :g4, 1, :a4, 1)

        8.times do
          play melody_pattern.tick, cutoff: rrand(90, 120), release: 0.3, amp: 0.95
          sleep 0.5
        end
      end

      in_thread do
        use_synth :bass_foundation
        am_bass = (knit :a1, 4, :c2, 2, :e2, 2)
        cutoff_line = (line 85, 110, steps: 8)

        8.times do
          play am_bass.tick, cutoff: cutoff_line.look, release: 0.5, amp: 0.35
          sleep 0.5
        end
      end

      in_thread do
        8.times do |beat|
          sample :bd_haus, amp: 0.55
          sample :hat_psych, amp: 0.3
          sample :elec_blip, amp: 0.3, rate: rrand(1.5, 2.5) if one_in(3)
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
          sample :elec_hi_snare, amp: 0.5, rate: 1.1
          sample :hat_psych, amp: 0.3
          sample :elec_blip, amp: 0.25, rate: rrand(2, 3) if beat % 4 == 3
          sleep 0.25
          sample :hat_psych, amp: 0.25
          sleep 0.25
        end
      end

      sleep 4
    end

    # Transition 2 - shift to key change
    use_synth :tech_saws
    play :b4, cutoff: 100, release: 3, amp: 0.75
    in_thread do
      use_synth :fm
      play_chord chord(:b2, :minor7), cutoff: 100, release: 3, amp: 0.3
    end
    in_thread do
      sample :bd_haus, amp: 0.6
      sample :elec_cymbal, amp: 0.3, rate: 1.1
      sleep 1.5
      sample :elec_hi_snare, amp: 0.5
    end
    sleep 3

    use_synth :tech_saws
    play :c5, cutoff: 120, release: 1, amp: 0.8
    in_thread do
      use_synth :bass_highend
      play :c3, cutoff: 110, release: 1, amp: 0.35
    end
    in_thread do
      sample :bd_haus, amp: 0.6
      sample :elec_blip, amp: 0.35, rate: 3
      sleep 0.5
      sample :elec_hi_snare, amp: 0.5
      sample :elec_blip, amp: 0.35, rate: 2.5
    end
    sleep 1

    # Section 3: Key change to C major - tech_saws climax with warm pad foundation and full intensity rhythm
    3.times do
      with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.25 do
        in_thread do
          use_synth :tech_saws
          c_major_melody = (ring :c4, :e4, :g4, :c5, :b4, :g4, :e4, :d4)
          cutoff_ramp = (line 100, 130, steps: 8)

          8.times do
            play c_major_melody.tick, cutoff: cutoff_ramp.look, release: 0.25, amp: 1.0
            sleep 0.5
          end
        end

        in_thread do
          with_fx :lpf, cutoff: 105 do
            use_synth :bass_foundation
            c_major_bass = (ring :c2, :c2, :g1, :g1, :a1, :a1, :f1, :f1)

            8.times do
              play c_major_bass.tick, cutoff: 95, release: 0.4, amp: 0.4
              sleep 0.5
            end
          end
        end

        in_thread do
          with_fx :reverb, room: 0.25, mix: 0.25 do
            8.times do |beat|
              sample :bd_haus, amp: 0.6
              sample :hat_psych, amp: 0.35
              sample :elec_blip, amp: 0.35, rate: rrand(2, 3.5) if spread(3, 8).tick
              sleep 0.25
              sample :hat_psych, amp: 0.3
              sleep 0.25
              sample :elec_hi_snare, amp: 0.55, rate: 1.15
              sample :hat_psych, amp: 0.35
              sample :elec_cymbal, amp: 0.25, rate: 1.2 if beat % 2 == 1
              sleep 0.25
              sample :hat_psych, amp: 0.3
              sample :elec_blip, amp: 0.3, rate: rrand(1.5, 2) if one_in(4)
              sleep 0.25
            end
          end
        end

        sleep 4
      end
    end

    # Final transition - closing phrase
    use_synth :chipbass
    play :c5, cutoff: 120, release: 4, amp: 0.85
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c3, :major7), cutoff: 100, release: 4, amp: 0.3
    end
    in_thread do
      sample :bd_haus, amp: 0.6
      sample :elec_cymbal, amp: 0.35, rate: 0.8
      sleep 2
      sample :elec_hi_snare, amp: 0.5
      sleep 1
      sample :bd_haus, amp: 0.55
    end
    sleep 4

  end
end