# Java User Group Dance Anthem
# Style: Energetic Electronic | Mood: Driving, High-Energy Techno-House
# Key: A major → B major | BPM: 128 | Time: 4/4

use_debug false
use_bpm 128

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ============================================================
    # SECTION 1: Intro — Key of A major
    # Melody: supersaw lead | Harmony: tech_saws pad + blade stabs
    # Bass: bass_foundation sub + tb303 | Percussion: sparse four-on-the-floor
    # ============================================================
    melody_a    = (ring :a4, :cs5, :e5, :a5, :gs5, :e5, :fs5, :e5)
    cutoff_a    = (line 85, 115, steps: 16)
    chords_a    = (ring chord(:a3, :major), chord(:fs3, :minor), chord(:d3, :major), chord(:e3, :major))
    stab_a      = (ring :a3, :cs4, :e4, :fs4)
    cutoff_pad_a = (line 82, 100, steps: 8)
    bass_ring_1 = (ring :a2, :a2, :e2, :a2, :a2, :cs2, :e2, :a2)
    cutoff_sw1  = (line 62, 82, steps: 16)

    2.times do
      # Melody drone
      use_synth :fm
      play :a2, release: 8, divisor: 3, depth: 12, amp: 0.9, cutoff: 90

      # Harmony: sustained tech_saws pad
      with_fx :reverb, room: 0.25, mix: 0.3 do
        use_synth :tech_saws
        play_chord chords_a.tick, cutoff: cutoff_pad_a.tick, release: 8, amp: 0.85
      end

      # Bass: sustaining sub
      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 7.5, amp: 1.1

      # 8 melodic + harmonic + bass + perc steps (each step = 0.5 beat)
      with_fx :reverb, room: 0.25, mix: 0.28 do
        use_synth :supersaw
        8.times do |i|
          # Melody
          play melody_a.tick, cutoff: cutoff_a.tick, release: 0.18, amp: 1.8

          # Harmony blade stab on every other step
          use_synth :blade
          play stab_a.tick, cutoff: 95, release: 0.12, amp: 0.7 if i.even?

          # Bass tb303
          use_synth :tb303
          play bass_ring_1.tick, cutoff: cutoff_sw1.tick, res: 0.82, release: 0.45, amp: 0.9, wave: 0

          # Percussion
          if i == 0
            sample :drum_heavy_kick, amp: 1.5
            sample :hat_cats, amp: 0.8
          elsif i == 2
            sample :drum_heavy_kick, amp: 1.2
            sample :elec_snare, amp: 1.2
            sample :hat_zild, amp: 0.65
          elsif i == 4
            sample :drum_heavy_kick, amp: 1.4
            sample :hat_cats, amp: 0.7
          elsif i == 6
            sample :drum_heavy_kick, amp: 1.2
            sample :elec_snare, amp: 1.1
            sample :hat_zild, amp: 0.65
          else
            sample :hat_zild, amp: 0.55
          end

          sleep 0.5
        end
      end

      # Second bar of intro section — subpulse bass variation
      use_synth :subpulse
      play :a1, cutoff: 68, release: 7.5, amp: 0.85

      bass_ring_1b = (ring :a2, :e2, :a2, :a2, :e2, :a2, :cs2, :e2)

      with_fx :reverb, room: 0.25, mix: 0.28 do
        use_synth :supersaw
        8.times do |i|
          play melody_a.tick, cutoff: cutoff_a.tick, release: 0.18, amp: 1.8

          use_synth :blade
          play stab_a.tick, cutoff: 95, release: 0.12, amp: 0.7 if i.even?

          use_synth :tb303
          play bass_ring_1b.tick, cutoff: cutoff_sw1.tick, res: 0.82, release: 0.45, amp: 0.88, wave: 0

          if i == 0
            sample :drum_heavy_kick, amp: 1.5
            sample :hat_cats, amp: 0.8
          elsif i == 2
            sample :drum_heavy_kick, amp: 1.2
            sample :elec_snare, amp: 1.1
            sample :hat_zild, amp: 0.65
          elsif i == 4
            sample :drum_heavy_kick, amp: 1.4
            sample :hat_cats, amp: 0.7
          elsif i == 6
            sample :drum_heavy_kick, amp: 1.2
            sample :elec_snare, amp: 1.0
            sample :hat_zild, amp: 0.65
          else
            sample :hat_zild, amp: 0.55
          end

          sleep 0.5
        end
      end
    end

    # ============================================================
    # TRANSITION: Intro → Build (Key of A)
    # ============================================================
    use_synth :dsaw
    play :a2, cutoff: 90, release: 8, amp: 1.1
    use_synth :fm
    play :a2, cutoff: 88, release: 8, amp: 1.0, divisor: 3, depth: 8
    use_synth :bass_foundation
    play :a1, cutoff: 70, release: 8, amp: 1.05
    sample :drum_cymbal_closed, amp: 0.9
    sleep 4

    # ============================================================
    # SECTION 2: Build — Key of A major
    # Melody: chiplead with echo | Harmony: tech_saws stabs + blade
    # Bass: walking tb303 | Percussion: denser hats + euclidean fills
    # ============================================================
    melody_b    = (ring :a4, :e5, :fs5, :a5, :b5, :a5, :gs5, :fs5)
    cutoff_b    = (line 90, 120, steps: 16)
    chords_b    = (ring chord(:a3, :major), chord(:e3, :major), chord(:d3, :major), chord(:e3, :major))
    stab_b      = (ring :e4, :a4, :d4, :e4)
    cutoff_pad_b = (line 88, 108, steps: 8)
    bass_walk_2 = (ring :a2, :cs2, :e2, :fs2, :e2, :a2, :e2, :cs2)
    cutoff_sw2  = (line 68, 88, steps: 16)

    2.times do
      # Melody drone
      use_synth :fm
      play :a2, release: 8, divisor: 2, depth: 10, amp: 0.8, cutoff: 88

      # Harmony: FM drone swell
      use_synth :fm
      play :a2, cutoff: 90, release: 8, amp: 0.9, divisor: 2, depth: 10

      # Bass: subpulse root
      use_synth :subpulse
      play :a1, cutoff: 72, release: 7.5, amp: 1.0

      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          use_synth :chiplead
          8.times do |i|
            play melody_b.tick, cutoff: cutoff_b.tick, release: 0.14, amp: 1.9

            # Harmony: tech_saws stab
            use_synth :tech_saws
            play_chord chords_b.tick, cutoff: cutoff_pad_b.tick, release: 0.28, amp: 0.95

            # Harmony: blade accent
            use_synth :blade
            play stab_b.tick, cutoff: 100, release: 0.11, amp: 0.65

            # Bass tb303
            use_synth :tb303
            play bass_walk_2.tick, cutoff: cutoff_sw2.tick, res: 0.85, release: 0.4, amp: 0.95, wave: 0

            # Percussion — denser 16th-note hats
            if i == 0
              sample :drum_heavy_kick, amp: 1.6
              sample :hat_cats, amp: 1.0
            elsif i == 2
              sample :drum_heavy_kick, amp: 1.3
              sample :drum_snare_hard, amp: 1.3
              sample :hat_cats, amp: 0.9
            elsif i == 4
              sample :drum_heavy_kick, amp: 1.5
              sample :hat_cats, amp: 0.85
            elsif i == 6
              sample :drum_heavy_kick, amp: 1.3
              sample :drum_snare_hard, amp: 1.2
              sample :hat_cats, amp: 0.9
            else
              sample :hat_zild, amp: 0.6
              sample :elec_snare, amp: 0.7 if one_in(3)
            end

            sleep 0.5
          end
        end
      end

      # Second bar — bass variation
      use_synth :bass_foundation
      play :e2, cutoff: 70, release: 7.5, amp: 0.9
      bass_walk_2b = (ring :a2, :a2, :e2, :a2, :b2, :a2, :gs2, :e2)

      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          use_synth :chiplead
          8.times do |i|
            play melody_b.tick, cutoff: cutoff_b.tick, release: 0.14, amp: 1.9

            use_synth :blade
            play stab_b.tick, cutoff: 100, release: 0.11, amp: 0.65

            use_synth :tb303
            play bass_walk_2b.tick, cutoff: cutoff_sw2.tick, res: 0.85, release: 0.4, amp: 0.92, wave: 0

            if i == 0
              sample :drum_heavy_kick, amp: 1.6
              sample :hat_cats, amp: 1.0
            elsif i == 2
              sample :drum_heavy_kick, amp: 1.3
              sample :drum_snare_hard, amp: 1.2
              sample :hat_cats, amp: 0.9
            elsif i == 4
              sample :drum_heavy_kick, amp: 1.5
              sample :hat_cats, amp: 0.85
            elsif i == 6
              sample :drum_heavy_kick, amp: 1.3
              sample :drum_snare_hard, amp: 1.2
              sample :hat_cats, amp: 0.85
            else
              sample :hat_zild, amp: 0.6
              sample :elec_snare, amp: 0.65 if one_in(3)
            end

            sleep 0.5
          end
        end
      end
    end

    # ============================================================
    # TRANSITION: Build → Drop (Key Change A → B)
    # ============================================================
    use_synth :dsaw
    play :b2, cutoff: 92, release: 8, amp: 1.2
    use_synth :fm
    play :b2, cutoff: 90, release: 8, amp: 1.1, divisor: 3, depth: 10
    use_synth :bass_foundation
    play :b1, cutoff: 72, release: 8, amp: 1.1
    sample :drum_cymbal_open, amp: 0.9
    sample :drum_cymbal_closed, amp: 1.0
    sample :elec_snare, amp: 0.9
    sleep 4

    # ============================================================
    # SECTION 3: Drop — Key of B major
    # Melody: dsaw power lead | Harmony: tech_saws + blade
    # Bass: pumping tb303 on B | Percussion: full power electronic
    # ============================================================
    melody_c    = (ring :b4, :ds5, :fs5, :b5, :as5, :fs5, :gs5, :fs5)
    cutoff_c    = (line 95, 125, steps: 16)
    chords_c    = (ring chord(:b3, :major), chord(:gs3, :minor), chord(:e3, :major), chord(:fs3, :major))
    stab_c      = (ring :b3, :ds4, :fs4, :gs4)
    cutoff_pad_c = (line 90, 115, steps: 8)
    bass_drop_3 = (ring :b2, :b2, :fs2, :b2, :b2, :ds2, :fs2, :b2)
    cutoff_sw3  = (line 72, 90, steps: 16)

    2.times do
      # Melody FM drone
      use_synth :fm
      play :b2, release: 8, divisor: 2, depth: 14, amp: 0.9, cutoff: 92

      # Harmony: tech_saws pad
      with_fx :lpf, cutoff: 108, mix: 1.0 do
        use_synth :tech_saws
        play_chord chords_c.tick, cutoff: cutoff_pad_c.tick, release: 8, amp: 1.0

        # Bass: subpulse sub
        use_synth :subpulse
        play :b1, cutoff: 68, release: 7.5, amp: 1.15

        with_fx :reverb, room: 0.22, mix: 0.25 do
          use_synth :dsaw
          8.times do |i|
            play melody_c.tick, cutoff: cutoff_c.tick, release: 0.16, amp: 2.0

            # Harmony: blade stab
            use_synth :blade
            play stab_c.tick, cutoff: 102, release: 0.13, amp: 0.75

            # FM bass harmony
            use_synth :fm
            play :b2, cutoff: 88, release: 8, amp: 0.85, divisor: 2, depth: 12 if i == 0

            # Bass tb303
            use_synth :tb303
            play bass_drop_3.tick, cutoff: cutoff_sw3.tick, res: 0.86, release: 0.38, amp: 1.0, wave: 0

            # Percussion — full power
            if i == 0
              sample :drum_heavy_kick, amp: 1.7
              sample :hat_cats, amp: 1.1
            elsif i == 2
              sample :drum_heavy_kick, amp: 1.5
              sample :drum_snare_hard, amp: 1.5
              sample :elec_snare, amp: 1.0
              sample :hat_cats, amp: 1.0
            elsif i == 4
              sample :drum_heavy_kick, amp: 1.6
              sample :hat_cats, amp: 0.95
            elsif i == 6
              sample :drum_heavy_kick, amp: 1.4
              sample :drum_snare_hard, amp: 1.4
              sample :elec_snare, amp: 1.1
              sample :hat_cats, amp: 1.0
            else
              sample :hat_zild, amp: 0.65
              sample :drum_cymbal_closed, amp: 0.7 if one_in(2)
            end

            sleep 0.5
          end
        end

        # Second bar — bass variation
        use_synth :bass_foundation
        play :fs2, cutoff: 70, release: 7.5, amp: 0.88
        bass_drop_3b = (ring :b2, :b2, :fs2, :b2, :gs2, :fs2, :b2, :ds2)

        with_fx :reverb, room: 0.22, mix: 0.25 do
          use_synth :dsaw
          8.times do |i|
            play melody_c.tick, cutoff: cutoff_c.tick, release: 0.16, amp: 2.0

            use_synth :blade
            play stab_c.tick, cutoff: 102, release: 0.13, amp: 0.75

            use_synth :tb303
            play bass_drop_3b.tick, cutoff: cutoff_sw3.tick, res: 0.86, release: 0.38, amp: 0.98, wave: 0

            if i == 0
              sample :drum_heavy_kick, amp: 1.7
              sample :hat_cats, amp: 1.1
            elsif i == 2
              sample :drum_heavy_kick, amp: 1.5
              sample :drum_snare_hard, amp: 1.5
              sample :elec_snare, amp: 1.0
              sample :hat_cats, amp: 1.0
            elsif i == 4
              sample :drum_heavy_kick, amp: 1.6
              sample :hat_cats, amp: 0.9
            elsif i == 6
              sample :drum_heavy_kick, amp: 1.4
              sample :drum_snare_hard, amp: 1.3
              sample :elec_snare, amp: 1.0
              sample :hat_cats, amp: 0.95
            else
              sample :hat_zild, amp: 0.6
              sample :drum_cymbal_closed, amp: 0.7 if one_in(2)
            end

            sleep 0.5
          end
        end
      end
    end

    # ============================================================
    # TRANSITION: Drop → Outro (Key of B)
    # ============================================================
    use_synth :dsaw
    play :b2, cutoff: 90, release: 8, amp: 1.1
    use_synth :fm
    play :b2, cutoff: 90, release: 8, amp: 1.0, divisor: 3, depth: 8
    use_synth :bass_foundation
    play :b1, cutoff: 70, release: 8, amp: 1.0
    sample :drum_cymbal_closed, amp: 1.1
    sample :elec_snare, amp: 1.0
    sleep 4

    # ============================================================
    # SECTION 4: Outro — Key of B major, winding down
    # Melody: supersaw + chiplead layered | Harmony: tech_saws + blade sustained
    # Bass: descending tb303 walk | Percussion: layered groove fading
    # ============================================================
    melody_d     = (ring :b4, :fs5, :gs5, :b5, :cs6, :b5, :as5, :gs5)
    cutoff_d     = (line 100, 90, steps: 16)
    chords_d     = (ring chord(:b3, :major), chord(:e3, :major), chord(:gs3, :minor), chord(:fs3, :major))
    stab_d       = (ring :b3, :e4, :gs4, :fs4)
    cutoff_pad_d = (line 100, 84, steps: 8)
    bass_outro   = (ring :b2, :fs2, :gs2, :b2, :cs2, :b2, :as2, :gs2)
    cutoff_sw4   = (line 80, 62, steps: 16)

    2.times do
      # Melody drones
      use_synth :fm
      play :b2, release: 8, divisor: 3, depth: 8, amp: 0.8, cutoff: 88
      use_synth :supersaw
      play :b3, release: 8, cutoff: 85, amp: 0.5

      # Harmony: tech_saws pad sustained
      use_synth :tech_saws
      play_chord chords_d.tick, cutoff: cutoff_pad_d.tick, release: 8, amp: 0.95

      # Bass: sustained foundation
      use_synth :bass_foundation
      play :b1, cutoff: 67, release: 7.5, amp: 1.05

      8.times do |i|
        # Melody: chiplead
        use_synth :chiplead
        play melody_d.tick, cutoff: cutoff_d.tick, release: 0.13, amp: 1.8

        # Harmony: blade stab
        use_synth :blade
        play stab_d.tick, cutoff: 95, release: 0.15, amp: 0.65

        # Harmony: FM bass stab
        use_synth :fm
        play stab_d.look - 12, cutoff: 86, release: 0.2, amp: 0.6, divisor: 3, depth: 6

        # Bass tb303
        use_synth :tb303
        play bass_outro.tick, cutoff: cutoff_sw4.tick, res: 0.80, release: 0.42, amp: 0.88, wave: 0

        # Percussion — layered outro groove
        if i == 0
          sample :drum_heavy_kick, amp: 1.6
          sample :hat_cats, amp: 1.0
        elsif i == 2
          sample :drum_heavy_kick, amp: 1.3
          sample :drum_snare_hard, amp: 1.3
          sample :hat_cats, amp: 0.9
        elsif i == 4
          sample :drum_heavy_kick, amp: 1.5
          sample :hat_cats, amp: 0.85
        elsif i == 6
          sample :drum_heavy_kick, amp: 1.2
          sample :drum_snare_hard, amp: 1.2
          sample :hat_cats, amp: 0.85
        else
          sample :hat_zild, amp: 0.6
          sample :elec_snare, amp: 0.7 if one_in(3)
          sample :drum_cymbal_closed, amp: 0.65 if one_in(4)
        end

        sleep 0.5
      end

      # Second bar — subpulse bass variation
      use_synth :subpulse
      play :b1, cutoff: 65, release: 7.5, amp: 0.82

      8.times do |i|
        use_synth :chiplead
        play melody_d.tick, cutoff: cutoff_d.tick, release: 0.13, amp: 1.8

        use_synth :blade
        play stab_d.tick, cutoff: 95, release: 0.15, amp: 0.65

        use_synth :tb303
        play bass_outro.tick, cutoff: cutoff_sw4.tick, res: 0.80, release: 0.42, amp: 0.85, wave: 0

        if i == 0
          sample :drum_heavy_kick, amp: 1.6
          sample :hat_cats, amp: 1.0
        elsif i == 2
          sample :drum_heavy_kick, amp: 1.3
          sample :drum_snare_hard, amp: 1.2
          sample :hat_cats, amp: 0.9
        elsif i == 4
          sample :drum_heavy_kick, amp: 1.5
          sample :hat_cats, amp: 0.8
        elsif i == 6
          sample :drum_heavy_kick, amp: 1.2
          sample :drum_snare_hard, amp: 1.1
          sample :hat_cats, amp: 0.8
        else
          sample :hat_zild, amp: 0.55
          sample :elec_snare, amp: 0.65 if one_in(3)
        end

        sleep 0.5
      end
    end

    # ============================================================
    # FINAL RESOLVE — Key of B, long sustain
    # ============================================================
    use_synth :supersaw
    play :b4, cutoff: 90, release: 6, amp: 1.6
    use_synth :fm
    play :b2, release: 8, divisor: 2, depth: 6, amp: 0.8, cutoff: 88
    use_synth :tech_saws
    play_chord chord(:b3, :major), cutoff: 88, release: 6, amp: 0.9
    use_synth :blade
    play :b4, cutoff: 90, release: 6, amp: 0.75
    use_synth :bass_foundation
    play :b1, cutoff: 65, release: 6, amp: 1.0
    use_synth :subpulse
    play :b2, cutoff: 68, release: 6, amp: 0.85
    sample :drum_cymbal_closed, amp: 1.0
    sample :drum_snare_hard, amp: 1.2
    sleep 6

  end
end