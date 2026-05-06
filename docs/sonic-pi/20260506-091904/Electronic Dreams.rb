# Electronic Dreams
# Style: Dreamy Electronic | Mood: Evolving, Atmospheric
# Key: Am -> Cm | BPM: 128 | Time: 4/4

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =====================
    # Section 1: Am - Dreamy opening
    # Melody: blade arpeggios | Harmony: hollow pad + supersaw stabs
    # Bass: subpulse drone + bass_foundation walk | Percussion: sparse kick/hat
    # =====================
    am_melody     = (ring :a4, :c5, :e5, :a4, :g4, :e4, :c5, :e5)
    am_bass_notes = (ring :a1, :a1, :e2, :a1, :g1, :a1, :e2, :g1)
    am_chords     = (ring chord(:a3, :minor), chord(:f3, :major), chord(:c3, :major), chord(:e3, :minor))
    am_stabs      = (ring chord(:a4, :minor), chord(:f4, :major), chord(:c4, :major), chord(:e4, :minor))

    3.times do
      # Long drones underneath
      use_synth :blade
      play :a3, release: 16, cutoff: 85, amp: 0.35

      use_synth :subpulse
      play :a1, cutoff: 65, release: 16, amp: 0.65

      use_synth :hollow
      play_chord chord(:a2, :minor), cutoff: 82, release: 16, amp: 0.5

      # 4 bars of integrated melody + harmony + bass + percussion
      4.times do
        # --- Beat 1 ---
        # Melody
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          with_fx :reverb, room: 0.28, mix: 0.3 do
            use_synth :blade
            play am_melody.tick, release: 0.45, cutoff: rrand(82, 108), amp: 0.95
          end
        end
        # Harmony pad
        use_synth :hollow
        play_chord am_chords.tick, cutoff: rrand(80, 100), release: 3.5, amp: 0.5
        # Bass
        use_synth :bass_foundation
        play am_bass_notes.tick, cutoff: rrand(62, 78), release: 0.8, amp: 0.65
        # Percussion beat 1
        with_fx :hpf, cutoff: 90, mix: 1.0 do
          sample :bd_808, amp: 0.7, cutoff: 80
          sample :drum_cymbal_closed, amp: 0.32
        end
        sleep 0.25
        sample :hat_gem, amp: 0.26
        sleep 0.25

        # --- Beat 2 ---
        use_synth :blade
        with_fx :reverb, room: 0.28, mix: 0.3 do
          play am_melody.tick, release: 0.45, cutoff: rrand(82, 108), amp: 0.95
        end
        use_synth :bass_foundation
        play am_bass_notes.tick, cutoff: rrand(62, 78), release: 0.8, amp: 0.65
        use_synth :supersaw
        play_chord am_stabs.look, cutoff: 88, release: 0.18, amp: 0.35
        sample :elec_snare, amp: 0.58
        sample :hat_gem, amp: 0.3
        sleep 0.25
        sample :hat_gem, amp: 0.2
        sleep 0.25

        # --- Beat 3 ---
        use_synth :blade
        with_fx :reverb, room: 0.28, mix: 0.3 do
          play am_melody.tick, release: 0.45, cutoff: rrand(82, 108), amp: 0.95
        end
        use_synth :bass_foundation
        play am_bass_notes.tick, cutoff: rrand(62, 78), release: 0.8, amp: 0.65
        sample :bd_808, amp: 0.62, cutoff: 80
        sample :drum_cymbal_closed, amp: 0.28
        sleep 0.25
        sample :hat_gem, amp: 0.26
        sleep 0.25

        # --- Beat 4 ---
        use_synth :blade
        with_fx :reverb, room: 0.28, mix: 0.3 do
          play am_melody.tick, release: 0.45, cutoff: rrand(82, 108), amp: 0.95
        end
        use_synth :bass_foundation
        play am_bass_notes.tick, cutoff: rrand(62, 78), release: 0.8, amp: 0.65
        use_synth :supersaw
        play_chord am_stabs.look, cutoff: 84, release: 0.15, amp: 0.3
        sample :elec_hi_snare, amp: 0.52
        sample :elec_snare, amp: 0.48
        sample :hat_gem, amp: 0.3
        sleep 0.25
        sample :hat_gem, amp: 0.18
        sleep 0.25
      end
    end

    # =====================
    # Transition 1: Bridge Am -> Section 2
    # =====================
    use_synth :fm
    play :a2, release: 8, cutoff: 90, amp: 0.5
    use_synth :dark_ambience
    play :a2, cutoff: 90, release: 8, amp: 0.45
    use_synth :subpulse
    play :a1, cutoff: 68, release: 8, amp: 0.55
    sample :bd_808, amp: 0.65, cutoff: 75
    sleep 1
    sample :elec_cymbal, amp: 0.38
    sleep 1
    sample :bd_808, amp: 0.58, cutoff: 75
    sleep 1
    sample :hat_zild, amp: 0.28
    sleep 1

    # =====================
    # Section 2: Am - Chiplead arpeggios + evolving harmony
    # Melody: chiplead eighth-note arps | Harmony: dark_ambience + hollow chords
    # Bass: subpulse + tb303 rolling groove | Percussion: rapid 16th-note hats
    # =====================
    am_arp      = (ring :a4, :e5, :c5, :a4, :g4, :c5, :e5, :g4,
                        :a4, :e5, :c5, :a5, :g4, :e5, :d5, :c5)
    am_bass_arp = (ring :a1, :a1, :e2, :a1, :g1, :e2, :a1, :g1)
    am2_chords  = (ring chord(:a3, :minor), chord(:e3, :minor), chord(:f3, :major), chord(:g3, :major))
    am2_stabs   = (ring chord(:a4, :minor), chord(:e4, :minor), chord(:f4, :major), chord(:g4, :major))

    3.times do
      # Long drones
      use_synth :mod_sine
      play :a2, release: 16, cutoff: 78, amp: 0.32

      use_synth :dark_ambience
      play :a2, cutoff: 80, release: 16, amp: 0.42

      use_synth :subpulse
      play :a1, cutoff: 62, release: 16, amp: 0.65

      # 4 bars: each bar = 8 eighth-note melody steps + harmony/bass/perc per beat
      4.times do
        # Beat 1
        use_synth :chiplead
        play am_arp.tick, release: 0.18, cutoff: (line 85, 115, steps: 32).tick, amp: 0.95
        use_synth :hollow
        play_chord am2_chords.tick, cutoff: rrand(82, 110), release: 3.8, amp: 0.45
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          play am_bass_arp.tick, cutoff: (line 65, 88, steps: 32).tick, release: 0.45, amp: 0.58, res: 0.8
        end
        sample :bd_808, amp: 0.78, cutoff: 82
        sample :hat_zild, amp: 0.36
        sleep 0.25
        use_synth :chiplead
        play am_arp.tick, release: 0.18, cutoff: (line 85, 115, steps: 32).tick, amp: 0.95
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          play am_bass_arp.tick, cutoff: (line 65, 88, steps: 32).tick, release: 0.45, amp: 0.58, res: 0.8
        end
        sample :hat_zild, amp: 0.2
        sleep 0.25

        # Beat 2
        use_synth :chiplead
        play am_arp.tick, release: 0.18, cutoff: (line 85, 115, steps: 32).tick, amp: 0.95
        use_synth :supersaw
        play_chord am2_stabs.look, cutoff: 90, release: 0.12, amp: 0.28
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          play am_bass_arp.tick, cutoff: (line 65, 88, steps: 32).tick, release: 0.45, amp: 0.58, res: 0.8
        end
        sample :elec_snare, amp: 0.62
        sample :elec_hi_snare, amp: 0.42
        sample :hat_zild, amp: 0.32
        sleep 0.25
        use_synth :chiplead
        play am_arp.tick, release: 0.18, cutoff: (line 85, 115, steps: 32).tick, amp: 0.95
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          play am_bass_arp.tick, cutoff: (line 65, 88, steps: 32).tick, release: 0.45, amp: 0.58, res: 0.8
        end
        sample :hat_zild, amp: 0.22
        sleep 0.25

        # Beat 3
        use_synth :chiplead
        play am_arp.tick, release: 0.18, cutoff: (line 85, 115, steps: 32).tick, amp: 0.95
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          play am_bass_arp.tick, cutoff: (line 65, 88, steps: 32).tick, release: 0.45, amp: 0.58, res: 0.8
        end
        sample :bd_808, amp: 0.7, cutoff: 82
        sample :hat_zild, amp: 0.36
        sleep 0.25
        use_synth :chiplead
        play am_arp.tick, release: 0.18, cutoff: (line 85, 115, steps: 32).tick, amp: 0.95
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          play am_bass_arp.tick, cutoff: (line 65, 88, steps: 32).tick, release: 0.45, amp: 0.58, res: 0.8
        end
        sample :hat_zild, amp: 0.2
        sleep 0.25

        # Beat 4
        use_synth :chiplead
        play am_arp.tick, release: 0.18, cutoff: (line 85, 115, steps: 32).tick, amp: 0.95
        use_synth :supersaw
        play_chord am2_stabs.look, cutoff: 86, release: 0.12, amp: 0.26
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          play am_bass_arp.tick, cutoff: (line 65, 88, steps: 32).tick, release: 0.45, amp: 0.58, res: 0.8
        end
        sample :elec_snare, amp: 0.6
        sample :elec_hi_snare, amp: 0.4
        sample :hat_zild, amp: 0.32
        sleep 0.25
        use_synth :chiplead
        play am_arp.tick, release: 0.18, cutoff: (line 85, 115, steps: 32).tick, amp: 0.95
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          play am_bass_arp.tick, cutoff: (line 65, 88, steps: 32).tick, release: 0.45, amp: 0.58, res: 0.8
        end
        sample :hat_gem, amp: 0.26 if one_in(3)
        sample :hat_zild, amp: 0.18
        sleep 0.25
      end
    end

    # =====================
    # Transition 2: Bridge Am -> Cm key change
    # =====================
    use_synth :blade
    play :c3, release: 8, cutoff: 88, amp: 0.5
    use_synth :dark_ambience
    play :c2, cutoff: 88, release: 8, amp: 0.45
    use_synth :subpulse
    play :c2, cutoff: 70, release: 8, amp: 0.58
    sample :bd_808, amp: 0.72, cutoff: 78
    sleep 0.5
    sample :elec_cymbal, amp: 0.42
    sleep 0.5
    sample :elec_snare, amp: 0.52
    sleep 0.5
    sample :hat_zild, amp: 0.28
    sleep 0.5
    sample :bd_808, amp: 0.62, cutoff: 78
    sleep 0.5
    sample :hat_gem, amp: 0.26
    sleep 0.5
    sample :elec_cymbal, amp: 0.38
    sleep 1

    # =====================
    # Section 3: Cm - Key change, atmospheric dreamscape
    # Melody: mod_sine with echo | Harmony: hollow pad + supersaw stabs
    # Bass: subpulse + bass_foundation walk | Percussion: echoing kick/hat
    # =====================
    cm_melody     = (ring :c5, :eb5, :g5, :c5, :bb4, :g4, :eb5, :g5)
    cm_bass_notes = (ring :c2, :c2, :g2, :c2, :bb1, :c2, :g2, :bb1)
    cm_chords     = (ring chord(:c3, :minor), chord(:ab3, :major), chord(:eb3, :major), chord(:bb3, :major))
    cm_stabs      = (ring chord(:c4, :minor), chord(:ab4, :major), chord(:eb4, :major), chord(:bb4, :major))

    3.times do
      # Long drones in Cm
      use_synth :blade
      play :c3, release: 16, cutoff: 82, amp: 0.35

      use_synth :hollow
      play_chord chord(:c2, :minor), cutoff: 80, release: 16, amp: 0.5

      use_synth :subpulse
      play :c1, cutoff: 63, release: 16, amp: 0.68

      # 4 bars
      4.times do
        # Beat 1
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
          use_synth :mod_sine
          play cm_melody.tick, release: 0.5, cutoff: rrand(80, 112), amp: 0.95
        end
        with_fx :reverb, room: 0.3, mix: 0.32 do
          use_synth :hollow
          play_chord cm_chords.tick, cutoff: rrand(80, 108), release: 3.6, amp: 0.48
        end
        use_synth :bass_foundation
        play cm_bass_notes.tick, cutoff: rrand(60, 80), release: 0.85, amp: 0.65
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.18 do
          sample :bd_808, amp: 0.75, cutoff: 80
          sample :drum_cymbal_closed, amp: 0.3
        end
        sleep 0.25
        sample :hat_gem, amp: 0.28
        sleep 0.25

        # Beat 2
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
          use_synth :mod_sine
          play cm_melody.tick, release: 0.5, cutoff: rrand(80, 112), amp: 0.95
        end
        use_synth :bass_foundation
        play cm_bass_notes.tick, cutoff: rrand(60, 80), release: 0.85, amp: 0.65
        use_synth :supersaw
        play_chord cm_stabs.look, cutoff: 90, release: 0.16, amp: 0.32
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.18 do
          sample :elec_snare, amp: 0.62
          sample :elec_hi_snare, amp: 0.38
          sample :hat_gem, amp: 0.33
        end
        sleep 0.25
        sample :hat_gem, amp: 0.2
        sleep 0.25

        # Beat 3
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
          use_synth :mod_sine
          play cm_melody.tick, release: 0.5, cutoff: rrand(80, 112), amp: 0.95
        end
        use_synth :bass_foundation
        play cm_bass_notes.tick, cutoff: rrand(60, 80), release: 0.85, amp: 0.65
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.18 do
          sample :bd_808, amp: 0.65, cutoff: 80
          sample :drum_cymbal_closed, amp: 0.26
        end
        sleep 0.25
        sample :hat_gem, amp: 0.28
        sleep 0.25

        # Beat 4
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
          use_synth :mod_sine
          play cm_melody.tick, release: 0.5, cutoff: rrand(80, 112), amp: 0.95
        end
        use_synth :bass_foundation
        play cm_bass_notes.tick, cutoff: rrand(60, 80), release: 0.85, amp: 0.65
        use_synth :supersaw
        play_chord cm_stabs.look, cutoff: 86, release: 0.14, amp: 0.28
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.18 do
          sample :elec_snare, amp: 0.6
          sample :elec_hi_snare, amp: 0.36
          sample :hat_gem, amp: 0.3
        end
        sleep 0.25
        sample :elec_cymbal, amp: 0.32 if one_in(4)
        sample :hat_gem, amp: 0.18
        sleep 0.25
      end
    end

    # =====================
    # Transition 3: Final bridge -> Cm high-energy finale
    # =====================
    use_synth :fm
    play :c2, release: 8, cutoff: 86, amp: 0.5
    use_synth :dark_ambience
    play :c2, cutoff: 86, release: 8, amp: 0.45
    use_synth :subpulse
    play :c1, cutoff: 66, release: 8, amp: 0.6
    sample :bd_808, amp: 0.78, cutoff: 80
    sleep 0.25
    sample :hat_zild, amp: 0.33
    sleep 0.25
    sample :elec_snare, amp: 0.58
    sleep 0.25
    sample :hat_zild, amp: 0.26
    sleep 0.25
    sample :bd_808, amp: 0.68, cutoff: 80
    sleep 0.25
    sample :elec_cymbal, amp: 0.4
    sleep 0.25
    sample :elec_snare, amp: 0.52
    sleep 0.25
    sample :hat_gem, amp: 0.28
    sleep 0.25
    sample :bd_808, amp: 0.62, cutoff: 80
    sleep 0.25
    sample :hat_zild, amp: 0.3
    sleep 0.25
    sample :elec_hi_snare, amp: 0.48
    sleep 0.25
    sample :hat_zild, amp: 0.22
    sleep 0.25
    sample :bd_808, amp: 0.72, cutoff: 80
    sleep 0.25
    sample :elec_cymbal, amp: 0.38
    sleep 0.25
    sample :elec_snare, amp: 0.62
    sleep 0.25
    sample :hat_zild, amp: 0.28
    sleep 0.25

    # =====================
    # Section 4: Cm - High-energy chiplead finale
    # Melody: chiplead rapid arps | Harmony: dark_ambience + hollow + supersaw
    # Bass: subpulse + tb303 energetic | Percussion: dense 16th hats + fills
    # =====================
    cm_arp      = (ring :c5, :g5, :eb5, :c5, :bb4, :eb5, :g5, :bb5,
                        :c5, :g5, :eb5, :c6, :bb4, :g5, :f5, :eb5)
    cm_bass_arp = (ring :c2, :c2, :g2, :c2, :bb1, :g2, :c2, :bb1)
    cm2_chords  = (ring chord(:c3, :minor), chord(:bb3, :major), chord(:ab3, :major), chord(:eb3, :major))
    cm2_stabs   = (ring chord(:c4, :minor), chord(:bb4, :major), chord(:ab4, :major), chord(:eb4, :major))

    3.times do
      # Long drones
      use_synth :mod_sine
      play :c2, release: 16, cutoff: 75, amp: 0.3

      use_synth :dark_ambience
      play :c2, cutoff: 78, release: 16, amp: 0.45

      use_synth :hollow
      play_chord chord(:c2, :minor), cutoff: 82, release: 16, amp: 0.38

      use_synth :subpulse
      play :c1, cutoff: 60, release: 16, amp: 0.68

      # 4 bars of 8 eighth-note steps each
      4.times do
        # Beat 1
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.28 do
            use_synth :chiplead
            play cm_arp.tick, release: 0.15, cutoff: (line 90, 120, steps: 32).tick, amp: 0.95
          end
        end
        use_synth :hollow
        play_chord cm2_chords.tick, cutoff: rrand(85, 115), release: 3.8, amp: 0.45
        use_synth :tb303
        play cm_bass_arp.tick, cutoff: (line 68, 90, steps: 32).tick, release: 0.4, amp: 0.6, res: 0.82
        sample :bd_808, amp: 0.82, cutoff: 85
        sample :hat_zild, amp: 0.4
        sleep 0.25
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          use_synth :chiplead
          play cm_arp.tick, release: 0.15, cutoff: (line 90, 120, steps: 32).tick, amp: 0.95
        end
        use_synth :tb303
        play cm_bass_arp.tick, cutoff: (line 68, 90, steps: 32).tick, release: 0.4, amp: 0.6, res: 0.82
        sample :hat_zild, amp: 0.26
        sleep 0.25

        # Beat 2
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          use_synth :chiplead
          play cm_arp.tick, release: 0.15, cutoff: (line 90, 120, steps: 32).tick, amp: 0.95
        end
        use_synth :supersaw
        play_chord cm2_stabs.look, cutoff: 92, release: 0.18, amp: 0.33
        use_synth :tb303
        play cm_bass_arp.tick, cutoff: (line 68, 90, steps: 32).tick, release: 0.4, amp: 0.6, res: 0.82
        sample :elec_snare, amp: 0.7
        sample :elec_hi_snare, amp: 0.5
        sample :hat_zild, amp: 0.38
        sleep 0.25
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          use_synth :chiplead
          play cm_arp.tick, release: 0.15, cutoff: (line 90, 120, steps: 32).tick, amp: 0.95
        end
        use_synth :tb303
        play cm_bass_arp.tick, cutoff: (line 68, 90, steps: 32).tick, release: 0.4, amp: 0.6, res: 0.82
        sample :hat_gem, amp: 0.28
        sleep 0.25

        # Beat 3
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          use_synth :chiplead
          play cm_arp.tick, release: 0.15, cutoff: (line 90, 120, steps: 32).tick, amp: 0.95
        end
        use_synth :tb303
        play cm_bass_arp.tick, cutoff: (line 68, 90, steps: 32).tick, release: 0.4, amp: 0.6, res: 0.82
        sample :bd_808, amp: 0.76, cutoff: 85
        sample :hat_zild, amp: 0.38
        sleep 0.25
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          use_synth :chiplead
          play cm_arp.tick, release: 0.15, cutoff: (line 90, 120, steps: 32).tick, amp: 0.95
        end
        use_synth :tb303
        play cm_bass_arp.tick, cutoff: (line 68, 90, steps: 32).tick, release: 0.4, amp: 0.6, res: 0.82
        sample :hat_zild, amp: 0.22
        sleep 0.25

        # Beat 4
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          use_synth :chiplead
          play cm_arp.tick, release: 0.15, cutoff: (line 90, 120, steps: 32).tick, amp: 0.95
        end
        use_synth :supersaw
        play_chord cm2_stabs.look, cutoff: 88, release: 0.15, amp: 0.3
        use_synth :tb303
        play cm_bass_arp.tick, cutoff: (line 68, 90, steps: 32).tick, release: 0.4, amp: 0.6, res: 0.82
        sample :elec_snare, amp: 0.66
        sample :elec_hi_snare, amp: 0.46
        sample :hat_zild, amp: 0.36
        sleep 0.25
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          use_synth :chiplead
          play cm_arp.tick, release: 0.15, cutoff: (line 90, 120, steps: 32).tick, amp: 0.95
        end
        use_synth :tb303
        play cm_bass_arp.tick, cutoff: (line 68, 90, steps: 32).tick, release: 0.4, amp: 0.6, res: 0.82
        sample :elec_cymbal, amp: 0.36 if one_in(3)
        sample :hat_gem, amp: 0.3 if one_in(2)
        sample :hat_zild, amp: 0.2
        sleep 0.25
      end
    end

  end
end