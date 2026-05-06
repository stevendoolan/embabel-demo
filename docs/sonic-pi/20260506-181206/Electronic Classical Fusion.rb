# Circuits & Counterpoint
# Style: Electronic / Cinematic | Mood: Dynamic, Evolving

use_debug false
use_bpm 112

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================
    # SECTION 1: Dm Intro — Chiplead melody + hollow pads + sparse percussion + bass foundation (2x 4 bars)
    # =============================================
    dm_melody    = (ring :d4, :f4, :a4, :c5, :d5, :a4, :f4, :e4,
                         :d4, :f4, :g4, :a4, :bb4, :a4, :g4, :f4)
    dm7_chords   = (ring chord(:d3, :minor7), chord(:d3, :minor7),
                         chord(:f3, :major7), chord(:c3, :major7))
    dm_bass_ring = (ring :d2, :d2, :f2, :a2, :c2, :a2, :f2, :e2)

    2.times do
      # Long drone anchor — fm sub
      use_synth :fm
      play :d2, release: 8, divisor: 2, depth: 12, cutoff: 85, amp: 0.4

      # Hollow sustained pad — Dm7 foundation
      with_fx :reverb, room: 0.3, mix: 0.3 do
        with_fx :lpf, cutoff: 95, mix: 1.0 do
          use_synth :hollow
          play_chord chord(:d2, :minor7), cutoff: 82, release: 16, amp: 0.45
        end
      end

      # Chiplead melody lead voice
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :reverb, room: 0.25, mix: 0.28 do
          use_synth :chiplead
          16.times do
            play dm_melody.tick, release: 0.18, cutoff: (line 88, 115, steps: 16).tick, amp: 0.95
            sleep 0.5
          end
        end
      end

      # Supersaw slow pad chords — harmony support
      with_fx :lpf, cutoff: 90, mix: 1.0 do
        use_synth :supersaw
        4.times do
          play_chord dm7_chords.tick, cutoff: (line 80, 95, steps: 4).tick, release: 1.9, amp: 0.28
          sleep 2
        end
      end

      # Bass: root anchor + tb303 syncopated eighths
      use_synth :bass_foundation
      play :d2, cutoff: 68, release: 8, amp: 0.7

      with_fx :lpf, cutoff: 82, mix: 1.0 do
        use_synth :tb303
        8.times do
          play dm_bass_ring.tick, cutoff: rrand(65, 82), release: 0.55, wave: 0, res: 0.8, amp: 0.6
          sleep 1
        end
      end

      # Percussion: sparse crisp foundation
      with_fx :hpf, cutoff: 100, mix: 1.0 do
        4.times do
          sample :bd_haus, amp: 0.75
          sample :drum_cymbal_open, amp: 0.35 if one_in(8)
          sleep 0.5
          sample :hat_cab, amp: 0.30
          sleep 0.5
          sample :elec_snare, amp: 0.55
          sample :hat_cab, amp: 0.26
          sleep 0.5
          sample :hat_cab, amp: 0.23
          sleep 0.5
          sample :bd_haus, amp: 0.65
          sleep 0.5
          sample :hat_cab, amp: 0.28
          sleep 0.5
          sample :elec_snare, amp: 0.52
          sample :hat_cab, amp: 0.25
          sleep 0.5
          sample :hat_cab, amp: 0.20 if one_in(2)
          sleep 0.5
        end
      end
    end

    # =============================================
    # TRANSITION 1: Dm -> F bridge drone
    # =============================================
    use_synth :blade
    play :d3, cutoff: 90, release: 8, amp: 0.55
    use_synth :fm
    play :f2, divisor: 3, depth: 8, cutoff: 88, release: 6, amp: 0.4
    use_synth :hollow
    play_chord chord(:d3, :minor7), cutoff: 88, release: 8, amp: 0.42
    use_synth :subpulse
    play :d2, cutoff: 72, release: 5, amp: 0.6
    sample :drum_cymbal_hard, amp: 0.65
    sleep 4

    # =============================================
    # SECTION 2: Dm FM Counterpoint — fm melody + rhodey arpeggios + walking bass + driving hi-hats (2x 4 bars)
    # =============================================
    dm_fm_melody  = (ring :a4, :bb4, :a4, :g4, :f4, :e4, :d4, :e4,
                          :f4, :g4, :a4, :c5, :d5, :c5, :bb4, :a4)
    dm_arp        = (ring :d3, :f3, :a3, :c4, :d3, :g3, :a3, :c4)
    dm_sus_chords = (ring chord(:d3, :minor7), chord(:g3, :m7),
                          chord(:f3, :major7), chord(:c3, :sus4))
    dm_walk       = (ring :d2, :f2, :a2, :g2, :f2, :e2, :d2, :c2,
                          :d2, :f2, :a2, :c3, :a2, :g2, :f2, :e2)

    2.times do
      # Long fm drone anchor
      use_synth :fm
      play :d2, release: 8, divisor: 1.5, depth: 16, cutoff: 90, amp: 0.38

      # Hollow sustained drone pad — Dm7
      with_fx :reverb, room: 0.3, mix: 0.32 do
        with_fx :lpf, cutoff: 98, mix: 1.0 do
          use_synth :hollow
          play_chord chord(:d2, :minor7), cutoff: 85, release: 16, amp: 0.42
        end
      end

      # FM melody — lead voice
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
        use_synth :fm
        16.times do
          play dm_fm_melody.tick, release: 0.22, divisor: rrand(1.0, 3.0), depth: rrand(4, 12), cutoff: rrand(85, 115), amp: 0.92
          sleep 0.5
        end
      end

      # Rhodey arpeggiated figures — harmony
      use_synth :rhodey
      8.times do
        play dm_arp.tick, cutoff: (line 82, 108, steps: 8).tick, release: 0.55, amp: 0.38
        sleep 1
      end

      # Supersaw chord pads underneath
      use_synth :supersaw
      4.times do
        play_chord dm_sus_chords.tick, cutoff: 88, release: 1.85, amp: 0.25
        sleep 2
      end

      # Bass: sub root + walking bass_foundation
      use_synth :subpulse
      play :d1, cutoff: 65, release: 8, amp: 0.58

      use_synth :bass_foundation
      16.times do
        play dm_walk.tick, cutoff: rrand(66, 80), release: 0.7, amp: 0.62
        sleep 0.5
      end

      # Percussion: driving hi-hats added
      with_fx :hpf, cutoff: 95, mix: 1.0 do
        4.times do
          sample :bd_haus, amp: 0.78
          sleep 0.25
          sample :hat_cab, amp: 0.28
          sleep 0.25
          sample :hat_cab, amp: 0.23
          sleep 0.25
          sample :hat_cab, amp: 0.26
          sleep 0.25
          sample :elec_snare, amp: 0.58
          sleep 0.25
          sample :hat_cab, amp: 0.28
          sleep 0.25
          sample :hat_cab, amp: 0.20
          sleep 0.25
          sample :hat_cab, amp: 0.23 if one_in(2)
          sleep 0.25
          sample :bd_haus, amp: 0.68
          sleep 0.25
          sample :hat_cab, amp: 0.26
          sleep 0.25
          sample :hat_cab, amp: 0.20
          sleep 0.25
          sample :hat_cab, amp: 0.24
          sleep 0.25
          sample :elec_snare, amp: 0.56
          sample :drum_cymbal_open, amp: 0.28 if one_in(4)
          sleep 0.25
          sample :hat_cab, amp: 0.26
          sleep 0.25
          sample :hat_cab, amp: 0.20
          sleep 0.25
          sample :hat_cab, amp: 0.22
          sleep 0.25
        end
      end
    end

    # =============================================
    # TRANSITION 2: Dm -> F key change drone
    # =============================================
    use_synth :blade
    play :f3, cutoff: 92, release: 8, amp: 0.58
    use_synth :fm
    play :c3, divisor: 2, depth: 10, cutoff: 88, release: 6, amp: 0.42
    use_synth :hollow
    play_chord chord(:f3, :major7), cutoff: 90, release: 8, amp: 0.45
    use_synth :bass_foundation
    play :f2, cutoff: 74, release: 5, amp: 0.65
    sample :drum_cymbal_hard, amp: 0.72
    sleep 4

    # =============================================
    # SECTION 3: F Major — Blade lead + supersaw pads + tb303 bass + fuller percussion (2x 4 bars)
    # =============================================
    f_melody      = (ring :f4, :g4, :a4, :c5, :d5, :c5, :a4, :g4,
                          :f4, :a4, :c5, :e5, :f5, :e5, :d5, :c5)
    f_bass_ring   = (ring :f2, :f2, :a2, :c3, :f2, :c2, :a1, :c2)
    f_pad_chords  = (ring chord(:f3, :major7), chord(:c3, :sus2),
                          chord(:a3, :minor7), chord(:g3, :sus4))

    2.times do
      # Long fm drone anchor in F
      use_synth :fm
      play :f2, release: 8, divisor: 2, depth: 14, cutoff: 92, amp: 0.38

      # Big hollow pad — Fmaj7 foundation
      with_fx :reverb, room: 0.3, mix: 0.35 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          use_synth :hollow
          play_chord chord(:f2, :major7), cutoff: 88, release: 16, amp: 0.45
        end
      end

      # Blade lead melody
      with_fx :lpf, cutoff: 115, mix: 1.0 do
        with_fx :reverb, room: 0.28, mix: 0.3 do
          use_synth :blade
          16.times do
            play f_melody.tick, release: 0.2, cutoff: (line 90, 118, steps: 16).tick, amp: 0.98
            sleep 0.5
          end
        end
      end

      # Supersaw slow chord swells — harmony
      use_synth :supersaw
      4.times do
        play_chord f_pad_chords.tick, cutoff: (line 85, 105, steps: 4).tick, release: 1.95, amp: 0.27
        sleep 2
      end

      # Bass: subpulse root + tb303 walking
      use_synth :subpulse
      play :f1, cutoff: 66, release: 8, amp: 0.65

      with_fx :lpf, cutoff: 85, mix: 1.0 do
        use_synth :tb303
        8.times do
          play f_bass_ring.tick, cutoff: rrand(68, 85), release: 0.6, wave: 0, res: 0.82, amp: 0.58
          sleep 1
        end
      end

      # Percussion: fuller energy in F
      4.times do
        sample :bd_fat, amp: 0.80
        sample :drum_cymbal_hard, amp: 0.45 if one_in(8)
        sleep 0.25
        sample :hat_cab, amp: 0.32
        sleep 0.25
        sample :hat_cab, amp: 0.26
        sleep 0.25
        sample :hat_cab, amp: 0.30
        sleep 0.25
        sample :elec_snare, amp: 0.62
        sleep 0.25
        sample :hat_cab, amp: 0.31
        sleep 0.25
        sample :hat_cab, amp: 0.24
        sleep 0.25
        sample :hat_cab, amp: 0.28
        sleep 0.25
        sample :bd_fat, amp: 0.70
        sleep 0.25
        sample :hat_cab, amp: 0.30
        sleep 0.25
        sample :drum_cymbal_open, amp: 0.32 if one_in(3)
        sleep 0.25
        sample :hat_cab, amp: 0.26
        sleep 0.25
        sample :elec_snare, amp: 0.60
        sleep 0.25
        sample :hat_cab, amp: 0.30
        sleep 0.25
        sample :hat_cab, amp: 0.22
        sleep 0.25
        sample :hat_cab, amp: 0.28
        sleep 0.25
      end
    end

    # =============================================
    # SECTION 4: F Finale — Chiplead high energy + rhodey arpeggios + dense bass + maximum rhythmic drive (2x 4 bars)
    # =============================================
    f_chip         = (ring :f5, :e5, :d5, :c5, :a4, :bb4, :c5, :d5,
                           :f5, :g5, :a5, :g5, :f5, :e5, :d5, :c5)
    f_arp          = (ring :f3, :a3, :c4, :e4, :f4, :a3, :e4, :c4)
    f_finale_chords = (ring chord(:f3, :major7), chord(:c3, :major7),
                            chord(:a3, :minor7), chord(:f3, :major7))
    f_finale_bass  = (ring :f2, :a2, :c3, :f2, :a2, :c3, :e2, :f2,
                          :f2, :c2, :a1, :c2, :f2, :bb2, :c3, :f2)

    2.times do
      # Long fm drone anchor — high energy F
      use_synth :fm
      play :f2, release: 8, divisor: 1.5, depth: 18, cutoff: 95, amp: 0.38

      # Big hollow pad finale — Fmaj7
      with_fx :reverb, room: 0.3, mix: 0.35 do
        with_fx :lpf, cutoff: 102, mix: 1.0 do
          use_synth :hollow
          play_chord chord(:f2, :major7), cutoff: 90, release: 16, amp: 0.48
        end
      end

      # Chiplead finale melody — lead voice
      with_fx :echo, phase: 0.25, decay: 1.2, mix: 0.18 do
        use_synth :chiplead
        16.times do
          play f_chip.tick, release: 0.14, cutoff: rrand(90, 120), amp: 1.0
          sleep 0.5
        end
      end

      # FM counter-melody
      use_synth :fm
      with_fx :reverb, room: 0.22, mix: 0.25 do
        [:c4, :f4, :a4, :c5, :f4, :a4, :c5, :f5].each do |n|
          play n, release: 0.38, divisor: rrand(2, 4), depth: rrand(6, 14), cutoff: rrand(82, 105), amp: 0.45
          sleep 0.5
        end
      end

      # Rhodey bright arpeggios — harmony
      use_synth :rhodey
      8.times do
        play f_arp.tick, cutoff: (line 88, 118, steps: 8).tick, release: 0.45, amp: 0.38
        sleep 1
      end

      # Supersaw chord swells — harmony
      use_synth :supersaw
      4.times do
        play_chord f_finale_chords.tick, cutoff: 92, release: 1.9, amp: 0.26
        sleep 2
      end

      # Bass: droning sub + bass_foundation quarters + tb303 sixteenth fills
      use_synth :subpulse
      play :f1, cutoff: 65, release: 8, amp: 0.68

      use_synth :bass_foundation
      4.times do
        play (ring :f2, :c2, :a1, :c2).tick, cutoff: 72, release: 1.4, amp: 0.68
        sleep 2
      end

      use_synth :tb303
      16.times do
        play f_finale_bass.tick, cutoff: rrand(70, 88), release: 0.38, wave: 0, res: 0.85, amp: 0.55
        sleep 0.5
      end

      # Percussion: maximum rhythmic drive
      4.times do
        sample :bd_haus, amp: 0.85
        sample :drum_cymbal_open, amp: 0.38 if one_in(4)
        sleep 0.25
        sample :hat_cab, amp: 0.35
        sleep 0.25
        sample :hat_cab, amp: 0.28
        sleep 0.25
        sample :hat_cab, amp: 0.32
        sleep 0.25
        sample :elec_snare, amp: 0.68
        sample :drum_cymbal_hard, amp: 0.40 if one_in(6)
        sleep 0.25
        sample :hat_cab, amp: 0.33
        sleep 0.25
        sample :hat_cab, amp: 0.26
        sleep 0.25
        sample :hat_cab, amp: 0.30
        sleep 0.25
        sample :bd_haus, amp: 0.75
        sleep 0.25
        sample :hat_cab, amp: 0.33
        sleep 0.25
        sample :hat_cab, amp: 0.28
        sleep 0.25
        sample :hat_cab, amp: 0.32
        sleep 0.25
        sample :elec_snare, amp: 0.64
        sleep 0.25
        sample :hat_cab, amp: 0.32
        sleep 0.25
        sample :drum_cymbal_open, amp: 0.34 if one_in(3)
        sleep 0.25
        sample :hat_cab, amp: 0.30
        sleep 0.25
      end
    end

  end
end