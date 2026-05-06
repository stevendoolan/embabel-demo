# Feed the Birds (EDM Remix)
# Style: House | Mood: Uplifting Euphoric

use_debug false
use_bpm 128

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ============================================================
    # SECTION 1: Intro — Key of D
    # Melody: supersaw lead | Harmony: hollow pads + rhodey arps
    # Bass: subpulse root pump | Percussion: four-on-the-floor
    # ============================================================
    d_melody_notes = (ring :d4, :d4, :fs4, :e4, :d4, :fs4, :a4, :a4)
    d_harm_chords  = (ring chord(:d3, :major), chord(:b2, :minor), chord(:g2, :major), chord(:a2, :major))
    cutoff_sweep_1 = (line 72, 108, steps: 8)
    section1_roots = (ring :d2, :d2, :g2, :a2)
    section1_sub   = (ring :d1, :d1, :g1, :a1)

    2.times do
      # --- Drone foundation ---
      use_synth :supersaw
      play :d2, release: 16, cutoff: 78, amp: 0.55

      # --- Harmony: hollow pad chord ---
      with_fx :reverb, room: 0.28, mix: 0.3 do
        use_synth :hollow
        play_chord d_harm_chords.tick, cutoff: cutoff_sweep_1.tick, release: 7.8, amp: 0.65
      end

      # --- Bass: sustained sub drone ---
      use_synth :bass_foundation
      play :d1, cutoff: 65, release: 8, amp: 0.85

      # --- 8 bars of combined melody + harmony arps + percussion + bass ---
      with_fx :lpf, cutoff: 82, mix: 1.0 do
        4.times do
          # Harmony rhodey arp upper voice
          use_synth :rhodey
          play d_harm_chords.look.first + 12, cutoff: 90, release: 0.55, amp: 0.5

          # Bass beat 1 pump
          use_synth :subpulse
          play section1_roots.tick, cutoff: 78, release: 0.7, amp: 1.0

          # Percussion beat 1
          sample :bd_haus, amp: 1.5
          sample :hat_cab, amp: 0.7

          # Melody bar 1
          use_synth :supersaw
          play :d4, release: 0.4, cutoff: 95, amp: 1.8
          sleep 0.5
          sample :hat_cab, amp: 0.5
          sleep 0.5

          # Bar 2 percuss
          sample :bd_haus, amp: 1.2
          sample :drum_snare_hard, amp: 1.1
          sample :hat_cab, amp: 0.65

          # Bass beat 2
          use_synth :subpulse
          play section1_roots.look, cutoff: 70, release: 0.4, amp: 0.78

          # Melody bar 2 phrase
          use_synth :supersaw
          play :d4, release: 0.2, cutoff: 90, amp: 1.7
          sleep 0.5
          sample :hat_cab, amp: 0.5
          use_synth :supersaw
          play :e4, release: 0.2, cutoff: 95, amp: 1.8
          sleep 0.5

          # Bar 3 — beat 3
          sample :bd_haus, amp: 1.4
          sample :hat_cab, amp: 0.65

          # Bass beat 3
          use_synth :subpulse
          play section1_roots.look, cutoff: 78, release: 0.7, amp: 1.0

          # Harmony rhodey
          use_synth :rhodey
          play d_harm_chords.look.first + 16, cutoff: 88, release: 0.45, amp: 0.45

          use_synth :supersaw
          play :d4, release: 0.3, cutoff: 88, amp: 1.7
          sleep 0.5
          sample :hat_cab, amp: 0.5
          use_synth :supersaw
          play :fs4, release: 0.5, cutoff: 100, amp: 1.9
          sleep 0.5

          # Beat 4 — kick + snare
          sample :bd_haus, amp: 1.2
          sample :drum_snare_hard, amp: 1.1
          sample :hat_cab, amp: 0.65

          # Bass beat 4 sub drop
          use_synth :subpulse
          play section1_sub.look, cutoff: 65, release: 0.5, amp: 0.85

          use_synth :supersaw
          play :a4, release: 0.8, cutoff: 100, amp: 1.9
          sleep 0.5
          sample :elec_snare, amp: 0.7 if one_in(3)
          sample :hat_cab, amp: 0.5
          sleep 0.5
        end
      end
    end

    # ============================================================
    # TRANSITION: D -> F (drone bridge)
    # ============================================================
    use_synth :blade
    play :d3, cutoff: 88, release: 8, amp: 1.0
    use_synth :supersaw
    play :f2, cutoff: 82, release: 8, amp: 0.8
    use_synth :bass_foundation
    play :f1, cutoff: 68, release: 8, amp: 0.9
    sample :bd_haus, amp: 1.4
    sample :hat_zild, amp: 0.6
    sleep 0.5
    sample :hat_zild, amp: 0.4
    sleep 0.5
    sample :bd_haus, amp: 1.2
    sample :drum_snare_hard, amp: 1.0
    sample :hat_zild, amp: 0.6
    sleep 0.5
    sample :hat_zild, amp: 0.4
    sleep 0.5
    sample :bd_haus, amp: 1.4
    sample :hat_zild, amp: 0.6
    sleep 0.5
    sample :hat_zild, amp: 0.4
    sleep 0.5
    sample :bd_haus, amp: 1.2
    sample :drum_snare_hard, amp: 1.0
    sample :elec_snare, amp: 0.9
    sample :hat_zild, amp: 0.6
    sleep 0.5
    sample :hat_zild, amp: 0.4
    sleep 0.5

    # ============================================================
    # SECTION 2: Build — Key of F
    # Melody: chiplead | Harmony: hollow + rhodey arps w/ echo
    # Bass: tb303 pulse | Percussion: dense hats + zild
    # ============================================================
    f_harm_chords  = (ring chord(:f3, :major), chord(:d3, :minor), chord(:as2, :major), chord(:c3, :major))
    cutoff_sweep_2 = (line 80, 115, steps: 8)
    section2_roots = (ring :f2, :f2, :as2, :c3)
    section2_sub   = (ring :f1, :f1, :as1, :c2)

    2.times do
      # --- Drone foundation F ---
      use_synth :blade
      play :f2, release: 16, cutoff: 82, amp: 0.6

      # --- Harmony pad ---
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        with_fx :lpf, cutoff: 108, mix: 1.0 do
          use_synth :hollow
          play_chord f_harm_chords.tick, cutoff: cutoff_sweep_2.tick, release: 7.6, amp: 0.65
        end
      end

      # --- Bass sustained sub ---
      use_synth :bass_foundation
      play :f1, cutoff: 68, release: 8, amp: 0.85

      # --- 8 bars combined ---
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
        4.times do
          # Harmony rhodey upper arp
          use_synth :rhodey
          play f_harm_chords.look.first + 12, cutoff: 95, release: 0.55, amp: 0.48

          # Bass beat 1 pump
          use_synth :tb303
          play section2_roots.tick, cutoff: 80, release: 0.6, amp: 0.95, wave: 0

          # Percussion beat 1
          sample (ring :bd_haus, :bd_fat).tick, amp: 1.5
          sample :hat_zild, amp: 0.75

          # Melody beat 1
          use_synth :chiplead
          play :f4, release: 0.4, cutoff: 100, amp: 1.9
          sleep 0.25
          sample :hat_cab, amp: 0.5
          sleep 0.25
          sample :hat_zild, amp: 0.6
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.5
          sleep 0.25

          # Beat 2 — kick + snare
          sample :bd_haus, amp: 1.2
          sample :drum_snare_hard, amp: 1.2
          sample :hat_zild, amp: 0.75

          use_synth :tb303
          play section2_roots.look, cutoff: 72, release: 0.3, amp: 0.75, wave: 0

          use_synth :rhodey
          play f_harm_chords.look.first + 16, cutoff: 92, release: 0.45, amp: 0.45

          use_synth :chiplead
          play :f4, release: 0.2, cutoff: 95, amp: 1.8
          sleep 0.25
          sample :hat_cab, amp: 0.5
          sleep 0.25
          sample :drum_cymbal_open, amp: 0.55
          sample :hat_zild, amp: 0.5
          sleep 0.25
          use_synth :chiplead
          play :g4, release: 0.2, cutoff: 100, amp: 1.8
          sleep 0.25

          # Beat 3 — kick + zild
          sample :bd_haus, amp: 1.4
          sample :hat_zild, amp: 0.75

          use_synth :tb303
          play section2_roots.look, cutoff: 80, release: 0.6, amp: 0.95, wave: 0

          use_synth :chiplead
          play :f4, release: 0.3, cutoff: 92, amp: 1.8
          sleep 0.25
          sample :hat_cab, amp: 0.5
          sleep 0.25
          sample :hat_zild, amp: 0.6
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.5
          sleep 0.25

          # Beat 4 — kick + snare + fill
          sample :bd_haus, amp: 1.2
          sample :drum_snare_hard, amp: 1.2
          sample :elec_snare, amp: 0.85 if one_in(2)
          sample :hat_zild, amp: 0.75

          use_synth :tb303
          play section2_sub.look, cutoff: 65, release: 0.55, amp: 0.85, wave: 0

          use_synth :chiplead
          play :a4, release: 0.5, cutoff: 105, amp: 2.0
          sleep 0.25
          sample :hat_cab, amp: 0.5
          sleep 0.25
          sample :hat_zild, amp: 0.6
          sample :drum_cymbal_open, amp: 0.5 if one_in(3)
          sleep 0.25
          use_synth :chiplead
          play :c5, release: 0.8, cutoff: 108, amp: 1.9
          sleep 0.25
        end
      end
    end

    # ============================================================
    # TRANSITION: Uplifting drone into drop
    # ============================================================
    use_synth :blade
    play :f2, cutoff: 90, release: 8, amp: 1.0
    use_synth :supersaw
    play :f3, cutoff: 85, release: 8, amp: 0.85
    use_synth :bass_foundation
    play :f1, cutoff: 70, release: 8, amp: 1.0
    4.times do
      sample :bd_haus, amp: 1.5
      sample :hat_zild, amp: 0.65
      sleep 0.25
      sample :elec_snare, amp: 0.85
      sample :hat_cab, amp: 0.5
      sleep 0.25
      sample :drum_snare_hard, amp: 1.0
      sample :hat_zild, amp: 0.6
      sleep 0.25
      sample :elec_snare, amp: 0.95
      sample :hat_cab, amp: 0.5
      sleep 0.25
    end

    # ============================================================
    # SECTION 3: Drop — Key of F, full euphoric climax
    # Melody: supersaw lead | Harmony: supersaw + hollow chords
    # Bass: subpulse + tb303 sixteenth pump | Percussion: max energy
    # ============================================================
    drop_melody = (ring :f4, :a4, :c5, :a4, :f4, :g4, :as4, :c5,
                        :d5, :c5, :as4, :g4, :f4, :a4, :c5, :f5)
    drop_harm_chords = (ring chord(:f3, :major), chord(:f3, :major),
                             chord(:d3, :minor), chord(:d3, :minor),
                             chord(:as2, :major), chord(:as2, :major),
                             chord(:c3, :major), chord(:c3, :major))
    cutoff_drop  = (line 88, 120, steps: 16)
    drop_bass    = (ring :f2, :f2, :c3, :as2, :f2, :g2, :as2, :c3,
                         :d3, :c3, :as2, :g2, :f2, :a2, :c3, :f3)
    drop_sub     = (ring :f1, :f1, :c2, :as1)

    2.times do
      # --- Deep euphoric drone ---
      use_synth :blade
      play :f2, release: 16, cutoff: 92, amp: 0.65

      use_synth :supersaw
      play :f1, release: 16, cutoff: 85, amp: 0.55

      # --- Bass drop sub drone ---
      use_synth :bass_foundation
      play :f1, cutoff: 72, release: 8, amp: 1.0

      with_fx :reverb, room: 0.28, mix: 0.28 do
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          8.times do |i|
            # Harmony chord swell
            use_synth :supersaw
            play_chord drop_harm_chords.tick, cutoff: cutoff_drop.tick, release: 1.9, amp: 0.68
            use_synth :hollow
            play_chord drop_harm_chords.look, cutoff: (cutoff_drop.look + 10).clamp(80, 128), release: 1.8, amp: 0.42
            use_synth :rhodey
            play drop_harm_chords.look.first + 24, cutoff: 105, release: 0.28, amp: 0.5

            # Percussion beat 1 — fat double kick
            sample :bd_fat, amp: 1.7
            sample :bd_haus, amp: 1.3
            sample :hat_zild, amp: 0.85

            # Bass beat 1 pump
            use_synth :subpulse
            play drop_bass.tick, cutoff: 82, release: 0.65, amp: 1.1

            # Melody beat 1
            with_fx :reverb, room: 0.22, mix: 0.22 do
              use_synth :supersaw
              play drop_melody[i * 2], release: 0.4, cutoff: cutoff_drop.look, amp: 1.9
            end
            sleep 0.25
            sample :hat_cab, amp: 0.6
            sleep 0.25
            sample :hat_zild, amp: 0.65
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.55
            sleep 0.25

            # Beat 2 — kick + snare
            sample :bd_haus, amp: 1.3
            sample :drum_snare_hard, amp: 1.4
            sample :hat_zild, amp: 0.85

            use_synth :subpulse
            play drop_sub.tick, cutoff: 70, release: 0.6, amp: 0.95

            with_fx :reverb, room: 0.22, mix: 0.22 do
              use_synth :supersaw
              play drop_melody[(i * 2 + 1) % 16], release: 0.4, cutoff: 105, amp: 1.85
            end
            sleep 0.25
            sample :drum_cymbal_open, amp: 0.65
            sample :hat_cab, amp: 0.55
            sleep 0.25
            sample :hat_zild, amp: 0.6
            sleep 0.25
            sample :hat_cab, amp: 0.5
            sample :elec_snare, amp: 0.95 if one_in(2)
            sleep 0.25
          end
        end
      end
    end

  end
end