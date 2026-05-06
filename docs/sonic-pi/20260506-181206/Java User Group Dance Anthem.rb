# Java User Group Dance Anthem
# Style: Exuberant electronic dance — house, chiptune, synth-pop fusion
# Key: A major -> B major (key change) | BPM: 128 | Time Signature: 4/4

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # -------------------------------------------------------
    # SECTION 1: A major intro — chiplead melody, blade pads,
    #            sub bass, house beat | 2 reps x 4 bars
    # -------------------------------------------------------
    melody_a     = (ring :a4, :cs5, :e5, :a5, :e5, :cs5, :b4, :a4)
    bass_a       = (ring :a1, :a1, :e2, :a1, :a1, :a1, :e2, :cs2)
    chords_a     = (ring chord(:a3, :major), chord(:e3, :major), chord(:fs3, :minor), chord(:e3, :major))
    cutoff_mel1  = (line 85, 115, steps: 16)
    cutoff_pad1  = (line 82, 102, steps: 16)

    2.times do
      # --- Drones ---
      use_synth :fm
      play :a2, release: 8, cutoff: 90, amp: 0.4

      use_synth :blade
      play_chord chord(:a3, :major), cutoff: 88, release: 16, amp: 0.45, pan: 0

      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 0.75

      # --- Melody: chiplead ---
      with_fx :lpf, cutoff: 105, mix: 1.0 do
        with_fx :reverb, room: 0.25, mix: 0.28 do
          use_synth :chiplead
          16.times do
            play melody_a.tick, cutoff: cutoff_mel1.tick, release: 0.18, amp: 0.9
            sleep 0.5
          end
        end
      end

      # --- Harmony: dsaw stabs on beats 2 & 4 ---
      with_fx :reverb, room: 0.25, mix: 0.28 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          8.times do
            sleep 1
            use_synth :dsaw
            play_chord chords_a.tick, cutoff: cutoff_pad1.tick, release: 0.45, amp: 0.55, pan: -0.55
            sleep 1
            sleep 1
            use_synth :dsaw
            play_chord chords_a.look, cutoff: cutoff_pad1.look, release: 0.45, amp: 0.52, pan: 0.55
            sleep 1
          end
        end
      end

      # --- Bass: sub foundation + tb303 offbeat ---
      8.times do
        use_synth :bass_foundation
        play bass_a.tick, cutoff: 68, release: 0.45, amp: 0.7
        sleep 0.5
        use_synth :tb303
        play bass_a.look, cutoff: rrand(72, 85), res: 0.8, wave: 0, release: 0.3, amp: 0.55
        sleep 0.5
      end

      # --- Percussion: foundational house beat ---
      8.times do |i|
        kick_amp = i == 0 ? 0.85 : 0.7
        is_snare = (i % 2 == 1)

        sample :bd_haus, amp: kick_amp
        sample :drum_cymbal_closed, amp: 0.4, rate: 1.2, finish: 0.4
        sample :hat_cats, amp: 0.3 if i == 0
        sleep 0.5

        sample :drum_cymbal_closed, amp: 0.35, rate: 1.2, finish: 0.4
        sample :drum_snare_hard, amp: 0.6 if is_snare
        sample :elec_blip, amp: 0.3, rate: 2.0 if one_in(6)
        sleep 0.5
      end
    end

    # -------------------------------------------------------
    # TRANSITION 1: Drone bridge A -> buildup
    # -------------------------------------------------------
    use_synth :supersaw
    play :a3, cutoff: 95, release: 8, amp: 0.55
    use_synth :blade
    play :a3, cutoff: 90, release: 8, amp: 0.5
    use_synth :bass_foundation
    play :a1, cutoff: 70, release: 8, amp: 0.7

    4.times do |i|
      sample :bd_haus, amp: 0.7
      sample :drum_cymbal_closed, amp: 0.3, rate: 1.1, finish: 0.35
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.28, rate: 1.1, finish: 0.35
      sample :drum_snare_hard, amp: 0.55 if i == 1 || i == 3
      sleep 0.5
    end

    # -------------------------------------------------------
    # SECTION 2: A major — supersaw lead, busier pattern,
    #            wider pads, driving bass | 2 reps x 4 bars
    # -------------------------------------------------------
    melody_a2   = (ring :a4, :e5, :fs5, :e5, :cs5, :b4, :cs5, :a4)
    bass_a2     = (ring :a1, :a1, :e2, :a1, :cs2, :a1, :e2, :fs2)
    chords_a2   = (ring chord(:a3, :major), chord(:d3, :major), chord(:e3, :major), chord(:a3, :major))
    cutoff_mel2 = (line 88, 118, steps: 16)
    cutoff_pad2 = (line 86, 112, steps: 16)

    with_fx :lpf, cutoff: 82, mix: 1.0 do
      2.times do
        # --- Drones ---
        use_synth :fm
        play :a2, release: 8, cutoff: 92, amp: 0.4

        use_synth :blade
        play_chord chord(:a3, :major), cutoff: 92, release: 16, amp: 0.48, pan: -0.2

        use_synth :bass_foundation
        play :a1, cutoff: 68, release: 8, amp: 0.75

        # --- Melody: supersaw ---
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          use_synth :supersaw
          16.times do
            play melody_a2.tick, cutoff: cutoff_mel2.tick, release: 0.15, amp: 0.95
            sleep 0.5
          end
        end

        # --- Harmony: dsaw stabs wide stereo ---
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
          8.times do
            sleep 1
            use_synth :dsaw
            play_chord chords_a2.tick, cutoff: cutoff_pad2.tick, release: 0.42, amp: 0.58, pan: -0.65
            sleep 1
            sleep 1
            use_synth :dsaw
            play_chord chords_a2.look, cutoff: cutoff_pad2.look, release: 0.42, amp: 0.55, pan: 0.65
            sleep 1
          end
        end

        # --- Bass: eighth-note pumping with tb303 sweeps ---
        8.times do
          use_synth :bass_foundation
          play bass_a2.tick, cutoff: 70, release: 0.5, amp: 0.72
          sleep 0.5
          use_synth :tb303
          play bass_a2.look, cutoff: rrand(75, 88), res: 0.82, wave: 0, release: 0.25, amp: 0.58
          sleep 0.5
        end

        # --- Percussion: busier pattern with open hat offbeats ---
        with_fx :hpf, cutoff: 90, mix: 1.0 do
          8.times do |i|
            kick_amp = i == 0 ? 0.88 : 0.72
            is_snare = (i % 2 == 1)

            sample :bd_haus, amp: kick_amp
            sample :drum_cymbal_closed, amp: 0.42, rate: 1.3, finish: 0.4
            sample :hat_cats, amp: 0.35 if i == 0
            sleep 0.25

            sample :drum_cymbal_closed, amp: 0.3, rate: 1.2, finish: 0.35
            sample :elec_blip, amp: 0.32, rate: 1.8 if spread(3, 8).tick
            sleep 0.25

            sample :drum_snare_hard, amp: 0.65 if is_snare
            sample :drum_cymbal_open, amp: 0.38, rate: 1.0, finish: 0.5 if is_snare
            sample :drum_cymbal_closed, amp: 0.38, rate: 1.3, finish: 0.4
            sleep 0.25

            sample :drum_cymbal_closed, amp: 0.28, rate: 1.2, finish: 0.3
            sample :elec_blip, amp: 0.28, rate: 2.2 if one_in(5)
            sleep 0.25
          end
        end
      end
    end

    # -------------------------------------------------------
    # TRANSITION 2: Key change drone A -> B major
    # -------------------------------------------------------
    use_synth :supersaw
    play :b3, cutoff: 98, release: 8, amp: 0.6
    use_synth :fm
    play :b2, release: 8, cutoff: 88, amp: 0.4
    use_synth :blade
    play :b3, cutoff: 95, release: 8, amp: 0.55
    use_synth :bass_foundation
    play :b1, cutoff: 72, release: 8, amp: 0.72

    4.times do |i|
      sample :bd_haus, amp: 0.75
      sample :drum_cymbal_closed, amp: 0.32, rate: 1.1, finish: 0.35
      sleep 0.5
      sample :drum_cymbal_open, amp: 0.36, rate: 0.9, finish: 0.6 if i == 1 || i == 3
      sample :drum_snare_hard, amp: 0.6 if i == 1 || i == 3
      sleep 0.5
    end

    # -------------------------------------------------------
    # SECTION 3: B major — climax! chiplead + supersaw layered,
    #            lush blade pads, driving bass, full percussion
    #            | 2 reps x 4 bars
    # -------------------------------------------------------
    melody_b    = (ring :b4, :ds5, :fs5, :b5, :fs5, :ds5, :cs5, :b4)
    melody_b2   = (ring :b4, :fs5, :gs5, :fs5, :ds5, :cs5, :ds5, :b4)
    bass_b      = (ring :b1, :b1, :fs2, :b1, :b1, :b1, :fs2, :ds2)
    chords_b    = (ring chord(:b3, :major), chord(:fs3, :minor), chord(:gs3, :minor), chord(:e3, :major))
    cutoff_mel3 = (line 92, 122, steps: 16)
    cutoff_pad3 = (line 90, 118, steps: 16)

    2.times do
      # --- Drones ---
      use_synth :fm
      play :b2, release: 8, cutoff: 95, amp: 0.4

      use_synth :blade
      play_chord chord(:b3, :major), cutoff: 96, release: 16, amp: 0.5, pan: 0

      use_synth :bass_foundation
      play :b1, cutoff: 70, release: 8, amp: 0.78

      # --- Melody: chiplead lead layer ---
      with_fx :lpf, cutoff: 112, mix: 1.0 do
        with_fx :reverb, room: 0.28, mix: 0.25 do
          use_synth :chiplead
          16.times do
            play melody_b.tick, cutoff: cutoff_mel3.tick, release: 0.17, amp: 0.9
            sleep 0.5
          end
        end
      end

      # --- Melody: supersaw counter-layer ---
      use_synth :supersaw
      16.times do
        play melody_b2.tick, cutoff: rrand(90, 118), release: 0.13, amp: 0.85
        sleep 0.5
      end

      # --- Harmony: blade stabs left, dsaw right ---
      with_fx :reverb, room: 0.3, mix: 0.28 do
        with_fx :lpf, cutoff: 108, mix: 1.0 do
          8.times do
            sleep 1
            use_synth :blade
            play_chord chords_b.tick, cutoff: cutoff_pad3.tick, release: 0.5, amp: 0.6, pan: -0.7
            sleep 1
            sleep 1
            use_synth :dsaw
            play_chord chords_b.look, cutoff: cutoff_pad3.look, release: 0.48, amp: 0.58, pan: 0.7
            sleep 1
          end
        end
      end

      # --- Bass: full pumping eighth-note pattern ---
      8.times do
        use_synth :bass_foundation
        play bass_b.tick, cutoff: 72, release: 0.5, amp: 0.75
        sleep 0.5
        use_synth :tb303
        play bass_b.look, cutoff: rrand(78, 90), res: 0.85, wave: 0, release: 0.28, amp: 0.6
        sleep 0.5
      end

      # --- Percussion: full climax pattern ---
      8.times do |i|
        kick_amp = i == 0 ? 0.9 : 0.75
        is_snare = (i % 2 == 1)

        sample :bd_haus, amp: kick_amp
        sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.4
        sample :hat_cats, amp: 0.4 if i == 0 || i == 4
        sleep 0.25

        sample :drum_cymbal_closed, amp: 0.32, rate: 1.3, finish: 0.35
        sample :elec_blip, amp: 0.35, rate: 2.0 if spread(5, 8).tick
        sleep 0.25

        sample :drum_snare_hard, amp: 0.7 if is_snare
        sample :drum_cymbal_open, amp: 0.4, rate: 1.0, finish: 0.55 if is_snare
        sample :drum_cymbal_closed, amp: 0.4, rate: 1.4, finish: 0.4
        sleep 0.25

        sample :drum_cymbal_closed, amp: 0.3, rate: 1.3, finish: 0.3
        sample :hat_cats, amp: 0.32 if one_in(3)
        sample :elec_blip, amp: 0.3, rate: 2.5 if one_in(4)
        sleep 0.25
      end
    end

    # -------------------------------------------------------
    # TRANSITION: Outro drone — sparse beat, 4 beats
    # -------------------------------------------------------
    use_synth :supersaw
    play :b3, cutoff: 90, release: 8, amp: 0.5
    use_synth :blade
    play :b3, cutoff: 88, release: 8, amp: 0.45
    use_synth :bass_foundation
    play :b1, cutoff: 65, release: 8, amp: 0.65

    4.times do |i|
      sample :bd_haus, amp: 0.72
      sample :drum_cymbal_closed, amp: 0.3, rate: 1.1, finish: 0.35
      sleep 0.5
      sample :drum_snare_hard, amp: 0.55 if i == 1 || i == 3
      sleep 0.5
    end

    # -------------------------------------------------------
    # SECTION 4: B major outro — energy pulls back, softer pads,
    #            simpler beat, melody winds down | 2 reps x 4 bars
    # -------------------------------------------------------
    melody_outro  = (ring :b4, :ds5, :fs5, :ds5, :b4, :cs5, :b4, :as4)
    bass_outro    = (ring :b1, :b1, :fs2, :b1, :ds2, :b1, :cs2, :b1)
    chords_outro  = (ring chord(:b3, :major), chord(:gs3, :minor), chord(:e3, :major), chord(:fs3, :minor))
    cutoff_outro  = (line 82, 98, steps: 16)

    2.times do
      # --- Drones ---
      use_synth :fm
      play :b2, release: 8, cutoff: 88, amp: 0.35

      use_synth :blade
      play_chord chord(:b3, :major), cutoff: 86, release: 16, amp: 0.4, pan: 0

      use_synth :bass_foundation
      play :b1, cutoff: 62, release: 8, amp: 0.62

      # --- Melody: chiplead, softened ---
      with_fx :reverb, room: 0.3, mix: 0.32 do
        use_synth :chiplead
        16.times do
          play melody_outro.tick, cutoff: rrand(80, 105), release: 0.2, amp: 0.88
          sleep 0.5
        end
      end

      # --- Harmony: soft dsaw stabs ---
      8.times do
        sleep 1
        use_synth :dsaw
        play_chord chords_outro.tick, cutoff: cutoff_outro.tick, release: 0.5, amp: 0.48, pan: -0.5
        sleep 1
        sleep 1
        use_synth :dsaw
        play_chord chords_outro.look, cutoff: cutoff_outro.look, release: 0.5, amp: 0.45, pan: 0.5
        sleep 1
      end

      # --- Bass: sparse, softer outro rhythm ---
      8.times do
        use_synth :bass_foundation
        play bass_outro.tick, cutoff: 65, release: 0.6, amp: 0.6
        sleep 0.5
        use_synth :tb303
        play bass_outro.look, cutoff: rrand(68, 80), res: 0.78, wave: 0, release: 0.3, amp: 0.5
        sleep 0.5
      end

      # --- Percussion: simple, pulled-back beat ---
      8.times do |i|
        kick_amp = i == 0 ? 0.78 : 0.62
        is_snare = (i % 2 == 1)

        sample :bd_haus, amp: kick_amp
        sample :drum_cymbal_closed, amp: 0.36, rate: 1.1, finish: 0.4
        sample :hat_cats, amp: 0.28 if i == 0
        sleep 0.5

        sample :drum_cymbal_closed, amp: 0.3, rate: 1.1, finish: 0.35
        sample :drum_snare_hard, amp: 0.55 if is_snare
        sample :elec_blip, amp: 0.25, rate: 1.6 if one_in(6)
        sleep 0.5
      end
    end

  end
end