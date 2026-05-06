# Smooth Croon
# Style: Soul | Mood: Warm and intimate | Key: F → Bb | Time: 4/4 | BPM: 72

use_debug false
use_bpm 72

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================================
    # SECTION 1: Sparse opening — F major, intimate soul groove
    # Melody: blade lead | Harmony: rhodey/hollow pads
    # Bass: walking bass_foundation | Percussion: soft kick/snare/hat
    # =============================================================
    2.times do
      # --- Long drones underneath ---
      use_synth :blade
      play :f3, release: 16, cutoff: 85, amp: 0.38

      use_synth :hollow
      play_chord chord(:f3, :major7), cutoff: 88, release: 16, amp: 0.42

      use_synth :bass_foundation
      play :f2, cutoff: 68, release: 16, amp: 0.65

      # --- Melody: blade, F major soul phrasing ---
      melody_f = (ring :f4, :a4, :c5, :a4, :g4, :f4, :eb4, :d4,
                       :f4, :c5, :eb5, :c5, :bb4, :a4, :g4, :f4,
                       :a4, :c5, :d5, :c5, :bb4, :a4, :g4, :a4,
                       :f4, :g4, :a4, :bb4, :c5, :bb4, :a4, :g4)
      dur_f    = (ring 0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5,
                       0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5,
                       0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 1.0,
                       0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5)

      # --- Harmony chord cycle: Fmaj7 | Dm9 | Gm7 | C9 (2 bars each) ---
      harm_chords_1 = [
        chord(:f3, :major7), chord(:f3, :major7),
        chord(:d3, :m9),     chord(:d3, :m9),
        chord(:g3, :m7),     chord(:g3, :m7),
        chord(:c3, :9),      chord(:c3, :9)
      ]
      cutoff_line_1 = (line 82, 100, steps: 8)

      # --- Bass walking line in F major ---
      bass_walk_f = (ring :f2, :a2, :c3, :eb2,
                          :f2, :g2, :a2, :c2,
                          :f2, :c3, :bb2, :a2,
                          :g2, :a2, :bb2, :c3,
                          :f2, :a2, :c3, :d2,
                          :f2, :e2, :eb2, :d2,
                          :c3, :bb2, :a2, :g2,
                          :f2, :g2, :a2, :c3)

      # --- Run all parts together bar by bar (8 bars x 4 beats) ---
      with_fx :reverb, room: 0.28, mix: 0.3 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          with_fx :hpf, cutoff: 90, mix: 1.0 do
            8.times do |bar|
              # Harmony chord on beat 1 of each bar
              use_synth :rhodey
              play_chord harm_chords_1[bar], cutoff: cutoff_line_1.tick, release: 3.8, amp: 0.50

              4.times do |beat|
                # Melody note
                use_synth :blade
                play melody_f.tick, cutoff: rrand(82, 108), release: dur_f.look * 0.9, amp: 0.92
                mel_dur = dur_f.tick

                # Bass note (quarter-note pulse)
                use_synth :bass_foundation
                play bass_walk_f.tick, cutoff: rrand(65, 82), release: 0.7, amp: 0.68

                # Percussion
                if beat == 0
                  sample :drum_bass_soft, amp: 0.72
                  sample :drum_cymbal_closed, amp: 0.32, rate: 1.1
                elsif beat == 1 || beat == 3
                  sample :drum_snare_soft, amp: 0.58
                  sample :drum_cymbal_closed, amp: 0.26, rate: 1.05
                  sample :hat_tap, amp: 0.20 if one_in(3)
                else
                  sample :drum_bass_soft, amp: 0.52
                  sample :drum_cymbal_closed, amp: 0.28, rate: 1.1
                end

                sleep mel_dur
              end
            end
          end
        end
      end
    end

    # =============================================================
    # TRANSITION: F → Bb (drone bridge)
    # =============================================================
    use_synth :blade
    play :f3, cutoff: 90, release: 8, amp: 0.48
    use_synth :hollow
    play :f3, cutoff: 90, release: 8, amp: 0.38
    use_synth :bass_foundation
    play :f2, cutoff: 70, release: 8, amp: 0.62
    sample :drum_cymbal_closed, amp: 0.20
    sleep 1
    sample :drum_cymbal_closed, amp: 0.16
    sleep 1
    sample :drum_cymbal_closed, amp: 0.13
    sleep 1
    sample :drum_cymbal_closed, amp: 0.10
    sleep 1

    # =============================================================
    # SECTION 2: Groove opens — F major, winwood lead + eighth hats
    # Melody: winwood_lead with echo | Harmony: hollow maj9 + rhodey arpeggios
    # Bass: fm sub pulse | Percussion: eighth-note hi-hats added
    # =============================================================
    2.times do
      # --- Long drones underneath ---
      use_synth :winwood_lead
      play :f3, release: 16, cutoff: 88, amp: 0.33

      use_synth :hollow
      play_chord chord(:f3, :maj9), cutoff: 90, release: 16, amp: 0.40

      use_synth :fm
      play :f2, cutoff: 72, release: 16, divisor: 2, depth: 4, amp: 0.52

      # --- Melody: winwood_lead with echo ---
      melody_f2 = (ring :f4, :g4, :a4, :c5, :eb5, :c5, :bb4, :a4,
                        :g4, :f4, :a4, :c5, :d5, :c5, :bb4, :g4,
                        :f4, :a4, :bb4, :c5, :d5, :eb5, :d5, :c5,
                        :bb4, :a4, :g4, :a4, :c5, :bb4, :a4, :f4)
      dur_f2   = (ring 0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5,
                       0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1.0, 0.5,
                       0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5,
                       0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1.0)
      cutoff_mel2 = (line 88, 112, steps: 32)

      # --- Harmony arpeggio chords ---
      harm_chords_2 = [
        chord(:f3, :maj9),
        chord(:d3, :m9),
        chord(:g3, :m9),
        chord(:c3, '9')
      ]
      cutoff_harm2 = (line 88, 108, steps: 32)

      # --- Bass walking line in F major (section 2) ---
      bass_walk_f2 = (ring :f2, :c3, :bb2, :a2,
                           :g2, :a2, :bb2, :c3,
                           :f2, :eb2, :d2, :c2,
                           :f2, :g2, :a2, :bb2,
                           :c3, :bb2, :a2, :g2,
                           :f2, :a2, :c3, :eb2,
                           :d2, :c2, :bb1, :c2,
                           :f2, :c3, :bb2, :f2)

      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          # 32 eighth-note steps = 16 beats = 4 bars per repetition x 2 reps = 8 bars
          32.times do |i|
            # Melody
            use_synth :winwood_lead
            play melody_f2.tick, cutoff: cutoff_mel2.tick, release: dur_f2.look * 0.85, amp: 0.90
            mel_dur2 = dur_f2.tick

            # Harmony arpeggio
            use_synth :rhodey
            play harm_chords_2[i / 8].choose, cutoff: cutoff_harm2.look, release: 0.8, amp: 0.46

            # Bass (every other step = quarter note)
            if i.even?
              use_synth :fm
              play bass_walk_f2.tick, cutoff: rrand(68, 85), release: 0.75, divisor: 2, depth: 3, amp: 0.58
            end

            # Percussion (eighth-note grid, mel_dur = 0.5)
            beat_in_bar = i % 8
            if beat_in_bar == 0
              sample :drum_bass_soft, amp: 0.78
              sample :drum_cymbal_closed, amp: 0.36, rate: 1.1
            elsif beat_in_bar == 1
              sample :hat_tap, amp: 0.23
            elsif beat_in_bar == 2 || beat_in_bar == 6
              sample :drum_snare_soft, amp: 0.62
              sample :drum_cymbal_closed, amp: 0.28, rate: 1.05
            elsif beat_in_bar == 3 || beat_in_bar == 7
              sample :hat_tap, amp: 0.18 if one_in(2)
            elsif beat_in_bar == 4
              sample :drum_bass_soft, amp: 0.55
              sample :drum_cymbal_closed, amp: 0.30, rate: 1.1
            elsif beat_in_bar == 5
              sample :hat_tap, amp: 0.20 if one_in(2)
            end

            sleep mel_dur2
          end
        end
      end
    end

    # =============================================================
    # TRANSITION: F → Bb key change (drone bridge)
    # =============================================================
    use_synth :blade
    play :bb3, cutoff: 90, release: 8, amp: 0.50
    use_synth :hollow
    play :bb3, cutoff: 90, release: 8, amp: 0.42
    use_synth :bass_foundation
    play :bb1, cutoff: 70, release: 8, amp: 0.65
    sample :drum_cymbal_closed, amp: 0.20
    sleep 1
    sample :drum_cymbal_closed, amp: 0.16
    sleep 1
    sample :drum_cymbal_closed, amp: 0.13
    sleep 1
    sample :drum_cymbal_closed, amp: 0.10
    sleep 1

    # =============================================================
    # SECTION 3: Soul climax — Bb major, fuller groove
    # Melody: winwood_lead soars | Harmony: hollow/rhodey Bb voicings
    # Bass: walking bass in Bb | Percussion: stronger kick, ghost taps
    # =============================================================
    2.times do
      # --- Long drones underneath ---
      use_synth :blade
      play :bb3, release: 16, cutoff: 90, amp: 0.38

      use_synth :hollow
      play_chord chord(:bb3, :major7), cutoff: 92, release: 16, amp: 0.45

      use_synth :bass_foundation
      play :bb1, cutoff: 70, release: 16, amp: 0.68

      # --- Melody: winwood_lead in Bb major ---
      melody_bb = (ring :bb4, :d5, :f5, :d5, :c5, :bb4, :ab4, :g4,
                        :bb4, :f5, :ab5, :f5, :eb5, :d5, :c5, :bb4,
                        :d5, :f5, :g5, :f5, :eb5, :d5, :c5, :d5,
                        :bb4, :c5, :d5, :eb5, :f5, :eb5, :d5, :bb4)
      dur_bb    = (ring 0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5,
                        0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5,
                        0.5, 0.5, 1, 0.5, 0.5, 0.5, 0.5, 1.0,
                        0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5)

      # --- Harmony chord cycle: Bbmaj7 | Gm9 | Cm9 | F9 (2 bars each) ---
      harm_chords_3 = [
        chord(:bb3, :major7), chord(:bb3, :major7),
        chord(:g3, :m9),      chord(:g3, :m9),
        chord(:c4, :m9),      chord(:c4, :m9),
        chord(:f3, '9'),      chord(:f3, '9')
      ]
      cutoff_line_3 = (line 90, 110, steps: 8)

      # --- Bass walking line in Bb major ---
      bass_walk_bb = (ring :bb1, :d2, :f2, :ab1,
                           :bb1, :c2, :d2, :f2,
                           :bb1, :f2, :eb2, :d2,
                           :c2, :d2, :eb2, :f2,
                           :bb1, :d2, :f2, :g2,
                           :bb1, :ab1, :g1, :f1,
                           :eb2, :d2, :c2, :bb1,
                           :f2, :eb2, :d2, :bb1)

      with_fx :reverb, room: 0.3, mix: 0.28 do
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          with_fx :hpf, cutoff: 90, mix: 1.0 do
            8.times do |bar|
              # Harmony chord on beat 1
              use_synth :rhodey
              play_chord harm_chords_3[bar], cutoff: cutoff_line_3.tick, release: 3.8, amp: 0.52

              4.times do |beat|
                # Melody note
                use_synth :winwood_lead
                play melody_bb.tick, cutoff: rrand(90, 115), release: dur_bb.look * 0.88, amp: 0.95
                mel_dur_bb = dur_bb.tick

                # Bass note (quarter-note pulse)
                use_synth :bass_foundation
                play bass_walk_bb.tick, cutoff: rrand(68, 86), release: 0.72, amp: 0.70

                # Percussion (climax — fuller groove)
                if beat == 0
                  sample :drum_bass_soft, amp: 0.82
                  sample :drum_cymbal_closed, amp: 0.38, rate: 1.1
                  sample :hat_tap, amp: 0.26
                elsif beat == 1 || beat == 3
                  sample :drum_snare_soft, amp: 0.70
                  sample :drum_cymbal_closed, amp: 0.30, rate: 1.05
                  sample :hat_tap, amp: 0.22
                  sample :hat_tap, amp: 0.16 if one_in(4)
                else
                  sample :drum_bass_soft, amp: 0.60
                  sample :drum_cymbal_closed, amp: 0.33, rate: 1.1
                  sample :hat_tap, amp: 0.23 if one_in(2)
                end

                sleep mel_dur_bb
              end
            end
          end
        end
      end
    end

    # =============================================================
    # FINAL RESOLUTION: Bb — gentle fade out
    # =============================================================
    use_synth :blade
    play :bb3, cutoff: 88, release: 8, amp: 0.42
    use_synth :hollow
    play_chord chord(:bb3, :major7), cutoff: 88, release: 8, amp: 0.42
    use_synth :bass_foundation
    play :bb1, cutoff: 68, release: 8, amp: 0.62

    # Soft hi-hat fade
    8.times do
      sample :drum_cymbal_closed, amp: 0.16
      sleep 0.5
      sample :hat_tap, amp: 0.10 if one_in(2)
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.13
      sleep 0.5
      sample :hat_tap, amp: 0.08 if one_in(3)
      sleep 0.5
    end

  end
end