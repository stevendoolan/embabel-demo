```ruby
# Electronic Dreams
# Style: Electronic | Mood: Dreamy

use_debug false
use_bpm 120

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ─── Section 1: Dreamy opening in A minor ───
    # Melody: blade lead | Harmony: hollow pads | Bass: bass_foundation + subpulse | Percussion: sparse
    am_melody    = (ring :a4, :c5, :e5, :g4, :a5, :e5, :c5, :a4)
    am_chords    = (ring chord(:a3, :minor), chord(:e3, :minor), chord(:a3, :minor), chord(:g3, :major))
    am_cutoff    = (line 80, 105, steps: 16)
    am_bass_ring = (ring :a1, :a1, :e2, :a1, :c2, :a1, :e2, :g1)
    am_chip      = (ring :a4, :c5, :e5, :a5, :g5, :e5, :c5, :e4)

    2.times do
      # Long drones underneath
      use_synth :dark_ambience
      play :a2, cutoff: 85, release: 16, amp: 0.55

      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 0.75

      # Melody thread
      in_thread do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            use_synth :blade
            16.times do
              play am_melody.tick, cutoff: rrand(85, 110), release: 0.35, amp: 0.95
              sleep 0.5
            end
          end
        end
      end

      # Harmony thread
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          with_fx :lpf, cutoff: 100, mix: 1.0 do
            use_synth :hollow
            8.times do
              play_chord am_chords.tick, cutoff: am_cutoff.tick, release: 2.1, amp: 0.6
              sleep 2
            end
          end
        end
      end

      # Bass thread
      in_thread do
        use_synth :subpulse
        8.times do
          play am_bass_ring.tick, cutoff: 72, release: 0.8, amp: 0.65
          sleep 1
        end
      end

      # Percussion thread
      with_fx :hpf, cutoff: 90, mix: 1.0 do
        8.times do |i|
          sample :bd_pure, amp: (i % 4 == 0) ? 0.85 : 0.65
          sample :hat_zild, amp: 0.25
          sleep 0.5
          sample :hat_zild, amp: 0.18
          sleep 0.5
          sample :elec_snare, amp: 0.55
          sample :hat_zild, amp: 0.22
          sleep 0.5
          sample :hat_zild, amp: 0.18
          sample :elec_ping, amp: 0.18 if one_in(6)
          sleep 0.5
          sample :bd_pure, amp: 0.68
          sample :hat_zild, amp: 0.24
          sleep 0.5
          sample :hat_zild, amp: 0.16
          sleep 0.5
          sample :elec_snare, amp: 0.52
          sample :hat_zild, amp: 0.22
          sleep 0.5
          sample :hat_zild, amp: 0.16
          sleep 0.5
        end
      end
    end

    # ─── Transition: Am -> higher energy Am ───
    use_synth :mod_sine
    play :a2, cutoff: 90, release: 8, amp: 0.6
    sleep 4

    # ─── Section 2: A minor — chiplead energy ───
    # Melody: chiplead arpeggios | Harmony: supersaw pads | Bass: tb303 | Percussion: tighter
    am2_chords = (ring chord(:a3, :minor), chord(:c3, :major), chord(:e3, :minor), chord(:g3, :major))
    am2_cutoff = (line 85, 115, steps: 16)
    am_tb_ring = (ring :a1, :c2, :e2, :a2, :e2, :c2, :a1, :e2)
    cutoff_ramp = (line 80, 120, steps: 32)

    2.times do
      # Long drones underneath
      use_synth :hollow
      play :a2, cutoff: 80, release: 16, amp: 0.5

      use_synth :bass_foundation
      play :a1, cutoff: 62, release: 8, amp: 0.72

      # Melody thread
      in_thread do
        use_synth :chiplead
        16.times do
          beat_amp = (look % 8 == 0) ? 1.0 : 0.85
          play am_chip.tick, cutoff: cutoff_ramp.tick, release: 0.2, amp: beat_amp
          sleep 0.5
        end
      end

      # Harmony thread
      in_thread do
        use_synth :supersaw
        8.times do
          play_chord am2_chords.tick, cutoff: am2_cutoff.tick, release: 2.05, amp: 0.55
          sleep 2
        end
      end

      # Bass thread
      in_thread do
        use_synth :tb303
        8.times do
          play am_tb_ring.tick, cutoff: 80, release: 0.6, wave: 0, amp: 0.6
          sleep 1
        end
      end

      # Percussion thread
      8.times do |i|
        sample :bd_pure, amp: (i % 4 == 0) ? 0.9 : 0.72
        sample :hat_zild, amp: 0.3
        sleep 0.5
        sample :hat_zild, amp: 0.22
        sample :elec_cymbal, amp: 0.18 if one_in(5)
        sleep 0.5
        sample :elec_snare, amp: 0.68
        sample :hat_zild, amp: 0.28
        sleep 0.5
        sample :hat_zild, amp: 0.2
        sleep 0.5
        sample :bd_pure, amp: 0.75
        sample :hat_zild, amp: 0.28
        sleep 0.5
        sample :hat_psych, amp: 0.2 if one_in(4)
        sample :hat_zild, amp: 0.2
        sleep 0.5
        sample :elec_snare, amp: 0.65
        sample :hat_zild, amp: 0.26
        sleep 0.5
        sample :hat_zild, amp: 0.18
        sample :elec_ping, amp: 0.22 if one_in(4)
        sleep 0.5
      end
    end

    # ─── Transition: Am -> Cm key change ───
    use_synth :blade
    play :c3, cutoff: 88, release: 8, amp: 0.6
    sleep 4

    # ─── Section 3: C minor — full lush arrangement ───
    # Melody: mod_sine lead | Harmony: hollow + dark_ambience pads | Bass: subpulse | Percussion: rich
    cm_melody    = (ring :c5, :eb5, :g5, :bb4, :c5, :g5, :eb5, :c4)
    cm_chords    = (ring chord(:c3, :minor), chord(:g3, :minor), chord(:c3, :minor), chord(:eb3, :major))
    cm_cutoff    = (line 82, 112, steps: 24)
    cm_bass_ring = (ring :c2, :c2, :g2, :c2, :eb2, :c2, :g2, :bb1)

    3.times do
      # Long drones underneath
      use_synth :dark_ambience
      play :c2, cutoff: 90, release: 16, amp: 0.6

      use_synth :bass_foundation
      play :c2, cutoff: 68, release: 8, amp: 0.75

      # Melody thread
      in_thread do
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
          use_synth :mod_sine
          16.times do
            beat_amp = (look % 8 == 0) ? 1.0 : 0.88
            play cm_melody.tick, cutoff: rrand(88, 118), release: 0.3, amp: beat_amp
            sleep 0.5
          end
        end
      end

      # Harmony thread
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :hollow
          8.times do
            play_chord cm_chords.tick, cutoff: cm_cutoff.tick, release: 2.1, amp: 0.65
            sleep 2
          end
        end
      end

      # Bass thread
      in_thread do
        use_synth :subpulse
        8.times do
          play cm_bass_ring.tick, cutoff: 75, release: 0.9, amp: 0.62
          sleep 1
        end
      end

      # Percussion thread
      with_fx :reverb, room: 0.25, mix: 0.22 do
        8.times do |i|
          sample :bd_pure, amp: (i % 4 == 0) ? 0.88 : 0.72
          sample :hat_zild, amp: 0.32
          sleep 0.5
          sample :hat_zild, amp: 0.22
          sample :hat_psych, amp: 0.18 if one_in(5)
          sleep 0.5
          sample :elec_snare, amp: 0.7
          sample :hat_zild, amp: 0.28
          sleep 0.5
          sample :hat_zild, amp: 0.2
          sample :elec_cymbal, amp: 0.22 if one_in(4)
          sleep 0.5
          sample :bd_pure, amp: 0.75
          sample :hat_zild, amp: 0.3
          sleep 0.5
          sample :hat_zild, amp: 0.2
          sleep 0.5
          sample :elec_snare, amp: 0.67
          sample :hat_zild, amp: 0.26
          sample :elec_ping, amp: 0.2 if one_in(5)
          sleep 0.5
          sample :hat_psych, amp: 0.22 if one_in(3)
          sample :hat_zild, amp: 0.18
          sleep 0.5
        end
      end
    end

    # ─── Transition: into outro ───
    use_synth :blade
    play :c3, cutoff: 90, release: 8, amp: 0.6
    sleep 4

    # ─── Outro: gentle fade in C minor ───
    # Melody: blade | Harmony: supersaw warm pads | Bass: fading tb303 | Percussion: sparse
    cm_outro       = (ring :c5, :eb5, :g5, :c6, :g5, :eb5, :c5, :g4)
    cm_outro_chords = (ring chord(:c3, :minor), chord(:eb3, :major), chord(:g3, :minor), chord(:c3, :minor))
    outro_cutoff    = (line 80, 95, steps: 16)
    cm_outro_bass   = (ring :c2, :g2, :eb2, :c2, :g1, :c2, :g2, :eb2)

    2.times do
      # Long drones underneath
      use_synth :dark_ambience
      play :c2, cutoff: 78, release: 16, amp: 0.5

      use_synth :bass_foundation
      play :c1, cutoff: 60, release: 8, amp: 0.65

      # Melody thread
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :blade
          16.times do
            play cm_outro.tick, cutoff: rrand(75, 100), release: 0.45, amp: 0.9
            sleep 0.5
          end
        end
      end

      # Harmony thread
      in_thread do
        use_synth :supersaw
        8.times do
          play_chord cm_outro_chords.tick, cutoff: outro_cutoff.tick, release: 2.2, amp: 0.55
          sleep 2
        end
      end

      # Bass thread
      in_thread do
        with_fx :lpf, cutoff: 75, mix: 1.0 do
          use_synth :tb303
          8.times do
            play cm_outro_bass.tick, cutoff: 72, release: 1.0, wave: 0, amp: 0.55
            sleep 1
          end
        end
      end

      # Percussion thread
      8.times do |i|
        sample :bd_pure, amp: (i % 4 == 0) ? 0.72 : 0.55
        sample :hat_zild, amp: 0.22
        sleep 0.5
        sample :hat_zild, amp: 0.14
        sleep 0.5
        sample :elec_snare, amp: 0.48
        sample :hat_zild, amp: 0.18
        sleep 0.5
        sample :hat_zild, amp: 0.12
        sleep 0.5
        sample :bd_pure, amp: 0.55
        sample :hat_zild, amp: 0.2
        sleep 0.5
        sample :hat_zild, amp: 0.12
        sleep 0.5
        sample :elec_snare, amp: 0.44
        sample :hat_zild, amp: 0.16
        sleep 0.5
        sample :hat_zild, amp: 0.1
        sleep 0.5
      end
    end

  end
end
```