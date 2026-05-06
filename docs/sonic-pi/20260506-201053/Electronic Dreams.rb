# Electronic Dreams
# Style: Dreamy electronic / ambient synth-pop | Mood: Ethereal, hypnotic, uplifting

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ══════════════════════════════════════════════════════
    # SECTION 1: Dreamy Am intro – blade lead, hollow pads, sparse drums, sub bass
    # ══════════════════════════════════════════════════════
    am_melody    = (ring :a4, :c5, :e5, :g5, :e5, :d5, :c5, :a4)
    am_arp_mel   = am_melody
    am_chords    = (ring chord(:a3, :minor7), chord(:e3, :minor7), chord(:c3, :major7), chord(:g3, :major))
    am_roots     = (ring :a1, :e2, :a1, :g1)
    cutoff_line  = (line 80, 110, steps: 16)
    cutoff_pad   = (line 80, 100, steps: 8)

    2.times do
      # — Long drones underneath —
      use_synth :supersaw
      play :a2, release: 8, cutoff: 85, amp: 0.35

      use_synth :dark_ambience
      play :a2, cutoff: 85, release: 9, amp: 0.35

      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 0.72

      # — Harmony: hollow pad chords —
      in_thread do
        with_fx :reverb, room: 0.28, mix: 0.3 do
          with_fx :lpf, cutoff: 95, mix: 1 do
            use_synth :hollow
            play_chord am_chords.tick, cutoff: cutoff_pad.tick, release: 4.2, amp: 0.55
            sleep 4
            play_chord am_chords.tick, cutoff: cutoff_pad.tick, release: 4.2, amp: 0.55
            sleep 4
          end
        end
      end

      # — Bass: rhythmic subpulse on beats —
      in_thread do
        4.times do
          use_synth :subpulse
          play am_roots.tick, cutoff: 72, release: 0.9, amp: 0.62
          sleep 1
        end
      end

      # — Percussion: sparse kick/snare/hats —
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.72
          sample :drum_cymbal_closed, amp: 0.28, rate: 1.2
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.20, rate: 1.1
          sleep 0.5
          sample :elec_snare, amp: 0.55
          sample :drum_cymbal_closed, amp: 0.26, rate: 1.2
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.18, rate: 1.1
          sample :elec_blip, amp: 0.20, rate: rrand(0.8, 1.2) if one_in(4)
          sleep 0.5
          sample :bd_haus, amp: 0.62
          sample :drum_cymbal_closed, amp: 0.26, rate: 1.2
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.18, rate: 1.0
          sleep 0.5
          sample :elec_snare, amp: 0.52
          sample :drum_cymbal_closed, amp: 0.24, rate: 1.2
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.16, rate: 1.1
          sleep 0.5
        end
      end

      # — Melody: blade lead —
      with_fx :reverb, room: 0.28, mix: 0.3 do
        with_fx :lpf, cutoff: 105, mix: 1 do
          use_synth :blade
          8.times do
            play am_arp_mel.tick, release: 0.45, cutoff: cutoff_line.tick, amp: 0.95
            sleep 0.5
          end
        end
      end
    end

    # ══════════════════════════════════════════════════════
    # SECTION 2: Am arpeggio energy – chiplead, rhodey chords, tighter hats, walking bass
    # ══════════════════════════════════════════════════════
    am_arp       = (ring :a4, :e5, :c5, :a5, :g4, :e4, :c4, :a3)
    am_rhodey    = (ring chord(:a3, :minor7), chord(:c3, :major7), chord(:e3, :minor), chord(:g3, :major))
    am_walk      = (ring :a1, :a1, :e2, :g1)

    2.times do
      # — Long drones underneath —
      use_synth :supersaw
      play :a2, release: 8, cutoff: 90, amp: 0.30

      use_synth :dark_ambience
      play :a2, cutoff: 88, release: 9, amp: 0.32

      use_synth :bass_foundation
      play :a1, cutoff: 68, release: 8, amp: 0.70

      # — Harmony: rhodey chord stabs every 2 beats —
      in_thread do
        use_synth :rhodey
        play_chord am_rhodey.tick, cutoff: 90, release: 2.2, amp: 0.50
        sleep 2
        play_chord am_rhodey.tick, cutoff: 90, release: 2.2, amp: 0.50
        sleep 2
        play_chord am_rhodey.tick, cutoff: 88, release: 2.2, amp: 0.50
        sleep 2
        play_chord am_rhodey.tick, cutoff: 88, release: 2.2, amp: 0.50
        sleep 2
      end

      # — Bass: tb303 walking —
      in_thread do
        with_fx :lpf, cutoff: 82, mix: 1 do
          4.times do
            use_synth :tb303
            play am_walk.tick, cutoff: 78, release: 0.55, amp: 0.65, res: 0.8
            sleep 1
          end
        end
      end

      # — Percussion: tighter hats, hat_zap driven —
      in_thread do
        with_fx :hpf, cutoff: 95, mix: 1 do
          4.times do
            sample :bd_haus, amp: 0.78
            sample :hat_zap, amp: 0.38, rate: 1.3
            sleep 0.5
            sample :hat_zap, amp: 0.25, rate: 1.1
            sleep 0.5
            sample :elec_snare, amp: 0.62
            sample :hat_zap, amp: 0.34, rate: 1.2
            sleep 0.5
            sample :hat_zap, amp: 0.23, rate: 1.0
            sample :elec_blip, amp: 0.26, rate: rrand(1.0, 1.6) if one_in(3)
            sleep 0.5
            sample :bd_haus, amp: 0.65
            sample :hat_zap, amp: 0.36, rate: 1.3
            sleep 0.5
            sample :hat_zap, amp: 0.22, rate: 1.1
            sleep 0.5
            sample :elec_snare, amp: 0.58
            sample :hat_zap, amp: 0.32, rate: 1.2
            sleep 0.5
            sample :hat_zap, amp: 0.22, rate: 1.0
            sample :elec_blip, amp: 0.25, rate: rrand(0.9, 1.4) if one_in(4)
            sleep 0.5
          end
        end
      end

      # — Melody: chiplead rapid arpeggio —
      with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
        use_synth :chiplead
        16.times do
          play am_arp.tick, release: 0.12, cutoff: rrand(85, 115), amp: 0.90
          sleep 0.25
        end
      end
    end

    # ══════════════════════════════════════════════════════
    # TRANSITION: Drone bridge – Am → Cm key change
    # ══════════════════════════════════════════════════════
    use_synth :supersaw
    play :c3, cutoff: 90, release: 8, amp: 0.50

    use_synth :hollow
    play :c3, cutoff: 85, release: 5, amp: 0.45

    use_synth :bass_foundation
    play :c2, cutoff: 70, release: 8, amp: 0.60

    sample :bd_haus, amp: 0.55
    sleep 1
    sample :elec_snare, amp: 0.40
    sleep 1
    sample :bd_haus, amp: 0.50
    sleep 1
    sample :elec_snare, amp: 0.38
    sleep 1

    # ══════════════════════════════════════════════════════
    # SECTION 3: Cm key change – supersaw melody, lush hollow pads, fuller groove
    # ══════════════════════════════════════════════════════
    cm_melody    = (ring :c5, :eb5, :g5, :bb5, :g5, :f5, :eb5, :c5)
    cm_chords    = (ring chord(:c3, :minor7), chord(:g3, :minor), chord(:eb3, :major7), chord(:bb3, :major))
    cm_roots     = (ring :c2, :g1, :c2, :bb1)
    cutoff_line2 = (line 85, 120, steps: 16)
    cutoff_pad2  = (line 85, 108, steps: 8)

    2.times do
      # — Long drones underneath —
      use_synth :blade
      play :c3, release: 8, cutoff: 88, amp: 0.32

      use_synth :dark_ambience
      play :c2, cutoff: 90, release: 9, amp: 0.38

      use_synth :bass_foundation
      play :c2, cutoff: 65, release: 8, amp: 0.72

      # — Harmony: hollow pads —
      in_thread do
        with_fx :reverb, room: 0.30, mix: 0.28 do
          with_fx :lpf, cutoff: 100, mix: 1 do
            use_synth :hollow
            play_chord cm_chords.tick, cutoff: cutoff_pad2.tick, release: 4.2, amp: 0.58
            sleep 4
            play_chord cm_chords.tick, cutoff: cutoff_pad2.tick, release: 4.2, amp: 0.58
            sleep 4
          end
        end
      end

      # — Bass: subpulse rhythmic root pulse —
      in_thread do
        4.times do
          use_synth :subpulse
          play cm_roots.tick, cutoff: 75, release: 0.85, amp: 0.60
          sleep 1
        end
      end

      # — Percussion: lush hats, fuller groove —
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.74
          sample :hat_zap, amp: 0.36, rate: 1.25
          sample :drum_cymbal_closed, amp: 0.25, rate: 1.1
          sleep 0.5
          sample :hat_zap, amp: 0.23, rate: 1.05
          sleep 0.5
          sample :elec_snare, amp: 0.60
          sample :hat_zap, amp: 0.32, rate: 1.2
          sleep 0.5
          sample :hat_zap, amp: 0.22, rate: 1.0
          sample :elec_blip, amp: 0.22, rate: rrand(0.8, 1.3) if one_in(3)
          sleep 0.5
          sample :bd_haus, amp: 0.64
          sample :hat_zap, amp: 0.34, rate: 1.25
          sample :drum_cymbal_closed, amp: 0.22, rate: 1.0
          sleep 0.5
          sample :hat_zap, amp: 0.22, rate: 1.05
          sleep 0.5
          sample :elec_snare, amp: 0.55
          sample :hat_zap, amp: 0.30, rate: 1.2
          sleep 0.5
          sample :hat_zap, amp: 0.20, rate: 1.0
          sleep 0.5
        end
      end

      # — Melody: supersaw uplifted —
      with_fx :reverb, room: 0.30, mix: 0.28 do
        with_fx :lpf, cutoff: 112, mix: 1 do
          use_synth :supersaw
          8.times do
            play cm_melody.tick, release: 0.4, cutoff: cutoff_line2.tick, amp: 0.95
            sleep 0.5
          end
        end
      end
    end

    # ══════════════════════════════════════════════════════
    # TRANSITION: Drone bridge – into Cm climax
    # ══════════════════════════════════════════════════════
    use_synth :supersaw
    play :c3, cutoff: 90, release: 8, amp: 0.50
    sleep 4

    # ══════════════════════════════════════════════════════
    # SECTION 4: Cm climax – chiplead rapid arp, rhodey stabs, driving beat, walking bass
    # ══════════════════════════════════════════════════════
    cm_arp       = (ring :c5, :g5, :eb5, :c5, :bb4, :g4, :eb4, :c4)
    cm_rhodey    = (ring chord(:c3, :minor7), chord(:eb3, :major7), chord(:g3, :minor), chord(:bb3, :major))
    cm_walk      = (ring :c2, :c2, :g1, :bb1)

    2.times do
      # — Long drones underneath —
      use_synth :blade
      play :c3, release: 8, cutoff: 95, amp: 0.30

      use_synth :hollow
      play :c2, cutoff: 92, release: 9, amp: 0.42

      use_synth :bass_foundation
      play :c2, cutoff: 68, release: 8, amp: 0.70

      # — Harmony: rhodey warm stabs —
      in_thread do
        use_synth :rhodey
        play_chord cm_rhodey.tick, cutoff: 93, release: 2.2, amp: 0.55
        sleep 2
        play_chord cm_rhodey.tick, cutoff: 93, release: 2.2, amp: 0.55
        sleep 2
        play_chord cm_rhodey.tick, cutoff: 90, release: 2.2, amp: 0.55
        sleep 2
        play_chord cm_rhodey.tick, cutoff: 90, release: 2.2, amp: 0.55
        sleep 2
      end

      # — Bass: driving tb303 walking bass —
      in_thread do
        4.times do
          use_synth :tb303
          play cm_walk.tick, cutoff: 80, release: 0.5, amp: 0.65, res: 0.82
          sleep 1
        end
      end

      # — Percussion: energetic climax beat with sixteenth subdivision —
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.82
          sample :hat_zap, amp: 0.44, rate: 1.4
          sleep 0.25
          sample :hat_zap, amp: 0.28, rate: 1.15
          sleep 0.25
          sample :hat_zap, amp: 0.24, rate: 1.1
          sleep 0.25
          sample :elec_blip, amp: 0.28, rate: rrand(1.0, 1.8) if one_in(3)
          sample :hat_zap, amp: 0.20, rate: 1.0
          sleep 0.25
          sample :elec_snare, amp: 0.68
          sample :hat_zap, amp: 0.40, rate: 1.35
          sleep 0.25
          sample :hat_zap, amp: 0.26, rate: 1.1
          sleep 0.25
          sample :bd_haus, amp: 0.50
          sample :hat_zap, amp: 0.22, rate: 1.05
          sleep 0.25
          sample :hat_zap, amp: 0.18, rate: 1.0
          sleep 0.25
          sample :bd_haus, amp: 0.72
          sample :hat_zap, amp: 0.40, rate: 1.4
          sleep 0.25
          sample :hat_zap, amp: 0.26, rate: 1.15
          sleep 0.25
          sample :hat_zap, amp: 0.22, rate: 1.1
          sample :elec_blip, amp: 0.26, rate: rrand(0.9, 1.6) if one_in(4)
          sleep 0.25
          sample :hat_zap, amp: 0.18, rate: 1.0
          sleep 0.25
          sample :elec_snare, amp: 0.62
          sample :hat_zap, amp: 0.36, rate: 1.3
          sleep 0.25
          sample :hat_zap, amp: 0.24, rate: 1.1
          sleep 0.25
          sample :hat_zap, amp: 0.20, rate: 1.05
          sleep 0.25
          sample :elec_blip, amp: 0.30, rate: rrand(1.2, 2.0) if one_in(3)
          sample :hat_zap, amp: 0.18, rate: 1.0
          sleep 0.25
        end
      end

      # — Melody: chiplead rapid arpeggio —
      with_fx :echo, phase: 0.25, decay: 1.8, mix: 0.22 do
        use_synth :chiplead
        16.times do
          play cm_arp.tick, release: 0.1, cutoff: rrand(90, 120), amp: 0.92
          sleep 0.25
        end
      end
    end

    # ══════════════════════════════════════════════════════
    # OUTRO: Fade – supersaw + dark_ambience pad, sparse percussion, long sub root
    # ══════════════════════════════════════════════════════
    use_synth :supersaw
    play :c3, cutoff: 80, release: 16, amp: 0.38

    use_synth :dark_ambience
    play :c2, cutoff: 78, release: 18, amp: 0.38

    use_synth :hollow
    play_chord chord(:c3, :minor7), cutoff: 82, release: 18, amp: 0.38

    use_synth :subpulse
    play :c1, cutoff: 60, release: 16, amp: 0.50

    8.times do
      sample :bd_haus, amp: 0.48
      sample :drum_cymbal_closed, amp: 0.18, rate: 1.1
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.14, rate: 1.0
      sample :elec_blip, amp: 0.15, rate: rrand(0.7, 1.1) if one_in(5)
      sleep 0.5
    end

  end
end