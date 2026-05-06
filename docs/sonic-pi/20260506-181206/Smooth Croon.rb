# Smooth Croon
# Style: Smooth Jazz | Mood: Late-night lounge, warm and silky
# Key: F major -> Bb major | BPM: 72 | Time: 4/4

use_debug false
use_bpm 72

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ============================================================
    # SECTION 1: F major — smooth jazz opening (2 repeats x 4 bars)
    # Melody: blade | Harmony: rhodey + hollow | Bass: bass_foundation + tb303 | Perc: brushed jazz groove
    # ============================================================
    melody_a     = (ring :f4, :a4, :c5, :eb5, :c5, :a4, :g4, :f4)
    cutoff_line_a = (line 85, 110, steps: 32)
    harm_chords_a = [
      chord(:f3, :major7),
      chord(:c3, :m9),
      chord(:d3, :m7),
      chord(:g3, :m9)
    ]
    cutoff_harm_a = (line 82, 100, steps: 8)
    walk_a = (ring :f2, :a2, :c3, :eb2, :c2, :g2, :d2, :g2)

    2.times do
      # --- Drones underneath (all parts)
      use_synth :blade
      play :f3, release: 16, cutoff: 88, amp: 0.45
      use_synth :hollow
      play_chord chord(:f2, :major7), cutoff: 85, release: 16, amp: 0.4
      use_synth :bass_foundation
      play :f1, cutoff: 65, release: 16, amp: 0.7

      with_fx :reverb, room: 0.28, mix: 0.3 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          4.times do |i|
            # --- Melody (blade)
            use_synth :blade
            4.times do
              play melody_a.tick, release: 0.45, cutoff: cutoff_line_a.tick, amp: 0.95
              sleep 1
            end

            # --- Harmony (rhodey chord pad + hollow shimmer, offset from melody via in-loop timing)
            # Note: harmony plays in its own 4-beat window each bar
          end
        end
      end

      # Harmony and bass/perc run concurrently via the same 4-beat-per-bar structure
      # Re-enter the 4-bar loop for harmony, bass, percussion
      # (In Sonic Pi single-thread model, we interleave by structuring per-beat)

      # Reset ring positions for a second pass through the 4 bars
      # We weave harmony, bass, perc into the melody's 4-beat bars below
    end

    # --- Because Sonic Pi is single-threaded, we combine all parts per bar in one unified loop ---
    # Restart section with full integration:

    melody_a      = (ring :f4, :a4, :c5, :eb5, :c5, :a4, :g4, :f4)
    cutoff_line_a = (line 85, 110, steps: 32)
    cutoff_harm_a = (line 82, 100, steps: 8)
    walk_a        = (ring :f2, :a2, :c3, :eb2, :c2, :g2, :d2, :g2)
    chord_seq_a   = [
      chord(:f3, :major7),
      chord(:c3, :m7),
      chord(:d3, :m7),
      chord(:g3, :m7)
    ]
    harm_chords_a = [
      chord(:f3, :major7),
      chord(:c3, :m9),
      chord(:d3, :m7),
      chord(:g3, :m9)
    ]

    2.times do
      # Sustained drones — all layers
      use_synth :blade
      play :f3, release: 16, cutoff: 88, amp: 0.42
      use_synth :hollow
      play_chord chord(:f2, :major7), cutoff: 85, release: 16, amp: 0.38
      use_synth :bass_foundation
      play :f1, cutoff: 65, release: 16, amp: 0.68

      with_fx :reverb, room: 0.28, mix: 0.28 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          4.times do |i|
            # --- Harmony chord pad (rhodey)
            use_synth :rhodey
            play_chord chord_seq_a[i % 4], release: 1.8, amp: 0.55, cutoff: cutoff_harm_a.tick

            # Beat 1 — kick + hat (loud downbeat) + bass root
            with_fx :hpf, cutoff: 100, mix: 1.0 do
              sample :bd_jazz, amp: 0.75, rate: 1.0
              sample :drum_cymbal_closed, amp: 0.45, rate: 1.1
            end
            use_synth :bass_foundation
            play walk_a[i * 2], cutoff: 72, release: 0.9, amp: 0.75
            # Melody beat 1
            use_synth :blade
            play melody_a.tick, release: 0.45, cutoff: cutoff_line_a.tick, amp: 0.92
            sleep 1

            # Beat 2 — snare + hat + hollow shimmer + bass walk + melody
            sample :drum_snare_soft, amp: 0.55
            sample :drum_cymbal_closed, amp: 0.35, rate: 1.05
            sample :drum_cymbal_open, amp: 0.28, rate: 0.9 if i == 2
            use_synth :hollow
            play harm_chords_a[i % 4].choose, cutoff: 88, release: 0.9, amp: 0.32
            use_synth :tb303
            play walk_a[i * 2 + 1], cutoff: 68, release: 0.6, amp: 0.55, wave: 0, res: 0.5
            use_synth :blade
            play melody_a.tick, release: 0.45, cutoff: cutoff_line_a.tick, amp: 0.92
            sleep 1

            # Beat 3 — kick + hat + bass passing tone + melody
            with_fx :hpf, cutoff: 100, mix: 1.0 do
              sample :bd_jazz, amp: 0.62, rate: 0.98
              sample :drum_cymbal_closed, amp: 0.38, rate: 1.1
            end
            use_synth :bass_foundation
            play walk_a[(i * 2 + 2) % 8], cutoff: 74, release: 0.7, amp: 0.65
            use_synth :blade
            play melody_a.tick, release: 0.45, cutoff: cutoff_line_a.tick, amp: 0.92
            sleep 1

            # Beat 4 — snare + hat + hollow shimmer + bass approach + melody + ghost snare
            sample :drum_snare_soft, amp: 0.5
            sample :drum_cymbal_closed, amp: 0.32, rate: 1.05
            use_synth :hollow
            play harm_chords_a[i % 4].choose, cutoff: 90, release: 0.9, amp: 0.28
            use_synth :tb303
            play walk_a[(i * 2 + 3) % 8], cutoff: 70, release: 0.5, amp: 0.52, wave: 0, res: 0.5
            use_synth :blade
            play melody_a.tick, release: 0.45, cutoff: cutoff_line_a.tick, amp: 0.92
            sleep 0.5
            sample :drum_snare_soft, amp: 0.26, rate: 1.05 if one_in(3)
            sleep 0.5
          end
        end
      end
    end

    # ============================================================
    # TRANSITION: F major -> Bb major (drone bridge, sleep 4)
    # ============================================================
    use_synth :blade
    play :f3, cutoff: 90, release: 10, amp: 0.5
    use_synth :winwood_lead
    play :bb3, cutoff: 85, release: 10, amp: 0.4
    use_synth :hollow
    play_chord chord(:f3, :major7), cutoff: 88, release: 10, amp: 0.38
    use_synth :rhodey
    play_chord chord(:bb3, :major7), cutoff: 85, release: 10, amp: 0.32
    use_synth :bass_foundation
    play :f1, cutoff: 68, release: 8, amp: 0.62
    sleep 4

    # ============================================================
    # SECTION 2: Bb major — key change, warmer tone (2 repeats x 4 bars)
    # Melody: winwood_lead | Harmony: rhodey + hollow | Bass: bass_foundation + tb303 | Perc: active 8th-note hats
    # ============================================================
    melody_b      = (ring :bb4, :d5, :f5, :ab5, :f5, :eb5, :d5, :bb4)
    cutoff_line_b = (line 88, 118, steps: 32)
    chord_seq_b   = [
      chord(:bb3, :major7),
      chord(:eb3, :major7),
      chord(:c3, :m7),
      chord(:f3, :dom7)
    ]
    harm_chords_b = [
      chord(:bb3, :maj9),
      chord(:eb3, :maj9),
      chord(:c3, :m9),
      chord(:f3, '9')
    ]
    cutoff_harm_b = (line 85, 105, steps: 8)
    walk_b        = (ring :bb1, :d2, :f2, :eb2, :c2, :eb2, :f2, :a2)

    2.times do
      # Sustained drones
      use_synth :blade
      play :bb2, release: 16, cutoff: 92, amp: 0.4
      use_synth :hollow
      play_chord chord(:bb2, :major7), cutoff: 88, release: 16, amp: 0.38
      use_synth :bass_foundation
      play :bb1, cutoff: 67, release: 16, amp: 0.68

      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
        4.times do |i|
          # Harmony chord pad
          use_synth :rhodey
          play_chord chord_seq_b[i % 4], release: 1.8, amp: 0.52, cutoff: cutoff_harm_b.tick

          # Beat 1 — kick + 8th hat + bass root + melody
          sample :bd_jazz, amp: 0.78, rate: 1.0
          sample :drum_cymbal_closed, amp: 0.42, rate: 1.08
          use_synth :bass_foundation
          play walk_b[i * 2], cutoff: 75, release: 0.95, amp: 0.75
          use_synth :winwood_lead
          play melody_b.tick, release: 0.48, cutoff: cutoff_line_b.tick, amp: 0.95
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.28, rate: 1.06
          sleep 0.5

          # Beat 2 — snare + hats + hollow shimmer + bass walk + melody
          sample :drum_snare_soft, amp: 0.58
          sample :drum_cymbal_closed, amp: 0.36, rate: 1.1
          use_synth :hollow
          play harm_chords_b[i % 4].choose, cutoff: 92, release: 1.0, amp: 0.28
          use_synth :tb303
          play walk_b[i * 2 + 1], cutoff: 70, release: 0.65, amp: 0.56, wave: 0, res: 0.5
          use_synth :winwood_lead
          play melody_b.tick, release: 0.48, cutoff: cutoff_line_b.tick, amp: 0.95
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.26, rate: 1.05
          sleep 0.5

          # Beat 3 — soft kick + hats + bass passing tone + melody
          sample :bd_jazz, amp: 0.60, rate: 0.97
          sample :drum_cymbal_closed, amp: 0.36, rate: 1.08
          use_synth :bass_foundation
          play walk_b[(i * 2 + 2) % 8], cutoff: 76, release: 0.75, amp: 0.65
          use_synth :winwood_lead
          play melody_b.tick, release: 0.48, cutoff: cutoff_line_b.tick, amp: 0.95
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.26, rate: 1.06
          sleep 0.5

          # Beat 4 — snare + hats + hollow shimmer + bass approach + melody + open hat on bar 4
          sample :drum_snare_soft, amp: 0.55
          sample :drum_cymbal_closed, amp: 0.33, rate: 1.05
          use_synth :hollow
          play harm_chords_b[i % 4].choose, cutoff: 90, release: 1.0, amp: 0.25
          use_synth :tb303
          play walk_b[(i * 2 + 3) % 8], cutoff: 72, release: 0.55, amp: 0.54, wave: 0, res: 0.5
          use_synth :winwood_lead
          play melody_b.tick, release: 0.48, cutoff: cutoff_line_b.tick, amp: 0.95
          sleep 0.5
          if i == 3
            sample :drum_cymbal_open, amp: 0.36, rate: 0.88
          else
            sample :drum_cymbal_closed, amp: 0.24, rate: 1.04 if one_in(2)
          end
          sleep 0.5
        end
      end
    end

    # ============================================================
    # TRANSITION: Bb major — gentle resolution drone (sleep 4)
    # ============================================================
    use_synth :blade
    play :bb3, cutoff: 88, release: 10, amp: 0.5
    use_synth :winwood_lead
    play :f4, cutoff: 85, release: 10, amp: 0.4
    use_synth :hollow
    play_chord chord(:bb3, :major7), cutoff: 86, release: 10, amp: 0.36
    use_synth :rhodey
    play_chord chord(:f3, :dom7), cutoff: 84, release: 10, amp: 0.30
    use_synth :bass_foundation
    play :bb1, cutoff: 70, release: 8, amp: 0.62
    sleep 4

    # ============================================================
    # SECTION 3: Bb major — final reprise, richest layer (2 repeats x 4 bars)
    # Melody: alternating blade + winwood | Harmony: rhodey + hollow | Bass: bass_foundation x2 + tb303 | Perc: euclidean kick variation
    # ============================================================
    melody_c      = (ring :bb4, :d5, :f5, :ab5, :g5, :f5, :eb5, :bb4)
    cutoff_line_c = (line 90, 120, steps: 32)
    chord_seq_c   = [
      chord(:bb3, :major7),
      chord(:eb3, :major7),
      chord(:g3, :m7),
      chord(:f3, :dom7)
    ]
    harm_chords_c = [
      chord(:bb3, :maj9),
      chord(:eb3, :maj9),
      chord(:g3, :m9),
      chord(:f3, '9')
    ]
    cutoff_harm_c = (line 88, 112, steps: 8)
    walk_c        = (ring :bb1, :d2, :f2, :ab2, :g2, :eb2, :f2, :a2)
    kick_pattern  = (ring true, false, false, true, false, true, false, false)

    2.times do
      # Sustained drones — richest layer
      use_synth :blade
      play :bb2, release: 16, cutoff: 95, amp: 0.38
      use_synth :winwood_lead
      play :f3, release: 16, cutoff: 90, amp: 0.34
      use_synth :hollow
      play_chord chord(:bb2, :major7), cutoff: 90, release: 16, amp: 0.36
      use_synth :rhodey
      play_chord chord(:f3, :dom7), cutoff: 87, release: 16, amp: 0.28
      use_synth :bass_foundation
      play :bb1, cutoff: 68, release: 16, amp: 0.66
      use_synth :bass_foundation
      play :f2, cutoff: 65, release: 16, amp: 0.42

      with_fx :reverb, room: 0.3, mix: 0.28 do
        4.times do |i|
          # Harmony chord pad
          use_synth :rhodey
          play_chord chord_seq_c[i % 4], release: 1.8, amp: 0.5, cutoff: cutoff_harm_c.tick

          # Beat 1 — strong downbeat kick + hat + bass root + melody (alternating synths)
          sample :bd_jazz, amp: 0.80, rate: 1.0
          sample :drum_cymbal_closed, amp: 0.44, rate: 1.1
          use_synth :bass_foundation
          play walk_c[i * 2], cutoff: 78, release: 0.9, amp: 0.75
          use_synth i.even? ? :blade : :winwood_lead
          play melody_c.tick, release: 0.5, cutoff: cutoff_line_c.tick, amp: 0.95
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.28, rate: 1.06
          sleep 0.5

          # Beat 2 — snare + hats + hollow shimmer + bass walk + melody + ghost snare
          sample :drum_snare_soft, amp: 0.62
          sample :drum_cymbal_closed, amp: 0.36, rate: 1.08
          use_synth :hollow
          play harm_chords_c[i % 4].choose, cutoff: 94, release: 1.1, amp: 0.26
          use_synth :tb303
          play walk_c[i * 2 + 1], cutoff: 74, release: 0.6, amp: 0.56, wave: 0, res: 0.5
          use_synth i.even? ? :winwood_lead : :blade
          play melody_c.tick, release: 0.5, cutoff: cutoff_line_c.tick, amp: 0.95
          sleep 0.5
          sample :drum_snare_soft, amp: 0.23, rate: 1.1 if one_in(3)
          sample :drum_cymbal_closed, amp: 0.25, rate: 1.05
          sleep 0.5

          # Beat 3 — euclidean kick variation + hat + bass passing tone + melody
          sample :bd_jazz, amp: 0.65, rate: 0.96 if kick_pattern.tick
          sample :drum_cymbal_closed, amp: 0.34, rate: 1.07
          use_synth :bass_foundation
          play walk_c[(i * 2 + 2) % 8], cutoff: 78, release: 0.75, amp: 0.65
          use_synth i.even? ? :blade : :winwood_lead
          play melody_c.tick, release: 0.5, cutoff: cutoff_line_c.tick, amp: 0.95
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.25, rate: 1.05
          sleep 0.5

          # Beat 4 — snare + hollow shimmer + bass approach + melody + open hat swell every 2 bars
          sample :drum_snare_soft, amp: 0.58
          sample :drum_cymbal_closed, amp: 0.32, rate: 1.06
          use_synth :hollow
          play harm_chords_c[i % 4].choose, cutoff: 92, release: 1.1, amp: 0.23
          use_synth :tb303
          play walk_c[(i * 2 + 3) % 8], cutoff: 72, release: 0.5, amp: 0.53, wave: 0, res: 0.5
          use_synth i.even? ? :winwood_lead : :blade
          play melody_c.tick, release: 0.5, cutoff: cutoff_line_c.tick, amp: 0.95
          sleep 0.5
          if i.even?
            sample :drum_cymbal_open, amp: 0.33, rate: 0.85
          else
            sample :drum_cymbal_closed, amp: 0.23, rate: 1.04 if one_in(2)
          end
          sleep 0.5
        end
      end
    end

    # ============================================================
    # FINAL FADE-OUT — gentle drone and hat roll trailing to silence
    # ============================================================
    use_synth :blade
    play :bb3, cutoff: 82, release: 12, amp: 0.35
    use_synth :hollow
    play_chord chord(:bb3, :major7), cutoff: 84, release: 12, amp: 0.28
    use_synth :rhodey
    play_chord chord(:bb3, :maj9), cutoff: 82, release: 12, amp: 0.22
    use_synth :bass_foundation
    play :bb1, cutoff: 65, release: 10, amp: 0.52

    4.times do |i|
      sample :drum_cymbal_closed, amp: 0.28 - (i * 0.05), rate: 1.05
      sleep 1
    end
    sample :drum_cymbal_open, amp: 0.16, rate: 0.82
    sleep 2

  end
end