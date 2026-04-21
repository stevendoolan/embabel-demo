# Electronic Classical Fusion
# Style: Electronic Classical | Mood: Ethereal

use_debug false
use_bpm 120

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Opening in Am - Piano melody with ambient harmony and minimal percussion
    3.times do
      with_fx :reverb, room: 0.25, mix: 0.3 do
        with_fx :lpf, cutoff: 100 do

          # Melody: Piano in Am
          in_thread do
            use_synth :piano
            melody_am = (ring :a4, :c5, :e5, :a5, :g5, :e5, :c5, :a4)
            cutoffs = (line 80, 110, steps: 8)

            8.times do
              play melody_am.tick, amp: 0.9, cutoff: cutoffs.look, release: 0.3
              sleep 0.5
            end

            use_synth :beep
            counter = (ring :e5, :d5, :c5, :b4, :a4, :g4, :e4, :a4)

            8.times do
              play counter.tick, amp: 0.8, cutoff: rrand(90, 115), release: 0.2
              sleep 0.5
            end
          end

          # Harmony: Ambient pad and saw arpeggios
          in_thread do
            use_synth :dark_ambience
            play_chord chord(:a3, :minor), cutoff: 85, release: 8, amp: 0.3

            use_synth :saw
            am_arp = (ring :a2, :c3, :e3, :a3)
            16.times do
              play am_arp.tick, cutoff: (line 80, 100, steps: 16).look, release: 0.15, amp: 0.25
              sleep 0.25
            end
          end

          # Percussion: Minimal foundation
          in_thread do
            with_fx :hpf, cutoff: 100 do
              4.times do
                sample :bd_haus, amp: 0.5
                sample :hat_psych, amp: 0.2, rate: 0.9
                sleep 1
                sample :hat_psych, amp: 0.15, rate: 0.9
                sleep 0.5
                sample :drum_cymbal_soft, amp: 0.3, rate: 0.8
                sleep 0.5
                sample :bd_haus, amp: 0.45
                sample :hat_psych, amp: 0.2, rate: 0.9
                sleep 1
                sample :elec_bell, amp: 0.25, rate: 1.2 if one_in(2)
                sleep 1
              end
            end
          end

          sleep 16
        end
      end
    end

    # Transition: Bridging Am to C major
    use_synth :sine
    play :a4, amp: 0.7, cutoff: 95, release: 2
    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:a3, :minor), cutoff: 90, release: 2, amp: 0.3
    end
    in_thread do
      sample :drum_cymbal_soft, amp: 0.4, rate: 0.7, attack: 0.5, release: 2
    end
    sleep 2

    use_synth :sine
    play :c5, amp: 0.7, cutoff: 100, release: 2
    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:c4, :major), cutoff: 95, release: 2, amp: 0.3
    end
    in_thread do
      sample :elec_bell, amp: 0.3, rate: 1.5
    end
    sleep 2

    # Section 2: C major development - Pluck melody with tri harmony and building percussion
    3.times do
      with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.25 do
        with_fx :lpf, cutoff: 100 do

          # Melody: Pluck and sine layers
          in_thread do
            use_synth :pluck
            melody_c = (ring :c5, :e5, :g5, :c6, :b5, :g5, :e5, :c5)

            8.times do
              play melody_c.tick, amp: 0.9, cutoff: (line 85, 120, steps: 8).look, release: 0.4
              sleep 0.5
            end

            use_synth :sine
            harmony = (ring :e5, :g5, :c6, :e6, :d6, :c6, :g5, :e5)

            8.times do
              play harmony.tick, amp: 0.75, cutoff: rrand(95, 115), release: 0.5
              sleep 0.5
            end
          end

          # Harmony: Tri chords with organ support
          in_thread do
            use_synth :tri
            c_progression = [chord(:c3, :major), chord(:g3, :major)]
            2.times do
              play_chord c_progression.tick, cutoff: 95, release: 3.5, amp: 0.35
              sleep 4
            end

            use_synth :organ_tonewheel
            organ_progression = [chord(:a3, :minor), chord(:f3, :major)]
            2.times do
              play_chord organ_progression.tick, cutoff: 100, release: 3.5, amp: 0.25
              sleep 4
            end
          end

          # Percussion: Increased intensity with snare
          in_thread do
            4.times do
              sample :bd_haus, amp: 0.55
              sample :hat_psych, amp: 0.25, rate: 1.0
              sleep 0.5
              sample :elec_snare, amp: 0.45
              sample :hat_psych, amp: 0.2, rate: 1.0
              sleep 0.5
              sample :bd_haus, amp: 0.5
              sample :hat_psych, amp: 0.25, rate: 1.0
              sleep 0.5
              sample :hat_psych, amp: 0.2, rate: 1.0
              sleep 0.25
              sample :elec_snare, amp: 0.4
              sample :drum_cymbal_soft, amp: 0.35, rate: 0.9
              sleep 0.25
            end
          end

          sleep 16
        end
      end
    end

    # Transition: Dramatic descent
    use_synth :beep
    play :c6, amp: 0.8, cutoff: 110, release: 1
    in_thread do
      use_synth :saw
      play :e3, cutoff: 100, release: 1, amp: 0.3
    end
    in_thread do
      sample :bd_haus, amp: 0.6, rate: 0.8
    end
    sleep 0.5
    in_thread do
      sample :bd_haus, amp: 0.55, rate: 0.75
    end
    sleep 0.5

    use_synth :beep
    play :g5, amp: 0.75, cutoff: 100, release: 1
    in_thread do
      use_synth :saw
      play :c3, cutoff: 95, release: 1, amp: 0.3
    end
    in_thread do
      sample :drum_cymbal_soft, amp: 0.4, rate: 0.7
    end
    sleep 1

    use_synth :beep
    play :e5, amp: 0.7, cutoff: 90, release: 2
    in_thread do
      use_synth :saw
      play :g2, cutoff: 90, release: 2, amp: 0.25
    end
    in_thread do
      sample :elec_bell, amp: 0.35, rate: 0.9
    end
    sleep 2

    # Section 3: Final statement - All layers converge in C major
    2.times do
      # Melody: Piano with beep and sine convergence
      in_thread do
        use_synth :piano
        final_melody = (ring :c5, :d5, :e5, :g5, :c6, :g5, :e5, :d5)

        8.times do
          play final_melody.tick, amp: 0.95, cutoff: (line 90, 120, steps: 8).look, release: 0.35
          sleep 0.5
        end

        use_synth :beep
        ascending = (ring :e4, :g4, :c5, :e5, :g5, :c6, :e6, :c6)

        4.times do
          play ascending.tick, amp: 0.85, cutoff: rrand(100, 120), release: 0.25
          sleep 0.5
        end

        use_synth :sine
        4.times do
          play ascending.tick, amp: 0.75, cutoff: rrand(95, 110), release: 0.3
          sleep 0.5
        end
      end

      # Harmony: Layered C major foundation
      in_thread do
        use_synth :dark_ambience
        play_chord chord(:c3, :major), cutoff: 85, release: 8, amp: 0.35

        use_synth :tri
        c_final_arp = (ring :c2, :e2, :g2, :c3, :e3, :g3, :c4, :g3)
        16.times do
          play c_final_arp.tick, cutoff: (line 90, 120, steps: 16).look, release: 0.2, amp: 0.3
          sleep 0.25
        end

        use_synth :organ_tonewheel
        final_chords = [chord(:c3, :major), chord(:g3, :major), chord(:a3, :minor), chord(:f3, :major)]
        4.times do
          play_chord final_chords.tick, cutoff: 100, release: 1.8, amp: 0.2
          sleep 2
        end
      end

      # Percussion: Full statement
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.6
          sample :hat_psych, amp: 0.3, rate: 1.1
          sleep 0.25
          sample :hat_psych, amp: 0.2, rate: 1.1
          sleep 0.25
          sample :elec_snare, amp: 0.55
          sample :hat_psych, amp: 0.3, rate: 1.1
          sleep 0.25
          sample :hat_psych, amp: 0.25, rate: 1.1
          sleep 0.25
          sample :bd_haus, amp: 0.55
          sample :hat_psych, amp: 0.3, rate: 1.1
          sleep 0.25
          sample :elec_bell, amp: 0.3, rate: 1.3 if spread(3, 8).tick
          sleep 0.25
          sample :elec_snare, amp: 0.5
          sample :drum_cymbal_soft, amp: 0.4, rate: 0.85
          sleep 0.5
        end
      end

      sleep 16
    end

    # Coda: Final ethereal resolution
    use_synth :sine
    play_chord chord(:c5, :major), amp: 0.7, cutoff: 100, release: 4
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c3, :major), cutoff: 85, release: 4, amp: 0.35
    end
    in_thread do
      use_synth :organ_tonewheel
      play_chord chord(:c4, :major), cutoff: 95, release: 4, amp: 0.25
    end
    in_thread do
      sample :drum_cymbal_soft, amp: 0.45, rate: 0.6, attack: 0.5, release: 4
      sample :elec_bell, amp: 0.35, rate: 1.0, release: 4
    end
    sleep 4

  end
end