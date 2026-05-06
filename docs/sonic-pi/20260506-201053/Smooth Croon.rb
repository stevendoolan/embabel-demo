# Smooth Croon
# Style: Soul/Jazz | Mood: Warm, lush, intimate

use_debug false
use_bpm 72

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ================================================================
    # SECTION 1: Intro/Verse — F major, gentle swing feel (2x4 bars)
    # Melody: Piano soul line | Harmony: Hollow + Rhodey jazz pads
    # Bass: Walking subpulse + bass_foundation | Perc: Soft brushed kit
    # ================================================================
    2.times do
      # --- Long drones anchoring Section 1 ---
      use_synth :blade
      play :f3, release: 16, cutoff: 85, amp: 0.30

      use_synth :hollow
      play_chord chord(:f2, :major7), cutoff: 85, release: 16, amp: 0.40

      use_synth :subpulse
      play :f1, cutoff: 65, release: 16, amp: 0.55

      with_fx :reverb, room: 0.25, mix: 0.28 do
        4.times do
          # --- Melody: Piano soul line in F major ---
          use_synth :piano
          mel_notes = (ring :f4, :a4, :c5, :bb4, :a4, :g4, :f4, :eb4)
          mel_co    = (ring 95, 100, 105, 98, 95, 92, 88, 90)
          play mel_notes.tick, release: 0.45, cutoff: mel_co.look, amp: 0.95
          sleep 0.5
          play mel_notes.tick, release: 0.25, cutoff: mel_co.look, amp: 0.88
          sleep 0.5
          play mel_notes.tick, release: 0.45, cutoff: mel_co.look, amp: 0.95
          sleep 0.5
          play mel_notes.tick, release: 0.30, cutoff: mel_co.look, amp: 0.90
          sleep 0.5
          play mel_notes.tick, release: 0.50, cutoff: mel_co.look, amp: 0.95
          sleep 0.5
          play mel_notes.tick, release: 0.25, cutoff: mel_co.look, amp: 0.85
          sleep 0.5
          play mel_notes.tick, release: 0.40, cutoff: mel_co.look, amp: 0.92
          sleep 0.5
          play mel_notes.tick, release: 0.60, cutoff: mel_co.look, amp: 0.95
          sleep 0.5

          # --- Harmony: Rhodey jazz voicings (ii-V-I-vi, one chord per 2 beats) ---
          jazz_chords = (ring
            chord(:f3, :major7),
            chord(:d3, :m7),
            chord(:g3, :m7),
            chord(:c3, '7')
          )
          co_h = (line 82, 100, steps: 8).tick
          use_synth :rhodey
          play_chord jazz_chords.tick, cutoff: co_h,     release: 1.8, amp: 0.52
          sleep 2
          play_chord jazz_chords.tick, cutoff: co_h + 4, release: 1.8, amp: 0.48
          sleep 2

          # --- Bass: Walking line in F major ---
          use_synth :bass_foundation
          walk = (ring :f2, :a2, :c3, :a2, :f2, :g2, :bb2, :g2)
          play walk.tick, cutoff: 72, release: 0.8, amp: 0.72
          sleep 1
          play walk.tick, cutoff: 68, release: 0.7, amp: 0.60
          sleep 1
          play walk.tick, cutoff: 70, release: 0.8, amp: 0.68
          sleep 1
          play walk.tick, cutoff: 66, release: 0.5, amp: 0.56
          sleep 1

          # --- Percussion: kick on 1&3, soft snare on 2&4, hi-hat offbeats ---
          sample :drum_bass_soft, amp: 0.70
          sample :drum_cymbal_closed, amp: 0.30
          sleep 0.5
          sample :drum_cymbal_pedal, amp: 0.26
          sleep 0.5
          sample :drum_snare_soft, amp: 0.55
          sample :drum_cymbal_closed, amp: 0.28
          sleep 0.5
          sample :drum_cymbal_pedal, amp: 0.23
          sleep 0.5
          sample :drum_bass_soft, amp: 0.62
          sample :drum_cymbal_closed, amp: 0.28
          sleep 0.5
          sample :drum_cymbal_pedal, amp: 0.24
          sleep 0.5
          sample :drum_snare_soft, amp: 0.52
          sample :drum_cymbal_closed, amp: 0.26
          sleep 0.5
          sample :drum_snare_soft, amp: 0.24 if one_in(3)
          sample :drum_cymbal_pedal, amp: 0.22
          sleep 0.5
        end
      end
    end

    # ================================================================
    # TRANSITION 1: F → Bb (4 beats) — blade + hollow drone bridges gap
    # ================================================================
    use_synth :blade
    play :f3, release: 8, cutoff: 90, amp: 0.40
    use_synth :hollow
    play_chord chord(:f3, :major7), cutoff: 88, release: 8, amp: 0.35
    use_synth :fm
    play :c3, cutoff: 86, release: 7, amp: 0.25
    use_synth :subpulse
    play :f1, cutoff: 68, release: 6, amp: 0.50
    sample :drum_cymbal_pedal, amp: 0.20
    sleep 1
    sample :drum_snare_soft, amp: 0.36
    sleep 1
    sample :drum_cymbal_pedal, amp: 0.18
    sleep 1
    sample :drum_cymbal_pedal, amp: 0.16
    sleep 1

    # ================================================================
    # SECTION 2: Groove/Hook — F major, rhythmic swing (2x4 bars)
    # Melody: Piano with echo | Harmony: FM bass + Hollow + Rhodey arp
    # Bass: Syncopated swing walk | Perc: Active hi-hat, ghost snares
    # ================================================================
    2.times do
      # --- Long drones anchoring Section 2 ---
      use_synth :rhodey
      play :f3, release: 16, cutoff: 90, amp: 0.30

      use_synth :fm
      play :f2, cutoff: 82, release: 16, divisor: 2, depth: 4, amp: 0.35

      use_synth :hollow
      play_chord chord(:f3, :major7), cutoff: 88, release: 16, amp: 0.28

      use_synth :subpulse
      play :f1, cutoff: 62, release: 16, amp: 0.52

      4.times do
        # --- Melody: Piano with echo ---
        with_fx :echo, phase: 0.75, decay: 1.5, mix: 0.18 do
          use_synth :piano
          melody = (ring :a4, :c5, :d5, :c5, :bb4, :a4, :g4, :f4)
          co_m = (line 90, 112, steps: 8).tick
          play melody.tick, release: 0.40, cutoff: co_m,      amp: 0.95
          sleep 0.75
          play melody.tick, release: 0.25, cutoff: co_m + 5,  amp: 0.88
          sleep 0.25
          play melody.tick, release: 0.50, cutoff: co_m + 3,  amp: 0.95
          sleep 0.50
          play melody.tick, release: 0.30, cutoff: co_m,      amp: 0.90
          sleep 0.50
          play melody.tick, release: 0.45, cutoff: co_m + 8,  amp: 0.95
          sleep 0.75
          play melody.tick, release: 0.25, cutoff: co_m + 5,  amp: 0.85
          sleep 0.25
          play melody.tick, release: 0.50, cutoff: co_m + 10, amp: 0.92
          sleep 0.50
          play melody.tick, release: 0.60, cutoff: co_m + 2,  amp: 0.95
          sleep 0.50
        end

        # --- Harmony: Rhodey arpeggiated jazz voicings ---
        arp_notes = (ring :a3, :c4, :e4, :g4, :f4, :e4, :d4, :c4)
        co2 = (line 86, 106, steps: 8).look
        use_synth :rhodey
        8.times do
          play arp_notes.tick, cutoff: co2, release: 0.35, amp: 0.40
          sleep 0.5
        end

        # --- Bass: Syncopated swing walking line ---
        use_synth :bass_foundation
        groove = (ring :f2, :a2, :c3, :bb2, :f2, :g2, :c3, :eb3)
        play groove.tick, cutoff: 75, release: 0.9, amp: 0.72
        sleep 0.75
        play groove.tick, cutoff: 68, release: 0.4, amp: 0.52
        sleep 0.25
        play groove.tick, cutoff: 72, release: 0.7, amp: 0.62
        sleep 1
        play groove.tick, cutoff: 75, release: 0.9, amp: 0.68
        sleep 0.75
        play groove.tick, cutoff: 66, release: 0.4, amp: 0.52
        sleep 0.25
        play groove.tick, cutoff: 70, release: 0.6, amp: 0.58
        sleep 0.5
        play groove.tick, cutoff: 72, release: 0.5, amp: 0.56
        sleep 0.5

        # --- Percussion: Active hi-hat, ghost snares, swing feel ---
        sample :drum_bass_soft, amp: 0.75
        sample :drum_cymbal_closed, amp: 0.33
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.20
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.24
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.18
        sleep 0.25
        sample :drum_snare_soft, amp: 0.58
        sample :drum_cymbal_closed, amp: 0.30
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.20
        sleep 0.25
        sample :drum_snare_soft, amp: 0.22 if one_in(2)
        sample :drum_cymbal_pedal, amp: 0.18
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.16
        sleep 0.25
        sample :drum_bass_soft, amp: 0.67
        sample :drum_cymbal_closed, amp: 0.28
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.20
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.22
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.16
        sleep 0.25
        sample :drum_snare_soft, amp: 0.56
        sample :drum_cymbal_closed, amp: 0.28
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.18
        sleep 0.25
        sample :drum_snare_soft, amp: 0.20 if one_in(3)
        sample :drum_cymbal_pedal, amp: 0.20
        sleep 0.25
        sample :drum_cymbal_pedal, amp: 0.16
        sleep 0.25
      end
    end

    # ================================================================
    # TRANSITION 2: F → Bb key change (4 beats) — bass drops to Bb
    # ================================================================
    use_synth :blade
    play :bb2, release: 10, cutoff: 88, amp: 0.40
    use_synth :hollow
    play_chord chord(:bb2, :major7), cutoff: 86, release: 10, amp: 0.35
    use_synth :fm
    play :bb1, cutoff: 84, release: 9, divisor: 2, depth: 3, amp: 0.28
    use_synth :subpulse
    play :bb1, cutoff: 65, release: 8, amp: 0.52
    sample :drum_bass_soft, amp: 0.55
    sleep 1
    sample :drum_snare_soft, amp: 0.42
    sleep 1
    sample :drum_cymbal_pedal, amp: 0.18
    sleep 1
    sample :drum_cymbal_closed, amp: 0.20
    sleep 1

    # ================================================================
    # SECTION 3: Chorus — Bb major, fuller sound (2x4 bars)
    # Melody: Blade lead | Harmony: FM + Hollow + Rhodey jazz cushion
    # Bass: Warm walking line in Bb | Perc: Warmer fuller kit
    # ================================================================
    2.times do
      # --- Long drones anchoring Section 3 ---
      use_synth :blade
      play :bb2, release: 16, cutoff: 92, amp: 0.32

      use_synth :fm
      play :bb1, cutoff: 85, release: 16, divisor: 2, depth: 5, amp: 0.32

      use_synth :hollow
      play_chord chord(:bb2, :major7), cutoff: 90, release: 16, amp: 0.35

      use_synth :subpulse
      play :bb1, cutoff: 63, release: 16, amp: 0.58

      with_fx :reverb, room: 0.28, mix: 0.28 do
        4.times do
          # --- Melody: Blade lead in Bb major ---
          use_synth :rhodey
          play :bb3, release: 3.8, cutoff: 88, amp: 0.28

          use_synth :blade
          bb_mel = (ring :d5, :f5, :eb5, :d5, :c5, :bb4, :a4, :bb4)
          co_bb = (line 88, 108, steps: 8).tick
          play bb_mel.tick, release: 0.55, cutoff: co_bb,      amp: 0.95
          sleep 0.75
          play bb_mel.tick, release: 0.30, cutoff: co_bb + 6,  amp: 0.88
          sleep 0.25
          play bb_mel.tick, release: 0.50, cutoff: co_bb + 4,  amp: 0.95
          sleep 0.50
          play bb_mel.tick, release: 0.35, cutoff: co_bb + 2,  amp: 0.90
          sleep 0.50
          play bb_mel.tick, release: 0.55, cutoff: co_bb + 8,  amp: 0.95
          sleep 0.75
          play bb_mel.tick, release: 0.28, cutoff: co_bb + 5,  amp: 0.88
          sleep 0.25
          play bb_mel.tick, release: 0.50, cutoff: co_bb + 12, amp: 0.92
          sleep 0.50
          play bb_mel.tick, release: 0.70, cutoff: co_bb + 3,  amp: 0.95
          sleep 0.50

          # --- Harmony: Rhodey Bb jazz ii-V-I cycle ---
          bb_jazz = (ring
            chord(:bb3, :major7),
            chord(:g3, :m7),
            chord(:eb3, :major7),
            chord(:f3, '7')
          )
          co3 = (line 88, 108, steps: 8).tick
          use_synth :rhodey
          play_chord bb_jazz.tick, cutoff: co3,      release: 1.8, amp: 0.52
          sleep 2
          play_chord bb_jazz.tick, cutoff: co3 + 5,  release: 1.8, amp: 0.48
          sleep 2

          # --- Bass: Walking line in Bb major (with LPF warmth) ---
          with_fx :lpf, cutoff: 82, mix: 1.0 do
            use_synth :bass_foundation
            bb_walk = (ring :bb2, :d3, :f3, :d3, :bb2, :c3, :eb3, :c3)
            play bb_walk.tick, cutoff: 78, release: 0.9, amp: 0.74
            sleep 1
            play bb_walk.tick, cutoff: 72, release: 0.7, amp: 0.60
            sleep 1
            play bb_walk.tick, cutoff: 76, release: 0.85, amp: 0.68
            sleep 1
            play bb_walk.tick, cutoff: 68, release: 0.55, amp: 0.57
            sleep 1
          end

          # --- Percussion: Fuller chorus feel, accented downbeat ---
          sample :drum_bass_soft, amp: 0.80
          sample :drum_cymbal_closed, amp: 0.36
          sleep 0.5
          sample :drum_cymbal_pedal, amp: 0.26
          sleep 0.5
          sample :drum_snare_soft, amp: 0.62
          sample :drum_cymbal_closed, amp: 0.32
          sleep 0.5
          sample :drum_snare_soft, amp: 0.26 if one_in(2)
          sample :drum_cymbal_pedal, amp: 0.24
          sleep 0.5
          sample :drum_bass_soft, amp: 0.70
          sample :drum_cymbal_closed, amp: 0.30
          sleep 0.5
          sample :drum_cymbal_pedal, amp: 0.26
          sleep 0.5
          sample :drum_snare_soft, amp: 0.58
          sample :drum_cymbal_closed, amp: 0.28
          sleep 0.5
          sample :drum_cymbal_pedal, amp: 0.22
          sleep 0.5
        end
      end
    end

    # ================================================================
    # OUTRO: Gentle fadeout in Bb — sustained drones dissolve
    # ================================================================
    use_synth :blade
    play :bb2, release: 12, cutoff: 80, amp: 0.28
    use_synth :rhodey
    play :d4, release: 10, cutoff: 82, amp: 0.22
    use_synth :hollow
    play_chord chord(:bb2, :major7), cutoff: 80, release: 12, amp: 0.25
    use_synth :fm
    play :bb1, cutoff: 78, release: 10, divisor: 2, depth: 3, amp: 0.20
    use_synth :subpulse
    play :bb1, cutoff: 60, release: 12, amp: 0.45
    use_synth :bass_foundation
    play :bb2, cutoff: 68, release: 8, amp: 0.50
    sample :drum_cymbal_pedal, amp: 0.16
    sleep 1
    sample :drum_snare_soft, amp: 0.30
    sleep 1
    sample :drum_cymbal_pedal, amp: 0.13
    sleep 1
    sample :drum_cymbal_closed, amp: 0.16
    sleep 1

  end
end