# Feed the Birds EDM Remix
# Style: House | Key: D -> F | Mood: Uplifting

use_debug false
use_bpm 128

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =====================================================================
    # SECTION 1: Intro / Verse in D major (8 bars x2)
    # Melody: supersaw | Harmony: blade pad + rhodey stabs + dsaw arp
    # Bass: bass_foundation drone + tb303 pulse | Perc: four-on-the-floor
    # =====================================================================
    2.times do

      # --- Drones ---
      use_synth :supersaw
      play :d3, release: 16, cutoff: 85, amp: 0.5
      use_synth :blade
      play_chord chord(:d3, :major), cutoff: 88, release: 16, amp: 0.75
      use_synth :bass_foundation
      play :d1, cutoff: 65, release: 16, amp: 1.1

      # --- Percussion ---
      in_thread do
        8.times do
          sample :drum_heavy_kick, amp: 1.4
          sample :drum_cymbal_closed, amp: 0.8
          sleep 0.25
          sample :hat_cab, amp: 0.55
          sleep 0.25
          sample :drum_snare_hard, amp: 1.2
          sample :elec_snare, amp: 0.7
          sample :drum_cymbal_closed, amp: 0.7
          sleep 0.25
          sample :hat_cab, amp: 0.5
          sleep 0.25
          sample :drum_heavy_kick, amp: 1.3
          sample :drum_cymbal_closed, amp: 0.75
          sleep 0.25
          sample :hat_cab, amp: 0.5
          sleep 0.25
          sample :drum_snare_hard, amp: 1.1
          sample :elec_snare, amp: 0.65
          sample :drum_cymbal_open, amp: 0.6 if one_in(3)
          sample :drum_cymbal_closed, amp: 0.7
          sleep 0.25
          sample :hat_cab, amp: 0.45
          sleep 0.25
        end
      end

      # --- Bass: tb303 pulse ---
      in_thread do
        with_fx :lpf, cutoff: 80, mix: 1.0 do
          use_synth :tb303
          bass_d = (ring :d2, :d2, :a2, :a2, :g2, :g2, :fs2, :fs2)
          8.times do
            play bass_d.tick, cutoff: 72, release: 0.55, wave: 0, amp: 1.05
            sleep 0.5
            play bass_d.look, cutoff: 65, release: 0.3, wave: 0, amp: 0.8
            sleep 0.5
          end
        end
      end

      # --- Harmony: rhodey stabs ---
      in_thread do
        chords_d = (ring chord(:d4, :major), chord(:g4, :major), chord(:a4, :major), chord(:g4, :major))
        use_synth :rhodey
        with_fx :reverb, room: 0.25, mix: 0.3 do
          8.times do
            play_chord chords_d.tick, cutoff: 95, release: 0.35, amp: 0.85
            sleep 1
          end
        end
      end

      # --- Harmony: dsaw arp ---
      in_thread do
        arp_d = (ring :d4, :fs4, :a4, :d5, :a4, :fs4, :g4, :a4,
                      :b4, :a4, :fs4, :d4, :e4, :fs4, :a4, :fs4)
        use_synth :dsaw
        16.times do
          play arp_d.tick, cutoff: (line 80, 105, steps: 16).look, release: 0.18, amp: 0.9
          sleep 0.5
        end
      end

      # --- Melody: supersaw "Feed the Birds" motif ---
      melody_d = (ring :d4, :fs4, :a4, :d5, :cs5, :b4, :a4, :fs4,
                       :g4, :a4, :b4, :d5, :e5, :d5, :cs5, :a4)
      with_fx :reverb, room: 0.25, mix: 0.28 do
        use_synth :supersaw
        16.times do
          play melody_d.tick, cutoff: (line 85, 110, steps: 16).tick, release: 0.22, amp: 1.8
          sleep 0.5
        end
      end

      sleep 8
    end

    # =====================================================================
    # TRANSITION: D -> F bridge drone
    # =====================================================================
    use_synth :winwood_lead
    play :d4, cutoff: 90, release: 8, amp: 1.2
    use_synth :supersaw
    play :d3, cutoff: 80, release: 8, amp: 0.5
    use_synth :blade
    play :d3, cutoff: 88, release: 8, amp: 0.8
    use_synth :bass_foundation
    play :d1, cutoff: 68, release: 8, amp: 1.0
    with_fx :hpf, cutoff: 100, mix: 1.0 do
      4.times do
        sample :drum_heavy_kick, amp: 1.4
        sample :hat_zild, amp: 0.7
        sleep 0.5
        sample :elec_snare, amp: 0.9
        sample :hat_zild, amp: 0.6
        sleep 0.5
      end
    end

    # =====================================================================
    # SECTION 2: Build / Chorus in D major (8 bars x2)
    # Melody: winwood_lead | Harmony: blade + rhodey + dsaw with echo
    # Bass: subpulse drone + tb303 | Perc: 16th-note hat drive
    # =====================================================================
    2.times do

      # --- Drones ---
      use_synth :supersaw
      play :d3, release: 16, cutoff: 90, amp: 0.5
      use_synth :blade
      play_chord chord(:d3, :major7), cutoff: 92, release: 16, amp: 0.78
      use_synth :subpulse
      play :d1, cutoff: 68, release: 16, amp: 1.0

      # --- Percussion ---
      in_thread do
        8.times do
          sample :drum_heavy_kick, amp: 1.6
          sample :hat_zild, amp: 0.8
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.65
          sleep 0.25
          sample :drum_snare_hard, amp: 1.3
          sample :elec_snare, amp: 0.85
          sample :hat_zild, amp: 0.75
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.6
          sleep 0.25
          sample :drum_heavy_kick, amp: 1.45
          sample :hat_zild, amp: 0.75
          sample :elec_cymbal, amp: 0.55 if one_in(4)
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.6
          sleep 0.25
          sample :drum_snare_hard, amp: 1.25
          sample :elec_snare, amp: 0.8
          sample :drum_cymbal_open, amp: 0.7
          sleep 0.25
          sample :hat_zild, amp: 0.65
          sleep 0.25
        end
      end

      # --- Bass: tb303 energetic ---
      in_thread do
        use_synth :tb303
        bass_d2 = (ring :d2, :a2, :g2, :a2, :d2, :g2, :fs2, :a2)
        8.times do
          play bass_d2.tick, cutoff: 75, release: 0.6, wave: 0, amp: 1.1
          sleep 0.5
          if one_in(4)
            play bass_d2.look + 12, cutoff: 70, release: 0.2, wave: 0, amp: 0.75
          end
          sleep 0.5
        end
      end

      # --- Harmony: rhodey stabs ---
      in_thread do
        chords_d2 = (ring chord(:d4, :major), chord(:g4, :major), chord(:a4, :major), chord(:b4, :minor))
        use_synth :rhodey
        8.times do
          play_chord chords_d2.tick, cutoff: (line 90, 115, steps: 8).look, release: 0.4, amp: 0.88
          sleep 1
        end
      end

      # --- Harmony: dsaw arp with echo ---
      in_thread do
        arp_d2 = (ring :d5, :fs5, :a5, :d5, :e5, :d5, :b4, :a4,
                       :g4, :b4, :d5, :e5, :fs5, :e5, :d5, :a4)
        use_synth :dsaw
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.22 do
          16.times do
            play arp_d2.tick, cutoff: (line 90, 118, steps: 16).look, release: 0.15, amp: 0.85
            sleep 0.5
          end
        end
      end

      # --- Melody: chiplead sparkle layer ---
      in_thread do
        sparkle_d = (ring :d5, :fs5, :a5, :d6, :cs6, :b5, :a5, :fs5,
                          :g5, :a5, :b5, :d6, :e6, :d6, :cs6, :a5)
        use_synth :chiplead
        16.times do
          play sparkle_d.tick, cutoff: rrand(90, 115), release: 0.12, amp: 1.2
          sleep 0.5
        end
      end

      # --- Melody: winwood_lead chorus ---
      with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
        use_synth :winwood_lead
        chorus_d = (ring :d4, :fs4, :a4, :d5, :e5, :d5, :b4, :a4,
                         :g4, :b4, :d5, :e5, :fs5, :e5, :d5, :a4)
        16.times do
          play chorus_d.tick, cutoff: (line 90, 120, steps: 16).tick, release: 0.2, amp: 1.9
          sleep 0.5
        end
      end

      sleep 8
    end

    # =====================================================================
    # TRANSITION: Key change D -> F
    # =====================================================================
    use_synth :supersaw
    play :f3, cutoff: 90, release: 8, amp: 0.6
    use_synth :winwood_lead
    play :f4, cutoff: 95, release: 8, amp: 1.2
    use_synth :blade
    play :f3, cutoff: 90, release: 8, amp: 0.8
    use_synth :bass_foundation
    play :f1, cutoff: 70, release: 8, amp: 1.1
    use_synth :subpulse
    play :f2, cutoff: 65, release: 8, amp: 0.85
    4.times do
      sample :drum_heavy_kick, amp: 1.5
      sample :hat_zild, amp: 0.8
      sleep 0.25
      sample :elec_snare, amp: 1.0
      sample :hat_cab, amp: 0.6
      sleep 0.25
      sample :drum_heavy_kick, amp: 1.3
      sample :hat_zild, amp: 0.7
      sleep 0.25
      sample :drum_snare_hard, amp: 1.1
      sample :drum_cymbal_open, amp: 0.8
      sleep 0.25
    end

    # =====================================================================
    # SECTION 3: Key Change to F major — Anthem Drop (8 bars x2)
    # Melody: winwood_lead + chiplead | Harmony: blade + rhodey + dsaw
    # Bass: bass_foundation + tb303 | Perc: full house energy
    # =====================================================================
    2.times do

      # --- Drones ---
      use_synth :supersaw
      play :f3, release: 16, cutoff: 88, amp: 0.55
      use_synth :blade
      play_chord chord(:f3, :major), cutoff: 90, release: 16, amp: 0.82
      use_synth :bass_foundation
      play :f1, cutoff: 68, release: 16, amp: 1.15

      # --- Percussion ---
      in_thread do
        with_fx :hpf, cutoff: 90, mix: 1.0 do
          8.times do
            sample :drum_heavy_kick, amp: 1.7
            sample :hat_zild, amp: 0.9
            sleep 0.25
            sample :hat_cab, amp: 0.7
            sleep 0.25
            sample :drum_snare_hard, amp: 1.4
            sample :elec_snare, amp: 1.0
            sample :hat_zild, amp: 0.8
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.65
            sleep 0.25
            sample :drum_heavy_kick, amp: 1.55
            sample :elec_cymbal, amp: 0.7
            sample :hat_zild, amp: 0.8
            sleep 0.25
            sample :hat_cab, amp: 0.65
            sleep 0.25
            sample :drum_snare_hard, amp: 1.35
            sample :elec_snare, amp: 0.9
            sample :drum_cymbal_open, amp: 0.85
            sleep 0.25
            sample :hat_zild, amp: 0.7
            sample :elec_snare, amp: 0.6 if one_in(3)
            sleep 0.25
          end
        end
      end

      # --- Bass: tb303 in F ---
      in_thread do
        with_fx :lpf, cutoff: 82, mix: 1.0 do
          use_synth :tb303
          bass_f = (ring :f2, :f2, :c3, :c3, :bb2, :bb2, :a2, :a2)
          8.times do
            play bass_f.tick, cutoff: 78, release: 0.6, wave: 0, amp: 1.1
            sleep 0.5
            play bass_f.look, cutoff: 68, release: 0.28, wave: 0, amp: 0.82
            sleep 0.5
          end
        end
      end

      # --- Harmony: rhodey stabs in F ---
      in_thread do
        chords_f = (ring chord(:f4, :major), chord(:bb4, :major), chord(:c5, :major), chord(:bb4, :major))
        use_synth :rhodey
        with_fx :lpf, cutoff: 105, mix: 0.9 do
          8.times do
            play_chord chords_f.tick, cutoff: 100, release: 0.38, amp: 0.9
            sleep 1
          end
        end
      end

      # --- Harmony: dsaw arpeggios in F ---
      in_thread do
        arp_f = (ring :f4, :a4, :c5, :f5, :e5, :d5, :c5, :a4,
                      :bb4, :c5, :d5, :f5, :g5, :f5, :e5, :c5)
        use_synth :dsaw
        16.times do
          play arp_f.tick, cutoff: (line 92, 120, steps: 16).look, release: 0.17, amp: 0.88
          sleep 0.5
        end
      end

      # --- Melody: chiplead sparkle in F ---
      in_thread do
        sparkle_f = (ring :f5, :a5, :c6, :f6, :e6, :d6, :c6, :a5,
                          :bb5, :c6, :d6, :f6, :g6, :f6, :e6, :c6)
        use_synth :chiplead
        16.times do
          play sparkle_f.tick, cutoff: rrand(95, 120), release: 0.11, amp: 1.2
          sleep 0.5
        end
      end

      # --- Melody: winwood_lead anthem motif in F ---
      with_fx :lpf, cutoff: 115, mix: 0.9 do
        with_fx :reverb, room: 0.3, mix: 0.3 do
          use_synth :winwood_lead
          anthem_f = (ring :f4, :a4, :c5, :f5, :e5, :d5, :c5, :a4,
                           :bb4, :c5, :d5, :f5, :g5, :f5, :e5, :c5)
          16.times do
            play anthem_f.tick, cutoff: (line 95, 125, steps: 16).tick, release: 0.22, amp: 1.95
            sleep 0.5
          end
        end
      end

      sleep 8
    end

    # =====================================================================
    # TRANSITION: Outro fade
    # =====================================================================
    use_synth :supersaw
    play :f3, cutoff: 85, release: 8, amp: 0.5
    use_synth :winwood_lead
    play :f4, cutoff: 88, release: 8, amp: 1.0
    use_synth :blade
    play :f3, cutoff: 85, release: 8, amp: 0.75
    use_synth :bass_foundation
    play :f1, cutoff: 65, release: 8, amp: 0.95
    4.times do
      sample :drum_heavy_kick, amp: 1.3
      sample :drum_cymbal_closed, amp: 0.65
      sleep 0.5
      sample :drum_snare_hard, amp: 1.1
      sample :drum_cymbal_open, amp: 0.6
      sleep 0.5
    end

    # =====================================================================
    # SECTION 4: Outro Reprise in F — soft, floating (4 bars x2)
    # Melody: winwood_lead | Harmony: blade + rhodey + dsaw
    # Bass: subpulse + bass_foundation | Perc: sparse, gentle
    # =====================================================================
    2.times do

      # --- Drones ---
      use_synth :supersaw
      play :f3, release: 8, cutoff: 82, amp: 0.4
      use_synth :blade
      play_chord chord(:f3, :major), cutoff: 82, release: 8, amp: 0.65
      use_synth :subpulse
      play :f1, cutoff: 62, release: 8, amp: 0.85

      # --- Percussion ---
      in_thread do
        4.times do
          sample :drum_heavy_kick, amp: 1.2
          sample :drum_cymbal_closed, amp: 0.6
          sleep 0.5
          sample :hat_cab, amp: 0.5
          sleep 0.5
          sample :drum_snare_hard, amp: 1.0
          sample :drum_cymbal_closed, amp: 0.55
          sleep 0.5
          sample :hat_cab, amp: 0.45
          sleep 0.5
          sample :drum_heavy_kick, amp: 1.1
          sample :drum_cymbal_closed, amp: 0.55
          sleep 0.5
          sample :hat_cab, amp: 0.4
          sleep 0.5
          sample :drum_snare_hard, amp: 0.9
          sample :drum_cymbal_open, amp: 0.5
          sleep 0.5
          sample :hat_cab, amp: 0.4
          sleep 0.5
        end
      end

      # --- Bass: quarter-note walk ---
      in_thread do
        use_synth :bass_foundation
        outro_bass = (knit :f2, 2, :c3, 1, :bb2, 1)
        4.times do
          play outro_bass.tick, cutoff: 70, release: 0.9, amp: 0.9
          sleep 1
        end
      end

      # --- Harmony: rhodey soft chords ---
      in_thread do
        chords_outro = (ring chord(:f4, :major), chord(:bb4, :major))
        use_synth :rhodey
        with_fx :reverb, room: 0.35, mix: 0.32 do
          4.times do
            play_chord chords_outro.tick, cutoff: (line 90, 80, steps: 4).look, release: 0.45, amp: 0.72
            sleep 1
          end
        end
      end

      # --- Harmony: dsaw gentle arp ---
      in_thread do
        arp_outro = (ring :f4, :a4, :c5, :f5, :e5, :d5, :c5, :a4)
        use_synth :dsaw
        8.times do
          play arp_outro.tick, cutoff: (line 88, 78, steps: 8).look, release: 0.25, amp: 0.78
          sleep 0.5
        end
      end

      # --- Melody: winwood_lead outro ---
      with_fx :reverb, room: 0.3, mix: 0.32 do
        use_synth :winwood_lead
        outro_f = (ring :f4, :a4, :c5, :f5, :e5, :d5, :c5, :a4)
        8.times do
          play outro_f.tick, cutoff: (line 90, 80, steps: 8).tick, release: 0.3, amp: 1.7
          sleep 0.5
        end
      end

      sleep 4
    end

  end
end