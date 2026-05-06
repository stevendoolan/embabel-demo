# Feed the Birds EDM Remix
# Style: EDM / uplifting progressive house | Mood: euphoric, bright, soaring

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================================
    # SECTION 1: Intro Build — Key of D major (2x8 bars)
    # Melody: chiplead | Harmony: blade + rhodey | Bass: bass_foundation + tb303 | Perc: light beat
    # =============================================================
    2.times do

      # --- Melody: Supersaw + chiplead drone and theme ---
      use_synth :supersaw
      play :d3, release: 8, cutoff: 90, amp: 0.35

      # --- Harmony: Blade sustained pad ---
      with_fx :reverb, room: 0.3, mix: 0.32 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          use_synth :blade
          play_chord chord(:d3, :major7), cutoff: 85, release: 16, amp: 0.45
        end
      end

      # --- Bass: Foundation root + tb303 pattern ---
      use_synth :bass_foundation
      play :d1, cutoff: 65, release: 8, amp: 0.7

      in_thread do
        with_fx :lpf, cutoff: 82, mix: 1.0 do
          use_synth :tb303
          4.times do
            play :d2, cutoff: 72, release: 0.4, amp: 0.72
            sleep 1
            play :d2, cutoff: 68, release: 0.3, amp: 0.58
            sleep 0.5
            play :a2, cutoff: 70, release: 0.3, amp: 0.55
            sleep 0.5
          end
          play :d2, cutoff: 75, release: 0.4, amp: 0.72
          sleep 1
          play :fs2, cutoff: 70, release: 0.3, amp: 0.58
          sleep 0.5
          play :a2, cutoff: 68, release: 0.3, amp: 0.55
          sleep 0.5
          play :d2, cutoff: 75, release: 0.4, amp: 0.72
          sleep 1
          play :e2, cutoff: 70, release: 0.25, amp: 0.55
          sleep 0.5
          play :fs2, cutoff: 72, release: 0.25, amp: 0.52
          sleep 0.5
        end
      end

      # --- Harmony: Rhodey chord stabs ---
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.28 do
          with_fx :lpf, cutoff: 100, mix: 1.0 do
            use_synth :rhodey
            2.times do
              sleep 0.5
              play_chord chord(:d3, :major7), cutoff: 90, release: 0.4, amp: 0.5
              sleep 1.5
              play_chord chord(:d3, :major7), cutoff: 88, release: 0.4, amp: 0.42
              sleep 2.0
            end
            2.times do
              sleep 0.5
              play_chord chord(:g3, :major7), cutoff: 92, release: 0.4, amp: 0.5
              sleep 1.5
              play_chord chord(:g3, :major7), cutoff: 90, release: 0.4, amp: 0.42
              sleep 2.0
            end
            2.times do
              sleep 0.5
              play_chord chord(:a3, :sus4), cutoff: 94, release: 0.4, amp: 0.5
              sleep 1.5
              play_chord chord(:a3, :sus4), cutoff: 92, release: 0.4, amp: 0.42
              sleep 2.0
            end
            2.times do
              sleep 0.5
              play_chord chord(:d3, :major7), cutoff: 96, release: 0.4, amp: 0.52
              sleep 1.5
              play_chord chord(:d3, :major7), cutoff: 94, release: 0.4, amp: 0.45
              sleep 2.0
            end
          end
        end
      end

      # --- Percussion: Light intro beat ---
      in_thread do
        with_fx :hpf, cutoff: 90, mix: 1.0 do
          4.times do |i|
            sample :bd_haus, amp: i == 0 ? 0.75 : 0.62
            sample :drum_cymbal_closed, amp: 0.32, rate: 1.2, finish: 0.3
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.22, rate: 1.2, finish: 0.3
            sleep 0.25
            sample :drum_snare_hard, amp: 0.52
            sample :drum_cymbal_closed, amp: 0.32, rate: 1.2, finish: 0.3
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.22, rate: 1.2, finish: 0.3
            sleep 0.25
            sample :bd_haus, amp: 0.58
            sample :drum_cymbal_closed, amp: 0.32, rate: 1.2, finish: 0.3
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.22, rate: 1.2, finish: 0.3
            sleep 0.25
            sample :drum_snare_hard, amp: 0.52
            sample :drum_cymbal_closed, amp: 0.32, rate: 1.2, finish: 0.3
            sleep 0.25
            sample :drum_cymbal_open, amp: 0.35, rate: 1.4, finish: 0.4
            sleep 0.25
          end
        end
      end

      # --- Melody: Chiplead Feed the Birds theme in D ---
      with_fx :reverb, room: 0.25, mix: 0.28 do
        use_synth :chiplead
        play :d3, release: 8, cutoff: 85, amp: 0.28

        [[:d4, 1.0], [:d4, 0.5], [:cs4, 1.5], [:b3, 0.5], [:d4, 1.0], [:b3, 0.5], [:a3, 1.0]].each do |note, dur|
          play note, cutoff: rrand(88, 108), release: [dur * 0.85, 0.1].max, amp: 0.92
          sleep dur
        end
        [[:fs4, 1.0], [:fs4, 0.5], [:e4, 1.5], [:d4, 0.5], [:fs4, 1.0], [:e4, 0.5], [:d4, 1.0]].each do |note, dur|
          play note, cutoff: rrand(90, 112), release: [dur * 0.85, 0.1].max, amp: 0.92
          sleep dur
        end
        [[:a4, 1.0], [:a4, 0.5], [:g4, 1.5], [:fs4, 0.5], [:a4, 1.0], [:g4, 0.5], [:fs4, 1.0]].each do |note, dur|
          play note, cutoff: rrand(92, 115), release: [dur * 0.85, 0.1].max, amp: 0.92
          sleep dur
        end
        [[:d5, 2.0], [:b4, 1.0], [:a4, 1.0], [:g4, 1.0], [:e4, 0.5], [:d4, 0.5]].each do |note, dur|
          play note, cutoff: rrand(90, 118), release: [dur * 0.85, 0.1].max, amp: 0.92
          sleep dur
        end
      end

    end

    # =============================================================
    # TRANSITION 1: D -> F drone bridge (4 beats)
    # =============================================================
    use_synth :fm
    play :d2, release: 8, cutoff: 90, amp: 0.5
    use_synth :supersaw
    play :f3, release: 8, cutoff: 95, amp: 0.4
    use_synth :blade
    play_chord chord(:f3, :major7), cutoff: 88, release: 8, amp: 0.42

    with_fx :hpf, cutoff: 100, mix: 1.0 do
      4.times do
        sample :bd_haus, amp: 0.68
        sample :drum_cymbal_closed, amp: 0.28, rate: 1.2, finish: 0.3
        sleep 0.5
        sample :hat_zild, amp: 0.25, finish: 0.25
        sleep 0.5
      end
    end

    # =============================================================
    # SECTION 2: Drop — Key of F major (2x8 bars)
    # Melody: winwood_lead | Harmony: tech_saws + blade + rhodey | Bass: subpulse + tb303 | Perc: full EDM
    # =============================================================
    2.times do

      # --- Melody: Supersaw + winwood_lead drone ---
      use_synth :supersaw
      play :f2, release: 8, cutoff: 88, amp: 0.3

      # --- Harmony: Wide tech_saws + blade pads ---
      with_fx :lpf, cutoff: 108, mix: 1.0 do
        use_synth :tech_saws
        play_chord chord(:f2, :major7), cutoff: 88, release: 16, amp: 0.36
        use_synth :blade
        play_chord chord(:bb3, :major7), cutoff: 90, release: 16, amp: 0.30
      end

      # --- Bass: Subpulse drone + tb303 groove ---
      use_synth :subpulse
      play :f1, cutoff: 68, release: 8, amp: 0.72

      in_thread do
        with_fx :lpf, cutoff: 85, mix: 1.0 do
          use_synth :tb303
          4.times do
            play :f2, cutoff: 75, release: 0.45, amp: 0.70
            sleep 1
            play :f2, cutoff: 70, release: 0.3, amp: 0.55
            sleep 0.5
            play :c3, cutoff: 72, release: 0.3, amp: 0.52
            sleep 0.5
          end
          play :f2, cutoff: 78, release: 0.45, amp: 0.70
          sleep 1
          play :a2, cutoff: 72, release: 0.3, amp: 0.55
          sleep 0.5
          play :c3, cutoff: 70, release: 0.3, amp: 0.52
          sleep 0.5
          play :f2, cutoff: 78, release: 0.45, amp: 0.70
          sleep 1
          play :g2, cutoff: 72, release: 0.25, amp: 0.52
          sleep 0.5
          play :a2, cutoff: 74, release: 0.25, amp: 0.50
          sleep 0.5
        end
      end

      # --- Harmony: Rhodey EDM stabs ---
      in_thread do
        with_fx :lpf, cutoff: 108, mix: 1.0 do
          use_synth :rhodey
          2.times do
            sleep 0.5
            play_chord chord(:f3, :major7), cutoff: 95, release: 0.35, amp: 0.52
            sleep 1.5
            play_chord chord(:f3, :major7), cutoff: 92, release: 0.35, amp: 0.45
            sleep 2.0
          end
          2.times do
            sleep 0.5
            play_chord chord(:bb3, :major7), cutoff: 96, release: 0.35, amp: 0.52
            sleep 1.5
            play_chord chord(:bb3, :major7), cutoff: 93, release: 0.35, amp: 0.45
            sleep 2.0
          end
          2.times do
            sleep 0.5
            play_chord chord(:c4, :sus4), cutoff: 98, release: 0.35, amp: 0.55
            sleep 1.5
            play_chord chord(:c4, :sus4), cutoff: 95, release: 0.35, amp: 0.48
            sleep 2.0
          end
          2.times do
            sleep 0.5
            play_chord chord(:f3, :major7), cutoff: 100, release: 0.35, amp: 0.55
            sleep 1.5
            play_chord chord(:f3, :major7), cutoff: 97, release: 0.35, amp: 0.48
            sleep 2.0
          end
        end
      end

      # --- Percussion: Full EDM beat ---
      in_thread do
        with_fx :reverb, room: 0.22, mix: 0.22 do
          4.times do |i|
            sample :bd_haus, amp: i == 0 ? 0.82 : 0.68
            sample :drum_cymbal_closed, amp: 0.35, rate: 1.3, finish: 0.3
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.25, rate: 1.3, finish: 0.3
            sample :hat_cats, amp: 0.2 if one_in(3)
            sleep 0.25
            sample :drum_snare_hard, amp: 0.65
            sample :elec_snare, amp: 0.42, rate: 0.95
            sample :drum_cymbal_closed, amp: 0.35, rate: 1.3, finish: 0.3
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.25, rate: 1.3, finish: 0.3
            sleep 0.25
            sample :bd_haus, amp: 0.67
            sample :drum_cymbal_closed, amp: 0.35, rate: 1.3, finish: 0.3
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.25, rate: 1.3, finish: 0.3
            sample :hat_cats, amp: 0.18 if one_in(4)
            sleep 0.25
            sample :drum_snare_hard, amp: 0.65
            sample :elec_snare, amp: 0.42, rate: 0.95
            sample :drum_cymbal_closed, amp: 0.35, rate: 1.3, finish: 0.3
            sleep 0.25
            sample :drum_cymbal_open, amp: 0.38, rate: 1.3, finish: 0.45
            sample :hat_zild, amp: 0.27, finish: 0.3
            sleep 0.25
          end
        end
      end

      # --- Melody: Winwood_lead theme in F ---
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          use_synth :winwood_lead
          play :f2, release: 8, cutoff: 88, amp: 0.28

          [[:f4, 1.0], [:f4, 0.5], [:e4, 1.5], [:eb4, 0.5], [:f4, 1.0], [:eb4, 0.5], [:c4, 1.0]].each do |note, dur|
            play note, cutoff: rrand(90, 115), release: [dur * 0.85, 0.1].max, amp: 0.95
            sleep dur
          end
          [[:a4, 1.0], [:a4, 0.5], [:g4, 1.5], [:f4, 0.5], [:a4, 1.0], [:g4, 0.5], [:f4, 1.0]].each do |note, dur|
            play note, cutoff: rrand(92, 118), release: [dur * 0.85, 0.1].max, amp: 0.95
            sleep dur
          end
          [[:c5, 1.0], [:c5, 0.5], [:bb4, 1.5], [:a4, 0.5], [:c5, 1.0], [:bb4, 0.5], [:a4, 1.0]].each do |note, dur|
            play note, cutoff: rrand(95, 118), release: [dur * 0.85, 0.1].max, amp: 0.95
            sleep dur
          end
          [[:f5, 2.0], [:d5, 1.0], [:c5, 1.0], [:bb4, 1.0], [:g4, 0.5], [:f4, 0.5]].each do |note, dur|
            play note, cutoff: rrand(92, 120), release: [dur * 0.85, 0.1].max, amp: 0.95
            sleep dur
          end
        end
      end

    end

    # =============================================================
    # TRANSITION 2: F swell into finale (4 beats)
    # =============================================================
    use_synth :supersaw
    play :f2, cutoff: 95, release: 8, amp: 0.48
    use_synth :blade
    play_chord chord(:f3, :sus4), cutoff: 92, release: 8, amp: 0.45
    use_synth :tech_saws
    play_chord chord(:f2, :major7), cutoff: 95, release: 8, amp: 0.32

    use_synth :subpulse
    play :f1, cutoff: 72, release: 8, amp: 0.62

    with_fx :hpf, cutoff: 100, mix: 1.0 do
      4.times do
        sample :bd_haus, amp: 0.72
        sample :drum_cymbal_closed, amp: 0.30, rate: 1.3, finish: 0.3
        sleep 0.5
        sample :hat_zild, amp: 0.28, finish: 0.25
        sleep 0.5
      end
    end

    # =============================================================
    # SECTION 3: Euphoric Finale — Key of F (2x8 bars)
    # Melody: supersaw soaring | Harmony: tech_saws + blade + rhodey (richest) | Bass: bass_foundation + tb303 | Perc: maximum energy
    # =============================================================
    2.times do

      # --- Melody: Supersaw drone ---
      use_synth :supersaw
      play :f2, release: 8, cutoff: 100, amp: 0.33
      use_synth :supersaw
      play :f3, release: 8, cutoff: 95, amp: 0.28

      # --- Harmony: tech_saws + blade rich pads ---
      with_fx :reverb, room: 0.32, mix: 0.35 do
        use_synth :tech_saws
        play_chord chord(:f2, :major7), cutoff: 95, release: 16, amp: 0.40
        use_synth :blade
        play_chord chord(:f3, :major7), cutoff: 90, release: 16, amp: 0.33
      end

      # --- Bass: Foundation + tb303 ascending fill ---
      use_synth :bass_foundation
      play :f1, cutoff: 70, release: 8, amp: 0.75

      in_thread do
        use_synth :tb303
        4.times do
          play :f2, cutoff: 80, release: 0.45, amp: 0.72
          sleep 1
          play :f2, cutoff: 75, release: 0.3, amp: 0.57
          sleep 0.5
          play :c3, cutoff: 77, release: 0.3, amp: 0.55
          sleep 0.5
        end
        play :f2, cutoff: 82, release: 0.45, amp: 0.72
        sleep 1
        play :a2, cutoff: 78, release: 0.3, amp: 0.58
        sleep 0.5
        play :c3, cutoff: 80, release: 0.3, amp: 0.57
        sleep 0.5
        play :f2, cutoff: 82, release: 0.45, amp: 0.72
        sleep 1
        play :bb2, cutoff: 76, release: 0.25, amp: 0.55
        sleep 0.5
        play :c3, cutoff: 78, release: 0.25, amp: 0.52
        sleep 0.5
      end

      # --- Harmony: Rhodey richest stabs ---
      in_thread do
        with_fx :reverb, room: 0.32, mix: 0.3 do
          use_synth :rhodey
          2.times do
            sleep 0.5
            play_chord chord(:f3, :major7), cutoff: 100, release: 0.4, amp: 0.58
            sleep 1.5
            play_chord chord(:f3, :major7), cutoff: 98, release: 0.4, amp: 0.52
            sleep 2.0
          end
          2.times do
            sleep 0.5
            play_chord chord(:d3, :minor7), cutoff: 102, release: 0.4, amp: 0.58
            sleep 1.5
            play_chord chord(:d3, :minor7), cutoff: 100, release: 0.4, amp: 0.52
            sleep 2.0
          end
          2.times do
            sleep 0.5
            play_chord chord(:bb3, :major7), cutoff: 105, release: 0.4, amp: 0.60
            sleep 1.5
            play_chord chord(:bb3, :major7), cutoff: 102, release: 0.4, amp: 0.55
            sleep 2.0
          end
          sleep 0.5
          play_chord chord(:c4, :sus4), cutoff: 108, release: 0.4, amp: 0.62
          sleep 1.5
          play_chord chord(:c4, :sus4), cutoff: 105, release: 0.4, amp: 0.57
          sleep 2.0
          sleep 0.5
          play_chord chord(:f3, :major7), cutoff: 110, release: 0.5, amp: 0.65
          sleep 1.5
          play_chord chord(:f3, :major7), cutoff: 108, release: 0.5, amp: 0.60
          sleep 2.0
        end
      end

      # --- Percussion: Maximum energy finale beat ---
      in_thread do
        4.times do |i|
          sample :bd_haus, amp: i == 0 ? 0.85 : 0.72
          sample :drum_cymbal_closed, amp: 0.38, rate: 1.4, finish: 0.3
          sample :hat_cats, amp: 0.25 if i == 0
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.27, rate: 1.4, finish: 0.3
          sample :hat_cats, amp: 0.20
          sleep 0.25
          sample :drum_snare_hard, amp: 0.72
          sample :elec_snare, amp: 0.47, rate: 0.95
          sample :hat_zild, amp: 0.32, finish: 0.4
          sample :drum_cymbal_closed, amp: 0.38, rate: 1.4, finish: 0.3
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.27, rate: 1.4, finish: 0.3
          sample :hat_cats, amp: 0.20
          sleep 0.25
          sample :bd_haus, amp: 0.68
          sample :drum_cymbal_closed, amp: 0.38, rate: 1.4, finish: 0.3
          sample :drum_cymbal_open, amp: 0.27, rate: 1.5, finish: 0.2 if i == 3
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.27, rate: 1.4, finish: 0.3
          sample :hat_cats, amp: 0.20
          sleep 0.25
          sample :drum_snare_hard, amp: 0.72
          sample :elec_snare, amp: 0.47, rate: 0.95
          sample :hat_zild, amp: 0.32, finish: 0.4
          sample :drum_cymbal_closed, amp: 0.38, rate: 1.4, finish: 0.3
          sleep 0.25
          sample :drum_cymbal_open, amp: 0.42, rate: 1.3, finish: 0.5
          sample :hat_cats, amp: 0.22
          sleep 0.25
        end
      end

      # --- Melody: Supersaw soaring finale phrases ---
      with_fx :reverb, room: 0.28, mix: 0.3 do
        use_synth :supersaw

        [[:f4, 1.0], [:f4, 0.5], [:e4, 1.5], [:eb4, 0.5], [:f4, 1.0], [:eb4, 0.5], [:c4, 1.0]].each do |note, dur|
          play note, cutoff: (line 90, 120, steps: 7).tick, release: [dur * 0.85, 0.1].max, amp: 0.93
          sleep dur
        end
        [[:a4, 1.0], [:a4, 0.5], [:g4, 1.5], [:f4, 0.5], [:a4, 1.0], [:g4, 0.5], [:f4, 1.0]].each do |note, dur|
          play note, cutoff: (line 95, 118, steps: 7).tick, release: [dur * 0.85, 0.1].max, amp: 0.93
          sleep dur
        end
        [[:c5, 1.0], [:c5, 0.5], [:bb4, 1.5], [:a4, 0.5], [:c5, 1.0], [:bb4, 0.5], [:a4, 1.0]].each do |note, dur|
          play note, cutoff: (line 100, 120, steps: 7).tick, release: [dur * 0.85, 0.1].max, amp: 0.93
          sleep dur
        end
        [[:f5, 2.0], [:d5, 1.0], [:c5, 1.0], [:bb4, 1.0], [:g4, 0.5], [:f4, 0.5]].each do |note, dur|
          play note, cutoff: (line 105, 120, steps: 6).tick, release: [dur * 0.85, 0.1].max, amp: 0.93
          sleep dur
        end
      end

    end

  end
end