# Feed the Birds EDM Remix
# Style: Uplifting EDM, lush pads, four-on-the-floor, progressive build
# Key: D major -> F major | BPM: 128 | Time: 4/4

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =========================================================
    # SECTION 1: INTRO — D major | Supersaw lead, blade/hollow
    # harmony, subpulse/tb303 bass, clean four-on-the-floor
    # =========================================================
    d_melody    = (ring :d4, :fs4, :a4, :d5, :cs5, :a4, :fs4, :e4,
                        :d4, :e4, :fs4, :a4, :b4, :a4, :fs4, :d4)
    d_cutoff    = (line 85, 115, steps: 16)
    intro_chords = (ring chord(:d3, :major), chord(:b2, :minor),
                        chord(:g2, :major), chord(:a2, :major))
    intro_hcutoff = (line 82, 102, steps: 8)
    d_bass_notes = (ring :d2, :a2, :fs2, :a2)
    d_stab_notes = (ring :d2, :a2, :d2, :fs2, :a2, :d2, :fs2, :e2)

    2.times do
      # --- Melody drones ---
      use_synth :supersaw
      play :d2, release: 16, cutoff: 80, amp: 0.35
      use_synth :supersaw
      play :a2, release: 16, cutoff: 75, amp: 0.25

      # --- Harmony drone ---
      use_synth :hollow
      play_chord chord(:d2, :major), cutoff: 85, release: 16, amp: 0.4

      # --- Bass sustained root ---
      use_synth :bass_foundation
      play :d1, cutoff: 65, release: 16, amp: 0.55

      # --- Melody thread ---
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.28 do
            use_synth :supersaw
            16.times do
              play d_melody.tick, cutoff: d_cutoff.tick, release: 0.18, amp: 0.95
              sleep 0.5
            end
          end
        end
      end

      # --- Harmony thread ---
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          with_fx :lpf, cutoff: 100, mix: 1.0 do
            4.times do
              use_synth :blade
              play_chord intro_chords.tick, cutoff: intro_hcutoff.tick, release: 1.6, amp: 0.5
              sleep 1.0
              use_synth :blade
              play_chord intro_chords.look, cutoff: intro_hcutoff.look + 8, release: 0.8, amp: 0.35
              sleep 1.0
              use_synth :blade
              play_chord intro_chords.look, cutoff: intro_hcutoff.look, release: 1.4, amp: 0.42
              sleep 1.0
              use_synth :blade
              play_chord intro_chords.look, cutoff: intro_hcutoff.look + 6, release: 0.7, amp: 0.32
              sleep 1.0
            end
          end
        end
      end

      # --- Bass thread ---
      in_thread do
        with_fx :lpf, cutoff: 82, mix: 1.0 do
          4.times do
            use_synth :subpulse
            play d_bass_notes.tick, cutoff: 78, release: 0.9, amp: 0.72
            sleep 1
            use_synth :tb303
            play d_stab_notes.tick, cutoff: 72, res: 0.8, release: 0.35, amp: 0.52
            sleep 0.5
            use_synth :subpulse
            play d_bass_notes.look, cutoff: 70, release: 0.45, amp: 0.52
            sleep 0.5
            use_synth :subpulse
            play d_bass_notes.look, cutoff: 76, release: 0.85, amp: 0.62
            sleep 1
            use_synth :tb303
            play d_stab_notes.tick, cutoff: 70, res: 0.82, release: 0.3, amp: 0.5
            sleep 0.5
            use_synth :subpulse
            play :a1, cutoff: 68, release: 0.4, amp: 0.48
            sleep 0.5
          end
        end
      end

      # --- Percussion thread ---
      in_thread do
        with_fx :hpf, cutoff: 90, mix: 1.0 do
          4.times do
            sample :bd_haus, amp: 0.7
            sample :hat_zild, amp: 0.32
            sleep 0.5
            sample :hat_cats, amp: 0.22
            sleep 0.5
            sample :bd_haus, amp: 0.55
            sample :drum_snare_hard, amp: 0.5
            sample :hat_zild, amp: 0.25
            sleep 0.5
            sample :hat_cats, amp: 0.2
            sleep 0.5
            sample :bd_haus, amp: 0.65
            sample :hat_zild, amp: 0.28
            sleep 0.25
            sample :hat_cats, amp: 0.18
            sleep 0.25
            sample :hat_cats, amp: 0.16
            sleep 0.5
            sample :drum_snare_hard, amp: 0.5
            sample :hat_zild, amp: 0.25
            sample :elec_blip2, amp: 0.18 if one_in(3)
            sleep 0.5
            sample :hat_cats, amp: 0.2
            sleep 0.5
          end
        end
      end

      sleep 8
    end

    # =========================================================
    # TRANSITION 1: D -> F key change bridge drone
    # =========================================================
    use_synth :supersaw
    play :f2, cutoff: 88, release: 8, amp: 0.5
    use_synth :supersaw
    play :c3, cutoff: 82, release: 8, amp: 0.38
    use_synth :hollow
    play_chord chord(:f3, :major), cutoff: 88, release: 8, amp: 0.45
    use_synth :bass_foundation
    play :f1, cutoff: 68, release: 8, amp: 0.6

    in_thread do
      with_fx :reverb, room: 0.25, mix: 0.22 do
        8.times do
          sample :drum_snare_hard, amp: 0.4
          sample :hat_cats, amp: 0.28
          sleep 0.5
        end
      end
    end

    sleep 4

    # =========================================================
    # SECTION 2: BUILD — F major | Winwood_lead melody, rhodey
    # harmony, trance bass, busier hi-hat patterns
    # =========================================================
    f_melody     = (ring :f4, :a4, :c5, :f5, :e5, :c5, :a4, :g4,
                         :f4, :g4, :a4, :c5, :d5, :c5, :a4, :f4)
    f_cutoff     = (line 88, 118, steps: 16)
    build_chords = (ring chord(:f3, :major), chord(:d3, :minor),
                        chord(:as2, :major), chord(:c3, :major))
    build_hcutoff = (line 86, 108, steps: 8)
    f_bass_ring  = (ring :f2, :c2, :a2, :c2)
    f_stab_ring  = (ring :f2, :c2, :f2, :a2, :c2, :f2, :a2, :g2)

    2.times do
      # --- Melody drones ---
      use_synth :winwood_lead
      play :f2, release: 16, cutoff: 85, amp: 0.3
      use_synth :winwood_lead
      play :c3, release: 16, cutoff: 80, amp: 0.22

      # --- Harmony drone ---
      use_synth :hollow
      play_chord chord(:f2, :major), cutoff: 88, release: 16, amp: 0.4

      # --- Bass sustained root ---
      use_synth :bass_foundation
      play :f1, cutoff: 67, release: 16, amp: 0.58

      # --- Melody thread ---
      in_thread do
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
          use_synth :winwood_lead
          16.times do
            play f_melody.tick, cutoff: f_cutoff.tick, release: 0.2, amp: 0.95
            sleep 0.5
          end
        end
      end

      # --- Harmony thread ---
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.35 do
          4.times do
            use_synth :rhodey
            play_chord build_chords.tick, cutoff: build_hcutoff.tick, release: 1.8, amp: 0.52
            sleep 1.0
            use_synth :rhodey
            play_chord build_chords.look, cutoff: build_hcutoff.look + 10, release: 0.9, amp: 0.38
            sleep 1.0
            use_synth :rhodey
            play_chord build_chords.look, cutoff: build_hcutoff.look + 4, release: 1.5, amp: 0.47
            sleep 1.0
            use_synth :rhodey
            play_chord build_chords.look, cutoff: build_hcutoff.look + 8, release: 0.8, amp: 0.35
            sleep 1.0
          end
        end
      end

      # --- Bass thread ---
      in_thread do
        4.times do
          use_synth :subpulse
          play f_bass_ring.tick, cutoff: 80, release: 0.9, amp: 0.72
          sleep 0.75
          use_synth :tb303
          play f_stab_ring.tick, cutoff: 74, res: 0.85, release: 0.25, amp: 0.48
          sleep 0.25
          use_synth :subpulse
          play f_bass_ring.look, cutoff: 76, release: 0.7, amp: 0.58
          sleep 0.5
          use_synth :tb303
          play f_stab_ring.look, cutoff: 72, res: 0.8, release: 0.2, amp: 0.45
          sleep 0.5
          use_synth :subpulse
          play f_bass_ring.look, cutoff: 78, release: 0.88, amp: 0.65
          sleep 0.75
          use_synth :tb303
          play f_stab_ring.tick, cutoff: 73, res: 0.83, release: 0.22, amp: 0.48
          sleep 0.25
          use_synth :subpulse
          play :c2, cutoff: 74, release: 0.5, amp: 0.52
          sleep 0.5
          use_synth :tb303
          play f_stab_ring.tick, cutoff: 71, res: 0.81, release: 0.2, amp: 0.45
          sleep 0.5
        end
      end

      # --- Percussion thread ---
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.72
          sample :drum_cymbal_open, amp: 0.28
          sleep 0.25
          sample :hat_cats, amp: 0.25
          sleep 0.25
          sample :hat_zild, amp: 0.27
          sleep 0.25
          sample :hat_cats, amp: 0.2
          sleep 0.25
          sample :bd_haus, amp: 0.58
          sample :drum_snare_hard, amp: 0.55
          sample :hat_zild, amp: 0.27
          sleep 0.25
          sample :hat_cats, amp: 0.22
          sleep 0.25
          sample :hat_cats, amp: 0.2
          sleep 0.25
          sample :hat_cats, amp: 0.18
          sleep 0.25
          sample :bd_haus, amp: 0.67
          sample :hat_zild, amp: 0.27
          sample :elec_blip2, amp: 0.2 if one_in(3)
          sleep 0.25
          sample :hat_cats, amp: 0.22
          sleep 0.25
          sample :hat_zild, amp: 0.25
          sleep 0.25
          sample :hat_cats, amp: 0.18
          sleep 0.25
          sample :drum_snare_hard, amp: 0.55
          sample :drum_cymbal_open, amp: 0.25
          sleep 0.25
          sample :hat_cats, amp: 0.25
          sleep 0.25
          sample :hat_cats, amp: 0.22
          sleep 0.25
          sample :hat_cats, amp: 0.2
          sleep 0.25
        end
      end

      sleep 8
    end

    # =========================================================
    # TRANSITION 2: Build -> Drop bridge drone
    # =========================================================
    use_synth :supersaw
    play :f2, cutoff: 92, release: 8, amp: 0.55
    use_synth :supersaw
    play :a2, cutoff: 86, release: 8, amp: 0.38
    use_synth :blade
    play_chord chord(:f3, :major), cutoff: 92, release: 8, amp: 0.45
    use_synth :subpulse
    play :f1, cutoff: 72, release: 8, amp: 0.65

    in_thread do
      4.times do
        sample :elec_cymbal, amp: 0.4
        sample :hat_cats, amp: 0.32
        sleep 0.25
        sample :drum_snare_hard, amp: 0.45
        sample :hat_cats, amp: 0.27
        sleep 0.25
        sample :hat_cats, amp: 0.25
        sleep 0.25
        sample :hat_cats, amp: 0.22
        sleep 0.25
      end
    end

    sleep 4

    # =========================================================
    # SECTION 3: DROP — F major | Chiplead high-energy melody,
    # blade+rhodey+hollow harmony, dense bass, 16th-note hats
    # =========================================================
    drop_melody   = (ring :f5, :e5, :d5, :c5, :a4, :c5, :d5, :f5,
                          :g5, :f5, :e5, :d5, :c5, :a4, :c5, :f5)
    drop_cutoff   = (line 95, 125, steps: 16)
    drop_chords   = (ring chord(:f3, :major), chord(:c3, :major),
                         chord(:d3, :minor), chord(:as2, :major))
    drop_hcutoff  = (line 90, 115, steps: 8)
    drop_bass_ring = (ring :f2, :f2, :c2, :a2)
    drop_stab_ring = (ring :f2, :c2, :a2, :f2, :g2, :c2, :a2, :f2)

    2.times do
      # --- Melody drones ---
      use_synth :supersaw
      play :f2, release: 16, cutoff: 90, amp: 0.38
      use_synth :supersaw
      play :c3, release: 16, cutoff: 85, amp: 0.28
      use_synth :supersaw
      play :a3, release: 16, cutoff: 80, amp: 0.2

      # --- Harmony drones ---
      use_synth :hollow
      play_chord chord(:f2, :major), cutoff: 90, release: 16, amp: 0.45
      use_synth :blade
      play_chord chord(:f3, :major), cutoff: 92, release: 16, amp: 0.35

      # --- Bass sustained roots ---
      use_synth :bass_foundation
      play :f1, cutoff: 70, release: 16, amp: 0.65
      use_synth :bass_foundation
      play :c2, cutoff: 65, release: 16, amp: 0.45

      # --- Melody thread ---
      in_thread do
        with_fx :lpf, cutoff: 118, mix: 1.0 do
          use_synth :chiplead
          16.times do
            play drop_melody.tick, cutoff: drop_cutoff.tick, release: 0.15, amp: 1.0
            sleep 0.5
          end
        end
      end

      # --- Harmony thread ---
      in_thread do
        with_fx :lpf, cutoff: 108, mix: 1.0 do
          4.times do
            use_synth :rhodey
            play_chord drop_chords.tick, cutoff: drop_hcutoff.tick, release: 1.6, amp: 0.55
            sleep 0.5
            use_synth :rhodey
            play_chord drop_chords.look, cutoff: drop_hcutoff.look + 12, release: 0.5, amp: 0.38
            sleep 0.5
            use_synth :rhodey
            play_chord drop_chords.look, cutoff: drop_hcutoff.look + 6, release: 1.2, amp: 0.47
            sleep 0.5
            use_synth :rhodey
            play_chord drop_chords.look, cutoff: drop_hcutoff.look + 9, release: 0.5, amp: 0.35
            sleep 0.5
            use_synth :rhodey
            play_chord drop_chords.look, cutoff: drop_hcutoff.look + 4, release: 1.4, amp: 0.52
            sleep 0.5
            use_synth :rhodey
            play_chord drop_chords.look, cutoff: drop_hcutoff.look + 10, release: 0.5, amp: 0.37
            sleep 0.5
            use_synth :rhodey
            play_chord drop_chords.look, cutoff: drop_hcutoff.look + 7, release: 1.1, amp: 0.45
            sleep 0.5
            use_synth :rhodey
            play_chord drop_chords.look, cutoff: drop_hcutoff.look + 14, release: 0.5, amp: 0.33
            sleep 0.5
          end
        end
      end

      # --- Bass thread ---
      in_thread do
        4.times do
          use_synth :subpulse
          play drop_bass_ring.tick, cutoff: 82, release: 0.85, amp: 0.75
          sleep 0.5
          use_synth :tb303
          play drop_stab_ring.tick, cutoff: 76, res: 0.85, release: 0.18, amp: 0.5
          sleep 0.25
          use_synth :subpulse
          play :f1, cutoff: 68, release: 0.2, amp: 0.42
          sleep 0.25
          use_synth :subpulse
          play drop_bass_ring.look, cutoff: 79, release: 0.8, amp: 0.65
          sleep 0.5
          use_synth :tb303
          play drop_stab_ring.tick, cutoff: 74, res: 0.83, release: 0.15, amp: 0.48
          sleep 0.5
          use_synth :subpulse
          play drop_bass_ring.look, cutoff: 81, release: 0.82, amp: 0.68
          sleep 0.5
          use_synth :tb303
          play drop_stab_ring.tick, cutoff: 75, res: 0.84, release: 0.15, amp: 0.48
          sleep 0.25
          use_synth :tb303
          play drop_stab_ring.look, cutoff: 73, res: 0.82, release: 0.12, amp: 0.44
          sleep 0.25
          use_synth :subpulse
          play :c2, cutoff: 77, release: 0.75, amp: 0.58
          sleep 0.5
          use_synth :tb303
          play drop_stab_ring.tick, cutoff: 72, res: 0.8, release: 0.15, amp: 0.46
          sleep 0.5
        end
      end

      # --- Percussion thread ---
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.82
          sample :elec_cymbal, amp: 0.35
          sleep 0.25
          sample :hat_cats, amp: 0.35
          sleep 0.25
          sample :hat_zild, amp: 0.3
          sleep 0.25
          sample :hat_cats, amp: 0.27
          sleep 0.25
          sample :bd_haus, amp: 0.62
          sample :drum_snare_hard, amp: 0.62
          sample :hat_zild, amp: 0.32
          sleep 0.25
          sample :hat_cats, amp: 0.28
          sleep 0.25
          sample :hat_cats, amp: 0.25
          sleep 0.25
          sample :elec_blip2, amp: 0.25
          sample :hat_cats, amp: 0.22
          sleep 0.25
          sample :bd_haus, amp: 0.75
          sample :drum_cymbal_open, amp: 0.32
          sleep 0.25
          sample :hat_cats, amp: 0.32
          sleep 0.25
          sample :hat_zild, amp: 0.28
          sleep 0.25
          sample :hat_cats, amp: 0.25
          sleep 0.25
          sample :drum_snare_hard, amp: 0.62
          sample :elec_cymbal, amp: 0.32
          sleep 0.25
          sample :hat_cats, amp: 0.32
          sleep 0.25
          sample :hat_zild, amp: 0.28
          sleep 0.25
          sample :hat_cats, amp: 0.27
          sleep 0.25
        end
      end

      sleep 8
    end

  end
end