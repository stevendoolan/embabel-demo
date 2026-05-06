# Smooth Croon
# Style: Jazz | Mood: Warm, Lush, Lyrical | Key: F → Bb | BPM: 72 | Time: 4/4

use_debug false
use_bpm 72

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ── Section 1: Intro — Chord Vamp in F ──
    # Melody: Rhodey croon, Harmony: hollow + fm pads, Bass: sustained root, Percussion: gentle brush

    chords_a = [
      chord(:f3, :major7),
      chord(:d3, :m7),
      chord(:g2, :m7),
      chord(:c3, '7')
    ]
    harm_chords_a = [
      chord(:f3, :major7),
      chord(:d3, :m9),
      chord(:g2, :m9),
      chord(:c3, '9')
    ]

    2.times do
      with_fx :reverb, room: 0.25, mix: 0.3 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do

          # Melody drone
          use_synth :rhodey
          play 41, release: 16, cutoff: 85, amp: 0.35

          # Harmony: hollow sustained pad
          use_synth :hollow
          play_chord chord(:f3, :major7), release: 16, cutoff: 88, amp: 0.5

          # Bass: sustained root
          use_synth :bass_foundation
          play :f1, cutoff: 70, release: 8, amp: 0.7

          # Melody: piano chord comping
          in_thread do
            use_synth :piano
            chords_a.each do |ch|
              play_chord ch, release: 1.8, amp: 0.3, cutoff: 90
              sleep 2
            end
          end

          # Harmony: fm chord stabs
          in_thread do
            use_synth :fm
            harm_chords_a.each do |ch|
              play_chord ch, release: 1.6, cutoff: 88, amp: 0.45
              sleep 2
            end
          end

          # Percussion: brushed kit
          4.times do
            sample :drum_bass_soft, amp: 0.75
            sample :drum_cymbal_closed, amp: 0.35
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.28
            sleep 0.5
            sample :drum_snare_soft, amp: 0.58
            sample :drum_cymbal_closed, amp: 0.32
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.25
            sleep 0.5
            sample :drum_bass_soft, amp: 0.6
            sample :drum_cymbal_closed, amp: 0.3
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.22
            sleep 0.5
            sample :drum_snare_soft, amp: 0.55
            sample :drum_cymbal_closed, amp: 0.3
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.22
            sleep 0.5
          end
        end
      end
    end

    # ── Section 2: Melody Lead in F ──
    # Melody: Rhodey lead + piano comp, Harmony: hollow + fm inner voicings, Bass: walking bass, Percussion: brushed kit

    inner_voicings_a = [
      chord(:f4, :major7),
      chord(:d4, :m7),
      chord(:g3, :m7),
      chord(:c4, '7')
    ]

    2.times do
      with_fx :lpf, cutoff: 110, mix: 1.0 do

        # Melody drone
        use_synth :rhodey
        play 41, release: 16, cutoff: 85, amp: 0.3

        # Harmony: hollow pad
        use_synth :hollow
        play_chord chord(:f3, :major7), release: 16, cutoff: 90, amp: 0.45

        # Bass: walking line F maj7 → Dm7 → Gm7 → C7
        in_thread do
          with_fx :lpf, cutoff: 82, mix: 1.0 do
            use_synth :bass_foundation
            play :f2,  cutoff: 75, release: 0.75, amp: 0.72; sleep 1
            play :a2,  cutoff: 72, release: 0.7,  amp: 0.65; sleep 1
            play :d2,  cutoff: 76, release: 0.75, amp: 0.72; sleep 1
            play :f2,  cutoff: 72, release: 0.7,  amp: 0.65; sleep 1
            play :g2,  cutoff: 75, release: 0.75, amp: 0.72; sleep 1
            play :bb2, cutoff: 72, release: 0.7,  amp: 0.65; sleep 1
            play :c2,  cutoff: 76, release: 0.75, amp: 0.72; sleep 1
            play :e2,  cutoff: 73, release: 0.7,  amp: 0.65; sleep 1
          end
        end

        # Piano comping
        in_thread do
          use_synth :piano
          chords_a.each do |ch|
            play_chord ch, release: 1.7, amp: 0.25, cutoff: 88
            sleep 2
          end
        end

        # Harmony: fm stabs
        in_thread do
          use_synth :fm
          harm_chords_a.each do |ch|
            play_chord ch, release: 1.4, cutoff: rrand(82, 100), amp: 0.4
            sleep 2
          end
        end

        # Harmony: hollow inner voicings
        in_thread do
          use_synth :hollow
          inner_voicings_a.each do |ch|
            play_chord ch, release: 1.8, cutoff: 92, amp: 0.3
            sleep 2
          end
        end

        # Melody: Rhodey lead
        in_thread do
          use_synth :rhodey
          melody_phrases_a = [
            [:f4, 0.5], [:a4, 0.5], [:c5, 0.5], [:e4, 0.5],
            [:f4, 0.75], [:g4, 0.25], [:a4, 1.0],
            [:d4, 0.5], [:f4, 0.5], [:a4, 0.5], [:c5, 0.5],
            [:bb4, 0.75], [:a4, 0.25], [:g4, 0.5], [:c4, 0.5]
          ]
          melody_phrases_a.each do |note, dur|
            play note, release: dur * 0.85, cutoff: rrand(88, 108), amp: 0.92
            sleep dur
          end
        end

        # Percussion
        4.times do
          sample :drum_bass_soft, amp: 0.75
          sample :drum_cymbal_closed, amp: 0.35
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.28
          sleep 0.5
          sample :drum_snare_soft, amp: 0.58
          sample :drum_cymbal_closed, amp: 0.32
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.25
          sleep 0.5
          sample :drum_bass_soft, amp: 0.6
          sample :drum_cymbal_closed, amp: 0.3
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.22
          sleep 0.5
          sample :drum_snare_soft, amp: 0.55
          sample :drum_cymbal_closed, amp: 0.3
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.22
          sleep 0.5
        end
      end
    end

    # ── Transition: F → Bb ──
    in_thread do
      use_synth :rhodey
      play 34, cutoff: 90, release: 10, amp: 0.5
      use_synth :piano
      play_chord chord(:bb2, :major7), release: 8, amp: 0.3, cutoff: 85
    end
    in_thread do
      use_synth :hollow
      play_chord chord(:bb2, :major7), release: 10, cutoff: 85, amp: 0.45
      use_synth :fm
      play_chord chord(:f3, :major7), release: 8, cutoff: 88, amp: 0.35
    end
    in_thread do
      use_synth :bass_foundation
      play :bb1, cutoff: 68, release: 10, amp: 0.65
    end
    # Transition percussion — 1 measure
    sample :drum_bass_soft, amp: 0.55
    sample :drum_cymbal_closed, amp: 0.28
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.2
    sleep 0.5
    sample :drum_snare_soft, amp: 0.5
    sample :drum_cymbal_closed, amp: 0.25
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.18
    sleep 0.5
    sample :drum_bass_soft, amp: 0.5
    sample :drum_cymbal_closed, amp: 0.22
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.18
    sleep 0.5
    sample :drum_snare_soft, amp: 0.48
    sample :drum_cymbal_closed, amp: 0.2
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.16
    sleep 0.5

    # ── Section 3: Key Change to Bb — Melody Lead ──
    # Melody: Rhodey in Bb, Harmony: hollow + fm Bb voicings, Bass: tb303 walking, Percussion: hat_tap swing

    chords_b = [
      chord(:bb2, :major7),
      chord(:g2, :m7),
      chord(:c3, :m7),
      chord(:f2, '7')
    ]
    harm_chords_b = [
      chord(:bb2, :major7),
      chord(:g2, :m9),
      chord(:c3, :m9),
      chord(:f2, '9')
    ]
    inner_voicings_b = [
      chord(:bb3, :major7),
      chord(:g3, :m7),
      chord(:c4, :m7),
      chord(:f3, '7')
    ]

    2.times do
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do

          # Melody drone
          use_synth :piano
          play 34, release: 16, cutoff: 80, amp: 0.28

          # Harmony: hollow drone
          use_synth :hollow
          play_chord chord(:bb2, :major7), release: 16, cutoff: 86, amp: 0.5

          # Bass: sustained root
          use_synth :bass_foundation
          play :bb1, cutoff: 70, release: 8, amp: 0.7

          # Piano comping
          in_thread do
            use_synth :piano
            chords_b.each do |ch|
              play_chord ch, release: 1.8, amp: 0.27, cutoff: 90
              sleep 2
            end
          end

          # Harmony: fm stabs
          in_thread do
            use_synth :fm
            harm_chords_b.each do |ch|
              play_chord ch, release: 1.5, cutoff: rrand(82, 102), amp: 0.42
              sleep 2
            end
          end

          # Harmony: hollow inner voicings
          in_thread do
            use_synth :hollow
            inner_voicings_b.each do |ch|
              play_chord ch, release: 1.7, cutoff: 94, amp: 0.28
              sleep 2
            end
          end

          # Melody: Rhodey in Bb
          in_thread do
            use_synth :rhodey
            melody_phrases_b = [
              [:bb4, 0.5], [:d5, 0.5], [:f5, 0.5], [:eb5, 0.5],
              [:d5, 0.75], [:c5, 0.25], [:bb4, 1.0],
              [:g4, 0.5], [:bb4, 0.5], [:c5, 0.5], [:d5, 0.5],
              [:f5, 0.75], [:eb5, 0.25], [:d5, 0.5], [:bb4, 0.5]
            ]
            melody_phrases_b.each do |note, dur|
              play note, release: dur * 0.85, cutoff: rrand(90, 112), amp: 0.95
              sleep dur
            end
          end

          # Bass: tb303 walking Bb
          in_thread do
            use_synth :tb303
            play :bb1, cutoff: 78, release: 0.8,  wave: 0, amp: 0.68; sleep 1
            play :d2,  cutoff: 75, release: 0.75, wave: 0, amp: 0.62; sleep 1
            play :g2,  cutoff: 78, release: 0.8,  wave: 0, amp: 0.68; sleep 1
            play :bb2, cutoff: 75, release: 0.75, wave: 0, amp: 0.62; sleep 1
            play :c2,  cutoff: 78, release: 0.8,  wave: 0, amp: 0.68; sleep 1
            play :eb2, cutoff: 75, release: 0.75, wave: 0, amp: 0.62; sleep 1
            play :f2,  cutoff: 78, release: 0.8,  wave: 0, amp: 0.68; sleep 1
            play :a2,  cutoff: 75, release: 0.75, wave: 0, amp: 0.62; sleep 1
          end

          # Percussion: hat_tap swing
          with_fx :reverb, room: 0.22, mix: 0.2 do
            4.times do
              sample :drum_bass_soft, amp: 0.8
              sample :hat_tap, amp: 0.38
              sleep 0.5
              sample :drum_cymbal_closed, amp: 0.27
              sleep 0.5
              sample :drum_snare_soft, amp: 0.62
              sample :hat_tap, amp: 0.3
              sleep 0.5
              sample :drum_cymbal_closed, amp: 0.24
              sample :drum_snare_soft, amp: 0.22 if one_in(3)
              sleep 0.5
              sample :drum_bass_soft, amp: 0.65
              sample :hat_tap, amp: 0.32
              sleep 0.5
              sample :drum_cymbal_closed, amp: 0.22
              sleep 0.5
              sample :drum_snare_soft, amp: 0.6
              sample :hat_tap, amp: 0.28
              sleep 0.5
              sample :drum_cymbal_closed, amp: 0.2
              sample :drum_snare_soft, amp: 0.18 if one_in(4)
              sleep 0.5
            end
          end
        end
      end
    end

    # ── Transition: Bb bridge to finale ──
    in_thread do
      use_synth :rhodey
      play 34, cutoff: 88, release: 10, amp: 0.5
      use_synth :piano
      play_chord chord(:bb2, :major7), release: 8, amp: 0.3, cutoff: 85
    end
    in_thread do
      use_synth :hollow
      play_chord chord(:bb2, :major7), release: 10, cutoff: 85, amp: 0.45
      use_synth :fm
      play_chord chord(:bb3, :major7), release: 8, cutoff: 88, amp: 0.35
    end
    in_thread do
      use_synth :bass_foundation
      play :bb1, cutoff: 68, release: 10, amp: 0.65
    end
    # Transition percussion — 1 measure
    sample :drum_bass_soft, amp: 0.6
    sample :hat_tap, amp: 0.3
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.22
    sleep 0.5
    sample :drum_snare_soft, amp: 0.52
    sample :hat_tap, amp: 0.25
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.2
    sleep 0.5
    sample :drum_bass_soft, amp: 0.55
    sample :hat_tap, amp: 0.28
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.18
    sleep 0.5
    sample :drum_snare_soft, amp: 0.5
    sample :hat_tap, amp: 0.22
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.16
    sleep 0.5

    # ── Section 4: Finale — Full arrangement, Bb, richest feel ──
    # All layers together: Rhodey + piano melody, hollow + fm harmony, bass_foundation + tb303 bass, full kit

    2.times do
      with_fx :reverb, room: 0.3, mix: 0.3 do
        with_fx :lpf, cutoff: 108, mix: 1.0 do

          # Melody: layered drones
          use_synth :rhodey
          play 34, release: 16, cutoff: 82, amp: 0.3
          use_synth :piano
          play 34, release: 16, cutoff: 78, amp: 0.2

          # Harmony: hollow pad
          use_synth :hollow
          play_chord chord(:bb2, :major7), release: 16, cutoff: 84, amp: 0.5

          # Bass: sustained root + passing note
          in_thread do
            use_synth :bass_foundation
            play :bb1, cutoff: 68, release: 8, amp: 0.75
            sleep 4
            play :f2,  cutoff: 70, release: 4, amp: 0.65
            sleep 4
          end

          # Piano comping
          in_thread do
            use_synth :piano
            chords_b.each do |ch|
              play_chord ch, release: 1.9, amp: 0.25, cutoff: 88
              sleep 2
            end
          end

          # Harmony: fm stabs
          in_thread do
            use_synth :fm
            harm_chords_b.each do |ch|
              play_chord ch, release: 1.8, cutoff: rrand(85, 108), amp: 0.4
              sleep 2
            end
          end

          # Harmony: hollow upper voicings
          in_thread do
            use_synth :hollow
            inner_voicings_b.each do |ch|
              play_chord ch, release: 2.0, cutoff: 96, amp: 0.3
              sleep 2
            end
          end

          # Melody: Rhodey finale — expressive
          in_thread do
            use_synth :rhodey
            finale_phrases = [
              [:f5, 0.5], [:d5, 0.5], [:bb4, 0.5], [:c5, 0.5],
              [:d5, 1.0], [:c5, 1.0],
              [:bb4, 0.5], [:g4, 0.5], [:f4, 0.5], [:eb4, 0.5],
              [:d4, 1.5], [:bb3, 0.5]
            ]
            finale_phrases.each do |note, dur|
              play note, release: dur * 0.9, cutoff: rrand(90, 115), amp: 0.98
              sleep dur
            end
          end

          # Bass: finale walking — bass_foundation + tb303
          in_thread do
            use_synth :bass_foundation
            play :bb1, cutoff: 72, release: 1.8, amp: 0.72; sleep 2
            use_synth :tb303
            play :d2,  cutoff: 80, release: 0.85, wave: 0, amp: 0.65; sleep 1
            play :f2,  cutoff: 78, release: 0.8,  wave: 0, amp: 0.62; sleep 1
            use_synth :bass_foundation
            play :g2,  cutoff: 72, release: 1.8,  amp: 0.70; sleep 2
            use_synth :tb303
            play :bb2, cutoff: 80, release: 0.85, wave: 0, amp: 0.63; sleep 1
            play :d2,  cutoff: 78, release: 0.8,  wave: 0, amp: 0.60; sleep 1
            use_synth :bass_foundation
            play :c2,  cutoff: 72, release: 1.8,  amp: 0.70; sleep 2
            use_synth :tb303
            play :eb2, cutoff: 80, release: 0.85, wave: 0, amp: 0.63; sleep 1
            play :g2,  cutoff: 78, release: 0.8,  wave: 0, amp: 0.60; sleep 1
            use_synth :bass_foundation
            play :f2,  cutoff: 74, release: 1.5,  amp: 0.68; sleep 2
            use_synth :tb303
            play :a2,  cutoff: 80, release: 0.8,  wave: 0, amp: 0.62; sleep 1
            play :bb1, cutoff: 78, release: 0.9,  wave: 0, amp: 0.65; sleep 1
          end

          # Percussion: fullest feel
          4.times do
            sample :drum_bass_soft, amp: 0.85
            sample :hat_tap, amp: 0.42
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.3
            sleep 0.5
            sample :drum_snare_soft, amp: 0.68
            sample :hat_tap, amp: 0.35
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.26
            sample :drum_snare_soft, amp: 0.2 if one_in(3)
            sleep 0.5
            sample :drum_bass_soft, amp: 0.7
            sample :hat_tap, amp: 0.36
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.24
            sleep 0.5
            sample :drum_snare_soft, amp: 0.65
            sample :hat_tap, amp: 0.32
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.22
            sample :drum_snare_soft, amp: 0.22 if one_in(3)
            sleep 0.5
          end
        end
      end
    end

    # ── Outro: gentle fade — all elements ──
    in_thread do
      use_synth :rhodey
      play 34, cutoff: 80, release: 12, amp: 0.3
      use_synth :piano
      play_chord chord(:bb2, :major7), release: 10, amp: 0.2, cutoff: 80
    end
    in_thread do
      use_synth :hollow
      play_chord chord(:bb2, :major7), release: 12, cutoff: 80, amp: 0.4
      use_synth :fm
      play_chord chord(:bb3, :major7), release: 10, cutoff: 82, amp: 0.3
    end
    in_thread do
      use_synth :bass_foundation
      play :bb1, cutoff: 65, release: 12, amp: 0.6
    end
    # Outro percussion — 2 bars fading
    2.times do
      sample :drum_bass_soft, amp: 0.5
      sample :hat_tap, amp: 0.25
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.18
      sleep 0.5
      sample :drum_snare_soft, amp: 0.42
      sample :hat_tap, amp: 0.2
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.15
      sleep 0.5
      sample :drum_bass_soft, amp: 0.42
      sample :hat_tap, amp: 0.18
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.14
      sleep 0.5
      sample :drum_snare_soft, amp: 0.38
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.12
      sleep 0.5
    end

  end
end