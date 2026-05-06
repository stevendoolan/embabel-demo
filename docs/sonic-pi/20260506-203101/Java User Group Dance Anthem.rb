# Java User Group Dance Anthem
# Style: Electronic Dance | Mood: High-energy, driving, euphoric

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================
    # SECTION 1: Key of A — Intro Groove
    # Melody: chiplead arpeggios | Harmony: blade drone + supersaw beats 2 & 4
    # Bass: sub-bass pulse | Percussion: four-on-the-floor
    # =============================================
    melody_a   = (ring :a4, :cs5, :e5, :a5, :gs5, :e5, :cs5, :a4)
    bass_roots_a1 = (ring :a1, :a1, :e2, :e2, :fs2, :fs2, :e2, :cs2)
    harm_chords_a = (ring
      chord(:a3, :major7),
      chord(:fs3, :minor7),
      chord(:d3, :major7),
      chord(:e3, :major7)
    )

    # Long blade drone underneath section 1
    use_synth :blade
    play :a2, cutoff: 85, release: 16, amp: 0.45

    2.times do
      # Melody drone pad
      use_synth :supersaw
      play :a2, release: 8, cutoff: 75, amp: 0.32

      # Bass sustained root
      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 0.75

      # Melody: chiplead arpeggios
      with_fx :reverb, room: 0.25, mix: 0.28 do
        use_synth :chiplead
        8.times do
          play melody_a.tick, cutoff: (line 90, 120, steps: 16).tick, release: 0.18, amp: 0.95
          sleep 0.5
        end
      end

      # Harmony: supersaw stabs on beats 2 & 4
      with_fx :reverb, room: 0.28, mix: 0.3 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          4.times do
            # Beat 1 — percussion + bass pulse
            use_synth :subpulse
            play bass_roots_a1.tick, cutoff: 72, release: 0.6, amp: 0.65
            with_fx :hpf, cutoff: 90, mix: 1.0 do
              sample :bd_klub, amp: 0.82
              sample :drum_cymbal_closed, amp: 0.30, rate: 1.2
            end
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.26, rate: 1.3
            sleep 0.5

            # Beat 2 — harmony stab + snare
            use_synth :supersaw
            play_chord harm_chords_a.tick, cutoff: (line 82, 108, steps: 8).tick, release: 0.55, amp: 0.55
            use_synth :subpulse
            play bass_roots_a1.tick, cutoff: 72, release: 0.6, amp: 0.65
            sample :elec_snare, amp: 0.60
            sample :drum_cymbal_closed, amp: 0.28, rate: 1.2
            sleep 0.5
            sample :drum_cymbal_open, amp: 0.20, rate: 1.4, finish: 0.15
            sleep 0.5

            # Beat 3 — kick + bass
            use_synth :subpulse
            play bass_roots_a1.tick, cutoff: 72, release: 0.6, amp: 0.65
            sample :bd_klub, amp: 0.70
            sample :drum_cymbal_closed, amp: 0.28, rate: 1.2
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.24, rate: 1.3
            sleep 0.5

            # Beat 4 — harmony stab + snare
            use_synth :supersaw
            play_chord harm_chords_a.look, cutoff: (line 82, 108, steps: 8).look, release: 0.45, amp: 0.45
            use_synth :subpulse
            play bass_roots_a1.tick, cutoff: 72, release: 0.6, amp: 0.65
            sample :elec_snare, amp: 0.58
            sample :drum_cymbal_closed, amp: 0.28, rate: 1.2
            sleep 0.5
            sample :elec_blip, amp: 0.25, rate: rrand(0.9, 1.2) if one_in(4)
            sample :drum_cymbal_open, amp: 0.18, rate: 1.4, finish: 0.12
            sleep 0.5
          end
        end
      end
    end

    # =============================================
    # TRANSITION 1: Drone bridge — A into Section 2
    # =============================================
    use_synth :mod_saw
    play :a2, cutoff: 90, release: 8, amp: 0.5
    play :e3, cutoff: 80, release: 8, amp: 0.28
    sample :bd_klub, amp: 0.68
    sleep 1
    sample :drum_cymbal_open, amp: 0.28, rate: 1.2, finish: 0.3
    sleep 1
    sample :bd_klub, amp: 0.62
    sleep 1
    sample :elec_snare, amp: 0.52
    sleep 1

    # =============================================
    # SECTION 2: Key of A — Supersaw Build
    # Melody: supersaw lead | Harmony: tech_saws + blade pads on beats 2 & 4
    # Bass: walking tb303 + subpulse | Percussion: ghost notes + more energy
    # =============================================
    lead_a2     = (ring :a5, :e5, :fs5, :a5, :e5, :cs5, :d5, :e5)
    chords_a    = (ring chord(:a3, :major), chord(:fs3, :minor), chord(:d3, :major), chord(:e3, :major))
    bass_walk_a = (ring :a1, :a1, :fs2, :fs2, :d2, :d2, :e2, :e2)

    # Long sustain drone for section 2
    use_synth :blade
    play :a2, cutoff: 88, release: 16, amp: 0.4
    use_synth :blade
    play :e3, cutoff: 80, release: 16, amp: 0.3

    2.times do
      # Melody pad sustain
      use_synth :mod_saw
      play :a2, release: 8, cutoff: 80, amp: 0.28

      # Bass: tb303 walking bass
      use_synth :bass_foundation
      play :a1, cutoff: 68, release: 8, amp: 0.72

      # Melody: supersaw lead with echo
      with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
        use_synth :supersaw
        8.times do
          tick
          amp_val = look % 8 == 0 ? 1.0 : 0.85
          play lead_a2.look, cutoff: rrand(88, 115), release: 0.22, amp: amp_val
          sleep 0.5
        end
      end

      # Melody chord stabs
      use_synth :supersaw
      4.times do
        play_chord chords_a.tick, release: 0.35, cutoff: 85, amp: 0.22
        sleep 1
      end

      # Harmony: tech_saws + blade on beats 2 & 4
      4.times do
        # Beat 1 — bass + kick
        use_synth :tb303
        tick
        cutoff_val = look % 4 == 0 ? 88 : rrand(70, 82)
        play bass_walk_a.look, cutoff: cutoff_val, release: 0.55, wave: 0, amp: 0.65
        sample :bd_klub, amp: look % 4 == 0 ? 0.86 : 0.73
        sample :hat_tap, amp: 0.33, rate: 1.5
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.23, rate: 1.3
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.26, rate: 1.2
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.20, rate: 1.3
        sleep 0.25

        # Beat 2 — harmony + snare
        use_synth :tech_saws
        play_chord harm_chords_a.tick, cutoff: 95, release: 0.5, amp: 0.5
        use_synth :subpulse
        play bass_walk_a.tick, cutoff: 75, release: 0.65, amp: 0.60
        sample :elec_snare, amp: 0.65
        sample :elec_pop, amp: 0.28, rate: rrand(1.0, 1.3)
        sample :hat_tap, amp: 0.30, rate: 1.4
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.22, rate: 1.2
        sleep 0.25
        sample :drum_cymbal_open, amp: 0.22, rate: 1.3, finish: 0.18
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.20, rate: 1.3
        sleep 0.25

        # Beat 3 — kick + bass
        use_synth :subpulse
        play bass_walk_a.tick, cutoff: 75, release: 0.65, amp: 0.60
        sample :bd_klub, amp: 0.74
        sample :hat_tap, amp: 0.28, rate: 1.5
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.22, rate: 1.2
        sleep 0.25
        sample :elec_blip, amp: 0.20, rate: rrand(0.8, 1.1) if one_in(3)
        sample :drum_cymbal_closed, amp: 0.20, rate: 1.3
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.18, rate: 1.3
        sleep 0.25

        # Beat 4 — harmony + snare
        use_synth :supersaw
        play_chord harm_chords_a.look, cutoff: 90, release: 1.2, amp: 0.48
        use_synth :subpulse
        play bass_walk_a.tick, cutoff: 75, release: 0.65, amp: 0.60
        sample :elec_snare, amp: 0.62
        sample :hat_tap, amp: 0.30, rate: 1.4
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.22, rate: 1.2
        sleep 0.25
        sample :drum_cymbal_open, amp: 0.25, rate: 1.3, finish: 0.2
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.18, rate: 1.3
        sleep 0.25
      end
    end

    # =============================================
    # TRANSITION 2: Drone bridge — A -> B key change
    # =============================================
    use_synth :mod_saw
    play :b2, cutoff: 90, release: 8, amp: 0.6
    play :fs3, cutoff: 80, release: 8, amp: 0.28
    use_synth :blade
    play :b2, cutoff: 88, release: 8, amp: 0.45
    use_synth :supersaw
    play :fs3, cutoff: 82, release: 8, amp: 0.25
    use_synth :bass_foundation
    play :b1, cutoff: 70, release: 8, amp: 0.72
    sample :bd_klub, amp: 0.68
    sleep 1
    sample :drum_cymbal_open, amp: 0.28, rate: 1.2, finish: 0.3
    sleep 1
    sample :bd_klub, amp: 0.62
    sleep 1
    sample :elec_snare, amp: 0.52
    sample :elec_blip, amp: 0.25, rate: 1.4
    sleep 1

    # =============================================
    # SECTION 3: Key of B — Elevated Energy Peak
    # Melody: chiplead in B | Harmony: supersaw + tech_saws pads
    # Bass: locked sub in B | Percussion: reverb-laced four-on-the-floor
    # =============================================
    melody_b    = (ring :b4, :ds5, :fs5, :b5, :as5, :fs5, :ds5, :b4)
    bass_roots_b = (ring :b1, :b1, :fs2, :fs2, :gs2, :gs2, :fs2, :ds2)
    harm_chords_b = (ring
      chord(:b3, :major7),
      chord(:gs3, :minor7),
      chord(:e3, :major7),
      chord(:fs3, :major7)
    )

    # Long lush drone in B for the climax
    use_synth :blade
    play :b2, cutoff: 90, release: 16, amp: 0.5

    2.times do
      # Melody pad drone in B
      use_synth :supersaw
      play :b2, release: 8, cutoff: 78, amp: 0.32

      # Bass sustained root
      use_synth :bass_foundation
      play :b1, cutoff: 67, release: 8, amp: 0.75

      # Melody: chiplead in B
      with_fx :lpf, cutoff: 115, mix: 1.0 do
        with_fx :reverb, room: 0.3, mix: 0.25 do
          use_synth :chiplead
          8.times do
            play melody_b.tick, cutoff: (line 92, 122, steps: 16).tick, release: 0.18, amp: 0.95
            sleep 0.5
          end
        end
      end

      # Harmony: supersaw + tech_saws on beats 2 & 4
      with_fx :reverb, room: 0.35, mix: 0.3 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          4.times do
            # Beat 1 — kick + sub bass
            use_synth :subpulse
            play bass_roots_b.tick, cutoff: 78, release: 0.58, amp: 0.64
            with_fx :reverb, room: 0.22, mix: 0.22 do
              sample :bd_klub, amp: bass_roots_b.look == :b1 ? 0.88 : 0.76
              sample :hat_tap, amp: 0.36, rate: 1.6
            end
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.28, rate: 1.3
            sleep 0.5

            # Beat 2 — harmony stab + snare
            use_synth :supersaw
            play_chord harm_chords_b.tick, cutoff: (line 88, 118, steps: 16).tick, release: 0.6, amp: 0.62
            use_synth :subpulse
            play bass_roots_b.tick, cutoff: 78, release: 0.58, amp: 0.64
            sample :elec_snare, amp: 0.70
            sample :elec_pop, amp: 0.30, rate: rrand(1.1, 1.4)
            sleep 0.5
            sample :drum_cymbal_open, amp: 0.28, rate: 1.4, finish: 0.2
            sleep 0.5

            # Beat 3 — kick + sub bass
            use_synth :subpulse
            play bass_roots_b.tick, cutoff: 78, release: 0.58, amp: 0.64
            sample :bd_klub, amp: 0.76
            sample :hat_tap, amp: 0.33, rate: 1.5
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.26, rate: 1.3
            sleep 0.5

            # Beat 4 — tech_saws shimmer + snare
            use_synth :tech_saws
            play_chord harm_chords_b.look, cutoff: (line 88, 118, steps: 16).look, release: 0.5, amp: 0.48
            use_synth :subpulse
            play bass_roots_b.tick, cutoff: 78, release: 0.58, amp: 0.64
            sample :elec_snare, amp: 0.68
            sample :hat_tap, amp: 0.32, rate: 1.5
            sleep 0.5
            sample :drum_cymbal_open, amp: 0.26, rate: 1.3, finish: 0.18
            sample :elec_blip, amp: 0.24, rate: rrand(1.0, 1.5) if one_in(3)
            sleep 0.5
          end
        end
      end
    end

    # =============================================
    # TRANSITION 3: Drone bridge — into climax
    # =============================================
    use_synth :mod_saw
    play :b2, cutoff: 92, release: 8, amp: 0.58
    play :fs3, cutoff: 85, release: 8, amp: 0.28
    use_synth :blade
    play :b2, cutoff: 92, release: 8, amp: 0.45
    use_synth :bass_foundation
    play :b1, cutoff: 70, release: 8, amp: 0.72
    sample :bd_klub, amp: 0.70
    sleep 1
    sample :drum_cymbal_open, amp: 0.30, rate: 1.2, finish: 0.3
    sleep 1
    sample :bd_klub, amp: 0.65
    sleep 1
    sample :elec_snare, amp: 0.55
    sleep 1

    # =============================================
    # SECTION 4: Key of B — Full Anthem Climax
    # Melody: mod_saw driving lead | Harmony: blade + supersaw major7 chords
    # Bass: tb303 filter sweep | Percussion: sixteenth-note hats, heavy kicks
    # =============================================
    lead_b2     = (ring :b5, :fs5, :gs5, :b5, :fs5, :ds5, :e5, :fs5)
    chords_b    = (ring chord(:b3, :major), chord(:gs3, :minor), chord(:e3, :major), chord(:fs3, :major))
    bass_walk_b = (ring :b1, :b1, :gs2, :gs2, :e2, :e2, :fs2, :fs2)

    # Sustained Bmaj7 pads underneath driving climax
    use_synth :blade
    play :b2, cutoff: 92, release: 16, amp: 0.48
    use_synth :blade
    play :fs3, cutoff: 85, release: 16, amp: 0.33

    2.times do
      # Melody pad sustain
      use_synth :mod_saw
      play :b2, release: 8, cutoff: 82, amp: 0.30

      # Bass foundation
      use_synth :bass_foundation
      play :b1, cutoff: 70, release: 8, amp: 0.72

      # Melody: driving mod_saw lead (sixteenth notes)
      use_synth :mod_saw
      16.times do
        tick
        play lead_b2.look, cutoff: (line 95, 125, steps: 16).look, release: 0.15, amp: 0.90
        sleep 0.25
      end

      # Melody chord stabs
      use_synth :supersaw
      4.times do
        play_chord chords_b.tick, release: 0.4, cutoff: 88, amp: 0.20
        sleep 1
      end

      # Harmony: supersaw + blade major7 on beats 2 & 4
      4.times do
        tick
        # Beat 1 — bass + kick
        use_synth :tb303
        play bass_walk_b.look, cutoff: (line 65, 90, steps: 8).look, release: 0.5, wave: 0, amp: 0.68
        bass_walk_b.tick
        sample :bd_klub, amp: look % 4 == 0 ? 0.86 : 0.73 if spread(4, 16)[look % 16]
        sample :drum_cymbal_closed, amp: 0.30, rate: 1.3
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.20, rate: 1.3
        sleep 0.25
        sample :hat_tap, amp: 0.28, rate: 1.5
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.18, rate: 1.3
        sleep 0.25

        # Beat 2 — harmony + snare
        use_synth :supersaw
        play_chord harm_chords_b.look, cutoff: (line 90, 122, steps: 16).look, release: 0.65, amp: 0.60
        use_synth :tb303
        play bass_walk_b.look, cutoff: (line 65, 90, steps: 8).look, release: 0.5, wave: 0, amp: 0.68
        bass_walk_b.tick
        sample :elec_snare, amp: 0.68
        sample :elec_pop, amp: 0.26, rate: rrand(1.0, 1.3)
        sample :drum_cymbal_closed, amp: 0.28, rate: 1.3
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.20, rate: 1.3
        sleep 0.25
        sample :drum_cymbal_open, amp: 0.26, rate: 1.4, finish: 0.15
        sleep 0.25
        sample :hat_tap, amp: 0.28, rate: 1.5 if spread(6, 16)[look % 16]
        sleep 0.25

        # Beat 3 — kick + bass
        use_synth :tb303
        play bass_walk_b.look, cutoff: (line 65, 90, steps: 8).look, release: 0.5, wave: 0, amp: 0.68
        bass_walk_b.tick
        sample :bd_klub, amp: 0.73 if spread(4, 16)[look % 16]
        sample :drum_cymbal_closed, amp: 0.28, rate: 1.3
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.18, rate: 1.3
        sleep 0.25
        sample :hat_tap, amp: 0.26, rate: 1.5 if spread(6, 16)[look % 16]
        sleep 0.25
        sample :elec_blip, amp: 0.22, rate: rrand(0.9, 1.6) if one_in(5)
        sleep 0.25

        # Beat 4 — blade sustain + snare
        use_synth :blade
        play_chord harm_chords_b.look, cutoff: (line 90, 122, steps: 16).look, release: 1.5, amp: 0.42
        use_synth :tb303
        play bass_walk_b.look, cutoff: (line 65, 90, steps: 8).look, release: 0.5, wave: 0, amp: 0.68
        bass_walk_b.tick
        sample :elec_snare, amp: 0.68
        sample :elec_pop, amp: 0.24, rate: rrand(1.0, 1.3)
        sample :drum_cymbal_closed, amp: 0.28, rate: 1.3
        sleep 0.25
        sample :drum_cymbal_open, amp: 0.26, rate: 1.4, finish: 0.15
        sleep 0.25
        sample :hat_tap, amp: 0.28, rate: 1.5 if spread(6, 16)[look % 16]
        sleep 0.25
        sample :elec_blip, amp: 0.22, rate: rrand(0.9, 1.6) if one_in(5)
        sleep 0.25
      end
    end

  end
end