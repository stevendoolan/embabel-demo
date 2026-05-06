# Java User Group Dance Anthem
# Style: Electronic | Mood: Energetic

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================
    # SECTION 1: Key of A — Chiplead intro + pad stabs + pumping bass + intro beat
    # 2x8-bar phrases (each bar = 4 beats)
    # =============================================
    melody_notes_a = (ring :a4, :cs5, :e5, :a5, :e5, :cs5, :b4, :a4)
    bass_notes_a   = (ring :a2, :a2, :e3, :e3, :fs3, :fs3, :e3, :e3)
    chords_a1 = (ring
      chord(:a3, :major),
      chord(:e3, :major),
      chord(:fs3, :minor),
      chord(:e3, :major)
    )
    bass_ring_a = (ring :a1, :a1, :e2, :e2, :fs2, :fs2, :e2, :e2)

    2.times do
      # Long drones underneath
      use_synth :supersaw
      play :a2, release: 16, cutoff: 75, amp: 0.4, detune: 0.2
      use_synth :supersaw
      play_chord chord(:a2, :major7), cutoff: 82, release: 16, amp: 0.35, detune: 0.3
      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 16, amp: 0.7

      8.times do |i|
        ct_harm = (line 82, 100, steps: 16).tick

        # --- MELODY ---
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.28 do
            # Beat 1 — accent melody
            use_synth :chiplead
            play melody_notes_a.tick, release: 0.18, cutoff: rrand(88, 108), amp: 0.95
            use_synth :supersaw
            play bass_notes_a.tick, release: 0.45, cutoff: 80, amp: 0.30

            # Beat 1 — harmony rhodey
            use_synth :rhodey
            play_chord chords_a1.tick, cutoff: ct_harm, release: 0.7, amp: 0.40

            # Beat 1 — bass
            use_synth :bass_foundation
            play bass_ring_a.tick, cutoff: 72, release: 0.85, amp: 0.78

            # Beat 1 — kick accent
            sample :bd_haus, amp: 0.85
            sample :hat_zild, amp: 0.40
            sleep 0.5

            # Beat 1-and
            use_synth :chiplead
            play melody_notes_a.look, release: 0.12, cutoff: rrand(82, 102), amp: 0.88
            use_synth :subpulse
            play bass_ring_a.look, cutoff: 68, release: 0.4, amp: 0.55, pulse_width: 0.4
            sample :hat_zild, amp: 0.28
            sleep 0.5

            # Beat 2
            use_synth :chiplead
            play melody_notes_a.look, release: 0.18, cutoff: rrand(88, 108), amp: 0.90
            use_synth :supersaw
            play_chord chords_a1.look, cutoff: ct_harm + 8, release: 0.35, amp: 0.45, detune: 0.25
            use_synth :bass_foundation
            play bass_ring_a.look, cutoff: 70, release: 0.75, amp: 0.72
            sample :drum_snare_hard, amp: 0.70
            sample :hat_zild, amp: 0.38
            sleep 0.5

            # Beat 2-and
            use_synth :chiplead
            play (scale(:a4, :major_pentatonic)).choose, release: 0.1, cutoff: 90, amp: 0.82
            use_synth :subpulse
            play bass_ring_a.look, cutoff: 65, release: 0.35, amp: 0.55, pulse_width: 0.35
            sample :hat_zild, amp: 0.26
            sleep 0.5

            # Beat 3
            use_synth :chiplead
            play melody_notes_a.look, release: 0.18, cutoff: rrand(88, 108), amp: 0.90
            use_synth :rhodey
            play_chord chords_a1.look, cutoff: ct_harm - 4, release: 0.6, amp: 0.36
            use_synth :bass_foundation
            play bass_ring_a.look, cutoff: 72, release: 0.85, amp: 0.76
            sample :bd_haus, amp: 0.78
            sample :hat_zild, amp: 0.38
            sleep 0.5

            # Beat 3-and
            use_synth :subpulse
            play bass_ring_a.look, cutoff: 66, release: 0.4, amp: 0.55, pulse_width: 0.4
            sample :hat_zild, amp: 0.26
            sleep 0.5

            # Beat 4
            use_synth :chiplead
            play (scale(:a4, :major_pentatonic)).choose, release: 0.1, cutoff: rrand(80, 105), amp: 0.85
            use_synth :tech_saws
            play_chord chords_a1.look, cutoff: ct_harm + 10, release: 0.28, amp: 0.42, detune: 0.2
            use_synth :tb303
            play bass_ring_a.look, cutoff: 78, res: 0.7, release: 0.6, amp: 0.58, wave: 0
            sample :drum_snare_hard, amp: 0.68
            sample :hat_zild, amp: 0.36
            sleep 0.5

            # Beat 4-and
            use_synth :chiplead
            play :a4, release: 0.1, cutoff: 95, amp: 0.88
            use_synth :subpulse
            play bass_ring_a.look, cutoff: 64, release: 0.3, amp: 0.52, pulse_width: 0.38
            sample :drum_cymbal_open, amp: 0.38, finish: 0.25 if (i + 1) % 4 == 0
            sample :hat_zild, amp: 0.24
            sleep 0.5
          end
        end
      end
    end

    # =============================================
    # TRANSITION: Drone bridge (A → B)
    # =============================================
    use_synth :prophet
    play :a2, cutoff: 90, release: 8, amp: 0.6
    play :e3, cutoff: 85, release: 8, amp: 0.4
    use_synth :supersaw
    play_chord chord(:a2, :major), cutoff: 85, release: 8, amp: 0.40, detune: 0.2
    use_synth :bass_foundation
    play :a1, cutoff: 68, release: 8, amp: 0.60
    use_synth :subpulse
    play :e2, cutoff: 62, release: 8, amp: 0.45, pulse_width: 0.4

    sample :bd_haus, amp: 0.72
    sleep 1
    sample :drum_snare_hard, amp: 0.60
    sleep 1
    sample :bd_haus, amp: 0.72
    sleep 1
    sample :drum_cymbal_open, amp: 0.42, finish: 0.4
    sleep 1

    # =============================================
    # SECTION 2: Key of A — Supersaw build-up + uplifting chords + walking bass + clap layer
    # 2x8-bar phrases
    # =============================================
    melody_notes_a2 = (ring :a4, :b4, :cs5, :e5, :cs5, :b4, :a4, :e5)
    harmony_notes_a = (ring :e4, :fs4, :a4, :cs5, :a4, :fs4, :e4, :a4)
    chords_a2 = (ring
      chord(:a3, :major),
      chord(:d3, :major),
      chord(:e3, :dom7),
      chord(:a3, :major)
    )
    bass_ring_a2 = (ring :a1, :b1, :cs2, :e2, :cs2, :b1, :a1, :e2)

    2.times do
      # Long drones underneath
      use_synth :fm
      play :a2, release: 16, cutoff: 78, divisor: 2, depth: 12, amp: 0.40
      use_synth :supersaw
      play_chord chord(:a2, :major), cutoff: 80, release: 16, amp: 0.38, detune: 0.35
      use_synth :subpulse
      play :a1, cutoff: 67, release: 16, amp: 0.65, pulse_width: 0.45

      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        with_fx :lpf, cutoff: 88, mix: 1.0 do
          8.times do |i|
            ct = (line 82, 115, steps: 16).tick
            ct_harm = (line 85, 112, steps: 16).look

            # Beat 1
            use_synth :supersaw
            play melody_notes_a2.tick, release: 0.17, cutoff: ct, amp: 0.95, detune: 0.15
            use_synth :mod_saw
            play harmony_notes_a.tick, release: 0.22, cutoff: ct - 10, amp: 0.28, mod_range: 4, mod_phase: 0.5
            use_synth :rhodey
            play_chord chords_a2.tick, cutoff: ct_harm, release: 0.65, amp: 0.42
            use_synth :bass_foundation
            play bass_ring_a2.tick, cutoff: 75, release: 0.90, amp: 0.78
            sample :bd_haus, amp: 0.88
            sample :hat_cab, amp: 0.38
            sleep 0.5

            # Beat 1-and
            use_synth :tb303
            play bass_ring_a2.look, cutoff: 80, res: 0.75, release: 0.45, amp: 0.55, wave: 0
            sample :hat_cab, amp: 0.28
            sample :elec_snare, amp: 0.22 if one_in(4)
            sleep 0.5

            # Beat 2
            use_synth :supersaw
            play melody_notes_a2.look, release: 0.12, cutoff: rrand(85, 112), amp: 0.90
            use_synth :tech_saws
            play_chord chords_a2.look, cutoff: ct_harm + 12, release: 0.30, amp: 0.50, detune: 0.25
            use_synth :bass_foundation
            play bass_ring_a2.look, cutoff: 72, release: 0.80, amp: 0.72
            sample :drum_snare_hard, amp: 0.72
            sample :elec_snare, amp: 0.34
            sample :hat_cab, amp: 0.36
            sleep 0.5

            # Beat 2-and
            use_synth :supersaw
            play (scale(:a4, :major)).choose, release: 0.1, cutoff: 95, amp: 0.85
            use_synth :subpulse
            play bass_ring_a2.look, cutoff: 66, release: 0.38, amp: 0.55, pulse_width: 0.42
            sample :hat_cab, amp: 0.25
            sleep 0.5

            # Beat 3
            use_synth :supersaw
            play melody_notes_a2.look, release: 0.18, cutoff: rrand(88, 115), amp: 0.92
            use_synth :supersaw
            play_chord chords_a2.look, cutoff: ct_harm + 5, release: 0.40, amp: 0.38, detune: 0.18
            use_synth :tb303
            play bass_ring_a2.look, cutoff: 82, res: 0.72, release: 0.70, amp: 0.62, wave: 0
            sample :bd_haus, amp: 0.80
            sample :hat_cab, amp: 0.36
            sleep 0.5

            # Beat 3-and
            use_synth :bass_foundation
            play bass_ring_a2.look, cutoff: 70, release: 0.40, amp: 0.58
            sample :hat_cab, amp: 0.24
            sleep 0.5

            # Beat 4
            use_synth :chiplead
            play (scale(:a4, :major_pentatonic)).choose, release: 0.1, cutoff: 100, amp: 0.88
            use_synth :tech_saws
            play_chord chords_a2.look, cutoff: ct_harm + 15, release: 0.28, amp: 0.48, detune: 0.22
            use_synth :rhodey
            play_chord chords_a2.look, cutoff: ct_harm, release: 0.50, amp: 0.30
            use_synth :tb303
            play bass_ring_a2.look, cutoff: 85, res: 0.80, release: 0.55, amp: 0.64, wave: 1
            sample :drum_snare_hard, amp: 0.70
            sample :elec_snare, amp: 0.30 if one_in(2)
            sample :hat_cab, amp: 0.34
            sleep 0.5

            # Beat 4-and
            use_synth :chiplead
            play :a5, release: 0.1, cutoff: 105, amp: 0.90
            use_synth :subpulse
            play bass_ring_a2.look, cutoff: 64, release: 0.30, amp: 0.52, pulse_width: 0.38
            if (i + 1) % 4 == 0
              sample :drum_cymbal_open, amp: 0.42, finish: 0.3
              sample :elec_snare, amp: 0.38
            else
              sample :hat_cab, amp: 0.22
            end
            sleep 0.5
          end
        end
      end
    end

    # =============================================
    # TRANSITION: Key change drone (A → B)
    # =============================================
    use_synth :prophet
    play :b2, cutoff: 92, release: 8, amp: 0.65
    play :fs3, cutoff: 88, release: 8, amp: 0.42
    use_synth :supersaw
    play_chord chord(:b2, :major), cutoff: 88, release: 8, amp: 0.45, detune: 0.25
    use_synth :bass_foundation
    play :b1, cutoff: 68, release: 8, amp: 0.65
    use_synth :subpulse
    play :fs2, cutoff: 63, release: 8, amp: 0.48, pulse_width: 0.4

    sample :bd_haus, amp: 0.80
    sleep 0.5
    sample :drum_snare_hard, amp: 0.65
    sleep 0.5
    sample :bd_haus, amp: 0.80
    sleep 0.5
    sample :drum_snare_hard, amp: 0.65
    sleep 0.5
    4.times do
      sample :elec_snare, amp: 0.45
      sleep 0.25
    end
    sample :drum_cymbal_open, amp: 0.50, finish: 0.5
    sleep 1

    # =============================================
    # SECTION 3: KEY CHANGE — Key of B
    # Chiplead + mod_saw lead, big anthem chords, driving bass, full climax drums
    # 3x8-bar phrases
    # =============================================
    melody_notes_b  = (ring :b4, :ds5, :fs5, :b5, :fs5, :ds5, :cs5, :b4)
    harmony_notes_b = (ring :fs4, :as4, :cs5, :fs5, :cs5, :as4, :gs4, :fs4)
    chords_b = (ring
      chord(:b3, :major),
      chord(:fs3, :dom7),
      chord(:gs3, :minor),
      chord(:e3, :major)
    )
    bass_ring_b = (ring :b1, :b1, :fs2, :fs2, :gs2, :gs2, :fs2, :fs2)

    3.times do
      # Long drones in B
      use_synth :supersaw
      play :b2, release: 16, cutoff: 80, amp: 0.40, detune: 0.25
      use_synth :fm
      play :b2, release: 16, cutoff: 70, divisor: 3, depth: 14, amp: 0.32
      use_synth :supersaw
      play_chord chord(:b2, :major), cutoff: 84, release: 16, amp: 0.44, detune: 0.35
      use_synth :bass_foundation
      play :b1, cutoff: 68, release: 16, amp: 0.72
      use_synth :subpulse
      play :b1, cutoff: 62, release: 16, amp: 0.52, pulse_width: 0.45

      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :reverb, room: 0.3, mix: 0.28 do
          8.times do |i|
            ct = (line 88, 118, steps: 24).tick
            ct_harm = (line 88, 118, steps: 24).look

            # Beat 1 — big accent
            use_synth :chiplead
            play melody_notes_b.tick, release: 0.16, cutoff: ct, amp: 1.0
            use_synth :mod_saw
            play harmony_notes_b.tick, release: 0.20, cutoff: ct - 12, amp: 0.26, mod_range: 5, mod_phase: 0.25
            use_synth :rhodey
            play_chord chords_b.tick, cutoff: ct_harm - 5, release: 0.70, amp: 0.45
            use_synth :bass_foundation
            play bass_ring_b.tick, cutoff: 78, release: 0.90, amp: 0.80
            sample :bd_haus, amp: 0.90
            sample :hat_zild, amp: 0.42
            sleep 0.25
            sample :hat_cab, amp: 0.30
            sleep 0.25

            # Beat 2 — snare + clap
            use_synth :chiplead
            play melody_notes_b.look, release: 0.11, cutoff: rrand(90, 115), amp: 0.93
            use_synth :tech_saws
            play_chord chords_b.look, cutoff: ct_harm + 12, release: 0.30, amp: 0.54, detune: 0.30
            use_synth :subpulse
            play bass_ring_b.look, cutoff: 65, release: 0.40, amp: 0.58, pulse_width: 0.42
            sample :drum_snare_hard, amp: 0.75
            sample :elec_snare, amp: 0.38
            sample :hat_zild, amp: 0.40
            sleep 0.25
            sample :hat_cab, amp: 0.28
            sleep 0.25

            # Beat 2-and extra fill
            use_synth :supersaw
            play (scale(:b4, :major_pentatonic)).choose, release: 0.1, cutoff: 100, amp: 0.88

            # Beat 3
            use_synth :chiplead
            play melody_notes_b.look, release: 0.18, cutoff: rrand(92, 118), amp: 0.95
            use_synth :supersaw
            play_chord chords_b.look, cutoff: ct_harm + 8, release: 0.45, amp: 0.42, detune: 0.28
            use_synth :bass_foundation
            play bass_ring_b.look, cutoff: 76, release: 0.85, amp: 0.78
            sample :bd_haus, amp: 0.82
            sample :hat_zild, amp: 0.40
            sleep 0.25
            sample :drum_cymbal_open, amp: 0.40, finish: 0.2 if (i + 1) % 6 == 0
            sample :hat_cab, amp: 0.28
            sleep 0.25

            # Beat 4
            use_synth :mod_saw
            play (scale(:b4, :major)).choose, release: 0.12, cutoff: rrand(88, 112), amp: 0.82, mod_range: 3, mod_phase: 0.5
            use_synth :tech_saws
            play_chord chords_b.look, cutoff: ct_harm + 18, release: 0.28, amp: 0.52, detune: 0.25
            use_synth :supersaw
            play_chord chords_b.look, cutoff: ct_harm + 10, release: 0.35, amp: 0.40, detune: 0.30
            use_synth :tb303
            play bass_ring_b.look, cutoff: 88, res: 0.82, release: 0.60, amp: 0.64, wave: 1
            sample :drum_snare_hard, amp: 0.73
            sample :elec_snare, amp: 0.35 if one_in(2)
            sample :hat_zild, amp: 0.38
            sleep 0.25

            # Beat 4-and
            use_synth :chiplead
            play :b5, release: 0.10, cutoff: 108, amp: 0.95
            use_synth :subpulse
            play bass_ring_b.look, cutoff: 64, release: 0.30, amp: 0.55, pulse_width: 0.38
            if (i + 1) % 4 == 0
              sample :elec_snare, amp: 0.42
              sample :drum_cymbal_open, amp: 0.44, finish: 0.35
            else
              sample :hat_cab, amp: 0.26
            end
            sleep 0.25
          end
        end
      end
    end

    # =============================================
    # OUTRO: Fading drones and percussion in B
    # =============================================
    use_synth :prophet
    play :b2, cutoff: 80, release: 12, amp: 0.5
    play :fs3, cutoff: 75, release: 12, amp: 0.3
    use_synth :supersaw
    play_chord chord(:b2, :major), cutoff: 78, release: 12, amp: 0.35, detune: 0.2
    use_synth :rhodey
    play_chord chord(:b3, :major), cutoff: 80, release: 12, amp: 0.28
    use_synth :bass_foundation
    play :b1, cutoff: 65, release: 12, amp: 0.58
    use_synth :subpulse
    play :fs2, cutoff: 60, release: 12, amp: 0.42, pulse_width: 0.4

    sample :bd_haus, amp: 0.72
    sleep 1
    sample :drum_snare_hard, amp: 0.58
    sleep 1
    sample :bd_haus, amp: 0.62
    sleep 1
    sample :drum_snare_hard, amp: 0.50
    sleep 1
    sample :bd_haus, amp: 0.52
    sleep 1
    sample :drum_cymbal_open, amp: 0.40, finish: 0.6
    sleep 1
    sample :hat_zild, amp: 0.30
    sleep 1
    sample :hat_zild, amp: 0.22
    sleep 1

  end
end