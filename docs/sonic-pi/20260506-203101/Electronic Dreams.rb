# Electronic Dreams
# Style: Dreamy electronic ambient | Mood: Atmospheric and evolving

use_debug false
use_bpm 120

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =========================================================
    # SECTION 1: Dreamy Am Opening — chiplead melody, hollow pads, subpulse bass, light beat
    # =========================================================
    melody_am = (ring :a4, :c5, :e5, :g5, :a5, :g5, :e5, :c5,
                      :a4, :e5, :c5, :a4, :g4, :a4, :c5, :e5)
    cutoff_ramp_s1 = (line 80, 115, steps: 32)
    am7_chords = [chord(:a2, :m7), chord(:e2, :m7), chord(:d2, :madd9), chord(:e2, :m7)]
    cutoff_s1 = (line 82, 100, steps: 8)

    2.times do
      # Melody drone
      use_synth :blade
      play :a2, release: 16, cutoff: 80, amp: 0.4

      # Harmony drone
      use_synth :dark_ambience
      play_chord am7_chords[0], cutoff: 85, release: 16, amp: 0.5

      # Bass sustained root
      use_synth :subpulse
      play :a1, cutoff: 70, release: 8, amp: 0.7

      in_thread do
        # Melody: chiplead lead
        with_fx :reverb, room: 0.25, mix: 0.3 do
          with_fx :lpf, cutoff: 110, mix: 1.0 do
            use_synth :chiplead
            16.times do
              play melody_am.tick, release: 0.18, cutoff: cutoff_ramp_s1.tick, amp: 1.0
              sleep 0.5
            end
          end
        end
      end

      in_thread do
        # Harmony: hollow pads
        with_fx :reverb, room: 0.3, mix: 0.35 do
          with_fx :lpf, cutoff: 95, mix: 1.0 do
            4.times do
              idx = tick % 4
              use_synth :hollow
              play_chord am7_chords[idx], cutoff: cutoff_s1.look, release: 4.2, amp: 0.55
              cutoff_s1.tick
              use_synth :fm
              play chord(:a2, :m7).choose, cutoff: 88, release: 3.8, divisor: 2, depth: 3, amp: 0.35
              sleep 2
            end
          end
        end
      end

      in_thread do
        # Bass: subpulse walking pattern
        4.times do
          use_synth :subpulse
          play :a2, cutoff: 72, release: 0.9, amp: 0.75
          sleep 1
          play :a2, cutoff: 65, release: 0.5, amp: 0.5
          sleep 0.5
          play :e2, cutoff: 68, release: 0.7, amp: 0.6
          sleep 0.5
          play :a2, cutoff: 65, release: 0.5, amp: 0.5
          sleep 1
          play :c2, cutoff: 68, release: 0.6, amp: 0.55
          sleep 0.5
          play :e2, cutoff: 65, release: 0.5, amp: 0.5
          sleep 0.5
        end
      end

      # Percussion: light dreamy four-on-the-floor
      with_fx :hpf, cutoff: 90, mix: 1.0 do
        4.times do
          sample :bd_haus, amp: 0.7
          sample :hat_zild, amp: 0.22
          sleep 0.25
          sample :hat_zild, amp: 0.15
          sleep 0.25
          sample :elec_snare, amp: 0.5
          sample :hat_zild, amp: 0.2
          sleep 0.25
          sample :hat_zild, amp: 0.13
          sleep 0.25
          sample :bd_haus, amp: 0.6
          sample :hat_zild, amp: 0.22
          sleep 0.25
          sample :hat_zild, amp: 0.15
          sleep 0.25
          sample :elec_snare, amp: 0.45
          sample :hat_zild, amp: 0.2
          sleep 0.25
          sample :hat_cats, amp: 0.18 if one_in(4)
          sleep 0.25
        end
      end
    end

    # --- Transition: Am -> Am build ---
    use_synth :blade
    play :a2, cutoff: 85, release: 8, amp: 0.5
    sleep 4

    # =========================================================
    # SECTION 2: Am Build — supersaw melody, fm pads, tb303 bass, tighter beat
    # =========================================================
    melody_am2 = (ring :e5, :a5, :g5, :e5, :c5, :a4, :b4, :c5,
                       :e5, :g5, :a5, :g5, :e5, :c5, :a4, :e4)
    cutoff_ramp_s2 = (line 85, 120, steps: 32)
    am_build_chords = [chord(:a2, :m9), chord(:f2, :major7), chord(:e2, :m7), chord(:d2, :madd9)]
    cutoff_s2 = (line 85, 108, steps: 8)

    2.times do
      # Melody drone
      use_synth :blade
      play :a2, release: 16, cutoff: 80, amp: 0.35

      # Harmony drone
      use_synth :dark_ambience
      play_chord am_build_chords[0], cutoff: 88, release: 16, amp: 0.5

      # Bass sustained
      use_synth :tb303
      play :a1, cutoff: 75, res: 0.8, release: 8, amp: 0.6

      in_thread do
        # Melody: supersaw with echo
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
          use_synth :supersaw
          16.times do
            play melody_am2.tick, release: 0.22, cutoff: cutoff_ramp_s2.tick, amp: 0.9
            sleep 0.5
          end
        end
      end

      in_thread do
        # Harmony: hollow + fm pads
        4.times do
          idx = tick % 4
          use_synth :hollow
          play_chord am_build_chords[idx], cutoff: cutoff_s2.look, release: 4.2, amp: 0.55
          cutoff_s2.tick
          use_synth :fm
          play am_build_chords[idx].choose, cutoff: 92, release: 3.6, divisor: 3, depth: 4, amp: 0.32
          sleep 2
        end
      end

      in_thread do
        # Bass: tb303 walking line
        with_fx :lpf, cutoff: 85, mix: 1.0 do
          am_bass = (ring :a2, :a2, :e2, :g2, :a2, :e2, :a2, :c2)
          cutoff_walk = (line 68, 85, steps: 8)
          8.times do
            use_synth :tb303
            play am_bass.tick, cutoff: cutoff_walk.tick, res: 0.82, release: 0.85, amp: 0.7
            sleep 1
          end
        end
      end

      # Percussion: tighter with ghost hits
      4.times do
        sample :bd_haus, amp: 0.8
        sample :hat_zild, amp: 0.28
        sleep 0.25
        sample :hat_cats, amp: 0.18
        sleep 0.25
        sample :elec_snare, amp: 0.55
        sample :hat_zild, amp: 0.25
        sleep 0.25
        sample :elec_hi_snare, amp: 0.22 if one_in(3)
        sample :hat_cats, amp: 0.16
        sleep 0.25
        sample :bd_haus, amp: 0.7
        sample :hat_zild, amp: 0.28
        sleep 0.25
        sample :hat_cats, amp: 0.18
        sleep 0.25
        sample :elec_snare, amp: 0.52
        sample :hat_zild, amp: 0.25
        sleep 0.25
        sample :elec_blip, amp: 0.2, rate: 1.5 if one_in(4)
        sample :hat_cats, amp: 0.16
        sleep 0.25
      end
    end

    # --- Transition: Am -> Cm key change ---
    use_synth :blade
    play :c3, cutoff: 85, release: 8, amp: 0.55
    use_synth :dark_ambience
    play_chord chord(:c2, :m7), cutoff: 80, release: 8, amp: 0.45
    use_synth :subpulse
    play :c2, cutoff: 78, release: 8, amp: 0.6
    # Sparse transitional beat
    sample :bd_haus, amp: 0.65
    sleep 0.5
    sample :elec_hi_snare, amp: 0.32
    sleep 0.5
    sample :bd_haus, amp: 0.6
    sleep 0.5
    sample :elec_snare, amp: 0.45
    sleep 0.5
    sample :elec_blip, amp: 0.28, rate: 2.0
    sleep 1.0
    sample :hat_zild, amp: 0.22
    sleep 0.5
    sample :hat_cats, amp: 0.18
    sleep 0.5

    # =========================================================
    # SECTION 3: Cm Key Change — chiplead melody, hollow pads, bass_foundation, fuller beat
    # =========================================================
    melody_cm = (ring :c5, :eb5, :g5, :bb5, :ab5, :g5, :eb5, :c5,
                      :c5, :g5, :eb5, :bb4, :ab4, :bb4, :c5, :eb5)
    cutoff_ramp_s3 = (line 80, 120, steps: 32)
    cm_chords = [chord(:c2, :m7), chord(:ab2, :major7), chord(:bb2, :dom7), chord(:g2, :m7)]
    cutoff_s3 = (line 80, 105, steps: 8)

    2.times do
      # Melody drone
      use_synth :blade
      play :c2, release: 16, cutoff: 80, amp: 0.4

      # Harmony drone
      use_synth :dark_ambience
      play_chord cm_chords[0], cutoff: 84, release: 16, amp: 0.5

      # Bass sustained root
      use_synth :bass_foundation
      play :c2, cutoff: 72, release: 8, amp: 0.7

      in_thread do
        # Melody: chiplead with reverb
        with_fx :reverb, room: 0.28, mix: 0.25 do
          with_fx :lpf, cutoff: 115, mix: 1.0 do
            use_synth :chiplead
            16.times do
              play melody_cm.tick, release: 0.18, cutoff: cutoff_ramp_s3.tick, amp: 1.0
              sleep 0.5
            end
          end
        end
      end

      in_thread do
        # Harmony: hollow + fm pads
        with_fx :reverb, room: 0.3, mix: 0.35 do
          with_fx :lpf, cutoff: 98, mix: 1.0 do
            4.times do
              idx = tick % 4
              use_synth :hollow
              play_chord cm_chords[idx], cutoff: cutoff_s3.look, release: 4.2, amp: 0.55
              cutoff_s3.tick
              use_synth :fm
              play cm_chords[idx].choose, cutoff: 86, release: 3.8, divisor: 2, depth: 3, amp: 0.33
              sleep 2
            end
          end
        end
      end

      in_thread do
        # Bass: bass_foundation walking pattern
        4.times do
          use_synth :bass_foundation
          play :c2, cutoff: 74, release: 0.9, amp: 0.75
          sleep 1
          play :c2, cutoff: 66, release: 0.5, amp: 0.5
          sleep 0.5
          play :g2, cutoff: 70, release: 0.7, amp: 0.6
          sleep 0.5
          play :c2, cutoff: 66, release: 0.5, amp: 0.5
          sleep 1
          play :eb2, cutoff: 68, release: 0.6, amp: 0.55
          sleep 0.5
          play :g2, cutoff: 66, release: 0.5, amp: 0.5
          sleep 0.5
        end
      end

      # Percussion: fuller driven pattern
      with_fx :reverb, room: 0.25, mix: 0.2 do
        4.times do
          sample :bd_haus, amp: 0.85
          sample :hat_zild, amp: 0.3
          sleep 0.25
          sample :hat_cats, amp: 0.2
          sleep 0.25
          sample :elec_snare, amp: 0.6
          sample :hat_zild, amp: 0.25
          sleep 0.25
          sample :elec_hi_snare, amp: 0.25 if one_in(3)
          sample :hat_cats, amp: 0.18
          sleep 0.25
          sample :bd_haus, amp: 0.72
          sample :hat_zild, amp: 0.3
          sleep 0.25
          sample :hat_cats, amp: 0.2
          sleep 0.25
          sample :elec_snare, amp: 0.58
          sample :hat_zild, amp: 0.25
          sleep 0.25
          sample :elec_blip, amp: 0.22, rate: 1.2 if one_in(4)
          sample :hat_cats, amp: 0.18
          sleep 0.25
        end
      end
    end

    # --- Transition: Cm section -> Cm finale ---
    use_synth :blade
    play :c3, cutoff: 88, release: 8, amp: 0.5
    use_synth :dark_ambience
    play_chord chord(:c2, :m7), cutoff: 82, release: 8, amp: 0.45
    sleep 4

    # =========================================================
    # SECTION 4: Cm Finale — supersaw melody, evolving pads, tb303 bass, driving beat
    # =========================================================
    melody_cm2 = (ring :g5, :eb5, :c5, :bb4, :ab4, :g4, :eb5, :c5,
                       :g5, :ab5, :g5, :eb5, :c5, :g4, :ab4, :c5)
    cutoff_ramp_s4 = (line 90, 110, steps: 32)
    cm_finale_chords = [chord(:c2, :madd9), chord(:ab2, :major7), chord(:eb2, :major7), chord(:bb2, :add9)]
    cutoff_s4 = (line 88, 112, steps: 8)

    2.times do
      # Melody drone
      use_synth :blade
      play :c2, release: 16, cutoff: 80, amp: 0.4

      # Harmony drone
      use_synth :dark_ambience
      play_chord cm_finale_chords[0], cutoff: 86, release: 16, amp: 0.5

      # Bass sustained root
      use_synth :tb303
      play :c1, cutoff: 68, res: 0.85, release: 8, amp: 0.6

      in_thread do
        # Melody: supersaw with echo
        with_fx :echo, phase: 0.375, decay: 1.8, mix: 0.22 do
          use_synth :supersaw
          16.times do
            play melody_cm2.tick, release: 0.2, cutoff: cutoff_ramp_s4.tick, amp: 0.92
            sleep 0.5
          end
        end
      end

      in_thread do
        # Harmony: hollow + fm evolving pads
        4.times do
          idx = tick % 4
          use_synth :hollow
          play_chord cm_finale_chords[idx], cutoff: cutoff_s4.look, release: 4.2, amp: 0.52
          cutoff_s4.tick
          use_synth :fm
          play cm_finale_chords[idx].choose, cutoff: 90, release: 3.5, divisor: 2.5, depth: 3.5, amp: 0.3
          sleep 2
        end
      end

      in_thread do
        # Bass: tb303 walking line descending
        cm_bass = (ring :c2, :eb2, :g2, :bb2, :ab2, :g2, :eb2, :c2)
        cutoff_drop = (line 82, 65, steps: 8)
        8.times do
          use_synth :tb303
          play cm_bass.tick, cutoff: cutoff_drop.tick, res: 0.80, release: 0.9, amp: 0.68
          sleep 1
        end
      end

      # Percussion: driving four-on-the-floor with fills
      4.times do
        sample :bd_haus, amp: 0.88
        sample :hat_zild, amp: 0.32
        sleep 0.25
        sample :hat_cats, amp: 0.22
        sleep 0.25
        sample :elec_snare, amp: 0.65
        sample :hat_zild, amp: 0.28
        sleep 0.25
        sample :elec_hi_snare, amp: 0.28 if one_in(3)
        sample :hat_cats, amp: 0.2
        sleep 0.25
        sample :bd_haus, amp: 0.75
        sample :hat_zild, amp: 0.32
        sleep 0.25
        sample :elec_blip, amp: 0.25, rate: 1.8 if one_in(5)
        sample :hat_cats, amp: 0.22
        sleep 0.25
        sample :elec_snare, amp: 0.62
        sample :hat_zild, amp: 0.28
        sleep 0.25
        sample :elec_hi_snare, amp: 0.28 if one_in(3)
        sample :elec_blip, amp: 0.25, rate: 2.0 if one_in(4)
        sample :hat_cats, amp: 0.2
        sleep 0.25
      end
    end

    # =========================================================
    # OUTRO: Fade into silence — sustained drones, simple beat
    # =========================================================
    use_synth :blade
    play :c3, cutoff: 65, release: 10, amp: 0.4
    use_synth :dark_ambience
    play_chord chord(:c2, :m7), cutoff: 68, release: 10, amp: 0.38
    use_synth :hollow
    play_chord chord(:c3, :madd9), cutoff: 72, release: 8, amp: 0.32
    use_synth :subpulse
    play :c1, cutoff: 62, release: 8, amp: 0.5

    4.times do
      2.times do
        sample :bd_haus, amp: 0.55
        sample :hat_zild, amp: 0.18
        sleep 0.5
        sample :elec_snare, amp: 0.4
        sample :hat_cats, amp: 0.15
        sleep 0.5
        sample :bd_haus, amp: 0.5
        sample :hat_zild, amp: 0.15
        sleep 0.5
        sample :elec_snare, amp: 0.38
        sleep 0.5
      end
    end

  end
end