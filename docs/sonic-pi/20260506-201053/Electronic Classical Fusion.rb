# Silicon Symphony
# Style: Hybrid electronic / Romantic orchestral | Mood: Dynamic, dramatic, evolving

use_debug false
use_bpm 112

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ================================================================
    # SECTION 1: Dm Opening — Chiplead melody, blade pads, bass foundation, steady drums
    # 2 reps x 8 beats = 16 beats total
    # ================================================================
    cutoff_line1   = (line 80, 115, steps: 16)
    dm_melody1     = (ring :d4, :f4, :a4, :d5, :c5, :a4, :g4, :f4)
    dm_chords1     = (ring chord(:d3, :minor), chord(:bb2, :major), chord(:f2, :major), chord(:a2, :major))
    cutoff_sweep1  = (line 80, 105, steps: 8)
    dm_roots1      = (ring :d2, :d2, :a2, :d2, :f2, :d2, :a2, :c3)

    2.times do
      # --- Long drones: melody + harmony foundation ---
      use_synth :fm
      play :d3, release: 9, divisor: 3, depth: 12, cutoff: 85, amp: 0.35

      use_synth :dark_ambience
      play :d2, cutoff: 85, release: 9, amp: 0.38

      use_synth :bass_foundation
      play :d2, cutoff: 68, release: 8, amp: 0.65

      # --- Melody: chiplead ---
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.28 do
            use_synth :chiplead
            8.times do
              play dm_melody1.tick, cutoff: cutoff_line1.tick, release: 0.18, amp: 0.92
              sleep 1
            end
          end
        end
      end

      # --- Harmony: blade pads ---
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.32 do
          with_fx :lpf, cutoff: 100, mix: 1.0 do
            use_synth :blade
            4.times do
              play_chord dm_chords1.tick, cutoff: cutoff_sweep1.tick, release: 2.1, amp: 0.50
              sleep 2
            end
          end
        end
      end

      # --- Bass: tb303 walking line ---
      in_thread do
        use_synth :tb303
        8.times do
          play dm_roots1.tick, cutoff: 72, release: 0.55, wave: 0, amp: 0.62
          sleep 1
        end
      end

      # --- Percussion: kick/snare foundation, hi-hats ---
      with_fx :hpf, cutoff: 90, mix: 1.0 do
        8.times do |i|
          if i == 0
            sample :bd_haus, amp: 0.80
            sample :drum_cymbal_hard, amp: 0.45, rate: 1.4
          elsif i == 4
            sample :bd_haus, amp: 0.65
          end
          sample :elec_snare, amp: 0.60 if i == 2 || i == 6
          sample :hat_cab, amp: i.even? ? 0.38 : 0.26, rate: 1.2
          sample :drum_tom_mid_hard, amp: 0.36 if i == 7
          sleep 1
        end
      end
    end

    # ================================================================
    # TRANSITION: Dm -> Em drone bridge (4 beats)
    # ================================================================
    use_synth :fm
    play :d3, cutoff: 90, release: 8, amp: 0.45
    use_synth :hollow
    play_chord chord(:d3, :minor), cutoff: 88, release: 8, amp: 0.40
    use_synth :bass_foundation
    play :d2, cutoff: 65, release: 6, amp: 0.60

    sample :drum_cymbal_open, amp: 0.50, rate: 0.9
    sleep 1
    sample :drum_tom_mid_hard, amp: 0.45
    sleep 1
    sample :elec_snare, amp: 0.55
    sleep 1
    sample :drum_cymbal_hard, amp: 0.42, rate: 1.1
    sleep 1

    # ================================================================
    # SECTION 2: Dm Intense — Winwood lead, hollow pads, subpulse bass, driving drums
    # 2 reps x 8 beats = 16 beats total
    # ================================================================
    dm_melody2    = (ring :d4, :a4, :c5, :a4, :f4, :g4, :a4, :d5)
    cutoff_line2  = (line 85, 120, steps: 16)
    dm_chords2    = (ring chord(:d3, :minor), chord(:g3, :minor), chord(:a3, :major), chord(:d3, :minor))
    cutoff_sweep2 = (line 85, 115, steps: 8)
    dm_walk2      = (ring :d2, :f2, :a2, :c3, :a2, :f2, :g2, :a2)

    2.times do
      # --- Long drones ---
      use_synth :fm
      play :a2, release: 9, divisor: 2, depth: 16, cutoff: 88, amp: 0.32

      use_synth :blade
      play :a2, cutoff: 82, release: 9, amp: 0.36

      use_synth :subpulse
      play :d1, cutoff: 62, release: 9, amp: 0.65

      # --- Melody: winwood_lead ---
      in_thread do
        use_synth :winwood_lead
        8.times do
          play dm_melody2.tick, cutoff: cutoff_line2.tick, release: 0.22, amp: 0.95
          sleep 1
        end
      end

      # --- Harmony: hollow pads ---
      in_thread do
        use_synth :hollow
        4.times do
          play_chord dm_chords2.tick, cutoff: cutoff_sweep2.tick, release: 2.1, amp: 0.52
          sleep 2
        end
      end

      # --- Bass: tb303 walking continuo ---
      in_thread do
        use_synth :tb303
        8.times do
          play dm_walk2.tick, cutoff: 78, release: 0.65, wave: 0, amp: 0.65
          sleep 1
        end
      end

      # --- Percussion: driving pattern with ghost snares ---
      8.times do |i|
        if i == 0
          sample :bd_haus, amp: 0.85
          sample :drum_cymbal_hard, amp: 0.48, rate: 1.3
        elsif i == 4
          sample :bd_haus, amp: 0.70
        end
        if i == 2 || i == 6
          sample :elec_snare, amp: 0.68
        end
        sample :elec_snare, amp: 0.24, rate: 1.5 if one_in(4) && i != 2 && i != 6
        sample :hat_cab, amp: 0.34, rate: 1.1
        sleep 0.5
        sample :hat_cab, amp: 0.22, rate: 1.3
        sleep 0.5
      end
    end

    # ================================================================
    # TRANSITION: Dm -> Em key change drone (4 beats)
    # ================================================================
    use_synth :fm
    play :e3, cutoff: 95, release: 8, amp: 0.50
    use_synth :dark_ambience
    play :e2, cutoff: 90, release: 8, amp: 0.44
    use_synth :bass_foundation
    play :e2, cutoff: 68, release: 6, amp: 0.62

    sample :drum_cymbal_open, amp: 0.55, rate: 0.85
    sleep 1
    sample :bd_haus, amp: 0.75
    sample :elec_snare, amp: 0.60
    sleep 1
    sample :drum_tom_mid_hard, amp: 0.50
    sleep 0.5
    sample :drum_tom_mid_hard, amp: 0.44, rate: 0.9
    sleep 0.5
    sample :drum_cymbal_hard, amp: 0.46, rate: 1.2
    sleep 1

    # ================================================================
    # SECTION 3: Em Climax — FM lead, hollow pads, bass_foundation walking Em, full drums
    # 2 reps x 8 beats = 16 beats total
    # ================================================================
    em_melody     = (ring :e4, :g4, :b4, :e5, :d5, :b4, :a4, :g4)
    cutoff_line3  = (line 90, 125, steps: 16)
    em_chords     = (ring chord(:e3, :minor), chord(:c3, :major), chord(:g3, :major), chord(:b3, :major))
    cutoff_sweep3 = (line 88, 120, steps: 8)
    em_walk       = (ring :e2, :g2, :b2, :e3, :d3, :b2, :a2, :b2)

    2.times do
      # --- Long drones ---
      use_synth :fm
      play :e3, release: 10, divisor: 2, depth: 18, cutoff: 90, amp: 0.36

      use_synth :dark_ambience
      play :e2, cutoff: 90, release: 11, amp: 0.42

      use_synth :subpulse
      play :e1, cutoff: 60, release: 10, amp: 0.65

      # --- Melody: fm with echo ---
      in_thread do
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.20 do
          use_synth :fm
          8.times do
            play em_melody.tick, cutoff: cutoff_line3.tick, release: 0.2, divisor: 2, depth: 8, amp: 0.90
            sleep 1
          end
        end
      end

      # --- Harmony: hollow pads with reverb ---
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.38 do
          use_synth :hollow
          4.times do
            play_chord em_chords.tick, cutoff: cutoff_sweep3.tick, release: 2.2, amp: 0.55
            sleep 2
          end
        end
      end

      # --- Bass: bass_foundation walking Em continuo ---
      in_thread do
        with_fx :lpf, cutoff: 88, mix: 1.0 do
          use_synth :bass_foundation
          8.times do
            play em_walk.tick, cutoff: 80, release: 0.70, amp: 0.63
            sleep 1
          end
        end
      end

      # --- Percussion: full orchestral-electronic hybrid ---
      with_fx :reverb, room: 0.25, mix: 0.22 do
        8.times do |i|
          if i == 0
            sample :bd_haus, amp: 0.88
            sample :drum_cymbal_open, amp: 0.46, rate: 1.0
          elsif i == 4
            sample :bd_haus, amp: 0.75
            sample :drum_cymbal_hard, amp: 0.36, rate: 1.2
          end
          if i == 2 || i == 6
            sample :elec_snare, amp: 0.74
            sample :drum_cymbal_hard, amp: 0.30, rate: 1.5 if one_in(2)
          end
          sample :drum_tom_mid_hard, amp: 0.50 if i == 6
          if i == 7
            sample :drum_tom_mid_hard, amp: 0.55, rate: 0.85
            sample :drum_cymbal_hard, amp: 0.40, rate: 1.1
          end
          sample :hat_cab, amp: 0.36, rate: 1.15
          sleep 0.5
          sample :hat_cab, amp: 0.24, rate: 1.3 if one_in(2)
          sleep 0.5
        end
      end
    end

    # ================================================================
    # FINAL FADE: Em sustained resolution — 8 beats
    # ================================================================
    use_synth :fm
    play :e3, release: 12, divisor: 3, depth: 10, cutoff: 80, amp: 0.40

    use_synth :blade
    play_chord chord(:e3, :minor), cutoff: 82, release: 12, amp: 0.44

    use_synth :dark_ambience
    play :e2, cutoff: 78, release: 14, amp: 0.38

    use_synth :bass_foundation
    play :e2, cutoff: 65, release: 12, amp: 0.56

    sample :drum_cymbal_open, amp: 0.50, rate: 0.8
    sleep 2
    sample :elec_snare, amp: 0.36
    sleep 2
    sample :drum_cymbal_hard, amp: 0.30, rate: 0.9
    sleep 2
    sample :hat_cab, amp: 0.18
    sleep 2

  end
end