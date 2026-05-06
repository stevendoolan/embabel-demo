# Circuits and Strings
# Style: Hybrid electronic/orchestral | Mood: Dynamic, evolving, cinematic

use_debug false
use_bpm 112

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ── Section 1: Dm Opening — melody, harmony, bass, and percussion together (2 × 4 bars) ──
    dm_melody     = (ring :d4, :f4, :a4, :c5, :a4, :f4, :e4, :d4)
    dm_bass_walk  = (ring :d2, :f2, :a2, :c2, :a2, :f2, :e2, :d2)
    dm_root_ring  = (ring :d2, :a2, :f2, :c2)
    dm_bass_mel   = (ring :d3, :a3, :f3, :c3)
    dm_chords     = (ring chord(:d3, :minor7), chord(:f3, :major7), chord(:c3, :major), chord(:g3, :minor7))
    dm_arp        = (ring :d3, :f3, :a3, :c4, :a3, :f3, :e3, :d3)

    2.times do
      # Long drones underneath
      use_synth :blade
      play :d3, release: 16, cutoff: 85, amp: 0.35
      use_synth :dark_ambience
      play :d2, cutoff: 85, release: 16, amp: 0.32
      use_synth :bass_foundation
      play :d1, cutoff: 65, release: 16, amp: 0.72

      # Hollow pad chord — one per 4 beats
      with_fx :reverb, room: 0.28, mix: 0.28 do
        use_synth :hollow
        play_chord dm_chords.tick, cutoff: 88, release: 4, amp: 0.52
      end

      with_fx :reverb, room: 0.25, mix: 0.25 do
        with_fx :lpf, cutoff: 82, mix: 1.0 do
          4.times do
            # Beat 1 — kick accent + melody + bass
            sample :bd_haus, amp: 0.72
            sample :hat_zild, amp: 0.28
            use_synth :piano
            play dm_melody.tick, cutoff: (line 85, 115, steps: 16).tick, release: 0.35, amp: 0.95
            use_synth :subpulse
            play :d2, cutoff: 72, release: 0.8, amp: 0.68
            sleep 0.25
            sample :hat_zild, amp: 0.2
            sleep 0.25

            # Beat 1 e+
            sample :drum_snare_hard, amp: 0.25, rate: 1.4
            sample :hat_zild, amp: 0.22
            use_synth :piano
            play dm_melody.look, cutoff: rrand(80, 108), release: 0.25, amp: 0.88
            use_synth :tb303
            play dm_bass_walk.tick, cutoff: 78, release: 0.45, amp: 0.58, res: 0.5
            sleep 0.25
            sample :hat_zild, amp: 0.16 if one_in(2)
            sleep 0.25

            # Beat 2 — snare + melody
            sample :drum_snare_hard, amp: 0.58
            sample :hat_zild, amp: 0.26
            use_synth :piano
            play dm_melody.tick, cutoff: rrand(85, 112), release: 0.3, amp: 0.9
            use_synth :tb303
            play dm_bass_walk.tick, cutoff: 74, release: 0.5, amp: 0.6, res: 0.45
            sleep 0.25
            sample :hat_zild, amp: 0.18
            sleep 0.25

            # Beat 2 e+
            sample :hat_zild, amp: 0.32 if one_in(3)
            sample :elec_snare, amp: 0.18 if one_in(4)
            use_synth :piano
            play dm_melody.look, cutoff: rrand(80, 105), release: 0.2, amp: 0.84
            use_synth :subpulse
            play dm_root_ring.tick, cutoff: 70, release: 0.6, amp: 0.62
            use_synth :fm
            play dm_arp.tick, cutoff: (line 82, 108, steps: 16).tick, release: 0.28, divisor: 2.0, depth: 3, amp: 0.38
            sleep 0.25
            sample :hat_zild, amp: 0.16
            sleep 0.25

            # Beat 3 — kick + melody
            sample :bd_haus, amp: 0.65
            sample :hat_zild, amp: 0.24
            use_synth :piano
            play dm_melody.tick, cutoff: rrand(88, 118), release: 0.3, amp: 0.92
            use_synth :tb303
            play dm_bass_walk.tick, cutoff: 76, release: 0.45, amp: 0.58, res: 0.5
            sleep 0.25
            sample :hat_zild, amp: 0.18
            sleep 0.25

            # Beat 3 e+
            sample :elec_snare, amp: 0.3 if one_in(2)
            sample :hat_zild, amp: 0.22
            use_synth :piano
            play dm_melody.look, cutoff: rrand(82, 110), release: 0.22, amp: 0.85
            use_synth :tb303
            play dm_bass_walk.look, cutoff: 72, release: 0.35, amp: 0.52, res: 0.4
            use_synth :fm
            play dm_arp.tick, cutoff: rrand(82, 108), release: 0.25, divisor: 2.0, depth: 3, amp: 0.36
            sleep 0.25
            sample :hat_zild, amp: 0.16
            sleep 0.25

            # Beat 4 — snare + bass melody
            sample :drum_snare_hard, amp: 0.55
            sample :hat_zild, amp: 0.26
            use_synth :piano
            play dm_bass_mel.tick, cutoff: 90, release: 0.55, amp: 0.72
            use_synth :bass_foundation
            play :d2, cutoff: 68, release: 1.0, amp: 0.68
            sleep 0.25

            # Beat 4 e+
            sample :hat_zild, amp: 0.3 if one_in(2)
            sleep 0.25
            sample :elec_snare, amp: 0.25 if one_in(3)
            sample :hat_zild, amp: 0.22
            use_synth :subpulse
            play :a2, cutoff: 74, release: 0.5, amp: 0.55
            sleep 0.25

            # Hollow pad refresh every 2 bars
            if (dm_chords.look.length rescue 0) == 0 || one_in(2)
              with_fx :reverb, room: 0.28, mix: 0.28 do
                use_synth :hollow
                play_chord dm_chords.tick, cutoff: (line 80, 105, steps: 8).look, release: 4, amp: 0.5
              end
            end
            sample :hat_zild, amp: 0.2
            sleep 0.25
          end
        end
      end
    end

    # ── Transition 1: Dm → Em drone bridge ──
    use_synth :blade
    play :d3, cutoff: 90, release: 8, amp: 0.42
    use_synth :piano
    play :a3, cutoff: 88, release: 6, amp: 0.28
    use_synth :dark_ambience
    play :d2, cutoff: 88, release: 8, amp: 0.38
    use_synth :hollow
    play_chord chord(:d3, :minor7), cutoff: 85, release: 6, amp: 0.42
    use_synth :bass_foundation
    play :d1, cutoff: 68, release: 8, amp: 0.68
    use_synth :subpulse
    play :a2, cutoff: 70, release: 6, amp: 0.48
    sample :drum_cymbal_hard, amp: 0.5
    sleep 1
    sample :drum_snare_hard, amp: 0.38, rate: 0.9
    sleep 1
    sample :bd_haus, amp: 0.55
    sleep 1
    sample :drum_cymbal_open, amp: 0.42
    sleep 1

    # ── Section 2: Em Key Change — winwood_lead melody, fm arpeggios, walking bass, syncopated drums (2 × 4 bars) ──
    em_melody      = (ring :e4, :g4, :b4, :d5, :b4, :g4, :fs4, :e4)
    em_bass_walk   = (ring :e2, :g2, :b2, :d2, :b2, :g2, :fs2, :e2)
    em_root_ring   = (ring :e2, :b2, :g2, :d2)
    em_bass_mel    = (ring :e3, :b3, :g3, :d3)
    em_chords_sus  = (ring chord(:e3, :minor7), chord(:b3, :minor), chord(:g3, :major), chord(:a3, :sus4))
    em_arp         = (ring :e3, :g3, :b3, :d4, :b3, :g3, :fs3, :e3)

    2.times do
      # Long drones underneath
      use_synth :blade
      play :e3, release: 16, cutoff: 88, amp: 0.36
      use_synth :dark_ambience
      play :e2, cutoff: 88, release: 16, amp: 0.32
      use_synth :bass_foundation
      play :e1, cutoff: 68, release: 16, amp: 0.72

      # Hollow pad chord
      with_fx :reverb, room: 0.28, mix: 0.28 do
        use_synth :hollow
        play_chord em_chords_sus.tick, cutoff: 90, release: 4, amp: 0.52
      end

      with_fx :lpf, cutoff: 115, mix: 1.0 do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          4.times do
            # Beat 1 — kick + winwood lead + bass
            sample :bd_haus, amp: 0.75
            sample :hat_zild, amp: 0.3
            use_synth :winwood_lead
            play em_melody.tick, cutoff: (line 90, 120, steps: 16).tick, release: 0.3, amp: 0.97
            use_synth :fm
            play em_arp.tick, cutoff: (line 82, 118, steps: 16).tick, release: 0.3, divisor: 2.0, depth: 3, amp: 0.42
            use_synth :subpulse
            play :e2, cutoff: 75, release: 0.85, amp: 0.68
            sleep 0.25
            sample :hat_zild, amp: 0.22
            sleep 0.25

            # Beat 1 e+
            sample :elec_snare, amp: 0.28 if one_in(2)
            sample :hat_zild, amp: 0.2
            use_synth :winwood_lead
            play em_melody.look, cutoff: rrand(85, 112), release: 0.2, amp: 0.9
            use_synth :tb303
            play em_bass_walk.tick, cutoff: 80, release: 0.4, amp: 0.6, res: 0.5
            sleep 0.25
            sample :hat_zild, amp: 0.16
            sleep 0.25

            # Beat 2 — snare stack + melody
            sample :drum_snare_hard, amp: 0.6
            sample :elec_snare, amp: 0.34
            sample :hat_zild, amp: 0.26
            use_synth :winwood_lead
            play em_melody.tick, cutoff: rrand(90, 118), release: 0.28, amp: 0.93
            use_synth :tb303
            play em_bass_walk.tick, cutoff: 76, release: 0.48, amp: 0.6, res: 0.48
            sleep 0.25
            sample :hat_zild, amp: 0.2
            sleep 0.25

            # Beat 2 e+
            sample :bd_haus, amp: 0.4 if one_in(3)
            sample :hat_zild, amp: 0.24 if one_in(2)
            use_synth :winwood_lead
            play em_melody.look, cutoff: rrand(85, 108), release: 0.18, amp: 0.87
            use_synth :subpulse
            play em_root_ring.tick, cutoff: 72, release: 0.65, amp: 0.62
            use_synth :fm
            play em_arp.tick, cutoff: rrand(88, 116), release: 0.25, divisor: 2.0, depth: 4, amp: 0.4
            sleep 0.25
            sample :hat_zild, amp: 0.18
            sleep 0.25

            # Beat 3 — kick + melody
            sample :bd_haus, amp: 0.68
            sample :hat_zild, amp: 0.26
            use_synth :winwood_lead
            play em_melody.tick, cutoff: rrand(92, 120), release: 0.28, amp: 0.94
            use_synth :tb303
            play em_bass_walk.tick, cutoff: 78, release: 0.42, amp: 0.58, res: 0.45
            sleep 0.25
            sample :hat_zild, amp: 0.2
            sleep 0.25

            # Beat 3 e+
            sample :elec_snare, amp: 0.36 if one_in(2)
            sample :hat_zild, amp: 0.22
            use_synth :winwood_lead
            play em_melody.look, cutoff: rrand(88, 114), release: 0.2, amp: 0.88
            use_synth :tb303
            play em_bass_walk.look, cutoff: 74, release: 0.32, amp: 0.53, res: 0.4
            use_synth :fm
            play em_arp.tick, cutoff: rrand(90, 118), release: 0.22, divisor: 2.0, depth: 4, amp: 0.38
            sleep 0.25
            sample :hat_zild, amp: 0.18
            sleep 0.25

            # Beat 4 — snare + bass root
            sample :drum_snare_hard, amp: 0.56
            sample :drum_cymbal_hard, amp: 0.38 if one_in(4)
            sample :hat_zild, amp: 0.26
            use_synth :piano
            play em_bass_mel.tick, cutoff: 92, release: 0.5, amp: 0.7
            use_synth :bass_foundation
            play :e2, cutoff: 70, release: 1.1, amp: 0.7
            sleep 0.25
            sample :hat_zild, amp: 0.22
            sleep 0.25

            # Beat 4 e+
            sample :hat_zild, amp: 0.34
            use_synth :subpulse
            play :b2, cutoff: 76, release: 0.55, amp: 0.56
            sleep 0.25
            sample :elec_snare, amp: 0.24 if one_in(3)
            sample :hat_zild, amp: 0.26

            # Hollow pad refresh
            with_fx :reverb, room: 0.28, mix: 0.28 do
              use_synth :hollow
              play_chord em_chords_sus.tick, cutoff: (line 85, 110, steps: 8).look, release: 4, amp: 0.5
            end
            sleep 0.25
          end
        end
      end
    end

    # ── Transition 2: Em → Finale drone bridge ──
    use_synth :blade
    play :e3, cutoff: 92, release: 8, amp: 0.42
    use_synth :piano
    play :b3, cutoff: 90, release: 6, amp: 0.28
    use_synth :dark_ambience
    play :e2, cutoff: 92, release: 8, amp: 0.4
    use_synth :hollow
    play_chord chord(:e3, :minor7), cutoff: 88, release: 6, amp: 0.42
    use_synth :bass_foundation
    play :e1, cutoff: 70, release: 8, amp: 0.72
    use_synth :subpulse
    play :b2, cutoff: 72, release: 6, amp: 0.5
    sample :drum_cymbal_hard, amp: 0.58
    sleep 0.5
    sample :drum_snare_hard, amp: 0.42, rate: 0.95
    sleep 0.5
    sample :bd_haus, amp: 0.6
    sample :elec_snare, amp: 0.28
    sleep 0.5
    sample :drum_cymbal_open, amp: 0.46
    sample :drum_snare_hard, amp: 0.35
    sleep 0.5
    sample :drum_cymbal_hard, amp: 0.52
    sleep 1
    sample :elec_snare, amp: 0.36
    sleep 0.5
    sample :hat_zild, amp: 0.3
    sleep 0.5

    # ── Section 3: Em Climax — blade + piano melody, dense pads, heavy bass, full drums (2 × 4 bars) ──
    em_climax      = (ring :e5, :d5, :b4, :g4, :fs4, :e4, :b4, :e5)
    em_harmony     = (ring :e3, :g3, :b3, :e3)
    em_climax_bass = (ring :e2, :g2, :b2, :e2, :d2, :b1, :g1, :e1)
    em_fifth_ring  = (ring :b2, :e2, :g2, :b2)
    em_climax_chords = (ring chord(:e3, :minor), chord(:g3, :major), chord(:d3, :major), chord(:a3, :minor), chord(:b3, :minor), chord(:e3, :minor), chord(:g3, :major), chord(:b3, :minor))

    2.times do
      # Long deep drones for climax
      use_synth :blade
      play :e2, release: 16, cutoff: 95, amp: 0.38
      use_synth :dark_ambience
      play :e1, cutoff: 95, release: 16, amp: 0.38
      use_synth :bass_foundation
      play :e1, cutoff: 72, release: 16, amp: 0.75

      with_fx :reverb, room: 0.28, mix: 0.25 do
        4.times do
          # Beat 1 — full kick + cymbal crash + blade melody + harmony pad
          sample :bd_haus, amp: 0.82
          sample :drum_cymbal_open, amp: 0.44
          sample :hat_zild, amp: 0.32
          use_synth :blade
          play em_climax.tick, cutoff: (line 95, 125, steps: 16).tick, release: 0.35, amp: 0.97
          use_synth :piano
          play em_harmony.tick, cutoff: 88, release: 0.5, amp: 0.45
          use_synth :hollow
          play_chord em_climax_chords.tick, cutoff: (line 88, 118, steps: 8).tick, release: 1.8, amp: 0.52
          use_synth :fm
          play em_climax_chords.look[0], cutoff: rrand(88, 115), release: 0.4, divisor: 2.5, depth: 4, amp: 0.36
          use_synth :subpulse
          play :e2, cutoff: 78, release: 1.0, amp: 0.72
          use_synth :tb303
          play :e2, cutoff: 85, release: 0.5, amp: 0.62, res: 0.55
          sleep 0.25
          sample :hat_zild, amp: 0.26
          sleep 0.25

          # Beat 1 e+
          sample :elec_snare, amp: 0.34 if one_in(2)
          sample :hat_zild, amp: 0.22
          use_synth :blade
          play em_climax.look, cutoff: rrand(90, 118), release: 0.22, amp: 0.92
          use_synth :tb303
          play em_climax_bass.tick, cutoff: 80, release: 0.4, amp: 0.6, res: 0.5
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.2
          sleep 0.25

          # Beat 2 — snare stack + melody
          sample :drum_snare_hard, amp: 0.64
          sample :elec_snare, amp: 0.38
          sample :hat_zild, amp: 0.28
          use_synth :blade
          play em_climax.tick, cutoff: rrand(92, 120), release: 0.28, amp: 0.93
          use_synth :hollow
          play_chord em_climax_chords.tick, cutoff: (line 90, 120, steps: 8).tick, release: 1.8, amp: 0.5
          use_synth :fm
          play em_climax_chords.look[0], cutoff: rrand(90, 118), release: 0.4, divisor: 2.5, depth: 5, amp: 0.33
          use_synth :tb303
          play em_climax_bass.tick, cutoff: 78, release: 0.42, amp: 0.6, res: 0.48
          sleep 0.25
          sample :hat_zild, amp: 0.22
          sleep 0.25

          # Beat 2 e+
          sample :bd_haus, amp: 0.38 if one_in(3)
          sample :hat_zild, amp: 0.26 if one_in(2)
          use_synth :blade
          play em_climax.look, cutoff: rrand(88, 115), release: 0.2, amp: 0.9
          use_synth :subpulse
          play em_fifth_ring.tick, cutoff: 74, release: 0.7, amp: 0.62
          sleep 0.25
          sample :hat_zild, amp: 0.2
          sleep 0.25

          # Beat 3 — kick + cymbal + melody + piano harmony
          sample :bd_haus, amp: 0.72
          sample :drum_cymbal_hard, amp: 0.42 if one_in(2)
          sample :hat_zild, amp: 0.28
          use_synth :blade
          play em_climax.tick, cutoff: rrand(95, 125), release: 0.3, amp: 0.95
          use_synth :piano
          play em_harmony.look, cutoff: 90, release: 0.45, amp: 0.42
          use_synth :tb303
          play em_climax_bass.tick, cutoff: 76, release: 0.38, amp: 0.58, res: 0.45
          sleep 0.25
          sample :hat_zild, amp: 0.22
          sleep 0.25

          # Beat 3 e+
          sample :elec_snare, amp: 0.32 if one_in(2)
          sample :hat_zild, amp: 0.36
          use_synth :blade
          play em_climax.look, cutoff: rrand(90, 118), release: 0.2, amp: 0.88
          use_synth :tb303
          play em_climax_bass.look, cutoff: 72, release: 0.3, amp: 0.52, res: 0.4
          sleep 0.25
          sample :hat_zild, amp: 0.32
          sleep 0.25

          # Beat 4 — snare + open cymbal + bass resolve
          sample :drum_snare_hard, amp: 0.62
          sample :drum_cymbal_open, amp: 0.34 if one_in(3)
          sample :hat_zild, amp: 0.26
          use_synth :piano
          play em_harmony.tick, cutoff: 92, release: 0.55, amp: 0.68
          use_synth :bass_foundation
          play :e2, cutoff: 70, release: 1.2, amp: 0.72
          sleep 0.25
          sample :hat_zild, amp: 0.26
          sleep 0.25

          # Beat 4 e+ — climactic 16th roll
          sample :hat_zild, amp: 0.42
          sample :elec_snare, amp: 0.28 if one_in(2)
          use_synth :subpulse
          play :b1, cutoff: 68, release: 0.8, amp: 0.6
          sleep 0.25
          sample :hat_zild, amp: 0.35
          sample :bd_haus, amp: 0.46 if one_in(3)
          sleep 0.25
        end
      end
    end

  end
end