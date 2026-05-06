# Feed the Birds EDM Remix
# Style: Uplifting EDM / House | Mood: Euphoric, Uplifting
# Key: D major -> F major | BPM: 128 | Time: 4/4

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================
    # SECTION 1: Intro / Verse — D major
    # Melody: supersaw lead | Harmony: blade+rhodey pads
    # Bass: subpulse+tb303 | Percussion: four-on-floor
    # =============================================
    melody_d      = (ring :d4, :fs4, :a4, :d5, :cs5, :a4, :fs4, :e4)
    bass_d        = (ring :d2, :d2, :a2, :d2, :d2, :fs2, :a2, :e2)
    harm1_chords  = (ring chord(:d3, :major7), chord(:a3, :major), chord(:g3, :major7), chord(:a3, :sus4))

    2.times do
      # Long sustaining drones — foundation
      use_synth :blade
      play :d3, cutoff: 85, release: 16, amp: 0.35
      use_synth :bass_foundation
      play :d1, cutoff: 65, release: 16, amp: 0.65

      with_fx :reverb, room: 0.25, mix: 0.28 do
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          8.times do |i|
            # --- Melody ---
            use_synth :supersaw
            play melody_d.tick, cutoff: (line 90, 115, steps: 16).tick, release: 0.45, amp: 0.95

            # --- Harmony ---
            use_synth :rhodey
            play_chord harm1_chords.tick, cutoff: 88, release: 0.35, amp: 0.55
            use_synth :supersaw
            play harm1_chords.look.to_a[0], cutoff: (line 82, 100, steps: 16).look, release: 0.3, amp: 0.38

            # --- Bass ---
            use_synth :subpulse
            play bass_d.tick, cutoff: 75, release: 0.7, amp: 0.72, pulse_width: 0.3

            # --- Percussion ---
            sample :bd_klub, amp: (i % 4 == 0 ? 0.85 : 0.72)
            sample :drum_cymbal_closed, amp: 0.35
            sleep 0.25

            sample :drum_cymbal_closed, amp: 0.28
            sleep 0.25

            # --- Harmony offbeat ---
            use_synth :rhodey
            play_chord harm1_chords.look, cutoff: 88, release: 0.25, amp: 0.35
            use_synth :supersaw
            play harm1_chords.look.to_a[1], cutoff: (line 82, 100, steps: 16).look, release: 0.2, amp: 0.32

            # --- Bass offbeat ---
            use_synth :tb303
            play bass_d.look, cutoff: rrand(60, 85), res: 0.8, release: 0.3, wave: 0, amp: 0.55

            # --- Percussion offbeat ---
            sample :drum_cymbal_open, amp: (i % 2 == 1 ? 0.38 : 0.22)
            if i % 2 == 1
              sample :drum_snare_hard, amp: 0.58
              sample :elec_snap, amp: 0.42
            end
            sleep 0.25

            if i % 4 == 3
              use_synth :subpulse
              play :a2, cutoff: 70, release: 0.2, amp: 0.50, pulse_width: 0.25
            end
            sample :drum_cymbal_closed, amp: 0.25
            sleep 0.25
          end
        end
      end
    end

    # =============================================
    # TRANSITION 1: Drone bridge D -> build
    # =============================================
    use_synth :blade
    play :d4, cutoff: 90, release: 8, amp: 0.45
    use_synth :dsaw
    play :a3, cutoff: 85, release: 8, amp: 0.38
    use_synth :rhodey
    play_chord chord(:d3, :major7), cutoff: 85, release: 8, amp: 0.38
    use_synth :bass_foundation
    play :d1, cutoff: 68, release: 8, amp: 0.60
    use_synth :tb303
    play :a2, cutoff: 75, res: 0.85, release: 8, wave: 0, amp: 0.48
    4.times do
      sample :drum_cymbal_closed, amp: 0.28
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.22
      sleep 0.5
    end

    # =============================================
    # SECTION 2: Drop / Build — D major
    # Melody: supersaw+blade | Harmony: supersaw chord stabs
    # Bass: rolling tb303+subpulse | Percussion: full energy
    # =============================================
    melody_d2    = (ring :d5, :a4, :fs4, :e4, :d4, :e4, :fs4, :a4)
    bass_ring_2  = (ring :d2, :a2, :fs2, :e2, :d2, :e2, :fs2, :a2)
    chords_roots = (ring :d2, :g2, :a2, :fs2)
    build_prog   = (ring chord(:d3, :sus2), chord(:g3, :major7), chord(:a3, :sus4), chord(:fs3, :minor7))

    3.times do |rep|
      # Sustained drones
      use_synth :blade
      play :d3, cutoff: rrand(80, 95), release: 16, amp: 0.30
      use_synth :bass_foundation
      play :d1, cutoff: 68, release: 16, amp: 0.68

      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
        with_fx :lpf, cutoff: 108, mix: 1.0 do
          with_fx :hpf, cutoff: 90, mix: 1.0 do
            8.times do |i|
              # --- Melody ---
              use_synth :supersaw
              play melody_d2.tick, cutoff: rrand(95, 120), release: 0.35, amp: 0.95
              use_synth :blade
              play build_prog.look.to_a.choose, cutoff: 88, release: 0.6, amp: 0.32

              # --- Harmony ---
              use_synth :supersaw
              play_chord build_prog.tick, cutoff: (line 85, 110, steps: 24).look, release: 0.28, amp: 0.52
              use_synth :rhodey
              play build_prog.look.to_a.choose, cutoff: 90, release: 0.4, amp: 0.40

              # --- Bass ---
              use_synth :subpulse
              play bass_ring_2.tick, cutoff: 78, release: 0.65, amp: 0.72, pulse_width: 0.28

              # --- Percussion ---
              sample :bd_klub, amp: (i % 4 == 0 ? 0.88 : 0.75)
              sample :drum_cymbal_closed, amp: 0.38
              sleep 0.25

              sample :hat_cab, amp: 0.22
              sleep 0.25

              # --- Harmony offbeat ---
              use_synth :blade
              play build_prog.look.to_a[2], cutoff: rrand(88, 105), release: 0.22, amp: 0.30
              use_synth :supersaw
              play build_prog.look.to_a[0] + 12, cutoff: (line 85, 110, steps: 24).look, release: 0.18, amp: 0.26

              # --- Bass offbeat ---
              use_synth :tb303
              play chords_roots[i % 4], cutoff: rrand(65, 88 + rep * 5), res: 0.82, release: 0.35, wave: 1, amp: 0.58

              # --- Percussion offbeat ---
              if i % 2 == 1
                sample :drum_snare_hard, amp: 0.65
                sample :elec_snap, amp: 0.50
                sample :drum_cymbal_open, amp: 0.40
              else
                sample :drum_cymbal_open, amp: 0.28 if one_in(2)
              end
              sample :hat_cab, amp: 0.28
              sleep 0.25

              if i == 7
                use_synth :subpulse
                play :a1, cutoff: 72, release: 0.18, amp: 0.52, pulse_width: 0.3
              end
              sample :drum_cymbal_open, amp: 0.30 if rep == 2 && one_in(3)
              sample :drum_cymbal_closed, amp: 0.26
              sleep 0.25
            end
          end
        end
      end
    end

    # =============================================
    # TRANSITION 2: Drone bridge D -> F key change
    # =============================================
    use_synth :blade
    play :f4, cutoff: 90, release: 10, amp: 0.45
    use_synth :dsaw
    play :c4, cutoff: 85, release: 10, amp: 0.36
    use_synth :rhodey
    play_chord chord(:f3, :major7), cutoff: 88, release: 10, amp: 0.38
    use_synth :bass_foundation
    play :f1, cutoff: 68, release: 10, amp: 0.62
    use_synth :tb303
    play :c3, cutoff: 78, res: 0.8, release: 10, wave: 0, amp: 0.48
    sample :drum_roll, amp: 0.40
    4.times do |i|
      sample :hat_cab, amp: 0.30 + (i * 0.04)
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.25
      sleep 0.5
    end

    # =============================================
    # SECTION 3: Key Change to F major — Euphoric
    # Melody: dsaw lead | Harmony: supersaw+rhodey+blade pads
    # Bass: tb303+subpulse+bass_foundation | Full percussion
    # =============================================
    melody_f       = (ring :f4, :a4, :c5, :f5, :e5, :c5, :a4, :g4)
    bass_ring_f    = (ring :f2, :c3, :f2, :bb2, :f2, :g2, :a2, :c3)
    chords_roots_f = (ring :f2, :bb2, :c3, :d2)
    euph_prog      = (ring chord(:f3, :major7), chord(:bb3, :major), chord(:c4, :sus4), chord(:f3, :major))

    3.times do
      # Bright sustaining drones in F
      use_synth :blade
      play :f3, cutoff: 100, release: 16, amp: 0.32
      use_synth :bass_foundation
      play :f1, cutoff: 70, release: 16, amp: 0.68

      with_fx :reverb, room: 0.3, mix: 0.28 do
        with_fx :lpf, cutoff: 118, mix: 1.0 do
          8.times do |i|
            # --- Melody ---
            use_synth :dsaw
            play melody_f.tick, cutoff: (line 100, 125, steps: 16).tick, release: 0.38, amp: 0.95

            # --- Harmony ---
            use_synth :supersaw
            play_chord euph_prog.tick, cutoff: (line 90, 115, steps: 24).look, release: 0.32, amp: 0.55
            use_synth :rhodey
            play euph_prog.look.to_a[1], cutoff: 92, release: 0.45, amp: 0.42

            # --- Bass ---
            use_synth :subpulse
            play bass_ring_f.tick, cutoff: 80, release: 0.68, amp: 0.72, pulse_width: 0.3

            # --- Percussion ---
            sample :bd_klub, amp: (i % 4 == 0 ? 0.90 : 0.78)
            sample :drum_cymbal_closed, amp: 0.40
            sleep 0.25

            sample :hat_cab, amp: 0.28
            sleep 0.25

            # --- Harmony offbeat ---
            use_synth :blade
            play euph_prog.look.to_a[2], cutoff: rrand(90, 108), release: 0.25, amp: 0.32
            use_synth :rhodey
            play euph_prog.look.to_a[0] + 12, cutoff: 88, release: 0.18, amp: 0.28

            # --- Bass offbeat ---
            use_synth :tb303
            play chords_roots_f[i % 4], cutoff: rrand(68, 90), res: 0.83, release: 0.32, wave: 0, amp: 0.58

            # --- Percussion offbeat ---
            if i % 2 == 1
              sample :drum_snare_hard, amp: 0.68
              sample :elec_snap, amp: 0.52
              sample :drum_cymbal_open, amp: 0.42
            else
              sample :drum_cymbal_open, amp: 0.30 if one_in(2)
            end
            sample :drum_cymbal_closed, amp: 0.30
            sleep 0.25

            if i % 4 == 3
              use_synth :subpulse
              play :c3, cutoff: 75, release: 0.2, amp: 0.50, pulse_width: 0.25
            end
            sample :hat_cab, amp: 0.20 if one_in(3)
            sample :drum_cymbal_closed, amp: 0.24
            sleep 0.25
          end
        end
      end
    end

    # =============================================
    # TRANSITION 3: Drone bridge into outro
    # =============================================
    use_synth :blade
    play :f4, cutoff: 92, release: 10, amp: 0.42
    use_synth :dsaw
    play :c4, cutoff: 88, release: 10, amp: 0.34
    use_synth :rhodey
    play_chord chord(:f3, :major7), cutoff: 85, release: 10, amp: 0.35
    use_synth :bass_foundation
    play :f1, cutoff: 65, release: 10, amp: 0.60
    use_synth :tb303
    play :f2, cutoff: 72, res: 0.8, release: 10, wave: 0, amp: 0.46
    4.times do
      sample :drum_cymbal_closed, amp: 0.26
      sleep 0.5
      sample :hat_cab, amp: 0.20
      sleep 0.5
    end

    # =============================================
    # SECTION 4: Outro — F major, stripped back
    # Melody: dsaw solo | Harmony: gentle rhodey+blade
    # Bass: simple subpulse walk | Percussion: lighter
    # =============================================
    melody_out  = (ring :f5, :e5, :c5, :a4, :g4, :f4, :c4, :f4)
    bass_out    = (ring :f2, :e2, :c3, :a2, :g2, :f2, :c2, :f2)
    outro_prog  = (ring chord(:f3, :major7), chord(:c3, :major), chord(:bb3, :major), chord(:f3, :major))

    2.times do
      # Gentle sustain drones
      use_synth :blade
      play :f3, cutoff: 82, release: 16, amp: 0.26
      use_synth :bass_foundation
      play :f1, cutoff: 63, release: 16, amp: 0.60

      8.times do |i|
        # --- Melody ---
        use_synth :dsaw
        play melody_out.tick, cutoff: rrand(85, 105), release: 0.5, amp: 0.90

        # --- Harmony ---
        use_synth :rhodey
        play_chord outro_prog.tick, cutoff: (line 80, 95, steps: 16).look, release: 0.5, amp: 0.48
        use_synth :blade
        play outro_prog.look.to_a.choose, cutoff: rrand(80, 98), release: 0.6, amp: 0.28

        # --- Bass ---
        use_synth :subpulse
        play bass_out.tick, cutoff: 74, release: 0.7, amp: 0.65, pulse_width: 0.28

        # --- Percussion ---
        sample :bd_klub, amp: (i % 4 == 0 ? 0.72 : 0.58) if i % 2 == 0
        sample :drum_cymbal_closed, amp: 0.30
        sleep 0.25

        sample :hat_cab, amp: 0.18
        sleep 0.25

        # --- Harmony offbeat ---
        use_synth :rhodey
        play outro_prog.look.to_a[0], cutoff: 85, release: 0.3, amp: 0.24

        # --- Bass offbeat ---
        if i.odd?
          use_synth :tb303
          play bass_out.look, cutoff: rrand(62, 80), res: 0.78, release: 0.28, wave: 0, amp: 0.50
        end

        # --- Percussion offbeat ---
        if i % 2 == 1
          sample :drum_snare_hard, amp: 0.50
          sample :elec_snap, amp: 0.36
        end
        sample :drum_cymbal_open, amp: (i % 2 == 1 ? 0.30 : 0.18)
        sleep 0.25

        sample :drum_cymbal_closed, amp: 0.20
        sleep 0.25
      end
    end

  end
end