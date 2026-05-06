# Circuits & Counterpoint
# Style: Hybrid orchestral electronic | Mood: Dark, evolving, luminous

use_debug false
use_bpm 112

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =========================================================
    # SECTION 1: Dm — Sparse foundation, blade drone, chiplead melody
    # Melody: chiplead | Harmony: hollow pad + supersaw | Bass: bass_foundation | Perc: kick/snare/hat
    # =========================================================
    dm_melody = (ring :d4, :f4, :a4, :c5, :a4, :g4, :f4, :e4,
                      :d4, :f4, :a4, :as4, :a4, :g4, :e4, :d4)
    dm_chords = (ring chord(:d3, :minor7), chord(:g3, :m7), chord(:a3, :m7), chord(:d3, :minor7))
    dm_walk = (ring :d2, :f2, :a2, :g2, :f2, :e2, :a2, :d2)
    cutoff_ramp = (line 85, 115, steps: 32)
    cutoff_pad = (line 82, 100, steps: 8)

    2.times do
      # Long drones underneath
      use_synth :blade
      play :d3, release: 8, cutoff: 90, amp: 0.7

      use_synth :hollow
      play_chord chord(:d2, :minor7), cutoff: 88, release: 8, amp: 0.8

      use_synth :bass_foundation
      play :d2, cutoff: 65, release: 8, amp: 1.0

      # Melody: chiplead runs
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :reverb, room: 0.25, mix: 0.28 do
          in_thread do
            use_synth :chiplead
            16.times do
              play dm_melody.tick, cutoff: cutoff_ramp.tick, release: 0.12, amp: 1.8
              sleep 0.25
            end
          end

          # Harmony: supersaw chord stabs — one per half bar
          in_thread do
            with_fx :lpf, cutoff: 105, mix: 1.0 do
              4.times do
                use_synth :supersaw
                play_chord dm_chords.tick, cutoff: cutoff_pad.tick, release: 1.8, amp: 0.75
                sleep 2
              end
            end
          end

          # Bass: walking bass_foundation
          in_thread do
            with_fx :lpf, cutoff: 85, mix: 1.0 do
              use_synth :bass_foundation
              8.times do
                play dm_walk.tick, cutoff: 72, release: 0.6, amp: 0.9
                sleep 0.5
              end
            end
          end

          # Percussion: sparse kick/snare/hat
          in_thread do
            with_fx :hpf, cutoff: 90, mix: 1.0 do
              4.times do
                sample :drum_heavy_kick, amp: 1.4
                sample :drum_cymbal_closed, amp: 0.7
                sleep 0.5
                sample :hat_zild, amp: 0.6
                sleep 0.5
                sample :drum_snare_hard, amp: 1.1
                sample :hat_zild, amp: 0.5
                sleep 0.5
                sample :hat_zild, amp: 0.55
                sleep 0.5
              end
            end
          end

        end
      end
      sleep 0 # threads handle all timing above; outer sleep covered by 16x0.25=4 beats per pass
    end

    # =========================================================
    # TRANSITION 1: Dm -> counterpoint bridge
    # FM drone + cymbal swell + snare roll
    # =========================================================
    use_synth :fm
    play :d2, release: 8, cutoff: 88, divisor: 2, depth: 8, amp: 1.1

    in_thread do
      sample :drum_cymbal_open, amp: 1.0
      sample :drum_roll, amp: 0.9, rate: 1.2
      sleep 2
      sample :drum_snare_hard, amp: 1.1
      sample :hat_zild, amp: 0.7
      sleep 1
      sample :drum_heavy_kick, amp: 1.4
      sleep 1
    end

    sleep 4

    # =========================================================
    # SECTION 2: Dm Counterpoint — FM bass drone, chiplead runs, rhodey comping, fuller beat
    # Melody: chiplead | Harmony: hollow + rhodey + supersaw | Bass: tb303 + subpulse | Perc: fuller hybrid
    # =========================================================
    dm_counter = (ring :d4, :a4, :f4, :c5, :as4, :g4, :a4, :d5,
                       :c5, :as4, :a4, :g4, :f4, :e4, :d4, :f4,
                       :a4, :g4, :f4, :e4, :d4, :c5, :as4, :a4)
    counter_chords = (ring
      chord(:d3, :minor7),
      chord(:g3, :m7),
      chord(:c3, :major7),
      chord(:as3, :major7),
      chord(:a3, :m7),
      chord(:d3, :minor7)
    )
    dm_counter_bass = (ring :d2, :d2, :a2, :c3, :as2, :g2, :a2, :d2,
                            :c3, :as2, :a2, :g2, :f2, :e2, :a2, :f2,
                            :a2, :g2, :f2, :e2, :d2, :c3, :as2, :a2)
    cutoff_ramp2 = (line 90, 118, steps: 48)
    cutoff_ramp_s2 = (line 85, 108, steps: 12)

    2.times do
      # Long drones underneath
      use_synth :fm
      play :d2, release: 8, cutoff: 92, divisor: 2, depth: 12, amp: 0.9

      use_synth :hollow
      play_chord chord(:d2, :minor7), cutoff: 88, release: 8, amp: 0.72

      use_synth :subpulse
      play :d1, cutoff: 62, release: 6, amp: 1.0

      # Melody: chiplead counterpoint runs (24 steps = 6 beats)
      in_thread do
        use_synth :chiplead
        24.times do
          play dm_counter.tick, cutoff: cutoff_ramp2.tick, release: 0.10, amp: 1.9
          sleep 0.25
        end
      end

      # Harmony: rhodey + supersaw comping (6 bars of 2 beats each = 6 beats)
      in_thread do
        6.times do
          use_synth :rhodey
          play_chord counter_chords.tick, cutoff: cutoff_ramp_s2.tick, release: 1.6, amp: 0.8
          sleep 1
          use_synth :supersaw
          play_chord counter_chords.look, cutoff: 90, release: 0.9, amp: 0.55
          sleep 1
        end
      end

      # Bass: tb303 articulate walking line (24 steps)
      in_thread do
        use_synth :tb303
        24.times do
          play dm_counter_bass.tick, cutoff: 80, release: 0.45, wave: 0, amp: 0.95
          sleep 0.25
        end
      end

      # Percussion: fuller hybrid beat (3 bars x 4/4)
      in_thread do
        3.times do
          sample :drum_heavy_kick, amp: 1.5
          sample :drum_cymbal_closed, amp: 0.8
          sleep 0.25
          sample :hat_zild, amp: 0.5
          sleep 0.25
          sample :elec_snare, amp: 0.65 if one_in(3)
          sample :hat_zild, amp: 0.45
          sleep 0.25
          sample :hat_zild, amp: 0.5
          sleep 0.25
          sample :drum_snare_hard, amp: 1.2
          sample :elec_snare, amp: 0.7
          sleep 0.25
          sample :hat_zild, amp: 0.55
          sleep 0.25
          sample :drum_heavy_kick, amp: 1.0 if one_in(2)
          sample :hat_zild, amp: 0.45
          sleep 0.25
          sample :hat_zild, amp: 0.5
          sleep 0.25
          sample :drum_heavy_kick, amp: 1.3
          sample :drum_cymbal_closed, amp: 0.65
          sleep 0.25
          sample :hat_zild, amp: 0.5
          sleep 0.25
          sample :drum_roll, amp: 0.6, rate: 1.5, finish: 0.3 if one_in(3)
          sample :hat_zild, amp: 0.4
          sleep 0.25
          sample :hat_zild, amp: 0.5
          sleep 0.25
        end
      end

      sleep 6 # 24 steps x 0.25 = 6 beats
    end

    # =========================================================
    # TRANSITION 2: Key change to F — blade + hollow drone bridge + open cymbal
    # =========================================================
    use_synth :blade
    play :f3, release: 8, cutoff: 95, amp: 1.2

    use_synth :hollow
    play_chord chord(:f3, :major7), cutoff: 92, release: 8, amp: 0.9

    use_synth :bass_foundation
    play :f2, cutoff: 70, release: 8, amp: 1.1

    in_thread do
      sample :drum_cymbal_open, amp: 1.1
      sample :drum_roll, amp: 1.0, rate: 1.0, finish: 0.5
      sleep 2
      sample :drum_snare_hard, amp: 1.2
      sample :elec_snare, amp: 0.8
      sleep 1
      sample :drum_heavy_kick, amp: 1.4
      sleep 1
    end

    sleep 4

    # =========================================================
    # SECTION 3: F Major — Bright blade lead, supersaw + rhodey harmony, bass_foundation walk, full hybrid beat
    # Melody: blade | Harmony: hollow + supersaw + rhodey | Bass: bass_foundation + subpulse | Perc: full bright beat
    # =========================================================
    f_melody = (ring :f4, :a4, :c5, :e5, :d5, :c5, :a4, :g4,
                     :f4, :c5, :a4, :as4, :g4, :f4, :c5, :f5)
    f_chords = (ring
      chord(:f3, :major7),
      chord(:d3, :minor7),
      chord(:bb3, :major7),
      chord(:c3, '9')
    )
    f_walk = (ring :f2, :a2, :c3, :e3, :d3, :c3, :a2, :f2,
                   :f2, :c3, :a2, :as2, :g2, :f2, :c3, :f2)
    cutoff_ramp3 = (line 95, 125, steps: 32)
    cutoff_ramp_s3 = (line 92, 118, steps: 8)

    2.times do
      # Long drones underneath
      use_synth :fm
      play :f2, release: 8, cutoff: 95, divisor: 2, depth: 10, amp: 0.8

      use_synth :hollow
      play_chord chord(:f2, :major7), cutoff: 95, release: 8, amp: 0.78

      use_synth :subpulse
      play :f1, cutoff: 65, release: 8, amp: 1.05

      # Melody: blade bright F major runs with echo
      in_thread do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.22 do
          use_synth :blade
          16.times do
            play f_melody.tick, cutoff: cutoff_ramp3.tick, release: 0.13, amp: 1.85
            sleep 0.25
          end
        end
      end

      # Harmony: supersaw beat 1 + rhodey beat 3 (4 pairs = 4 bars)
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          4.times do
            use_synth :supersaw
            play_chord f_chords.tick, cutoff: cutoff_ramp_s3.tick, release: 1.9, amp: 0.8
            sleep 2
            use_synth :rhodey
            play_chord f_chords.look, cutoff: 100, release: 1.4, amp: 0.7
            sleep 2
          end
        end
      end

      # Bass: bass_foundation walking line in F major
      in_thread do
        use_synth :bass_foundation
        16.times do
          play f_walk.tick, cutoff: 78, release: 0.55, amp: 0.88
          sleep 0.25
        end
      end

      # Percussion: full bright hybrid beat
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.22 do
          4.times do
            sample :drum_heavy_kick, amp: 1.5
            sample :drum_cymbal_open, amp: 0.9
            sleep 0.25
            sample :hat_zild, amp: 0.65
            sleep 0.25
            sample :elec_snare, amp: 0.6 if one_in(3)
            sample :hat_zild, amp: 0.5
            sleep 0.25
            sample :hat_zild, amp: 0.55
            sleep 0.25
            sample :drum_snare_hard, amp: 1.3
            sample :elec_snare, amp: 0.75
            sleep 0.25
            sample :hat_zild, amp: 0.6
            sleep 0.25
            sample :drum_heavy_kick, amp: 1.0 if one_in(2)
            sample :hat_zild, amp: 0.5
            sleep 0.25
            sample :hat_zild, amp: 0.55
            sleep 0.25
          end
        end
      end

      sleep 4 # 16 steps x 0.25 = 4 beats
    end

  end
end