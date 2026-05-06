```ruby
# Digital Baroque
# Style: Electronic Baroque | Mood: Dynamic, Evolving
# Key: Dm -> Em | BPM: 116

use_debug false
use_bpm 116

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ============================================================
    # SECTION 1: Dm Opening — formal baroque groove, light pads
    # Melody: fm lead | Harmony: hollow + supersaw | Bass: bass_foundation + subpulse | Perc: tight hats
    # ============================================================

    dm_melody      = (ring :d4, :f4, :a4, :c5, :a4, :f4, :e4, :d4)
    dm_bass_ring   = (ring :d3, :a3, :f3, :c3)
    dm_chords      = (ring chord(:d3, :minor), chord(:a3, :minor), chord(:bb3, :major), chord(:f3, :major))
    dm_bass_roots  = (ring :d2, :a2, :f2, :c2)

    2.times do
      # --- Drones: melody blade + harmony hollow + bass foundation ---
      use_synth :blade
      play :d3, release: 8, cutoff: 85, amp: 0.35

      use_synth :hollow
      play_chord chord(:d3, :minor), cutoff: 88, release: 16, amp: 0.5

      use_synth :bass_foundation
      play :d2, cutoff: 68, release: 8, amp: 0.75

      # --- Harmony: supersaw shimmer ---
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          with_fx :lpf, cutoff: 95, mix: 1.0 do
            use_synth :supersaw
            4.times do
              play_chord dm_chords.tick, cutoff: (line 82, 100, steps: 4).tick, release: 2.0, amp: 0.38
              sleep 2
            end
          end
        end
      end

      # --- Bass: subpulse basso continuo ---
      in_thread do
        use_synth :subpulse
        8.times do |i|
          play dm_bass_roots.tick, cutoff: 72, release: 0.6, amp: i == 0 ? 0.78 : 0.6, pulse_width: 0.3
          sleep 1
        end
      end

      # --- Percussion: tight formal groove ---
      in_thread do
        with_fx :hpf, cutoff: 95, mix: 1.0 do
          8.times do |i|
            sample :bd_klub, amp: (i % 8 == 0) ? 0.85 : 0.65
            sample :hat_cab, amp: 0.32
            sleep 0.5
            sample :hat_cab, amp: 0.22
            sleep 0.5
            sample :drum_snare_hard, amp: 0.6
            sample :hat_cab, amp: 0.28
            sleep 0.5
            sample :hat_cab, amp: 0.2
            sample :drum_cymbal_closed, amp: 0.25 if one_in(3)
            sleep 0.5
            sample :bd_klub, amp: 0.65
            sample :hat_cab, amp: 0.30
            sleep 0.5
            sample :hat_cab, amp: 0.18
            sleep 0.5
            sample :drum_snare_hard, amp: 0.58
            sample :hat_cab, amp: 0.26
            sleep 0.5
            sample :elec_snare, amp: 0.22 if one_in(4)
            sample :hat_cab, amp: 0.18
            sleep 0.5
          end
        end
      end

      # --- Melody: fm lead (runs 16 eighth notes = 2 bars) ---
      with_fx :reverb, room: 0.25, mix: 0.28 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          use_synth :chiplead
          play dm_bass_ring.tick, release: 0.4, cutoff: 90, amp: 0.45

          use_synth :fm
          16.times do
            play dm_melody.tick, release: 0.12, divisor: 2, depth: 4,
                 cutoff: rrand(88, 112), amp: 0.95
            sleep 0.5
          end
        end
      end
    end

    # ============================================================
    # TRANSITION 1: Dm -> Dm developed drone bridge
    # ============================================================
    use_synth :blade
    play :f3, cutoff: 90, release: 8, amp: 0.5
    use_synth :dark_ambience
    play :d2, cutoff: 85, release: 8, amp: 0.45
    sleep 4

    # ============================================================
    # SECTION 2: Dm Developed — urgency builds, chiplead takes lead
    # Melody: chiplead run | Harmony: dark_ambience + hollow swells | Bass: tb303 walk | Perc: urgent hats
    # ============================================================

    dm_run         = (ring :d4, :e4, :f4, :a4, :c5, :a4, :g4, :f4)
    dm_prog2       = (ring chord(:d3, :minor), chord(:g3, :minor), chord(:a3, :minor7), chord(:d3, :minor))
    dm_walk        = (ring :d2, :f2, :a2, :c3, :a2, :g2, :f2, :e2)

    2.times do
      # --- Drones: blade + dark_ambience + bass foundation ---
      use_synth :blade
      play :f3, release: 8, cutoff: 88, amp: 0.3

      use_synth :dark_ambience
      play :d2, cutoff: 85, release: 16, amp: 0.45

      use_synth :bass_foundation
      play :f2, cutoff: 65, release: 8, amp: 0.7

      # --- Harmony: hollow slow chord swells ---
      in_thread do
        use_synth :hollow
        4.times do
          play_chord dm_prog2.tick, cutoff: (line 84, 105, steps: 4).tick, release: 2.2, amp: 0.42
          sleep 2
        end
      end

      # --- Bass: tb303 walking line with filter sweep ---
      in_thread do
        with_fx :lpf, cutoff: 82, mix: 1.0 do
          use_synth :tb303
          16.times do |i|
            play dm_walk.tick,
                 cutoff: (line 62, 85, steps: 16).tick,
                 release: 0.45,
                 res: 0.85,
                 wave: 0,
                 amp: i == 0 ? 0.78 : 0.62
            sleep 0.5
          end
        end
      end

      # --- Percussion: urgency builds, elec_snare fills ---
      in_thread do
        8.times do |i|
          sample :bd_klub, amp: (i % 8 == 0) ? 0.88 : 0.7
          sample :hat_tap, amp: 0.38
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.28
          sample :hat_tap, amp: 0.22
          sleep 0.5
          sample :drum_snare_hard, amp: 0.72
          sample :hat_tap, amp: 0.32
          sleep 0.5
          sample :elec_snare, amp: 0.35
          sample :hat_tap, amp: 0.2
          sleep 0.5
          sample :bd_klub, amp: 0.68
          sample :hat_tap, amp: 0.35
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.22
          sample :hat_tap, amp: 0.18
          sleep 0.5
          sample :drum_snare_hard, amp: 0.65
          sample :elec_snare, amp: 0.28 if one_in(3)
          sample :hat_tap, amp: 0.30
          sleep 0.5
          sample :elec_snare, amp: 0.32 if one_in(2)
          sample :hat_tap, amp: 0.16
          sleep 0.5
        end
      end

      # --- Melody: chiplead run ---
      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        use_synth :chiplead
        play :d4, release: 0.08, cutoff: 95, amp: 0.5

        use_synth :chiplead
        16.times do
          play dm_run.tick, release: 0.1, cutoff: (line 90, 118, steps: 16).tick, amp: 0.95
          sleep 0.5
        end
      end
    end

    # ============================================================
    # TRANSITION 2: Dm -> Em drone bridge
    # ============================================================
    use_synth :blade
    play :e3, cutoff: 90, release: 8, amp: 0.5
    use_synth :dark_ambience
    play :e2, cutoff: 88, release: 8, amp: 0.5
    use_synth :hollow
    play_chord chord(:e3, :minor), cutoff: 90, release: 8, amp: 0.45
    use_synth :bass_foundation
    play :e2, cutoff: 70, release: 8, amp: 0.7

    with_fx :reverb, room: 0.25, mix: 0.22 do
      sample :drum_snare_hard, amp: 0.5
      sleep 1
      sample :elec_snare, amp: 0.35
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.3
      sleep 0.5
      sample :drum_snare_hard, amp: 0.55
      sleep 1
      sample :elec_snare, amp: 0.3
      sleep 0.25
      sample :elec_snare, amp: 0.22
      sleep 0.25
      sample :hat_cab, amp: 0.28
      sleep 0.5
    end

    # ============================================================
    # SECTION 3: Em Key Change — peak energy, soaring blade lead
    # Melody: blade lead | Harmony: dark_ambience + hollow + supersaw | Bass: subpulse Em | Perc: full hybrid
    # ============================================================

    em_melody      = (ring :e4, :fs4, :g4, :b4, :a4, :g4, :fs4, :e4)
    em_bass_ring   = (ring :e3, :b3, :g3, :d3)
    em_chords      = (ring chord(:e3, :minor), chord(:a3, :minor), chord(:b3, :minor), chord(:e3, :minor))
    em_bass_roots  = (ring :e2, :b2, :g2, :d2)

    2.times do
      # --- Drones: fm + dark_ambience + hollow Em + bass foundation ---
      use_synth :fm
      play :e3, release: 8, divisor: 3, depth: 6, cutoff: 90, amp: 0.38

      use_synth :dark_ambience
      play :e2, cutoff: 90, release: 16, amp: 0.48

      use_synth :hollow
      play_chord chord(:e3, :minor), cutoff: 92, release: 16, amp: 0.5

      use_synth :bass_foundation
      play :e2, cutoff: 70, release: 8, amp: 0.75

      # --- Harmony: supersaw Em progression ---
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.38 do
          with_fx :lpf, cutoff: 100, mix: 1.0 do
            use_synth :supersaw
            4.times do
              play_chord em_chords.tick, cutoff: (line 85, 108, steps: 4).tick, release: 2.1, amp: 0.35
              sleep 2
            end
          end
        end
      end

      # --- Bass: subpulse articulated Em walking ---
      in_thread do
        use_synth :subpulse
        8.times do |i|
          play em_bass_roots.tick,
               cutoff: rrand(68, 84),
               release: 0.55,
               pulse_width: 0.28,
               amp: i == 0 ? 0.78 : 0.6
          sleep 1
        end
      end

      # --- Percussion: full hybrid groove, peak energy ---
      in_thread do
        with_fx :hpf, cutoff: 95, mix: 1.0 do
          8.times do |i|
            sample :bd_klub, amp: (i % 8 == 0) ? 0.9 : 0.72
            sample :hat_cab, amp: 0.40
            sleep 0.5
            sample :hat_tap, amp: 0.28
            sample :drum_cymbal_closed, amp: 0.24
            sleep 0.5
            sample :drum_snare_hard, amp: 0.75
            sample :hat_cab, amp: 0.35
            sleep 0.5
            sample :elec_snare, amp: 0.40
            sample :hat_tap, amp: 0.22
            sleep 0.5
            sample :bd_klub, amp: 0.70
            sample :hat_cab, amp: 0.36
            sleep 0.5
            sample :drum_cymbal_closed, amp: 0.30
            sample :hat_tap, amp: 0.20
            sleep 0.5
            sample :drum_snare_hard, amp: 0.70
            sample :elec_snare, amp: 0.38
            sample :hat_cab, amp: 0.32
            sleep 0.5
            sample :elec_snare, amp: 0.30 if one_in(2)
            sample :hat_tap, amp: 0.18
            sleep 0.5
          end
        end
      end

      # --- Melody: blade soaring lead in Em ---
      with_fx :reverb, room: 0.3, mix: 0.3 do
        with_fx :lpf, cutoff: 112, mix: 1.0 do
          use_synth :chiplead
          play em_bass_ring.tick, release: 0.35, cutoff: 88, amp: 0.45

          use_synth :blade
          16.times do
            play em_melody.tick, release: 0.14, cutoff: rrand(92, 120), amp: 0.95
            sleep 0.5
          end
        end
      end
    end

    # ============================================================
    # OUTRO: Fade — Em drones decay to silence
    # ============================================================
    use_synth :blade
    play :e3, cutoff: 80, release: 6, amp: 0.4
    use_synth :hollow
    play_chord chord(:e3, :minor), cutoff: 82, release: 8, amp: 0.4
    use_synth :dark_ambience
    play :e2, cutoff: 80, release: 8, amp: 0.38
    use_synth :bass_foundation
    play :e2, cutoff: 62, release: 6, amp: 0.6

    sample :drum_snare_hard, amp: 0.45
    sleep 1
    sample :elec_snare, amp: 0.28
    sleep 0.5
    sample :hat_cab, amp: 0.22
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.20
    sleep 1
    sample :elec_snare, amp: 0.18
    sleep 0.5
    sample :hat_tap, amp: 0.14
    sleep 0.5

  end
end
```