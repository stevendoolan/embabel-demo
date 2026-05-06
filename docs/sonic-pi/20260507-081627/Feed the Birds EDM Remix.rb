# Feed the Birds EDM Remix
# Style: Uplifting House / EDM | Mood: Euphoric and Anthemic
# Key: F major -> G major | BPM: 128 | Time: 4/4

use_debug false
use_bpm 128

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================
    # SECTION 1: Intro — F major supersaw melody + blade pads + sub bass + minimal percussion
    # 2 passes of 16-beat melody loops
    # =============================================
    melody_f = (ring :f4, :a4, :c5, :a4, :g4, :f4, :e4, :f4,
                     :a4, :c5, :f5, :e5, :d5, :c5, :a4, :g4,
                     :f4, :a4, :c5, :a4, :bb4, :a4, :g4, :f4,
                     :e4, :f4, :g4, :a4, :c5, :c5, :c5, :c5)

    f_chords = (ring
      chord(:f3, :major),
      chord(:d3, :minor),
      chord(:bb3, :major),
      chord(:c3, :major))

    2.times do
      # --- Melody drone ---
      use_synth :supersaw
      play :f2, release: 8, cutoff: 80, amp: 0.9

      # --- Harmony: long hollow drone ---
      use_synth :hollow
      play_chord chord(:f2, :major), cutoff: 88, release: 16, amp: 0.8

      # --- Bass: sustained sub root ---
      use_synth :bass_foundation
      play :f1, cutoff: 65, release: 7.8, amp: 1.1
      use_synth :subpulse
      play :f2, cutoff: 72, release: 3.8, amp: 0.85

      # --- Melody: supersaw lead ---
      with_fx :reverb, room: 0.25, mix: 0.28 do
        use_synth :supersaw
        16.times do
          play melody_f.tick, cutoff: (line 85, 115, steps: 16).tick, release: 0.18, amp: 1.8
          sleep 0.5
        end
      end

      # --- Harmony: blade pad chord changes ---
      with_fx :reverb, room: 0.3, mix: 0.32 do
        use_synth :blade
        play_chord f_chords.tick, cutoff: (line 82, 102, steps: 4).tick, release: 3.8, amp: 0.75
        sleep 4

        play_chord f_chords.tick, cutoff: (line 82, 102, steps: 4).tick, release: 3.8, amp: 0.75
      end

      # --- Bass: bass on fifth ---
      use_synth :bass_foundation
      play :c2, cutoff: 68, release: 3.8, amp: 0.95
      use_synth :subpulse
      play :c3, cutoff: 70, release: 1.8, amp: 0.78

      # --- Percussion: minimal intro ---
      with_fx :hpf, cutoff: 90, mix: 1.0 do
        4.times do |i|
          sample :bd_fat, amp: (i % 4 == 0) ? 1.4 : 1.1
          sample :hat_zild, amp: 0.5
          sleep 0.5
          sample :hat_cats, amp: 0.4
          sleep 0.5
          sample :drum_snare_hard, amp: 0.9
          sample :hat_zild, amp: 0.45
          sleep 0.5
          sample :hat_cats, amp: 0.35
          sleep 0.5
          sample :bd_fat, amp: 1.2
          sample :hat_zild, amp: 0.48
          sleep 0.5
          sample :hat_cats, amp: 0.32
          sleep 0.5
          sample :drum_snare_hard, amp: 0.85
          sample :hat_zild, amp: 0.5
          sleep 0.5
          sample :hat_cats, amp: 0.3
          sample :drum_cymbal_hard, amp: 0.65 if i == 3
          sleep 0.5
        end
      end
    end

    # =============================================
    # SECTION 1b: Intro Build — F major percussion + chiplead + rhodey pads + TB303 bass
    # 2 passes with fuller groove
    # =============================================
    acid_f = (ring :f2, :f2, :c3, :f2, :a2, :g2, :f2, :c2,
                   :f2, :f2, :bb2, :a2, :g2, :f2, :e2, :f2)

    2.times do
      # --- Melody drone ---
      use_synth :supersaw
      play :f2, release: 8, cutoff: 82, amp: 0.8

      # --- Harmony: hollow drone + rhodey chords ---
      use_synth :hollow
      play_chord chord(:f2, :major), cutoff: 85, release: 16, amp: 0.75

      # --- Bass: sustained sub root + TB303 ---
      use_synth :bass_foundation
      play :f1, cutoff: 62, release: 7.8, amp: 1.15

      # --- Melody: chiplead with percussion interleaved ---
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :reverb, room: 0.22, mix: 0.22 do
          use_synth :chiplead
          8.times do |i|
            # Kick on beat 1
            with_fx :hpf, cutoff: 60, mix: 1.0 do
              sample :bd_fat, amp: (i % 4 == 0) ? 1.5 : 1.1
            end
            play melody_f.tick, cutoff: rrand(88, 112), release: 0.15, amp: 1.9
            sleep 0.5

            sample :hat_cab, amp: 0.5
            play melody_f.tick, cutoff: rrand(85, 108), release: 0.15, amp: 1.7
            sleep 0.5

            sample :drum_snare_soft, amp: (i % 4 == 1) ? 0.9 : 0.55
            play melody_f.tick, cutoff: rrand(90, 115), release: 0.15, amp: 1.8
            sleep 0.5

            sample :hat_cab, amp: 0.45
            play melody_f.tick, cutoff: rrand(85, 110), release: 0.15, amp: 1.7
            sleep 0.5
          end
        end
      end

      # --- Harmony: rhodey chord hits ---
      use_synth :rhodey
      play_chord f_chords.tick, cutoff: (line 85, 108, steps: 4).tick, release: 3.6, amp: 0.85
      sleep 4
      use_synth :rhodey
      play_chord f_chords.tick, cutoff: (line 85, 108, steps: 4).tick, release: 3.6, amp: 0.85
      sleep 4

      # --- Bass: TB303 rolling acid ---
      with_fx :lpf, cutoff: 85, mix: 1.0 do
        16.times do
          use_synth :tb303
          play acid_f.tick,
               cutoff: (line 65, 88, steps: 16).look,
               res: 0.82,
               wave: 0,
               release: 0.28,
               amp: 0.9
          sleep 0.5
        end
      end

      # --- Percussion: full build groove ---
      8.times do |i|
        sample :bd_fat, amp: (i % 4 == 0) ? 1.5 : 1.2
        sample :hat_zild, amp: 0.55
        sleep 0.5
        sample :hat_cats, amp: 0.5
        sample :elec_blip, amp: 0.5 if one_in(3)
        sleep 0.5
        sample :drum_snare_hard, amp: 1.1
        sample :bd_fat, amp: 0.95
        sample :hat_zild, amp: 0.5
        sleep 0.5
        sample :hat_cats, amp: 0.42
        sleep 0.5
        sample :bd_fat, amp: 1.3
        sample :hat_zild, amp: 0.52
        sleep 0.5
        sample :hat_cats, amp: 0.38
        sleep 0.5
        sample :drum_snare_hard, amp: 1.05
        sample :hat_zild, amp: 0.52
        sleep 0.5
        sample :hat_cats, amp: 0.38
        sample :drum_cymbal_hard, amp: 0.75 if i == 7
        sleep 0.5
      end
    end

    # =============================================
    # TRANSITION: F -> G key change drone bridge
    # =============================================
    use_synth :supersaw
    play :f2, cutoff: 90, release: 8, amp: 1.0
    use_synth :supersaw
    play :c3, cutoff: 85, release: 8, amp: 0.65
    use_synth :hollow
    play_chord chord(:c3, :major), cutoff: 90, release: 8, amp: 0.85
    use_synth :bass_foundation
    play :f1, cutoff: 68, release: 4.5, amp: 1.0
    use_synth :subpulse
    play :g2, cutoff: 72, release: 4.5, amp: 0.78
    sample :drum_cymbal_hard, amp: 0.85
    sample :bd_fat, amp: 1.3
    sleep 1
    sample :hat_zild, amp: 0.5
    sleep 1
    sample :hat_cats, amp: 0.4
    sleep 1
    sample :hat_zild, amp: 0.45
    sleep 1

    # =============================================
    # SECTION 2: Drop — G major winwood_lead melody + hollow pads + TB303 bass + full drum groove
    # 2 passes of 16-beat melody loops
    # =============================================
    melody_g = (ring :g4, :b4, :d5, :b4, :a4, :g4, :fs4, :g4,
                     :b4, :d5, :g5, :fs5, :e5, :d5, :b4, :a4,
                     :g4, :b4, :d5, :b4, :c5, :b4, :a4, :g4,
                     :fs4, :g4, :a4, :b4, :d5, :d5, :d5, :d5)

    g_chords = (ring
      chord(:g3, :major),
      chord(:e3, :minor),
      chord(:c3, :major),
      chord(:d3, :major))

    acid_g = (ring :g2, :g2, :d3, :g2, :b2, :a2, :g2, :d2,
                   :g2, :g2, :c3, :b2, :a2, :g2, :fs2, :g2)

    2.times do
      # --- Melody: long pad drone ---
      use_synth :supersaw
      play :g2, release: 8, cutoff: 84, amp: 0.95
      use_synth :supersaw
      play :d3, release: 8, cutoff: 78, amp: 0.5

      # --- Harmony: blade drone + hollow chord changes ---
      use_synth :blade
      play_chord chord(:g2, :major), cutoff: 90, release: 16, amp: 0.75

      # --- Bass: deep sub root + subpulse fifth ---
      use_synth :bass_foundation
      play :g1, cutoff: 64, release: 7.8, amp: 1.1
      use_synth :subpulse
      play :d2, cutoff: 70, release: 3.8, amp: 0.78

      # --- Melody: winwood_lead with echo ---
      with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.18 do
        use_synth :winwood_lead
        16.times do
          play melody_g.tick, cutoff: (line 90, 118, steps: 16).tick, release: 0.2, amp: 1.85
          sleep 0.5
        end
      end

      # --- Harmony: hollow chord changes ---
      with_fx :reverb, room: 0.3, mix: 0.32 do
        use_synth :hollow
        play_chord g_chords.tick, cutoff: (line 86, 108, steps: 4).tick, release: 3.8, amp: 0.78
        sleep 4
        play_chord g_chords.tick, cutoff: (line 86, 108, steps: 4).tick, release: 3.8, amp: 0.78
      end

      # --- Bass: TB303 acid weave in G ---
      16.times do
        use_synth :tb303
        play acid_g.tick,
             cutoff: (line 68, 90, steps: 16).look,
             res: 0.85,
             wave: 0,
             release: 0.25,
             amp: 0.88
        sleep 0.5
      end

      # --- Percussion: fuller drop groove ---
      with_fx :reverb, room: 0.25, mix: 0.22 do
        8.times do |i|
          sample :bd_fat, amp: (i % 4 == 0) ? 1.6 : 1.2
          sample :hat_zild, amp: 0.6
          sleep 0.5
          sample :hat_cats, amp: 0.52
          sample :elec_blip, amp: 0.5 if one_in(4)
          sleep 0.5
          sample :drum_snare_hard, amp: 1.2
          sample :bd_fat, amp: 1.0
          sample :hat_zild, amp: 0.52
          sleep 0.5
          sample :hat_cats, amp: 0.45
          sleep 0.5
          sample :bd_fat, amp: 1.35
          sample :hat_zild, amp: 0.55
          sleep 0.5
          sample :hat_cats, amp: 0.42
          sleep 0.5
          sample :drum_snare_hard, amp: 1.15
          sample :hat_zild, amp: 0.55
          sleep 0.5
          sample :hat_cats, amp: 0.42
          sample :drum_cymbal_hard, amp: 0.8 if i == 7
          sleep 0.5
        end
      end
    end

    # =============================================
    # TRANSITION: Into full drop — G major bridge
    # =============================================
    use_synth :supersaw
    play :g2, cutoff: 88, release: 8, amp: 1.0
    use_synth :blade
    play_chord chord(:g2, :major), cutoff: 92, release: 8, amp: 0.8
    use_synth :bass_foundation
    play :g1, cutoff: 70, release: 4.5, amp: 1.05
    use_synth :subpulse
    play :g2, cutoff: 75, release: 4.5, amp: 0.82
    sample :drum_cymbal_hard, amp: 0.95
    sample :bd_fat, amp: 1.4
    sleep 1
    sample :hat_zild, amp: 0.58
    sleep 1
    sample :hat_cats, amp: 0.48
    sleep 1
    sample :hat_zild, amp: 0.48
    sleep 1

    # =============================================
    # SECTION 3: Full Drop — G major chiplead + rhodey + dense TB303 bass + maximum percussion
    # 4 passes
    # =============================================
    melody_g2 = (ring :g4, :b4, :d5, :g5, :fs5, :e5, :d5, :b4,
                      :c5, :b4, :a4, :g4, :a4, :b4, :d5, :d5)

    g_full_chords = (ring
      chord(:g3, :major),
      chord(:c3, :major),
      chord(:d3, :major),
      chord(:e3, :minor))

    acid_g2 = (ring :g2, :g2, :d3, :b2, :c3, :b2, :a2, :g2,
                    :g2, :d2, :g2, :fs2, :g2, :a2, :d3, :d2)

    4.times do |section_i|
      # --- Melody: supersaw drone ---
      use_synth :supersaw
      play :g2, release: 8, cutoff: 82, amp: 0.82

      # --- Harmony: hollow long drone ---
      use_synth :hollow
      play_chord chord(:g2, :major), cutoff: 88, release: 8, amp: 0.72

      # --- Bass: sub punch + subpulse accent ---
      use_synth :bass_foundation
      play :g1, cutoff: 66, release: 6.8, amp: 1.1
      use_synth :subpulse
      play :g2, cutoff: 75, release: 1.8, amp: 0.9

      # --- Melody: chiplead and winwood_lead alternating ---
      with_fx :lpf, cutoff: 112, mix: 1.0 do
        8.times do |i|
          with_fx :hpf, cutoff: 58, mix: 1.0 do
            sample :bd_fat, amp: (i % 4 == 0 && section_i == 0) ? 1.7 : (i % 4 == 0 ? 1.55 : 1.2)
          end
          use_synth :chiplead
          play melody_g2.tick, cutoff: rrand(90, 118), release: 0.13, amp: 1.9
          sleep 0.5

          sample :hat_zild, amp: 0.62
          use_synth :winwood_lead
          play melody_g2.tick, cutoff: rrand(88, 112), release: 0.18, amp: 1.75
          sleep 0.5

          sample :drum_snare_hard, amp: (section_i >= 2 ? 1.45 : 1.25)
          use_synth :chiplead
          play melody_g2.tick, cutoff: rrand(92, 116), release: 0.13, amp: 1.85
          sleep 0.5

          sample :hat_zild, amp: 0.58
          use_synth :winwood_lead
          play melody_g2.tick, cutoff: rrand(86, 110), release: 0.18, amp: 1.7
          sleep 0.5
        end
      end

      # --- Harmony: rhodey chord hits ---
      use_synth :rhodey
      play_chord g_full_chords.tick, cutoff: (line 88, 118, steps: 8).look, release: 3.6, amp: 0.88
      sleep 4
      use_synth :rhodey
      play_chord g_full_chords.tick, cutoff: (line 88, 118, steps: 8).look, release: 3.6, amp: 0.82
      sleep 4

      # --- Bass: driving TB303 acid groove ---
      16.times do
        use_synth :tb303
        play acid_g2.tick,
             cutoff: rrand(72, 90),
             res: 0.86,
             wave: 0,
             release: 0.22,
             amp: 0.9
        sleep 0.5
      end

      # --- Percussion: maximum energy ---
      8.times do |i|
        sample :bd_fat, amp: (i % 4 == 0 && section_i == 0) ? 1.75 : (i % 4 == 0 ? 1.55 : 1.25)
        sample :hat_zild, amp: 0.65
        sleep 0.5
        sample :hat_cats, amp: 0.55
        sample :elec_blip, amp: 0.6 if one_in(3)
        sleep 0.5
        sample :drum_snare_hard, amp: 1.35
        sample :bd_fat, amp: 1.05
        sample :hat_zild, amp: 0.58
        sleep 0.5
        sample :hat_cats, amp: 0.5
        sleep 0.5
        sample :bd_fat, amp: 1.45
        sample :hat_zild, amp: 0.62
        sleep 0.5
        sample :hat_cats, amp: 0.48
        sample :elec_blip, amp: 0.55 if one_in(4)
        sleep 0.5
        sample :drum_snare_hard, amp: (section_i >= 2 ? 1.45 : 1.25)
        sample :hat_zild, amp: 0.62
        sleep 0.5
        sample :hat_cats, amp: 0.48
        sample :drum_cymbal_hard, amp: (i == 7 ? (section_i == 3 ? 1.1 : 0.85) : 0.0) if i == 7
        sleep 0.5
      end
    end

    # =============================================
    # OUTRO: Long fade-out drone in G
    # =============================================
    use_synth :supersaw
    play :g2, cutoff: 88, release: 12, amp: 0.85
    use_synth :supersaw
    play :d3, cutoff: 80, release: 10, amp: 0.45
    use_synth :winwood_lead
    play :g4, cutoff: 95, release: 8, amp: 1.5
    use_synth :hollow
    play_chord chord(:g2, :major), cutoff: 88, release: 12, amp: 0.8
    use_synth :blade
    play_chord chord(:g3, :major), cutoff: 82, release: 10, amp: 0.7
    use_synth :rhodey
    play_chord chord(:g3, :major7), cutoff: 90, release: 8, amp: 0.65
    use_synth :bass_foundation
    play :g1, cutoff: 62, release: 9.5, amp: 1.0
    use_synth :subpulse
    play :g2, cutoff: 68, release: 7.5, amp: 0.75
    use_synth :tb303
    play :g2, cutoff: 70, res: 0.8, wave: 0, release: 6.0, amp: 0.82
    sample :drum_cymbal_hard, amp: 1.0
    sample :bd_fat, amp: 1.3
    sleep 1
    sample :hat_zild, amp: 0.52
    sleep 1
    sample :drum_snare_hard, amp: 0.95
    sleep 1
    sample :hat_cats, amp: 0.38
    sleep 1
    sample :bd_fat, amp: 1.0
    sleep 1
    sample :hat_zild, amp: 0.38
    sleep 1
    sample :drum_snare_hard, amp: 0.75
    sleep 1
    sample :hat_cats, amp: 0.28
    sleep 1

  end
end