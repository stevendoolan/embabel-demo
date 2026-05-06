# Electronic Dreams
# Style: Dreamy Electronic | Mood: Atmospheric, Evolving
# Key: Am -> Cm | Tempo: 120 BPM | Time: 4/4

use_debug false
use_bpm 120

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # -------------------------------------------------------
    # SECTION 1: Am — Dreamy opening (4 bars total, 2x repeat)
    # Melody: blade arpeggios | Harmony: hollow pads | Bass: subpulse roots | Percussion: sparse four-on-the-floor
    # -------------------------------------------------------
    am_melody      = (ring :a4, :c5, :e5, :a4, :g4, :e4, :f4, :e4)
    am_bass_ring   = (ring :a1, :a1, :e2, :a1, :c2, :a1, :e2, :g1)
    am_chords      = [chord(:a3, :minor), chord(:f3, :major), chord(:c3, :major), chord(:e3, :minor)]
    cutoff_swell1  = (line 80, 102, steps: 8)

    2.times do
      # Long drones underneath
      use_synth :blade
      play :a3, release: 8, cutoff: 85, amp: 0.45
      use_synth :dark_ambience
      play :a2, release: 16, cutoff: 82, amp: 0.35
      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 0.65

      # Melody — blade with reverb
      in_thread do
        with_fx :reverb, room: 0.28, mix: 0.3 do
          with_fx :lpf, cutoff: 100, mix: 1.0 do
            2.times do
              4.times do
                use_synth :blade
                play am_melody.tick, release: 0.45, cutoff: rrand(82, 108), amp: 0.95
                sleep 0.5
                use_synth :blade
                play am_melody.tick, release: 0.3, cutoff: rrand(80, 100), amp: 0.9
                sleep 0.5
              end
            end
          end
        end
      end

      # Harmony — hollow pad chords
      in_thread do
        with_fx :reverb, room: 0.28, mix: 0.3 do
          with_fx :lpf, cutoff: 100, mix: 1.0 do
            use_synth :hollow
            play_chord am_chords[0], release: 2.2, cutoff: cutoff_swell1.tick, amp: 0.55
            sleep 2
            use_synth :hollow
            play_chord am_chords[1], release: 2.2, cutoff: cutoff_swell1.tick, amp: 0.52
            sleep 2
            use_synth :hollow
            play_chord am_chords[2], release: 2.2, cutoff: cutoff_swell1.tick, amp: 0.52
            sleep 2
            use_synth :hollow
            play_chord am_chords[3], release: 2.2, cutoff: cutoff_swell1.tick, amp: 0.52
            sleep 2
          end
        end
      end

      # Bass — syncopated subpulse
      in_thread do
        2.times do
          use_synth :subpulse
          play am_bass_ring.tick, cutoff: 72, release: 0.8, amp: 0.72
          sleep 1
          use_synth :subpulse
          play am_bass_ring.tick, cutoff: 68, release: 0.5, amp: 0.58
          sleep 0.5
          use_synth :subpulse
          play am_bass_ring.tick, cutoff: 70, release: 0.4, amp: 0.55
          sleep 0.5
          use_synth :subpulse
          play am_bass_ring.tick, cutoff: 72, release: 0.7, amp: 0.62
          sleep 1
          use_synth :subpulse
          play am_bass_ring.tick, cutoff: 66, release: 0.35, amp: 0.56
          sleep 0.75
          use_synth :subpulse
          play am_bass_ring.tick, cutoff: 70, release: 0.3, amp: 0.52
          sleep 0.25
        end
      end

      # Percussion — sparse four-on-the-floor
      with_fx :hpf, cutoff: 90, mix: 1.0 do
        4.times do |i|
          sample :bd_haus, amp: i == 0 ? 0.75 : 0.62
          sample :drum_cymbal_closed, amp: 0.32, rate: 1.2
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.22, rate: 1.1
          sleep 0.5
          sample :elec_snare, amp: 0.52
          sample :drum_cymbal_closed, amp: 0.28, rate: 1.2
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.18, rate: 1.0
          sleep 0.5
          sample :bd_haus, amp: 0.60
          sample :drum_cymbal_closed, amp: 0.28, rate: 1.2
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.20, rate: 1.1
          sleep 0.5
          sample :elec_snare, amp: 0.48
          sample :drum_cymbal_closed, amp: 0.25, rate: 1.2
          sleep 0.5
          sample :elec_blip, amp: 0.22, rate: rrand(0.9, 1.2) if one_in(3)
          sample :drum_cymbal_closed, amp: 0.16, rate: 1.0
          sleep 0.5
        end
      end
    end

    # -------------------------------------------------------
    # TRANSITION 1: Am -> Am (section 2 energy build)
    # -------------------------------------------------------
    use_synth :blade
    play :a3, cutoff: 88, release: 8, amp: 0.5
    use_synth :dark_ambience
    play :a2, cutoff: 85, release: 8, amp: 0.38
    use_synth :bass_foundation
    play :a1, cutoff: 68, release: 8, amp: 0.62
    with_fx :hpf, cutoff: 90, mix: 1.0 do
      sample :bd_haus, amp: 0.7
      sample :hat_zap, amp: 0.32
      sleep 1
      sample :elec_snare, amp: 0.48
      sleep 1
      sample :bd_haus, amp: 0.65
      sample :hat_zap, amp: 0.28
      sleep 1
      sample :elec_snare, amp: 0.52
      sample :elec_blip, amp: 0.28, rate: 1.4
      sleep 1
    end

    # -------------------------------------------------------
    # SECTION 2: Am — Full energy build (4 bars total, 2x repeat)
    # Melody: supersaw arpeggios | Harmony: FM shimmer chords | Bass: tb303 | Percussion: dense four-on-the-floor
    # -------------------------------------------------------
    am_arp         = (ring :a4, :e5, :c5, :a5, :g4, :e5, :f4, :a4)
    am_tb_ring     = (ring :a1, :e2, :a1, :a1, :g1, :e2, :a1, :c2)
    am_chords2     = [chord(:a3, :minor), chord(:e3, :minor), chord(:f3, :major), chord(:g3, :major)]
    cutoff_ramp    = (line 85, 115, steps: 16)
    cutoff_swell2  = (line 85, 112, steps: 8)
    cutoff_bass_ramp = (line 62, 85, steps: 32)

    2.times do
      # Long drones underneath
      use_synth :supersaw
      play :a3, release: 8, cutoff: 90, amp: 0.38
      use_synth :hollow
      play :a3, release: 16, cutoff: 88, amp: 0.35
      use_synth :tb303
      play :a1, cutoff: 70, res: 0.85, wave: 0, release: 8, amp: 0.60

      # Melody — supersaw arpeggios with echo
      in_thread do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          2.times do
            8.times do
              use_synth :supersaw
              play am_arp.tick, release: 0.2, cutoff: cutoff_ramp.tick, amp: 0.92
              sleep 0.5
            end
          end
        end
      end

      # Harmony — FM shimmer chords
      in_thread do
        use_synth :fm
        play_chord am_chords2[0], release: 2.0, cutoff: cutoff_swell2.tick, amp: 0.52, divisor: 2.0, depth: 1.0
        sleep 2
        use_synth :fm
        play_chord am_chords2[1], release: 2.0, cutoff: cutoff_swell2.tick, amp: 0.50, divisor: 2.0, depth: 1.0
        sleep 2
        use_synth :fm
        play_chord am_chords2[2], release: 2.0, cutoff: cutoff_swell2.tick, amp: 0.50, divisor: 2.0, depth: 1.0
        sleep 2
        use_synth :fm
        play_chord am_chords2[3], release: 2.0, cutoff: cutoff_swell2.tick, amp: 0.50, divisor: 2.0, depth: 1.0
        sleep 2
      end

      # Bass — tb303 syncopated eighths
      in_thread do
        2.times do
          8.times do
            use_synth :tb303
            play am_tb_ring.tick, cutoff: cutoff_bass_ramp.tick, res: 0.82, wave: 0,
                 release: 0.45, amp: 0.65
            sleep 0.5
          end
        end
      end

      # Percussion — dense four-on-the-floor with hat_zap accents
      4.times do |i|
        sample :bd_haus, amp: i == 0 ? 0.82 : 0.70
        sample :hat_zap, amp: 0.42
        sleep 0.25
        sample :elec_tick, amp: 0.25
        sleep 0.25
        sample :elec_snare, amp: 0.60
        sample :hat_zap, amp: 0.35
        sleep 0.25
        sample :elec_tick, amp: 0.20 if one_in(2)
        sleep 0.25
        sample :bd_haus, amp: 0.68
        sample :hat_zap, amp: 0.38
        sleep 0.25
        sample :elec_blip, amp: 0.25, rate: rrand(1.0, 1.5) if one_in(3)
        sleep 0.25
        sample :elec_snare, amp: 0.56
        sample :hat_zap, amp: 0.32
        sleep 0.25
        sample :elec_tick, amp: 0.22
        sleep 0.25
      end
    end

    # -------------------------------------------------------
    # TRANSITION 2: Key change Am -> Cm
    # -------------------------------------------------------
    use_synth :supersaw
    play :c4, cutoff: 90, release: 8, amp: 0.48
    use_synth :dark_ambience
    play :c3, cutoff: 88, release: 8, amp: 0.42
    use_synth :bass_foundation
    play :c2, cutoff: 70, release: 8, amp: 0.65
    with_fx :reverb, room: 0.25, mix: 0.22 do
      sample :bd_haus, amp: 0.75
      sample :hat_zap, amp: 0.38
      sleep 0.5
      sample :elec_tick, amp: 0.28
      sleep 0.5
      sample :elec_snare, amp: 0.56
      sample :hat_zap, amp: 0.32
      sleep 0.5
      sample :elec_blip, amp: 0.32, rate: 1.3
      sleep 0.5
      sample :bd_haus, amp: 0.70
      sample :hat_zap, amp: 0.35
      sleep 0.5
      sample :elec_tick, amp: 0.25
      sleep 0.5
      sample :elec_snare, amp: 0.54
      sample :drum_cymbal_closed, amp: 0.28
      sleep 0.5
      sample :elec_blip, amp: 0.28, rate: 1.6
      sleep 0.5
    end

    # -------------------------------------------------------
    # SECTION 3: Cm — Chiplead dreamy melody (4 bars total, 2x repeat)
    # Melody: chiplead | Harmony: hollow + dark_ambience pads | Bass: bass_foundation syncopated | Percussion: euclidean hats
    # -------------------------------------------------------
    cm_melody      = (ring :c5, :eb5, :g5, :c5, :bb4, :g4, :ab4, :g4)
    cm_bass_ring   = (ring :c2, :c2, :g1, :c2, :eb2, :c2, :g1, :bb1)
    cm_chords      = [chord(:c3, :minor), chord(:ab3, :major), chord(:eb3, :major), chord(:bb3, :major)]
    cutoff_ramp2   = (line 88, 118, steps: 16)
    cutoff_swell3  = (line 88, 110, steps: 8)
    hi_hat_pattern = spread(5, 8)

    2.times do
      # Long drones underneath
      use_synth :chiplead
      play :c4, release: 8, cutoff: 90, amp: 0.38
      use_synth :dark_ambience
      play :c2, release: 16, cutoff: 84, amp: 0.42
      use_synth :bass_foundation
      play :c1, cutoff: 65, release: 8, amp: 0.68

      # Melody — chiplead with reverb
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.28 do
          with_fx :lpf, cutoff: 110, mix: 1.0 do
            2.times do
              4.times do
                use_synth :chiplead
                play cm_melody.tick, release: 0.35, cutoff: cutoff_ramp2.tick, amp: 0.98
                sleep 0.5
                use_synth :chiplead
                play cm_melody.tick, release: 0.25, cutoff: rrand(85, 112), amp: 0.92
                sleep 0.5
              end
            end
          end
        end
      end

      # Harmony — hollow pads with reverb
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.28 do
          use_synth :hollow
          play_chord cm_chords[0], release: 2.2, cutoff: cutoff_swell3.tick, amp: 0.55
          sleep 2
          use_synth :hollow
          play_chord cm_chords[1], release: 2.2, cutoff: cutoff_swell3.tick, amp: 0.52
          sleep 2
          use_synth :hollow
          play_chord cm_chords[2], release: 2.2, cutoff: cutoff_swell3.tick, amp: 0.52
          sleep 2
          use_synth :hollow
          play_chord cm_chords[3], release: 2.2, cutoff: cutoff_swell3.tick, amp: 0.52
          sleep 2
        end
      end

      # Bass — bass_foundation + subpulse syncopated
      in_thread do
        with_fx :lpf, cutoff: 82, mix: 1.0 do
          2.times do
            use_synth :bass_foundation
            play cm_bass_ring.tick, cutoff: 75, release: 0.85, amp: 0.75
            sleep 1
            use_synth :subpulse
            play cm_bass_ring.tick, cutoff: 70, release: 0.4, amp: 0.58
            sleep 0.5
            use_synth :bass_foundation
            play cm_bass_ring.tick, cutoff: 72, release: 0.6, amp: 0.65
            sleep 0.5
            use_synth :bass_foundation
            play cm_bass_ring.tick, cutoff: 75, release: 0.75, amp: 0.68
            sleep 1
            use_synth :subpulse
            play cm_bass_ring.tick, cutoff: 68, release: 0.35, amp: 0.58
            sleep 0.75
            use_synth :subpulse
            play cm_bass_ring.tick, cutoff: 66, release: 0.3, amp: 0.52
            sleep 0.25
          end
        end
      end

      # Percussion — euclidean hi-hat pattern
      8.times do |i|
        sample :bd_haus, amp: i == 0 ? 0.80 : 0.64
        sample :hat_zap, amp: 0.40 if hi_hat_pattern.tick
        sleep 0.25
        sample :elec_tick, amp: 0.28 if hi_hat_pattern.tick
        sleep 0.25
        sample :elec_snare, amp: 0.58 if [2, 3, 6, 7].include?(i)
        sample :drum_cymbal_closed, amp: 0.25 if hi_hat_pattern.tick
        sleep 0.25
        sample :elec_blip, amp: 0.28, rate: rrand(0.8, 1.6) if one_in(4)
        sample :elec_tick, amp: 0.20 if hi_hat_pattern.tick
        sleep 0.25
      end
    end

    # -------------------------------------------------------
    # TRANSITION 3: Cm section 3 -> Cm Outro
    # -------------------------------------------------------
    use_synth :supersaw
    play :c3, cutoff: 80, release: 12, amp: 0.32
    use_synth :dark_ambience
    play :c2, cutoff: 82, release: 14, amp: 0.42
    use_synth :bass_foundation
    play :c1, cutoff: 66, release: 12, amp: 0.68
    sample :bd_haus, amp: 0.75
    sample :hat_zap, amp: 0.38
    sleep 1
    sample :elec_snare, amp: 0.55
    sleep 1

    # -------------------------------------------------------
    # SECTION 4: Cm Outro — All layers blend, futuristic fills (4 bars total, 2x repeat)
    # Melody: chiplead outro | Harmony: FM + hollow blend | Bass: tb303 descending | Percussion: full blend
    # -------------------------------------------------------
    cm_outro        = (ring :c5, :g5, :eb5, :bb4, :ab4, :g4, :eb4, :c4)
    cm_outro_bass   = (ring :c2, :g1, :eb2, :c2, :bb1, :c2, :g1, :c2)
    cm_outro_chords = [chord(:c3, :minor), chord(:g3, :minor), chord(:eb3, :major), chord(:bb3, :major)]
    cutoff_swell4   = (line 90, 118, steps: 8)
    cutoff_outro    = (line 68, 60, steps: 32)

    2.times do
      # Long drones underneath
      use_synth :blade
      play :c3, release: 8, cutoff: 85, amp: 0.36
      use_synth :supersaw
      play :g4, release: 8, cutoff: 88, amp: 0.24
      use_synth :hollow
      play :c3, release: 8, cutoff: 88, amp: 0.40
      use_synth :dark_ambience
      play :c2, release: 8, cutoff: 82, amp: 0.36
      use_synth :tb303
      play :c1, cutoff: 72, res: 0.8, wave: 1, release: 8, amp: 0.60

      # Melody — chiplead outro with reverb
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.32 do
          2.times do
            8.times do
              use_synth :chiplead
              play cm_outro.tick, release: 0.4, cutoff: rrand(88, 115), amp: 0.95
              sleep 0.5
            end
          end
        end
      end

      # Harmony — FM + hollow blend
      in_thread do
        use_synth :fm
        play_chord cm_outro_chords[0], release: 2.0, cutoff: cutoff_swell4.tick, amp: 0.52, divisor: 1.5, depth: 1.2
        sleep 2
        use_synth :fm
        play_chord cm_outro_chords[1], release: 2.0, cutoff: cutoff_swell4.tick, amp: 0.50, divisor: 1.5, depth: 1.2
        sleep 2
        use_synth :hollow
        play_chord cm_outro_chords[2], release: 2.2, cutoff: cutoff_swell4.tick, amp: 0.52
        sleep 2
        use_synth :hollow
        play_chord cm_outro_chords[3], release: 2.2, cutoff: cutoff_swell4.tick, amp: 0.50
        sleep 2
      end

      # Bass — tb303 slower weighted hits
      in_thread do
        2.times do
          use_synth :tb303
          play cm_outro_bass.tick, cutoff: cutoff_outro.tick, res: 0.83, wave: 1,
               release: 0.9, amp: 0.68
          sleep 1
          use_synth :subpulse
          play cm_outro_bass.tick, cutoff: cutoff_outro.tick, release: 0.5, amp: 0.58
          sleep 0.5
          use_synth :tb303
          play cm_outro_bass.tick, cutoff: cutoff_outro.tick, res: 0.8, wave: 1,
               release: 0.45, amp: 0.60
          sleep 0.5
          use_synth :bass_foundation
          play cm_outro_bass.tick, cutoff: 68, release: 0.85, amp: 0.68
          sleep 1
          use_synth :subpulse
          play cm_outro_bass.tick, cutoff: cutoff_outro.tick, release: 0.4, amp: 0.56
          sleep 0.75
          use_synth :subpulse
          play cm_outro_bass.tick, cutoff: 65, release: 0.3, amp: 0.52
          sleep 0.25
        end
      end

      # Percussion — full blend with futuristic fills
      with_fx :hpf, cutoff: 85, mix: 1.0 do
        4.times do |i|
          sample :bd_haus, amp: i == 0 ? 0.82 : 0.68
          sample :hat_zap, amp: 0.45
          sleep 0.25
          sample :elec_tick, amp: 0.30
          sleep 0.25
          sample :elec_snare, amp: 0.64
          sample :drum_cymbal_closed, amp: 0.30
          sleep 0.25
          sample :elec_blip, amp: 0.28, rate: rrand(1.0, 1.8) if one_in(3)
          sleep 0.25
          sample :bd_haus, amp: 0.65
          sample :hat_zap, amp: 0.40
          sleep 0.25
          sample :elec_tick, amp: 0.26
          sample :elec_blip, amp: 0.22, rate: rrand(0.9, 1.4) if one_in(4)
          sleep 0.25
          sample :elec_snare, amp: 0.58
          sample :hat_zap, amp: 0.35
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.26
          sample :elec_tick, amp: 0.22 if one_in(2)
          sleep 0.25
        end
      end
    end

  end
end