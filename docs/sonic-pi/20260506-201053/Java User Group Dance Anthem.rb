# Java User Group Dance Anthem
# Style: Energetic Electronic Dance | Mood: Euphoric, High-Energy

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # -----------------------------------------------
    # SECTION 1: Intro/Verse — Key of A major
    # Chiplead melody, supersaw pads, subpulse bass, four-on-the-floor kick
    # -----------------------------------------------
    a_melody  = (ring :a4, :cs5, :e5, :a5, :gs5, :e5, :cs5, :b4)
    a_bass    = (ring :a3, :a3, :e4, :e4, :a3, :a3, :cs4, :e4)
    s1_chords = (ring chord(:a3, :major), chord(:e3, :major), chord(:cs3, :minor), chord(:a3, :major))

    2.times do
      # Long drone underneath — supersaw pad
      use_synth :supersaw
      play :a2, release: 16, cutoff: 70, amp: 0.35

      # Blade shimmer
      use_synth :blade
      play :a3, cutoff: 90, release: 8, amp: 0.28

      # Sub-bass drone anchors the root
      use_synth :subpulse
      play :a1, cutoff: 65, release: 8, amp: 0.65

      with_fx :reverb, room: 0.25, mix: 0.28 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          use_synth :chiplead
          8.times do
            beat = look % 8

            # --- Percussion ---
            sample :bd_klub,            amp: beat == 0 ? 0.75 : 0.62
            sample :elec_snare,         amp: 0.52 if [2, 6].include?(beat)
            sample :elec_hi_snare,      amp: 0.38 if [2, 5, 6].include?(beat)
            sample :drum_cymbal_closed, amp: 0.28, rate: 1.6
            sample :drum_cymbal_open,   amp: 0.25, rate: 1.2, finish: 0.3 if beat == 3

            # --- Bass foundation rhythmic hits ---
            use_synth :bass_foundation
            if beat == 0
              play :a2, cutoff: 78, release: 0.9, amp: 0.65
            elsif beat == 2
              play :e2, cutoff: 72, release: 0.6, amp: 0.55
            elsif beat == 4
              play :a2, cutoff: 75, release: 0.8, amp: 0.60
            elsif beat == 6
              play :cs2, cutoff: 70, release: 0.5, amp: 0.52
            end

            # --- Harmony chord stabs ---
            use_synth beat.even? ? :supersaw : :rhodey
            play_chord s1_chords.look,
                       cutoff:   beat.even? ? (line 82, 108, steps: 8).tick(:cf1) : rrand(88, 112),
                       release:  beat.even? ? 0.55 : 0.18,
                       amp:      beat.even? ? 0.32 : 0.42
            s1_chords.tick

            # --- Melody lead ---
            use_synth :chiplead
            play a_melody.tick, cutoff: rrand(88, 112), release: 0.18, amp: 0.92
            sleep 0.5

            play a_bass.look, cutoff: rrand(80, 98), release: 0.12, amp: 0.75
            sleep 0.5
          end
        end
      end
    end

    # -----------------------------------------------
    # TRANSITION 1: Bridge drone A -> B
    # -----------------------------------------------
    use_synth :supersaw
    play :a2, cutoff: 85, release: 8, amp: 0.5
    sleep 4

    # -----------------------------------------------
    # SECTION 2: Build — Key of A, supersaw drive + tb303 bass runs
    # More syncopation, evolving cutoff, offbeat chord stabs
    # -----------------------------------------------
    a_melody2 = (ring :a4, :e5, :cs5, :b4, :a4, :gs4, :a4, :cs5)
    s2_chords = (ring chord(:a3, :major), chord(:fs3, :minor), chord(:d3, :major), chord(:e3, :major))
    bass_run  = (ring :a2, :a2, :e2, :e2, :gs2, :a2, :cs2, :e2)

    2.times do
      # Sustained pad drone
      use_synth :supersaw
      play :a2, release: 16, cutoff: 75, amp: 0.38
      play :e3, release: 16, cutoff: 70, amp: 0.28

      # Blade shimmer on the fifth
      use_synth :blade
      play :e4, cutoff: 95, release: 8, amp: 0.25

      # Sub drone
      use_synth :subpulse
      play :a1, cutoff: 62, release: 8, amp: 0.63

      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          8.times do
            beat = look % 8

            # --- Percussion ---
            sample :bd_klub,            amp: beat == 0 ? 0.80 : 0.65
            sample :elec_snare,         amp: 0.55 if [2, 6].include?(beat)
            sample :hat_snap,           amp: 0.48 if spread(3, 8).tick(:hs)
            sample :elec_hi_snare,      amp: 0.42 if [1, 4, 6].include?(beat)
            sample :drum_cymbal_closed, amp: beat.even? ? 0.32 : 0.22, rate: 1.7
            sample :drum_cymbal_open,   amp: 0.28, rate: 1.3, finish: 0.35 if beat == 7

            # --- tb303 bass run ---
            use_synth :tb303
            rel_b  = (beat == 0 || beat == 4) ? 0.7 : 0.3
            amp_b  = beat == 0 ? 0.68 : 0.52
            play bass_run.tick(:br), cutoff: rrand(68, 85), release: rel_b, amp: amp_b, res: 0.3

            # --- Harmony chord stabs ---
            if [1, 3, 5, 7].include?(beat)
              use_synth :supersaw
              play_chord s2_chords.tick, cutoff: (line 90, 118, steps: 16).tick(:cf2), release: 0.22, amp: 0.48
            else
              use_synth :rhodey
              play_chord s2_chords.look, cutoff: rrand(85, 105), release: 0.45, amp: 0.38
            end

            # --- Melody lead ---
            use_synth :supersaw
            play a_melody2.tick, cutoff: (line 90, 118, steps: 16).tick(:cf3), release: 0.15, amp: 0.90
            sleep 0.5

            use_synth :supersaw
            play a_melody2.look, cutoff: rrand(82, 102), release: 0.1, amp: 0.78
            sleep 0.5
          end
        end
      end
    end

    # -----------------------------------------------
    # TRANSITION 2: Key change drone A -> B
    # -----------------------------------------------
    use_synth :supersaw
    play :b2, cutoff: 88, release: 8, amp: 0.55
    sleep 4

    # -----------------------------------------------
    # SECTION 3: Climax — Key of B major
    # winwood_lead melody, big supersaw wall, full drum groove, deep sub on B
    # -----------------------------------------------
    b_melody  = (ring :b4, :ds5, :fs5, :b5, :as5, :fs5, :ds5, :cs5)
    b_bass    = (ring :b3, :b3, :fs4, :fs4, :b3, :b3, :ds4, :fs4)
    b_roots   = (ring :b2, :b2, :fs2, :fs2, :b2, :b2, :ds2, :fs2)
    s3_chords = (ring chord(:b3, :major), chord(:fs3, :minor), chord(:gs3, :minor), chord(:e3, :major))

    2.times do
      # Big pad drone in B
      use_synth :supersaw
      play :b2, release: 16, cutoff: 78, amp: 0.40
      play :fs3, release: 16, cutoff: 72, amp: 0.28

      # Blade shimmer
      use_synth :blade
      play :b4, cutoff: 100, release: 8, amp: 0.28
      play :fs4, cutoff: 95, release: 8, amp: 0.22

      # Deep sub root on B
      use_synth :subpulse
      play :b1, cutoff: 65, release: 8, amp: 0.68

      with_fx :lpf, cutoff: 112, mix: 1.0 do
        with_fx :reverb, room: 0.28, mix: 0.28 do
          8.times do
            beat = look % 8

            # --- Percussion ---
            sample :bd_klub,            amp: beat == 0 ? 0.85 : 0.70
            sample :elec_snare,         amp: 0.60 if [2, 6].include?(beat)
            sample :elec_hi_snare,      amp: 0.48 if [2, 6].include?(beat)
            sample :hat_snap,           amp: 0.50 if spread(5, 8).tick(:hsc)
            sample :elec_hi_snare,      amp: 0.35 if one_in(3)
            sample :drum_cymbal_closed, amp: beat.even? ? 0.36 : 0.25, rate: 1.8
            sample :drum_cymbal_open,   amp: 0.32, rate: 1.4, finish: 0.4 if [3, 7].include?(beat)
            sample :hat_zap,            amp: 0.22 if one_in(4)

            # --- Bass foundation + roots ---
            use_synth :bass_foundation
            rel_r  = (beat == 0 || beat == 4) ? 0.85 : 0.45
            amp_r  = beat == 0 ? 0.70 : 0.55
            play b_roots.tick(:br2), cutoff: rrand(70, 88), release: rel_r, amp: amp_r

            # --- Harmony chord stabs ---
            if [1, 3, 5, 7].include?(beat)
              use_synth :supersaw
              play_chord s3_chords.tick, cutoff: (line 92, 122, steps: 16).tick(:cf4), release: 0.2, amp: 0.52
            else
              use_synth :rhodey
              play_chord s3_chords.look, cutoff: rrand(88, 110), release: 0.5, amp: 0.42
            end

            # --- Melody lead ---
            use_synth :winwood_lead
            play b_melody.tick, cutoff: rrand(92, 118), release: 0.2, amp: 0.95
            sleep 0.5

            use_synth :winwood_lead
            play b_bass.tick(:bb), cutoff: rrand(82, 100), release: 0.12, amp: 0.80
            sleep 0.5
          end
        end
      end
    end

    # -----------------------------------------------
    # OUTRO: Final fade — sustained drones in B, kick fade
    # -----------------------------------------------
    use_synth :supersaw
    play_chord chord(:b2, :major), cutoff: 80, release: 8, amp: 0.38
    use_synth :blade
    play :b3, cutoff: 85, release: 8, amp: 0.22
    use_synth :subpulse
    play :b1, cutoff: 62, release: 8, amp: 0.55
    use_synth :bass_foundation
    play :b2, cutoff: 68, release: 8, amp: 0.48

    8.times do
      beat = look % 8
      amp_fade = [0.65, 0.60, 0.55, 0.50, 0.45, 0.40, 0.35, 0.30][beat]
      sample :bd_klub,            amp: amp_fade
      sample :elec_snare,         amp: 0.42 if [2, 6].include?(beat)
      sample :drum_cymbal_closed, amp: 0.20, rate: 1.5
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.14, rate: 1.5
      sleep 0.5
    end

  end
end