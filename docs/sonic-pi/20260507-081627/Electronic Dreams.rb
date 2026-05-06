# Electronic Dreams
# Style: Dreamy Electronic | Mood: Ethereal and Evolving

use_debug false
use_bpm 128

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # -------------------------------------------------------
    # Section 1: Dreamy Opening in Am
    # Melody: blade lead | Harmony: hollow + dark_ambience pads
    # Bass: sustained bass_foundation drone | Percussion: sparse kick/hat
    # -------------------------------------------------------
    am_melody   = (ring :a4, :c5, :e5, :g5, :a5, :e5, :c5, :b4)
    am_bass_ring = (ring :a1, :a1, :e2, :g2)
    am_chords   = (ring
      chord(:a3, :minor7),
      chord(:e3, :minor7),
      chord(:f3, :major7),
      chord(:g3, :major)
    )

    2.times do
      # Long drone underneath — melody
      use_synth :blade
      play :a3, release: 16, cutoff: 88, amp: 1.0

      # Long bass drone
      use_synth :bass_foundation
      play :a1, cutoff: 68, release: 8, amp: 1.1

      # Harmony: dark_ambience bed
      use_synth :dark_ambience
      play :a2, cutoff: 88, release: 16, amp: 0.9

      # Melody + harmony pads + bass stabs + percussion together
      with_fx :reverb, room: 0.28, mix: 0.28 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          16.times do
            tick
            # Percussion
            kick_amp = (spread(1, 4).look ? 1.4 : 1.0)
            sample :bd_tek, amp: kick_amp, rate: 0.92
            sample :hat_cats, amp: 0.6, rate: 1.1

            sleep 0.25

            sample :hat_cats, amp: 0.38, rate: 0.95 if one_in(3)

            sleep 0.25

            sample :elec_snare, amp: (spread(2, 8).look ? 1.1 : 0.0)
            sample :elec_cymbal, amp: 0.5, rate: 0.8 if one_in(5)

            sleep 0.25

            sample :hat_cats, amp: 0.48, rate: 1.05

            # Melody
            use_synth :blade
            play am_melody.tick, cutoff: rrand(85, 108), release: 0.45, amp: 1.8

            # Harmony: hollow chord every 8 steps (every 4 beats)
            if (look % 8) == 0
              use_synth :hollow
              play_chord am_chords.tick, cutoff: rrand(82, 100), release: 3.8, amp: 0.85
            end

            sleep 0.25
          end
        end
      end
    end

    # -------------------------------------------------------
    # Section 1b: Chip lead variation + rhythmic bass stabs
    # Melody: chiplead | Harmony: dsaw pads | Bass: subpulse stabs
    # Percussion: fuller four-on-the-floor
    # -------------------------------------------------------
    2.times do
      # Drone
      use_synth :supersaw
      play :a2, release: 8, cutoff: 82, amp: 0.7

      # Harmony drone
      use_synth :dark_ambience
      play :a2, cutoff: 84, release: 16, amp: 0.8

      # Harmony dsaw pad cycling
      use_synth :dsaw
      play_chord am_chords.tick, cutoff: rrand(82, 98), release: 3.6, detune: rrand(0.05, 0.18), amp: 0.75

      # Bass foundation
      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 6, amp: 1.0

      with_fx :lpf, cutoff: 95, mix: 1.0 do
        8.times do
          tick
          # Percussion
          kick_amp = (spread(1, 4).look ? 1.4 : 1.0)
          sample :bd_tek, amp: kick_amp, rate: 0.92
          sample :hat_cats, amp: 0.6, rate: 1.1

          # Melody
          use_synth :chiplead
          play am_melody.tick, cutoff: (line 85, 110, steps: 16).tick, release: 0.4, amp: 1.7

          # Bass stab
          use_synth :subpulse
          play am_bass_ring.tick, cutoff: 72, release: 0.6, amp: 1.05

          sleep 0.5

          tick
          sample :bd_tek, amp: 0.7, rate: 0.92
          sample :hat_tap, amp: 0.45, rate: 1.2 if spread(3, 8).look
          sample :elec_snare, amp: 0.75 if spread(2, 8).look

          use_synth :chiplead
          play am_bass_ring.tick, cutoff: rrand(80, 100), release: 0.38, amp: 1.6

          use_synth :subpulse
          play am_bass_ring.look, cutoff: 68, release: 0.4, amp: 0.85

          sleep 0.5
        end
      end
    end

    # -------------------------------------------------------
    # Transition: Drone bridge Am -> Cm
    # -------------------------------------------------------
    use_synth :blade
    play :c3, cutoff: 90, release: 10, amp: 1.2

    use_synth :hollow
    play :c3, cutoff: 90, release: 10, amp: 1.0

    use_synth :bass_foundation
    play :a1, cutoff: 65, release: 5, amp: 0.95

    sample :bd_tek, amp: 1.4, rate: 0.9
    sleep 1
    sample :elec_snare, amp: 1.0
    sleep 1
    sample :bd_tek, amp: 1.1, rate: 0.9
    sleep 1
    sample :elec_cymbal, amp: 0.65, rate: 0.7
    sleep 1

    # -------------------------------------------------------
    # Section 2: Key Change to Cm — supersaw leads, dreamy & fuller
    # Melody: supersaw | Harmony: dsaw + hollow pads
    # Bass: bass_foundation + tb303 | Percussion: fuller beat with toms
    # -------------------------------------------------------
    cm_melody  = (ring :c5, :eb5, :g5, :bb5, :c6, :g5, :eb5, :d5)
    cm_harmony = (ring :c4, :eb4, :g4, :bb4)
    cm_chords  = (ring
      chord(:c3, :minor7),
      chord(:g3, :minor7),
      chord(:eb3, :major7),
      chord(:bb3, :major)
    )
    cm_bass_ring = (ring :c2, :c2, :g2, :bb2)

    # Bass root drone
    use_synth :bass_foundation
    play :c1, cutoff: 65, release: 8, amp: 1.1

    3.times do
      # Long drone pads
      use_synth :supersaw
      play :c3, release: 16, cutoff: 85, amp: 0.9

      use_synth :blade
      play :g3, release: 8, cutoff: 78, amp: 0.5

      use_synth :dark_ambience
      play :c2, cutoff: 86, release: 16, amp: 1.0

      use_synth :bass_foundation
      play :c1, cutoff: 62, release: 8, amp: 1.05

      with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.22 do
        with_fx :reverb, room: 0.25, mix: 0.28 do
          16.times do
            tick
            # Percussion
            kick_amp = (spread(1, 4).look ? 1.5 : 1.1)
            sample :bd_fat, amp: kick_amp, rate: 0.95
            sample :hat_cats, amp: 0.65, rate: 1.15

            sleep 0.25

            sample :hat_cats, amp: 0.42, rate: 1.0
            sample :drum_tom_mid_soft, amp: 0.72 if spread(3, 16).look

            sleep 0.25

            sample :elec_snare, amp: (spread(2, 8).look ? 1.3 : 0.0)
            sample :elec_cymbal, amp: 0.58, rate: 0.85 if one_in(4)

            sleep 0.25

            sample :hat_cats, amp: 0.52, rate: 1.1
            sample :drum_tom_mid_soft, amp: 0.62 if one_in(5)

            # Melody
            use_synth :supersaw
            play cm_melody.tick, cutoff: rrand(88, 115), release: 0.42, amp: 1.9

            # Harmony chord every 8 steps
            if (look % 8) == 0
              use_synth :dsaw
              play_chord cm_chords.tick,
                cutoff: (line 84, 108, steps: 16).look,
                release: 3.7,
                detune: rrand(0.06, 0.2),
                amp: 0.8
              use_synth :hollow
              play_chord cm_chords.look,
                cutoff: rrand(80, 96),
                release: 3.5,
                amp: 0.65
            end

            # Bass tb303 stab
            use_synth :tb303
            play cm_bass_ring.tick, cutoff: rrand(68, 82), release: 0.55, amp: 0.95, res: 0.8, wave: 0

            sleep 0.25
          end
        end
      end
    end

    # -------------------------------------------------------
    # Transition: Drone bridge into Climax
    # -------------------------------------------------------
    use_synth :blade
    play :c4, cutoff: 90, release: 12, amp: 1.2

    use_synth :hollow
    play :c3, cutoff: 88, release: 12, amp: 1.0

    use_synth :bass_foundation
    play :c2, cutoff: 66, release: 8, amp: 1.0

    sample :bd_tek, amp: 1.4, rate: 0.9
    sleep 1
    sample :elec_snare, amp: 1.1
    sleep 1
    sample :bd_tek, amp: 1.2, rate: 0.9
    sleep 1
    sample :elec_cymbal, amp: 0.65, rate: 0.75
    sleep 1

    # -------------------------------------------------------
    # Section 3: Climax — chiplead + supersaw, full energy
    # Melody: chiplead + supersaw harmony | Harmony: dsaw swell pads
    # Bass: subpulse + tb303 | Percussion: driving toms + crashes
    # -------------------------------------------------------
    cm_run = (ring :c5, :d5, :eb5, :f5, :g5, :ab5, :bb5, :c6,
                   :c6, :bb5, :ab5, :g5, :f5, :eb5, :d5, :c5)
    climax_chords = (ring
      chord(:c3, :minor),
      chord(:eb3, :major),
      chord(:bb2, :major),
      chord(:g3, :minor)
    )
    cm_climb = (ring :c2, :eb2, :g2, :bb2)

    2.times do
      # Long drones
      use_synth :supersaw
      play :c3, release: 8, cutoff: 90, amp: 1.0

      use_synth :dark_ambience
      play :c2, cutoff: 90, release: 16, amp: 1.1

      use_synth :bass_foundation
      play :c1, cutoff: 70, release: 8, amp: 1.15

      with_fx :lpf, cutoff: 112, mix: 1.0 do
        16.times do
          tick
          # Percussion — climax energy
          kick_amp = (spread(1, 4).look ? 1.6 : 1.15)
          sample :bd_tek, amp: kick_amp, rate: 1.0
          sample :hat_cats, amp: 0.75, rate: 1.2

          sleep 0.25

          sample :hat_cats, amp: 0.52, rate: 1.05
          sample :drum_tom_mid_soft, amp: 0.88 if spread(5, 16).look

          sleep 0.25

          sample :elec_snare, amp: (spread(2, 8).look ? 1.5 : 0.0)
          sample :elec_cymbal, amp: 0.72, rate: 1.0 if one_in(3)

          sleep 0.25

          sample :hat_cats, amp: 0.62, rate: 1.15
          sample :drum_tom_mid_soft, amp: 0.78 if one_in(4)

          # Melody
          use_synth :chiplead
          play cm_run.tick, cutoff: (line 90, 118, steps: 16).look, release: 0.25, amp: 2.0

          # Harmony layer
          use_synth :supersaw
          play cm_harmony.look, cutoff: 82, release: 0.4, amp: 0.45

          # Harmony chord every 8 steps
          if (look % 8) == 0
            use_synth :dsaw
            play_chord climax_chords.tick,
              cutoff: (line 86, 118, steps: 8).look,
              release: 3.8,
              detune: rrand(0.1, 0.25),
              amp: 0.85
            use_synth :hollow
            play_chord climax_chords.look,
              cutoff: rrand(85, 105),
              release: 3.5,
              amp: 0.7
          end

          # Bass: alternating subpulse + tb303
          use_synth :subpulse
          play cm_climb.look, cutoff: 78, release: 0.45, amp: 1.0
          use_synth :tb303
          play cm_climb.tick, cutoff: rrand(72, 88), release: 0.35, amp: 0.9, res: 0.82, wave: 1

          sample :elec_blip, amp: 0.38, rate: 2.0 if one_in(6)

          sleep 0.25
        end
      end
    end

    # -------------------------------------------------------
    # Outro: Fade back to dreamy blade drone in Cm
    # Melody: blade | Harmony: dsaw fading pads
    # Bass: sustained drone + subpulse | Percussion: sparse
    # -------------------------------------------------------
    use_synth :blade
    play :c4, cutoff: 90, release: 12, amp: 1.2

    use_synth :hollow
    play :c3, cutoff: 88, release: 12, amp: 1.0

    use_synth :bass_foundation
    play :c2, cutoff: 63, release: 8, amp: 0.9

    # Transition sparse beat
    sample :bd_tek, amp: 1.3, rate: 0.9
    sleep 1
    sample :elec_snare, amp: 1.0
    sleep 1
    sample :bd_tek, amp: 1.1, rate: 0.9
    sleep 1
    sample :elec_cymbal, amp: 0.55, rate: 0.7
    sleep 1

    2.times do
      # Fading drones
      use_synth :dark_ambience
      play :c2, cutoff: 80, release: 8, amp: 0.85

      use_synth :bass_foundation
      play :c2, cutoff: 63, release: 8, amp: 0.9

      # Harmony: gentle dsaw fade
      use_synth :dsaw
      play_chord cm_chords.tick,
        cutoff: (line 80, 90, steps: 8).tick,
        release: 3.5,
        detune: rrand(0.04, 0.12),
        amp: 0.7

      8.times do
        tick
        # Sparse percussion
        kick_amp = (spread(1, 4).look ? 1.3 : 0.9)
        sample :bd_tek, amp: kick_amp, rate: 0.9
        sample :hat_cats, amp: 0.5, rate: 1.0

        sleep 0.25

        sample :hat_cats, amp: 0.32, rate: 0.9 if one_in(3)

        sleep 0.25

        sample :elec_snare, amp: (spread(2, 8).look ? 1.0 : 0.0)
        sample :elec_cymbal, amp: 0.42, rate: 0.7 if one_in(6)

        sleep 0.25

        sample :hat_cats, amp: 0.38, rate: 0.95

        # Melody: blade fade
        use_synth :blade
        play cm_melody.tick, cutoff: rrand(78, 95), release: 0.55, amp: 1.65

        # Bass: subpulse gentle pulse
        use_synth :subpulse
        play (ring :c2, :g2, :eb2, :g2).tick, cutoff: 70, release: 0.7, amp: 0.85

        sleep 0.25
      end

      8.times do
        tick
        sample :bd_tek, amp: (spread(1, 4).look ? 1.2 : 0.88), rate: 0.9
        sample :hat_cats, amp: 0.42, rate: 0.95

        sleep 0.25

        sample :hat_cats, amp: 0.28, rate: 0.88 if one_in(4)

        sleep 0.25

        sample :elec_snare, amp: (spread(2, 8).look ? 0.9 : 0.0)

        sleep 0.25

        sample :hat_cats, amp: 0.35, rate: 0.9

        # Melody: chiplead fade
        use_synth :chiplead
        play cm_run.tick, cutoff: rrand(80, 100), release: 0.3, amp: 1.6

        sleep 0.25
      end
    end

  end
end