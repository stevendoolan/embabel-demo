# Digital Baroque
# Style: Epic Baroque | Mood: Dark, triumphant, orchestral
# Key: Dm → F Major | Time: 4/4 | BPM: 112

use_debug false
use_bpm 112

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ════════════════════════════════════════════════════════════════
    # SECTION 1: Dm – Epic Baroque Opening
    # Melody: blade lead | Harmony: dark_ambience + hollow + fm
    # Bass: bass_foundation walking continuo | Perc: stately kick/cymbal
    # ════════════════════════════════════════════════════════════════
    dm_melody  = (ring :d4, :f4, :a4, :d5, :c5, :a4, :g4, :f4,
                       :e4, :f4, :a4, :c5, :d5, :a4, :f4, :e4)
    dm_chords  = (ring chord(:d3, :minor), chord(:bb3, :major), chord(:f3, :major), chord(:c3, :major))
    dm_arps    = (ring :d3, :f3, :a3, :c4, :f3, :a3, :c4, :d4)
    s1_walk    = (ring :d2, :f2, :a2, :c3, :a2, :f2, :e2, :d2)

    2.times do
      # — Melody drone —
      use_synth :blade
      play :d3, release: 8, cutoff: 85, amp: 1.2

      # — Harmony drone —
      use_synth :dark_ambience
      play_chord chord(:d2, :minor), cutoff: 82, release: 16, amp: 0.85

      # — Bass drone —
      use_synth :bass_foundation
      play :d1, cutoff: 65, release: 8, amp: 1.1

      with_fx :reverb, room: 0.28, mix: 0.3 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          8.times do |i|
            # — Percussion beat 1 accent —
            sample :bd_fat, amp: 1.6
            sample :drum_cymbal_hard, amp: 0.8 if i == 0
            sample :hat_zild, amp: 0.6

            # — Harmony: hollow pad chord —
            use_synth :hollow
            play_chord dm_chords.tick, cutoff: (line 80, 100, steps: 8).tick, release: 1.8, amp: 0.75

            # — Harmony: FM arp —
            use_synth :fm
            play dm_arps.tick, cutoff: 88, release: 0.12, amp: 0.6, divisor: 3, depth: 6

            # — Melody: beat 1 —
            use_synth :blade
            play dm_melody.tick, cutoff: rrand(88, 112), release: 0.22, amp: 1.8

            # — Bass: beat 1 —
            use_synth :bass_foundation
            play s1_walk.tick, cutoff: 72, release: 0.8, amp: 1.15
            sleep 0.5

            # Beat 1-and
            sample :hat_zild, amp: 0.4
            use_synth :fm
            play dm_arps.look, cutoff: 85, release: 0.10, amp: 0.55, divisor: 3, depth: 6
            use_synth :blade
            play dm_melody.tick, cutoff: rrand(85, 108), release: 0.18, amp: 1.7
            sleep 0.5

            # Beat 2
            sample :hat_zild, amp: 0.55
            use_synth :fm
            play dm_arps.tick, cutoff: 90, release: 0.12, amp: 0.6, divisor: 3, depth: 6
            use_synth :blade
            play dm_melody.tick, cutoff: rrand(88, 115), release: 0.20, amp: 1.8
            # — Bass: beat 2 (tb303 fifth) —
            use_synth :tb303
            play :a1, cutoff: 68, release: 0.5, wave: 0, amp: 0.85
            sleep 0.5

            # Beat 2-and
            sample :hat_zild, amp: 0.35
            use_synth :fm
            play dm_arps.look, cutoff: 86, release: 0.10, amp: 0.55, divisor: 3, depth: 6
            use_synth :blade
            play dm_melody.tick, cutoff: rrand(82, 105), release: 0.18, amp: 1.7
            sleep 0.5

            # Beat 3 — kick + snare
            sample :bd_fat, amp: 1.4
            sample :drum_snare_hard, amp: 1.0
            sample :hat_zild, amp: 0.55
            # — Bass: beat 3 walking step —
            use_synth :bass_foundation
            play s1_walk.look, cutoff: 70, release: 0.7, amp: 1.0
            sleep 0.5

            # Beat 3-and
            sample :hat_zild, amp: 0.35
            sleep 0.5

            # Beat 4
            sample :hat_zild, amp: 0.55
            sample :elec_cymbal, amp: 0.5 if one_in(3)
            # — Bass: beat 4 tb303 —
            use_synth :tb303
            play :c2, cutoff: 66, release: 0.5, wave: 0, amp: 0.8
            sleep 0.5

            # Beat 4-and
            sample :drum_tom_mid_hard, amp: 0.7 if i == 7
            sample :hat_zild, amp: 0.35
            sleep 0.5
          end
        end
      end
    end

    # ════════════════════════════════════════════════════════════════
    # TRANSITION 1: Drone bridge Dm → F (sleep 4)
    # ════════════════════════════════════════════════════════════════
    use_synth :blade
    play :d3, cutoff: 90, release: 8, amp: 1.2
    use_synth :pluck
    play :f3, cutoff: 88, release: 6, amp: 0.9
    use_synth :dark_ambience
    play :d2, cutoff: 85, release: 8, amp: 0.9
    use_synth :hollow
    play_chord chord(:f3, :major), cutoff: 88, release: 6, amp: 0.8
    use_synth :bass_foundation
    play :d2, cutoff: 68, release: 8, amp: 1.05
    sample :drum_cymbal_hard, amp: 0.9
    sample :bd_fat, amp: 1.5
    sleep 1
    sample :hat_zild, amp: 0.5
    sleep 1
    sample :drum_snare_hard, amp: 1.1
    sample :elec_cymbal, amp: 0.6
    sleep 1
    sample :hat_zild, amp: 0.5
    sleep 1

    # ════════════════════════════════════════════════════════════════
    # SECTION 2: Dm – Winwood Lead Countermelody
    # Melody: winwood_lead | Harmony: hollow + fm | Bass: tb303 animated
    # Perc: busier pattern with tom accents
    # ════════════════════════════════════════════════════════════════
    ww_melody  = (ring :a4, :g4, :f4, :e4, :d4, :e4, :f4, :a4,
                       :c5, :a4, :g4, :f4, :e4, :f4, :g4, :a4)
    pluck_bass = (ring :d3, :a3, :f3, :c3)
    dm2_chords = (ring chord(:d3, :minor), chord(:g3, :minor), chord(:a3, :major), chord(:d3, :minor))
    dm2_arps   = (ring :d3, :a3, :f3, :a3, :g3, :d4, :a3, :e4)
    s2_walk    = (ring :d2, :a2, :f2, :c2, :e2, :f2, :a2, :d2)

    2.times do
      # — Melody drone —
      use_synth :fm
      play :d2, release: 8, cutoff: 80, amp: 0.9, divisor: 4, depth: 8

      # — Harmony drone —
      use_synth :dark_ambience
      play :d2, cutoff: 80, release: 16, amp: 0.8

      # — Bass drone —
      use_synth :bass_foundation
      play :d1, cutoff: 62, release: 8, amp: 1.0

      8.times do |i|
        # Beat 1 — kick + cymbal downbeat accent on bar 1
        sample :bd_fat, amp: 1.7
        sample :drum_cymbal_hard, amp: 0.85 if i == 0
        sample :hat_zild, amp: 0.65

        # — Harmony: hollow pad —
        use_synth :hollow
        play_chord dm2_chords.tick, cutoff: (line 83, 103, steps: 8).tick, release: 2.0, amp: 0.8

        # — Harmony: FM arp —
        use_synth :fm
        play dm2_arps.tick, cutoff: rrand(84, 96), release: 0.11, amp: 0.55, divisor: 4, depth: 5

        # — Melody: beat 1 (winwood_lead) —
        use_synth :winwood_lead
        play ww_melody.tick, cutoff: (line 88, 115, steps: 16).tick, release: 0.28, amp: 1.9

        # — Bass: beat 1 —
        use_synth :bass_foundation
        play s2_walk.tick, cutoff: 75, release: 0.9, amp: 1.15
        sleep 0.5

        # Beat 1-and — snare ghost + hi-hat
        sample :drum_snare_hard, amp: 0.6
        sample :hat_zild, amp: 0.45
        use_synth :fm
        play dm2_arps.look, cutoff: rrand(82, 94), release: 0.10, amp: 0.50, divisor: 4, depth: 5
        use_synth :pluck
        play pluck_bass.look, cutoff: 90, release: 0.4, amp: 1.2
        use_synth :winwood_lead
        play ww_melody.tick, cutoff: rrand(85, 110), release: 0.22, amp: 1.8
        sleep 0.5

        # Beat 2 — hi-hat
        sample :hat_zild, amp: 0.6
        use_synth :fm
        play dm2_arps.tick, cutoff: rrand(86, 98), release: 0.12, amp: 0.55, divisor: 4, depth: 5
        use_synth :winwood_lead
        play ww_melody.tick, cutoff: rrand(90, 115), release: 0.25, amp: 1.9
        # — Bass: beat 2 tb303 —
        use_synth :tb303
        play :a1, cutoff: 70, release: 0.6, wave: 0, amp: 0.88
        sleep 0.5

        # Beat 2-and — light kick variation
        sample :bd_fat, amp: 0.9 if one_in(3)
        sample :hat_zild, amp: 0.4
        use_synth :fm
        play dm2_arps.look, cutoff: rrand(83, 95), release: 0.10, amp: 0.50, divisor: 4, depth: 5
        use_synth :pluck
        play pluck_bass.tick, cutoff: 88, release: 0.35, amp: 1.1
        use_synth :winwood_lead
        play ww_melody.tick, cutoff: rrand(85, 108), release: 0.20, amp: 1.8
        # — Bass: beat 2-and tb303 —
        use_synth :tb303
        play :f2, cutoff: 67, release: 0.4, wave: 0, amp: 0.78
        sleep 0.5

        # Beat 3 — kick + snare accent
        sample :bd_fat, amp: 1.5
        sample :drum_snare_hard, amp: 1.2
        sample :hat_zild, amp: 0.6
        # — Bass: beat 3 walking step —
        use_synth :bass_foundation
        play s2_walk.look, cutoff: 72, release: 0.8, amp: 1.0
        sleep 0.5

        # Beat 3-and — tom fill on every other bar
        sample :drum_tom_mid_hard, amp: 0.8 if i.odd?
        sample :hat_zild, amp: 0.4
        sleep 0.5

        # Beat 4 — hi-hat + elec cymbal shimmer
        sample :hat_zild, amp: 0.6
        sample :elec_cymbal, amp: 0.55 if one_in(2)
        # — Bass: beat 4 leading tone —
        use_synth :tb303
        play :c2, cutoff: 68, release: 0.5, wave: 0, amp: 0.82
        sleep 0.5

        # Beat 4-and — tom fill leading into next bar
        sample :drum_tom_mid_hard, amp: 0.75 if i == 7
        sample :hat_zild, amp: 0.45
        # — Bass: beat 4-and leading chromatic —
        use_synth :tb303
        play :cs2, cutoff: 65, release: 0.4, wave: 0, amp: 0.75
        sleep 0.5
      end
    end

    # ════════════════════════════════════════════════════════════════
    # TRANSITION 2: Key change to F Major — bold cymbal hit (sleep 4)
    # ════════════════════════════════════════════════════════════════
    use_synth :blade
    play :f3, cutoff: 92, release: 10, amp: 1.3
    use_synth :pluck
    play :c4, cutoff: 88, release: 6, amp: 0.9
    use_synth :dark_ambience
    play :f2, cutoff: 88, release: 10, amp: 1.0
    use_synth :hollow
    play_chord chord(:f3, :major7), cutoff: 90, release: 6, amp: 0.85
    use_synth :bass_foundation
    play :f2, cutoff: 70, release: 10, amp: 1.1
    sample :drum_cymbal_hard, amp: 1.1
    sample :bd_fat, amp: 1.6
    sleep 1
    sample :hat_zild, amp: 0.55
    sleep 1
    sample :drum_snare_hard, amp: 1.2
    sample :elec_cymbal, amp: 0.7
    sleep 1
    sample :drum_tom_mid_hard, amp: 0.9
    sleep 1

    # ════════════════════════════════════════════════════════════════
    # SECTION 3: F Major – Triumphant Resolution
    # Melody: blade + winwood_lead | Harmony: dark_ambience + hollow + fm
    # Bass: walking continuo | Perc: full driving hybrid pattern
    # ════════════════════════════════════════════════════════════════
    f_melody  = (ring :f4, :g4, :a4, :c5, :d5, :c5, :a4, :g4,
                      :f4, :a4, :c5, :e5, :f5, :e5, :d5, :c5)
    f_harmony = (ring :f3, :c4, :a3, :f3)
    f_chords  = (ring chord(:f3, :major), chord(:bb3, :major), chord(:c3, :major), chord(:f3, :major))
    f_arps    = (ring :f3, :a3, :c4, :f4, :bb3, :d4, :c3, :e3)
    s3_walk   = (ring :f2, :c3, :a2, :g2, :f2, :a2, :c3, :e3)
    s3_tb_res = (ring :a2, :g2, :f2, :e2)

    2.times do
      # — Melody drone —
      use_synth :blade
      play :f2, release: 8, cutoff: 88, amp: 1.0

      # — Harmony drone —
      use_synth :dark_ambience
      play_chord chord(:f2, :major), cutoff: 86, release: 16, amp: 1.0

      # — Bass drone —
      use_synth :bass_foundation
      play :f1, cutoff: 65, release: 8, amp: 1.1

      with_fx :reverb, room: 0.25, mix: 0.25 do
        8.times do |i|
          # Beat 1 — strong kick + cymbal downbeat on bar 1
          sample :bd_fat, amp: 1.8
          sample :drum_cymbal_hard, amp: 1.0 if i == 0
          sample :hat_zild, amp: 0.7

          # — Harmony: hollow pad —
          use_synth :hollow
          play_chord f_chords.tick, cutoff: (line 88, 115, steps: 8).tick, release: 2.2, amp: 0.85

          # — Harmony: FM arp —
          use_synth :fm
          play f_arps.tick, cutoff: rrand(90, 108), release: 0.14, amp: 0.65, divisor: 2, depth: 7

          # — Melody: beat 1 (blade) —
          use_synth :blade
          play f_melody.tick, cutoff: (line 90, 120, steps: 16).tick, release: 0.25, amp: 2.0

          # — Bass: beat 1 —
          use_synth :bass_foundation
          play s3_walk.tick, cutoff: 78, release: 0.9, amp: 1.2
          sleep 0.5

          # Beat 1-and — snare ghost
          sample :drum_snare_hard, amp: 0.65
          sample :hat_zild, amp: 0.5
          use_synth :fm
          play f_arps.look, cutoff: rrand(88, 105), release: 0.12, amp: 0.60, divisor: 2, depth: 7
          use_synth :pluck
          play f_harmony.look, cutoff: 92, release: 0.5, amp: 1.2
          use_synth :blade
          play f_melody.tick, cutoff: rrand(90, 118), release: 0.22, amp: 1.9
          sleep 0.5

          # Beat 2 — kick + snare accent
          sample :bd_fat, amp: 1.5
          sample :drum_snare_hard, amp: 1.3
          sample :hat_zild, amp: 0.65
          use_synth :fm
          play f_arps.tick, cutoff: rrand(92, 110), release: 0.14, amp: 0.65, divisor: 2, depth: 7
          use_synth :winwood_lead
          play f_melody.tick, cutoff: rrand(95, 120), release: 0.28, amp: 1.9
          # — Bass: beat 2 fifth —
          use_synth :tb303
          play :c2, cutoff: 72, release: 0.6, wave: 0, amp: 0.9
          sleep 0.5

          # Beat 2-and — elec cymbal shimmer
          sample :elec_cymbal, amp: 0.6
          sample :hat_zild, amp: 0.45
          use_synth :fm
          play f_arps.look, cutoff: rrand(90, 106), release: 0.12, amp: 0.60, divisor: 2, depth: 7
          use_synth :pluck
          play f_harmony.tick, cutoff: 90, release: 0.4, amp: 1.1
          use_synth :winwood_lead
          play f_melody.tick, cutoff: rrand(88, 112), release: 0.22, amp: 1.8
          sleep 0.5

          # Beat 3 — kick + cymbal hard swell
          sample :bd_fat, amp: 1.7
          sample :drum_cymbal_hard, amp: 0.75
          sample :hat_zild, amp: 0.65
          # — Bass: beat 3 walking movement —
          use_synth :bass_foundation
          play s3_walk.look, cutoff: 74, release: 0.8, amp: 1.05
          sleep 0.5

          # Beat 3-and — tom fill for orchestral grandeur
          sample :drum_tom_mid_hard, amp: 0.9
          sample :hat_zild, amp: 0.45
          sleep 0.5

          # Beat 4 — kick + snare
          sample :bd_fat, amp: 1.5
          sample :drum_snare_hard, amp: 1.2
          sample :hat_zild, amp: 0.65
          # — Bass: beat 4 resolving step —
          use_synth :tb303
          play s3_tb_res.tick, cutoff: 70, release: 0.5, wave: 0, amp: 0.85
          sleep 0.5

          # Beat 4-and — big cymbal swell into next bar / tom fill at section end
          sample :drum_cymbal_hard, amp: 0.85 if i == 7
          sample :drum_tom_mid_hard, amp: 1.0 if i == 7
          sample :elec_cymbal, amp: 0.55 if one_in(2)
          sample :hat_zild, amp: 0.5
          sleep 0.5
        end
      end
    end

    # ════════════════════════════════════════════════════════════════
    # FINAL CADENCE: Sustained F major resolution (sleep 6)
    # ════════════════════════════════════════════════════════════════
    use_synth :blade
    play :f3, cutoff: 90, release: 8, amp: 1.4
    use_synth :pluck
    play :f4, cutoff: 88, release: 6, amp: 1.2
    use_synth :pluck
    play :a4, cutoff: 86, release: 5, amp: 1.0
    use_synth :dark_ambience
    play_chord chord(:f2, :major), cutoff: 88, release: 10, amp: 1.0
    use_synth :hollow
    play_chord chord(:f3, :major7), cutoff: 90, release: 8, amp: 0.9
    use_synth :fm
    play :f3, cutoff: 92, release: 6, amp: 0.7, divisor: 3, depth: 5
    use_synth :bass_foundation
    play :f1, cutoff: 65, release: 8, amp: 1.1
    use_synth :tb303
    play :f2, cutoff: 72, release: 6, wave: 0, amp: 0.9
    sample :drum_cymbal_hard, amp: 1.0
    sample :bd_fat, amp: 1.6
    sleep 1
    sample :hat_zild, amp: 0.55
    sleep 1
    sample :drum_snare_hard, amp: 1.1
    sleep 1
    sample :elec_cymbal, amp: 0.65
    sleep 1
    sample :hat_zild, amp: 0.45
    sleep 1
    sample :drum_cymbal_hard, amp: 0.7
    sleep 1

  end
end