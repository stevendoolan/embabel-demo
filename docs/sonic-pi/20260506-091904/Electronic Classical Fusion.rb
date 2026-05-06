# Circuits & Strings
# Style: Dynamic hybrid electronic/orchestral | Mood: Energetic, evolving, cinematic
# Key: Dm → F | BPM: 112 | Time: 4/4

use_debug false
use_bpm 112

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =====================
    # SECTION 1: Dm — FM lead + hollow pad + foundational bass + kick/snare groove
    # 4 repeats x 2 bars = 8 bars
    # =====================
    dm_melody    = (ring :d4, :f4, :a4, :c5, :a4, :f4, :e4, :d4)
    dm_arp       = (ring :d4, :f4, :a4, :f4, :d4, :c4, :a3, :c4)
    dm_arp2      = (ring :a3, :d4, :f4, :a4, :c5, :a4, :f4, :d4)
    dm_chords    = (ring chord(:d3, :minor), chord(:a3, :minor), chord(:bb3, :major), chord(:a3, :minor))
    dm_bass_ring = (ring :d2, :d2, :a2, :f2)
    dm_sub_ring  = (ring :d2, :a2, :c2, :f2)

    4.times do
      # --- Long drones underneath (melody, harmony, bass) ---
      use_synth :fm
      play :d3, release: 8, divisor: 3, depth: 12, cutoff: 85, amp: 0.45

      use_synth :hollow
      play_chord chord(:d3, :minor), cutoff: 85, release: 8, amp: 0.45

      use_synth :bass_foundation
      play :d2, cutoff: 68, release: 8, amp: 0.72

      # --- Melody: FM lead (bar 1, 8 eighth notes) ---
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :reverb, room: 0.25, mix: 0.28 do
          use_synth :fm
          8.times do
            play dm_melody.tick, release: 0.18, cutoff: rrand(88, 112), divisor: 2, depth: 8, amp: 0.95
            sleep 0.5
          end
        end
      end

      # --- Harmony: Supersaw pad chord + Rhodey arpeggio (bar 1) ---
      use_synth :supersaw
      play_chord dm_chords.tick, cutoff: 82, release: 4, amp: 0.32

      with_fx :reverb, room: 0.3, mix: 0.3 do
        with_fx :lpf, cutoff: (line 80, 105, steps: 4).tick, mix: 1.0 do
          use_synth :rhodey
          8.times do
            play dm_arp.tick, cutoff: rrand(88, 108), release: 0.18, amp: 0.42
            sleep 0.5
          end
        end
      end

      # --- Melody: Pluck accents (bar 2) ---
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :reverb, room: 0.25, mix: 0.28 do
          use_synth :pluck
          [nil, :f4, nil, :a4, :d5, nil, :c5, nil].each do |n|
            play n, release: 0.3, cutoff: rrand(90, 115), amp: 0.85 if n
            sleep 0.5
          end
        end
      end

      # --- Harmony: Rhodey arpeggio bar 2 ---
      with_fx :reverb, room: 0.3, mix: 0.3 do
        use_synth :rhodey
        8.times do
          play dm_arp2.tick, cutoff: rrand(85, 105), release: 0.2, amp: 0.38
          sleep 0.5
        end
      end

      # --- Bass: subpulse + tb303 (runs concurrently via sleep accounting across both bars) ---
      use_synth :subpulse
      play dm_sub_ring.tick, cutoff: 72, release: 1.8, amp: 0.58

      # --- Percussion: bar 1 ---
      with_fx :hpf, cutoff: 100, mix: 1.0 do
        sample :bd_fat, amp: 0.72
        sample :hat_zild, amp: 0.28
      end
    end

    # =====================
    # TRANSITION 1: Dm → Dm (builds to section 2)
    # =====================
    use_synth :blade
    play :d4, release: 8, cutoff: 90, amp: 0.5
    use_synth :fm
    play :d3, release: 8, divisor: 4, depth: 10, cutoff: 80, amp: 0.38

    use_synth :hollow
    play_chord chord(:d3, :minor), cutoff: 88, release: 8, amp: 0.42
    use_synth :supersaw
    play :f3, cutoff: 80, release: 8, amp: 0.28

    use_synth :bass_foundation
    play :d2, cutoff: 65, release: 8, amp: 0.68
    use_synth :subpulse
    play :f2, cutoff: 70, release: 6, amp: 0.5

    sample :drum_cymbal_open, amp: 0.45
    sleep 1
    sample :drum_tom_mid_hard, amp: 0.35
    sleep 1
    sample :drum_tom_mid_hard, amp: 0.3
    sleep 1
    sample :drum_cymbal_soft, amp: 0.28
    sleep 1

    # =====================
    # SECTION 2: Dm — Blade lead + Supersaw evolving pad + deeper bass + euclidean kicks
    # 4 repeats x 2 bars = 8 bars
    # =====================
    dm_blade     = (ring :d4, :a4, :c5, :d5, :c5, :a4, :g4, :f4)
    dm_pluck     = (ring :f3, :a3, :d4, :f3)
    dm2_chords   = (ring chord(:d3, :m7), chord(:c3, :major), chord(:bb2, :major), chord(:a2, :minor))
    dm2_arp      = (ring :d4, :f4, :a4, :c5, :a4, :g4, :f4, :e4)
    dm2_arp2     = (ring :f3, :a3, :c4, :f4, :e4, :d4, :c4, :a3)
    dm2_bass_ring = (ring :d2, :f2, :a2, :c2)
    dm2_sub_ring  = (ring :d1, :a1, :d2, :g2)
    kick_pattern = spread(5, 8)

    4.times do
      # --- Long drones underneath ---
      use_synth :fm
      play :f3, release: 8, divisor: 2, depth: 14, cutoff: 88, amp: 0.38

      use_synth :blade
      play :d4, release: 4, cutoff: 95, amp: 0.3

      use_synth :hollow
      play_chord chord(:d3, :m7), cutoff: 90, release: 8, amp: 0.42

      use_synth :supersaw
      play_chord dm2_chords.tick, cutoff: (line 82, 112, steps: 4).tick, release: 4, amp: 0.32

      use_synth :bass_foundation
      play :d2, cutoff: 65, release: 8, amp: 0.72

      # --- Melody: Blade lead (bar 1) ---
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        use_synth :blade
        8.times do
          play dm_blade.tick, release: 0.22, cutoff: (line 90, 118, steps: 8).tick, amp: 0.9
          sleep 0.5
        end
      end

      # --- Harmony: Rhodey inner voice bar 1 ---
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        use_synth :rhodey
        8.times do
          play dm2_arp.tick, cutoff: rrand(90, 112), release: 0.2, amp: 0.42
          sleep 0.5
        end
      end

      # --- Melody: Pluck harmony (bar 2) ---
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        use_synth :pluck
        8.times do
          play dm_pluck.tick, release: 0.25, cutoff: rrand(85, 108), amp: 0.75
          sleep 0.5
        end
      end

      # --- Harmony: Rhodey inner voice bar 2 ---
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        use_synth :rhodey
        8.times do
          play dm2_arp2.tick, cutoff: rrand(85, 108), release: 0.22, amp: 0.38
          sleep 0.5
        end
      end

      # --- Bass: tb303 + subpulse syncopation ---
      use_synth :tb303
      play dm2_bass_ring.tick, cutoff: 80, res: 0.65, wave: 1, release: 1.4, amp: 0.58

      use_synth :subpulse
      play dm2_sub_ring.tick, cutoff: 68, release: 0.5, amp: 0.52

      # --- Percussion: euclidean kick bar 1 ---
      8.times do |i|
        sample :bd_fat, amp: (i == 0 ? 0.72 : 0.55) if kick_pattern[i]
        sample :hat_zild, amp: (i.even? ? 0.25 : 0.15)
        sample :drum_snare_hard, amp: 0.52 if [2, 6].include?(i)
        sample :drum_cymbal_soft, amp: 0.25 if i == 4
        sleep 0.5
      end

      # --- Percussion: bar 2 orchestral swell ---
      with_fx :reverb, room: 0.28, mix: 0.25 do
        sample :bd_fat, amp: 0.65
        sample :hat_zild, amp: 0.22
        sleep 0.5
        sample :drum_tom_mid_hard, amp: 0.42
        sleep 0.5
        sample :drum_snare_hard, amp: 0.55
        sample :drum_cymbal_soft, amp: 0.27
        sleep 0.5
        sample :hat_zild, amp: 0.18
        sleep 0.5
        sample :bd_fat, amp: 0.58
        sample :drum_tom_mid_hard, amp: 0.38
        sleep 0.5
        sample :drum_cymbal_soft, amp: 0.28
        sleep 0.5
        sample :drum_snare_hard, amp: 0.5
        sample :drum_cymbal_open, amp: 0.35
        sleep 0.5
        sample :hat_zild, amp: 0.15 if one_in(2)
        sleep 0.5
      end
    end

    # =====================
    # TRANSITION 2: Dm → F Major (key change)
    # =====================
    use_synth :blade
    play :f4, release: 9, cutoff: 92, amp: 0.52
    use_synth :fm
    play :f2, release: 9, divisor: 3, depth: 16, cutoff: 82, amp: 0.4

    use_synth :hollow
    play_chord chord(:f3, :major), cutoff: 90, release: 9, amp: 0.45
    use_synth :supersaw
    play :f3, cutoff: 82, release: 9, amp: 0.28

    use_synth :bass_foundation
    play :f2, cutoff: 66, release: 9, amp: 0.7
    use_synth :subpulse
    play :f1, cutoff: 62, release: 8, amp: 0.55

    sample :drum_cymbal_open, amp: 0.52
    sleep 1
    sample :drum_tom_mid_hard, amp: 0.42
    sleep 0.5
    sample :drum_tom_mid_hard, amp: 0.35
    sleep 0.5
    sample :drum_snare_hard, amp: 0.38
    sleep 1
    sample :drum_cymbal_soft, amp: 0.28
    sleep 1

    # =====================
    # SECTION 3: F Major — Brighter FM + hollow pads + driving bass + energetic percussion
    # 4 repeats x 2 bars = 8 bars
    # =====================
    f_melody  = (ring :f4, :g4, :a4, :c5, :a4, :g4, :f4, :e4)
    f_pluck   = (ring :f3, :c4, :a3, :f3)
    f_chords  = (ring chord(:f3, :major), chord(:c3, :major), chord(:a2, :minor), chord(:bb2, :major))
    f_arp     = (ring :f4, :a4, :c5, :a4, :g4, :f4, :e4, :f4)
    f_arp2    = (ring :c4, :e4, :g4, :c5, :a4, :g4, :f4, :e4)
    f_bass_ring = (ring :f2, :c2, :a2, :f2)
    f_sub_ring  = (ring :f1, :c2, :f2, :g2)

    4.times do
      # --- Long drones underneath ---
      use_synth :fm
      play :f3, release: 8, divisor: 2, depth: 18, cutoff: 100, amp: 0.4

      use_synth :hollow
      play_chord chord(:f3, :major), cutoff: 98, release: 8, amp: 0.42

      use_synth :supersaw
      play_chord f_chords.tick, cutoff: (line 90, 118, steps: 4).tick, release: 4, amp: 0.34

      use_synth :bass_foundation
      play :f2, cutoff: 72, release: 8, amp: 0.72

      # --- Melody: FM lead bar 1 (brighter) ---
      with_fx :lpf, cutoff: 118, mix: 1.0 do
        with_fx :reverb, room: 0.22, mix: 0.28 do
          use_synth :fm
          8.times do
            play f_melody.tick, release: 0.15, cutoff: rrand(100, 122), divisor: 2, depth: 10, amp: 0.95
            sleep 0.5
          end
        end
      end

      # --- Harmony: Rhodey arpeggio bar 1 ---
      with_fx :reverb, room: 0.35, mix: 0.3 do
        with_fx :lpf, cutoff: 112, mix: 1.0 do
          use_synth :rhodey
          8.times do
            play f_arp.tick, cutoff: rrand(95, 120), release: 0.17, amp: 0.44
            sleep 0.5
          end
        end
      end

      # --- Melody: Pluck harmony bar 2 ---
      with_fx :lpf, cutoff: 118, mix: 1.0 do
        with_fx :reverb, room: 0.22, mix: 0.28 do
          use_synth :pluck
          8.times do
            play f_pluck.tick, release: 0.28, cutoff: rrand(95, 118), amp: 0.8
            sleep 0.5
          end
        end
      end

      # --- Harmony: Rhodey arpeggio bar 2 ---
      with_fx :reverb, room: 0.35, mix: 0.3 do
        with_fx :lpf, cutoff: 112, mix: 1.0 do
          use_synth :rhodey
          8.times do
            play f_arp2.tick, cutoff: rrand(95, 118), release: 0.2, amp: 0.4
            sleep 0.5
          end
        end
      end

      # --- Bass: subpulse + tb303 driving F major ---
      with_fx :lpf, cutoff: 82, mix: 1.0 do
        use_synth :subpulse
        play f_sub_ring.tick, cutoff: 70, release: 1.5, amp: 0.6

        use_synth :tb303
        play f_bass_ring.tick, cutoff: 88, res: 0.65, wave: 1, release: 1.2, amp: 0.62
      end

      # --- Percussion: bar 1 driving four-on-the-floor ---
      sample :bd_fat, amp: 0.72
      sample :hat_zild, amp: 0.3
      sleep 0.5
      sample :hat_zild, amp: 0.18
      sleep 0.5
      sample :drum_snare_hard, amp: 0.6
      sample :hat_zild, amp: 0.25
      sleep 0.5
      sample :hat_zild, amp: 0.17
      sleep 0.5
      sample :bd_fat, amp: 0.65
      sample :hat_zild, amp: 0.27
      sleep 0.5
      sample :drum_cymbal_soft, amp: 0.32
      sleep 0.5
      sample :drum_snare_hard, amp: 0.56
      sample :hat_zild, amp: 0.22
      sleep 0.5
      sample :drum_tom_mid_hard, amp: 0.35 if one_in(2)
      sleep 0.5

      # --- Percussion: bar 2 cymbal-led orchestral climax ---
      sample :bd_fat, amp: 0.7
      sample :drum_cymbal_open, amp: 0.42
      sleep 0.5
      sample :hat_zild, amp: 0.2
      sleep 0.5
      sample :drum_snare_hard, amp: 0.58
      sample :drum_cymbal_soft, amp: 0.3
      sleep 0.5
      sample :hat_zild, amp: 0.18
      sleep 0.5
      sample :bd_fat, amp: 0.62
      sample :drum_tom_mid_hard, amp: 0.42
      sleep 0.5
      sample :drum_cymbal_soft, amp: 0.28
      sleep 0.5
      sample :drum_snare_hard, amp: 0.55
      sample :drum_cymbal_open, amp: 0.38
      sleep 0.5
      sample :hat_zild, amp: 0.17
      sleep 0.5

      # --- Percussion hpf accent ---
      with_fx :hpf, cutoff: 100, mix: 1.0 do
        sample :hat_snap, amp: 0.28
      end
    end

    # =====================
    # FINAL OUTRO: Fade to F Major drone
    # =====================
    use_synth :blade
    play :f4, release: 12, cutoff: 88, amp: 0.45
    use_synth :fm
    play :f3, release: 12, divisor: 4, depth: 8, cutoff: 80, amp: 0.38

    use_synth :hollow
    play_chord chord(:f3, :major), cutoff: 88, release: 12, amp: 0.42
    use_synth :supersaw
    play :f3, cutoff: 80, release: 12, amp: 0.28

    use_synth :bass_foundation
    play :f2, cutoff: 65, release: 12, amp: 0.68
    use_synth :subpulse
    play :f1, cutoff: 60, release: 12, amp: 0.52

    sample :drum_cymbal_open, amp: 0.45
    sleep 2
    sample :drum_cymbal_soft, amp: 0.32
    sleep 2
    sample :drum_cymbal_soft, amp: 0.25
    sleep 2
    sample :drum_cymbal_soft, amp: 0.18
    sleep 2

  end
end