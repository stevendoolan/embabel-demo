use_debug false
use_bpm 120

# Electronic Classical Fusion - Ethereal electronic journey through C major to A minor

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Ethereal opening in C major - Prophet lead with atmospheric drone, harmony pads, and minimal percussion
    3.times do
      use_synth :prophet
      play :c2, release: 16, cutoff: 85, amp: 0.4

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :fm
          play_chord chord(:c3, :major7), cutoff: 85, release: 16, divisor: 2, depth: 8, amp: 0.3

          use_synth :prophet
          play_chord chord(:e3, :minor7), cutoff: 88, release: 8, amp: 0.25
          sleep 2
          play_chord chord(:a3, :minor7), cutoff: 90, release: 6, amp: 0.25
          sleep 2
        end
      end

      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          16.times do
            sample :bd_haus, amp: 0.5, cutoff: 90
            sample :hat_psych, amp: 0.25, rate: 1.2
            sleep 0.5
            sample :hat_psych, amp: 0.18, rate: 1.2
            sleep 0.5
          end
        end
      end

      with_fx :reverb, room: 0.25, mix: 0.3 do
        with_fx :lpf, cutoff: 110, mix: 0.8 do
          use_synth :prophet
          notes = (ring :c4, :e4, :g4, :b4, :c5, :g4, :e4, :d4)
          16.times do
            play notes.tick, release: 0.3, cutoff: (line 90, 115, steps: 16).look, amp: 0.85
            sleep 0.25
          end
        end
      end
    end

    # Transition drone - bridges to next section
    use_synth :fm
    play :c2, release: 8, divisor: 4, depth: 18, cutoff: 90, amp: 0.6
    use_synth :organ_tonewheel
    play_chord chord(:c3, :sus4), cutoff: 92, release: 8, amp: 0.3
    sample :bd_haus, amp: 0.6, cutoff: 95
    sleep 4

    # Section 2: Piano arpeggios in C major - building intensity with progression and drums
    2.times do
      use_synth :prophet
      play :g2, release: 12, cutoff: 88, amp: 0.35

      in_thread do
        use_synth :fm
        play_chord chord(:c3, :major7), cutoff: 88, release: 12, divisor: 3, depth: 10, amp: 0.3

        use_synth :prophet
        chords_prog = knit(chord(:c3, :major), 2, chord(:f3, :major7), 2, chord(:g3, :sus4), 2, chord(:a3, :minor7), 2)
        8.times do
          play_chord chords_prog.tick, cutoff: (line 85, 105, steps: 8).look, release: 0.5, amp: 0.3
          sleep 0.5
        end
      end

      in_thread do
        16.times do |n|
          sample :bd_haus, amp: n == 0 ? 0.6 : 0.5, cutoff: 92
          sample :hat_psych, amp: 0.3, rate: 1.1
          sleep 0.25
          sample :hat_psych, amp: 0.2, rate: 1.1
          sleep 0.25
          sample :elec_snare, amp: 0.45, rate: 0.95
          sample :hat_psych, amp: 0.28, rate: 1.1
          sleep 0.25
          sample :hat_psych, amp: 0.2, rate: 1.1
          sample :drum_tom_mid_soft, amp: 0.3 if one_in(8)
          sleep 0.25
        end
      end

      use_synth :piano
      melody = (knit :c4, 2, :e4, 2, :g4, 2, :c5, 1, :b4, 1, :a4, 2, :g4, 2, :f4, 2, :e4, 2)
      16.times do
        play melody.tick, release: 0.2, cutoff: rrand(95, 115), amp: 0.9
        sleep 0.25
      end
    end

    # Transition drone with key change preparation - tom fill
    use_synth :prophet
    play :a2, release: 10, cutoff: 92, amp: 0.6
    use_synth :organ_tonewheel
    play_chord chord(:e3, :minor7), cutoff: 90, release: 10, amp: 0.35
    sample :bd_haus, amp: 0.6
    sleep 0.5
    2.times do
      sample :drum_tom_mid_soft, amp: 0.4, rate: 1.1
      sleep 0.25
    end
    sample :elec_snare, amp: 0.55
    sleep 0.5

    # Section 3: Key change to A minor - Saw synth creates ethereal tension, full intensity percussion
    3.times do
      use_synth :fm
      play :a1, release: 16, divisor: 3, depth: 22, cutoff: 87, amp: 0.4

      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :fm
          play_chord chord(:a2, :minor7), cutoff: 87, release: 16, divisor: 2, depth: 12, amp: 0.35

          use_synth :prophet
          am_chords = (ring chord(:a3, :minor), chord(:f3, :major7), chord(:c3, :major), chord(:g3, :sus4))
          4.times do
            play_chord am_chords.tick, cutoff: (line 85, 115, steps: 4).look, release: 1, amp: 0.3
            sleep 1
          end
        end
      end

      in_thread do
        with_fx :hpf, cutoff: 95, mix: 0.7 do
          16.times do |n|
            sample :bd_haus, amp: n == 0 ? 0.6 : 0.5, cutoff: 88
            sample :hat_psych, amp: 0.32, rate: 1.15
            sleep 0.125
            sample :hat_psych, amp: 0.22, rate: 1.15
            sleep 0.125
            sample :elec_snare, amp: 0.5, rate: 0.9
            sample :hat_psych, amp: 0.3, rate: 1.15
            sample :elec_cymbal, amp: 0.28 if spread(3, 16).tick
            sleep 0.125
            sample :hat_psych, amp: 0.22, rate: 1.15
            sample :drum_tom_mid_soft, amp: 0.35, rate: rrand(0.95, 1.05) if one_in(6)
            sleep 0.125
          end
        end
      end

      with_fx :lpf, cutoff: 105, mix: 0.8 do
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.25 do
          use_synth :saw
          am_notes = (ring :a3, :c4, :e4, :a4, :g4, :e4, :d4, :c4)
          16.times do
            play am_notes.tick, release: 0.25, cutoff: (line 85, 120, steps: 16).look, amp: 0.8
            sleep 0.25
          end
        end
      end
    end

    # Final transition - ethereal fade with orchestral tom outro
    use_synth :prophet
    play :a2, release: 12, cutoff: 90, amp: 0.5
    use_synth :fm
    play_chord chord(:a2, :minor7), cutoff: 90, release: 12, divisor: 2, depth: 15, amp: 0.4
    3.times do
      sample :drum_tom_mid_soft, amp: 0.45, rate: (ring 1.2, 1.0, 0.9).tick
      sleep 0.5
    end
    sample :elec_cymbal, amp: 0.4, rate: 0.8
    sample :bd_haus, amp: 0.6
    sleep 6

  end
end