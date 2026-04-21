use_debug false
use_bpm 128

# Feed the Birds EDM Remix
# Electronic uplifting melody in C major with key change to Am

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Opening in C major - supersaw lead, prophet pads, four-on-the-floor beat
    2.times do
      in_thread do
        use_synth :prophet
        play :c2, release: 16, cutoff: 85, amp: 0.4

        with_fx :reverb, room: 0.25, mix: 0.3 do
          with_fx :lpf, cutoff: 110, mix: 0.5 do
            use_synth :supersaw
            notes = (ring :g4, :g4, :fs4, :e4, :g4, :e4, :d4, :c4)
            durations = (ring 0.75, 0.25, 1, 0.5, 0.75, 0.25, 1, 1)
            cutoffs = (ring 100, 105, 95, 90, 100, 95, 85, 80)

            8.times do
              play notes.tick, release: 0.3, cutoff: cutoffs.look, amp: 0.9
              sleep durations.look
            end
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :prophet
          chords = knit(chord(:c3, :major), 4, chord(:g2, :major), 2, chord(:f3, :major), 2)

          8.times do
            play_chord chords.tick, cutoff: (line 85, 105, steps: 8).look, release: 1, amp: 0.3
            sleep 1
          end
        end
      end

      in_thread do
        with_fx :hpf, cutoff: 100, mix: 0.5 do
          16.times do
            tick
            sample :bd_haus, amp: (factor?(look, 8) ? 0.7 : 0.6)
            sample :hat_psych, amp: 0.25, rate: 1.2
            sleep 0.25
            sample :hat_psych, amp: 0.15, rate: 1.2
            sleep 0.25
            sample :elec_hi_snare, amp: 0.5
            sample :hat_psych, amp: 0.25, rate: 1.2
            sleep 0.25
            sample :hat_psych, amp: 0.15, rate: 1.2
            sleep 0.25
          end
        end
      end

      sleep 8
    end

    # Transition drone - bridges to Section 2
    use_synth :fm
    play :c2, cutoff: 90, release: 8, divisor: 4, depth: 15, amp: 0.6
    sleep 4

    # Section 2: Build intensity - fm synth lead, hollow arpeggios, faster hi-hats
    2.times do
      in_thread do
        use_synth :fm
        play :c2, release: 16, cutoff: 90, divisor: 3, depth: 18, amp: 0.4

        use_synth :fm
        melody = (knit :g4, 2, :g4, 1, :fs4, 1, :e4, 2, :g4, 2, :e4, 1, :d4, 1, :c4, 2)

        16.times do
          play melody.tick, release: 0.2, cutoff: (line 95, 115, steps: 16).look, amp: 0.85
          sleep 0.25
        end
      end

      in_thread do
        use_synth :hollow
        play_chord chord(:c3, :major), cutoff: 90, release: 16, amp: 0.25

        use_synth :hollow
        chord_notes = (ring :c3, :e3, :g3, :c4, :e3, :g3, :c4, :e3)

        16.times do
          play chord_notes.tick, cutoff: (line 90, 120, steps: 16).look, release: 0.15, amp: 0.35
          sleep 0.25
        end
      end

      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          64.times do
            tick
            sample :bd_haus, amp: 0.55
            sample :hat_psych, amp: 0.3, rate: 1.3
            sleep 0.125
            sample :hat_psych, amp: 0.2, rate: 1.3
            sleep 0.125
            if factor?(look, 8)
              sample :elec_hi_snare, amp: 0.5, rate: 1.1
            end
            if factor?(look, 16)
              sample :elec_cymbal, amp: 0.25, rate: 0.9
            end
          end
        end
      end

      sleep 4
    end

    # Transition drone - prepares key change to Am
    use_synth :prophet
    play :a1, cutoff: 88, release: 10, amp: 0.6
    sleep 4

    # Section 3: Key change to Am - beep lead climax, dark_ambience pads, full energy percussion
    3.times do
      in_thread do
        use_synth :supersaw
        play :a1, release: 16, cutoff: 85, amp: 0.35

        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.25 do
          use_synth :beep
          am_melody = (ring :a4, :a4, :gs4, :e4, :a4, :e4, :d4, :c4)
          am_durations = (ring 0.75, 0.25, 1, 0.5, 0.75, 0.25, 1, 1)

          8.times do
            play am_melody.tick, release: 0.25, cutoff: rrand(100, 120), amp: 1.0
            sleep am_durations.look
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.35 do
          use_synth :dark_ambience
          am_chords = knit(chord(:a2, :minor), 4, chord(:e2, :minor), 2, chord(:f3, :major), 2)

          8.times do
            play_chord am_chords.tick, cutoff: (line 80, 100, steps: 8).look, release: 1, amp: 0.4
            sleep 1
          end
        end
      end

      in_thread do
        32.times do
          tick
          sample :bd_haus, amp: (factor?(look, 16) ? 0.65 : 0.6)
          sample :hat_psych, amp: 0.35, rate: 1.2
          sleep 0.125
          sample :hat_psych, amp: 0.25, rate: 1.2
          sleep 0.125
          if factor?(look, 4)
            sample :elec_hi_snare, amp: 0.55, rate: 1.05
          end
          if factor?(look, 8)
            sample :elec_cymbal, amp: 0.3, rate: 0.85
          end
          if one_in(16)
            sample :elec_hi_snare, amp: 0.35, rate: 1.5
          end
        end
      end

      sleep 8
    end

    # Final transition - fadeout with sparse rhythm
    in_thread do
      use_synth :fm
      play :a1, cutoff: 80, release: 12, divisor: 5, depth: 20, amp: 0.5
    end

    in_thread do
      use_synth :hollow
      play_chord chord(:a2, :minor), cutoff: 75, release: 12, amp: 0.3
    end

    in_thread do
      16.times do
        tick
        sample :bd_haus, amp: 0.4
        sample :hat_psych, amp: 0.2, rate: 1.1 if factor?(look, 2)
        sleep 0.5
      end
    end

    sleep 8

  end
end