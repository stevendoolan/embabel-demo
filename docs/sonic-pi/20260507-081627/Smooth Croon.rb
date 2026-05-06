# Smooth Croon
# Style: Soul | Mood: Warm, soulful, and lush | Key: F → Bb | BPM: 72 | Time: 4/4

use_debug false
use_bpm 72

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================================
    # SECTION 1: Smooth Soul Opening in F
    # Melody: Rhodey lead | Harmony: Piano + Hollow drone
    # Bass: Walking bass in F | Percussion: Laid-back soul groove
    # =============================================================
    melody_notes = (ring :f4, :a4, :c5, :eb5, :f5, :eb5, :c5, :a4)
    f_chords     = (ring chord(:f3, :major7), chord(:d3, :m7), chord(:a2, :m7), chord(:c3, '9'))
    bass_walk_f  = (ring :f2, :a2, :c3, :eb2, :f2, :c2, :a2, :g2)

    2.times do
      # --- Long drones for atmosphere ---
      use_synth :rhodey
      play :f3, release: 16, cutoff: 85, amp: 0.5
      use_synth :hollow
      play_chord chord(:f2, :major7), cutoff: 88, release: 16, amp: 0.7
      use_synth :bass_foundation
      play :f1, cutoff: 68, release: 8, amp: 1.0

      # --- Melody: Rhodey lead in F ---
      with_fx :reverb, room: 0.25, mix: 0.28 do
        use_synth :rhodey
        4.times do
          play melody_notes.tick, cutoff: rrand(88, 108), release: 0.55, amp: 1.8
          sleep 1
          play melody_notes.tick, cutoff: rrand(85, 105), release: 0.45, amp: 1.7
          sleep 1
          play melody_notes.tick, cutoff: rrand(90, 110), release: 0.55, amp: 1.8
          sleep 0.5
          play melody_notes.tick, cutoff: rrand(82, 100), release: 0.3,  amp: 1.7
          sleep 0.5
        end
      end

      # --- Harmony: Piano chords with arpeggiated fills ---
      with_fx :reverb, room: 0.3, mix: 0.3 do
        use_synth :piano
        4.times do
          play_chord f_chords.tick, cutoff: (line 82, 100, steps: 8).tick, release: 3.6, amp: 0.85
          sleep 2
          arp = f_chords.look.to_a
          play arp[0], cutoff: 92, release: 0.35, amp: 0.7
          sleep 0.5
          play arp[1], cutoff: 90, release: 0.3,  amp: 0.65
          sleep 0.5
          play arp[2], cutoff: 88, release: 0.25, amp: 0.6
          sleep 0.5
          play arp[0] + 12, cutoff: 86, release: 0.2, amp: 0.55
          sleep 0.5
        end
      end

      # --- Bass: Walking bass in F ---
      use_synth :bass_foundation
      4.times do
        play bass_walk_f.tick, cutoff: 72, release: 0.85, amp: 1.05
        sleep 1
        play bass_walk_f.tick, cutoff: 70, release: 0.7,  amp: 0.9
        sleep 1
        play bass_walk_f.tick, cutoff: 74, release: 0.75, amp: 1.0
        sleep 0.5
        play bass_walk_f.tick, cutoff: 68, release: 0.5,  amp: 0.85
        sleep 0.5
      end

      # --- Percussion: Laid-back soul groove ---
      4.times do
        sample :bd_pure,        amp: 1.4
        sample :hat_cab,        amp: 0.7
        sleep 0.5
        sample :hat_cab,        amp: 0.55, rate: 0.95
        sleep 0.5
        sample :drum_snare_soft, amp: 1.2
        sample :hat_cab,        amp: 0.65
        sleep 0.5
        sample :hat_cab,        amp: 0.5, rate: 0.9
        sleep 0.5
        sample :bd_pure,        amp: 1.1
        sample :hat_cab,        amp: 0.6
        sleep 0.5
        sample :hat_cab,        amp: 0.45, rate: 0.95
        sleep 0.5
        sample :drum_snare_soft, amp: 1.1
        sample :drum_cymbal_soft, amp: 0.55
        sleep 0.5
        sample :hat_cab,        amp: 0.5 if one_in(2)
        sleep 0.5
      end
    end

    # =============================================================
    # TRANSITION: F → Bb drone bridge
    # =============================================================
    use_synth :rhodey
    play :f3, cutoff: 90, release: 8, amp: 1.2
    use_synth :hollow
    play_chord chord(:f2, :major7), cutoff: 85, release: 8, amp: 0.8
    use_synth :bass_foundation
    play :f1, cutoff: 70, release: 8, amp: 1.0
    sample :drum_cymbal_soft, amp: 0.65
    sleep 4

    # =============================================================
    # SECTION 2: Soul Groove in F
    # Melody: Winwood Lead | Harmony: Piano comping rhythm
    # Bass: Syncopated groove bass | Percussion: Swing feel groove
    # =============================================================
    melody_b      = (ring :f4, :g4, :a4, :bb4, :c5, :bb4, :a4, :g4)
    groove_chords = (ring chord(:f3, :major7), chord(:bb2, :maj9), chord(:g2, :m7), chord(:c3, '9'))
    bass_groove_f = (ring :f2, :c2, :a2, :bb2, :c3, :a2, :g2, :eb2)

    2.times do
      # --- Long drones for atmosphere ---
      use_synth :winwood_lead
      play :f3, release: 16, cutoff: 80, amp: 0.45
      use_synth :hollow
      play_chord chord(:f2, :major7), cutoff: 82, release: 16, amp: 0.65
      use_synth :fm
      play :f1, cutoff: 65, release: 8, divisor: 2, depth: 1.5, amp: 0.85

      # --- Melody: Winwood Lead with echo ---
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.18 do
        use_synth :winwood_lead
        4.times do
          sample :drum_snare_soft, amp: 0.7
          sample :hat_tap,         amp: 0.55
          play melody_b.tick, cutoff: rrand(90, 115), release: 0.6,  amp: 1.9
          sleep 1
          sample :hat_tap,         amp: 0.45
          play melody_b.tick, cutoff: rrand(85, 108), release: 0.45, amp: 1.75
          sleep 1
          sample :drum_snare_hard, amp: 0.75
          sample :hat_tap,         amp: 0.5
          play melody_b.tick, cutoff: rrand(88, 112), release: 0.5,  amp: 1.8
          sleep 1
          sample :hat_tap,         amp: 0.4
          play melody_b.tick, cutoff: rrand(82, 102), release: 0.35, amp: 1.7
          sleep 1
        end
      end

      # --- Harmony: Piano comping rhythm ---
      use_synth :piano
      4.times do
        play_chord groove_chords.tick, cutoff: 95, release: 1.6, amp: 0.9
        sleep 1
        inner = groove_chords.look.to_a
        play inner[1], cutoff: 90, release: 0.4,  amp: 0.6
        sleep 1
        play_chord groove_chords.look, cutoff: 92, release: 0.9,  amp: 0.75
        sleep 1
        play inner[2],       cutoff: 88, release: 0.3,  amp: 0.55
        sleep 0.5
        play inner[0] + 12,  cutoff: 86, release: 0.25, amp: 0.5
        sleep 0.5
      end

      # --- Bass: Syncopated groove bass in F ---
      use_synth :bass_foundation
      4.times do
        play bass_groove_f.tick, cutoff: 78, release: 0.9,  amp: 1.1
        sleep 0.75
        play bass_groove_f.tick, cutoff: 72, release: 0.5,  amp: 0.85
        sleep 1.25
        play bass_groove_f.tick, cutoff: 76, release: 0.8,  amp: 1.0
        sleep 0.75
        play bass_groove_f.tick, cutoff: 70, release: 0.45, amp: 0.82
        sleep 0.25
      end

      # --- Percussion: Swing feel with ghost snares ---
      with_fx :reverb, room: 0.22, mix: 0.22 do
        4.times do
          sample :bd_pure,         amp: 1.5
          sample :hat_cab,         amp: 0.75
          sleep 0.5
          sample :hat_cab,         amp: 0.5
          sleep 0.25
          sample :drum_snare_soft, amp: 0.7 if one_in(3)
          sleep 0.25
          sample :drum_snare_soft, amp: 1.3
          sample :hat_cab,         amp: 0.7
          sleep 0.5
          sample :hat_cab,         amp: 0.5
          sleep 0.5
          sample :bd_pure,         amp: 1.2
          sample :hat_cab,         amp: 0.65
          sleep 0.5
          sample :hat_cab,         amp: 0.45
          sleep 0.25
          sample :hat_cab,         amp: 0.4 if one_in(2)
          sleep 0.25
          sample :drum_snare_soft, amp: 1.2
          sample :drum_cymbal_soft, amp: 0.6
          sleep 0.5
          sample :hat_cab,         amp: 0.55
          sleep 0.5
        end
      end
    end

    # =============================================================
    # TRANSITION: Key change drone F → Bb
    # =============================================================
    use_synth :rhodey
    play :bb2, cutoff: 88, release: 10, amp: 1.2
    use_synth :hollow
    play_chord chord(:bb1, :maj9), cutoff: 84, release: 10, amp: 0.85
    use_synth :bass_foundation
    play :bb1, cutoff: 68, release: 10, amp: 1.05
    sample :drum_cymbal_soft, amp: 0.7
    sleep 4

    # =============================================================
    # SECTION 3: Key Change to Bb — Soulful Resolution
    # Melody: Rhodey lead in Bb | Harmony: Piano lush maj7/9 voicings
    # Bass: Walking bass in Bb | Percussion: Fuller, warmer groove
    # =============================================================
    melody_c      = (ring :bb4, :d5, :f5, :eb5, :d5, :c5, :bb4, :f4)
    harmony_c     = (ring :bb3, :f4, :d4, :eb4)
    bb_chords     = (ring chord(:bb2, :major7), chord(:g2, :m9), chord(:eb3, :major7), chord(:f2, '9'))
    bass_walk_bb  = (ring :bb1, :d2, :f2, :eb2, :d2, :c2, :bb1, :f1)

    3.times do
      # --- Long drones for atmosphere ---
      use_synth :rhodey
      play :bb2, release: 16, cutoff: 82, amp: 0.5
      use_synth :hollow
      play_chord chord(:bb1, :major7), cutoff: 85, release: 16, amp: 0.72
      use_synth :fm
      play :bb1, cutoff: 63, release: 8, divisor: 2, depth: 1.2, amp: 0.9

      # --- Melody: Rhodey lead in Bb ---
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          use_synth :rhodey
          play harmony_c.tick, release: 3.8, cutoff: 78, amp: 0.5
          4.times do
            sample :drum_snare_soft, amp: 0.65
            sample :hat_tap,         amp: 0.5
            play melody_c.tick, cutoff: rrand(92, 118), release: 0.65, amp: 2.0
            sleep 1
            sample :hat_tap,         amp: 0.42
            play melody_c.tick, cutoff: rrand(88, 112), release: 0.5,  amp: 1.85
            sleep 1
            sample :drum_snare_hard, amp: 0.72
            sample :hat_tap,         amp: 0.48
            play melody_c.tick, cutoff: rrand(90, 116), release: 0.6,  amp: 1.95
            sleep 0.5
            play melody_c.tick, cutoff: rrand(85, 108), release: 0.35, amp: 1.8
            sleep 0.5
          end
        end
      end

      # --- Harmony: Lush piano maj7/9 voicings in Bb ---
      with_fx :lpf, cutoff: 105, mix: 1.0 do
        use_synth :piano
        4.times do
          play_chord bb_chords.tick, cutoff: (line 85, 108, steps: 12).tick, release: 2.8, amp: 0.88
          sleep 1
          inner_bb = bb_chords.look.to_a
          play inner_bb[0],      cutoff: 90, release: 0.5,  amp: 0.62
          sleep 0.5
          play inner_bb[1],      cutoff: 88, release: 0.4,  amp: 0.58
          sleep 0.5
          play inner_bb[2],      cutoff: 86, release: 0.35, amp: 0.55
          sleep 0.5
          play inner_bb[0] + 12, cutoff: 84, release: 0.3,  amp: 0.5
          sleep 0.5
          play inner_bb[1] + 12, cutoff: 82, release: 0.25, amp: 0.48
          sleep 0.5
          play inner_bb[2],      cutoff: 80, release: 0.2,  amp: 0.45
          sleep 0.5
        end
      end

      # --- Bass: Walking bass in Bb ---
      with_fx :lpf, cutoff: 85, mix: 1.0 do
        use_synth :bass_foundation
        4.times do
          play bass_walk_bb.tick, cutoff: 75, release: 0.9,  amp: 1.1
          sleep 1
          play bass_walk_bb.tick, cutoff: 72, release: 0.7,  amp: 0.88
          sleep 1
          play bass_walk_bb.tick, cutoff: 76, release: 0.8,  amp: 1.0
          sleep 0.5
          play bass_walk_bb.tick, cutoff: 70, release: 0.5,  amp: 0.85
          sleep 0.5
        end
      end

      # --- Percussion: Fuller, warmer groove in Bb ---
      4.times do
        sample :bd_pure,          amp: 1.6
        sample :hat_cab,          amp: 0.8
        sleep 0.5
        sample :hat_cab,          amp: 0.55, rate: 0.92
        sleep 0.25
        sample :drum_snare_soft,  amp: 0.65 if one_in(3)
        sleep 0.25
        sample :drum_snare_soft,  amp: 1.4
        sample :hat_cab,          amp: 0.7
        sleep 0.5
        sample :hat_cab,          amp: 0.5
        sleep 0.5
        sample :bd_pure,          amp: 1.2
        sample :hat_cab,          amp: 0.65
        sleep 0.5
        sample :hat_cab,          amp: 0.5, rate: 0.95
        sleep 0.25
        sample :hat_cab,          amp: 0.4 if one_in(2)
        sleep 0.25
        sample :drum_snare_soft,  amp: 1.3
        sample :drum_cymbal_soft, amp: 0.7
        sleep 0.5
        sample :hat_cab,          amp: 0.6
        sleep 0.5
      end
    end

    # =============================================================
    # OUTRO: Long Bb drone resolution — fade to stillness
    # =============================================================
    use_synth :winwood_lead
    play :bb3, cutoff: 85, release: 12, amp: 1.0
    use_synth :rhodey
    play :f4,  cutoff: 80, release: 10, amp: 0.8
    use_synth :hollow
    play_chord chord(:bb1, :major7), cutoff: 82, release: 14, amp: 0.75
    use_synth :piano
    play_chord chord(:bb3, :major7), cutoff: 85, release: 10, amp: 0.7
    use_synth :bass_foundation
    play :bb1, cutoff: 65, release: 12, amp: 1.0
    use_synth :fm
    play :f1,  cutoff: 60, release: 10, divisor: 2, depth: 1.0, amp: 0.8
    4.times do
      sample :drum_cymbal_soft, amp: 0.6
      sleep 1
      sample :hat_cab, amp: 0.45
      sleep 1
    end

  end
end