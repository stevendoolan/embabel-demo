# Java User Group Dance Anthem
# Style: Electronic | Mood: Energetic | BPM: 128 | Time: 4/4

use_debug false
use_bpm 128

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # -------------------------------------------------------
    # SECTION 1: A major — Supersaw anthem intro + four-on-the-floor beat
    # Melody: supersaw anthem | Harmony: tech_saws + blade pad
    # Bass: subpulse four-on-the-floor | Percussion: tight hats
    # -------------------------------------------------------
    melody_a  = (ring :a4, :cs5, :e5, :a5, :e5, :cs5, :a4, :fs4)
    bass_a    = (ring :a2, :a2, :e3, :fs3)
    bass_s1   = (ring :a2, :a2, :e2, :fs2)
    chords_1  = (ring
      chord(:a3, :major),
      chord(:e3, :dom7),
      chord(:fs3, :minor),
      chord(:e3, :major)
    )

    2.times do
      # Long drone foundations
      use_synth :supersaw
      play :a2, release: 8, cutoff: 85, amp: 0.9
      use_synth :blade
      play_chord chord(:a2, :major), cutoff: 85, release: 16, amp: 0.5
      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 1.0

      # Melody + harmony + bass + percussion woven together (4 bars)
      4.times do
        # --- Melody: 2 notes per beat across 4 beats ---
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.28 do
            use_synth :supersaw
            2.times do
              play melody_a.tick, release: 0.18, cutoff: rrand(88, 112), amp: 1.8
              sleep 0.5
            end
          end
        end

        # --- Harmony chord on beat 1 of each bar ---
        use_synth :tech_saws
        play_chord chords_1.tick, cutoff: 90, release: 0.9, amp: 0.7

        # --- Bass pulse: one note per beat ---
        use_synth :supersaw
        play bass_a.tick, release: 0.22, cutoff: 80, amp: 0.9
        use_synth :subpulse
        play bass_s1.tick, cutoff: 75, release: 0.35, amp: 1.1

        # --- Percussion: beat 1 accent ---
        sample :bd_tek, amp: 1.6
        sample :drum_cymbal_closed, amp: 0.6, rate: 1.4, finish: 0.3
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.25

        # --- Melody 2nd half of this beat group ---
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          with_fx :reverb, room: 0.25, mix: 0.28 do
            use_synth :supersaw
            2.times do
              play melody_a.tick, release: 0.18, cutoff: rrand(88, 112), amp: 1.8
              sleep 0.5
            end
          end
        end

        # Beats 2-4 percussion + filler
        sample :drum_snare_hard, amp: 1.1
        sample :drum_cymbal_closed, amp: 0.6, rate: 1.4, finish: 0.3
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.25
        sleep 0.5
        sample :bd_tek, amp: 1.3
        sample :drum_cymbal_closed, amp: 0.6, rate: 1.4, finish: 0.3
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.25
        sleep 0.5
        sample :drum_snare_hard, amp: 1.1
        sample :drum_cymbal_closed, amp: 0.55, rate: 1.4, finish: 0.3
        sample :drum_cymbal_open, amp: 0.5, rate: 1.3, finish: 0.4 if one_in(3)
        sleep 0.5
        sample :hat_cats, amp: 0.5, rate: 1.2, finish: 0.3
        sleep 0.5
      end
    end

    # -------------------------------------------------------
    # TRANSITION 1→2: Drone bridge (A major)
    # -------------------------------------------------------
    use_synth :supersaw
    play :a2, cutoff: 90, release: 8, amp: 1.0
    use_synth :blade
    play_chord chord(:a2, :major), cutoff: 88, release: 8, amp: 0.6
    use_synth :bass_foundation
    play :a1, cutoff: 68, release: 8, amp: 1.0
    sample :bd_tek, amp: 1.4
    sleep 1
    sample :drum_cymbal_closed, amp: 0.55, rate: 1.4, finish: 0.3
    sleep 1
    sample :bd_tek, amp: 1.3
    sleep 1
    sample :drum_cymbal_closed, amp: 0.55, rate: 1.4, finish: 0.3
    sleep 1

    # -------------------------------------------------------
    # SECTION 2: A major — Chiplead energy build
    # Melody: chiplead + arp | Harmony: blade pad + tech_saws
    # Bass: walking subpulse | Percussion: busier hats
    # -------------------------------------------------------
    melody_b  = (ring :a4, :cs5, :e5, :fs5, :e5, :cs5, :b4, :a4)
    arp_b     = (ring :a5, :e5, :cs5, :a4, :cs5, :e5, :a5, :cs6)
    bass_s2   = (ring :a2, :cs3, :e2, :a2, :fs2, :e2, :cs2, :a2)
    chords_2  = (ring
      chord(:a3, :major7),
      chord(:d3, :major),
      chord(:e3, :dom7),
      chord(:a3, :major)
    )

    2.times do
      # Long drone foundations
      use_synth :supersaw
      play :a3, release: 8, cutoff: 88, amp: 0.7
      use_synth :blade
      play_chord chord(:a2, :major7), cutoff: 88, release: 16, amp: 0.55
      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 0.9

      4.times do
        # --- Melody: chiplead lead ---
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.22 do
          use_synth :chiplead
          2.times do
            play melody_b.tick, release: 0.15, cutoff: rrand(90, 118), amp: 1.9
            sleep 0.5
          end
        end

        # --- Harmony chord ---
        use_synth :tech_saws
        play_chord chords_2.tick, cutoff: rrand(85, 108), release: 0.85, amp: 0.75

        # --- Bass ---
        use_synth :bass_foundation
        play :a1, cutoff: 65, release: 0.4, amp: 0.7
        with_fx :lpf, cutoff: 85, mix: 1.0 do
          use_synth :subpulse
          2.times do
            play bass_s2.tick, cutoff: 78, release: 0.4, amp: 1.0
            sleep 0.5
          end
        end

        # --- Percussion beat 1 accent ---
        with_fx :hpf, cutoff: 90, mix: 1.0 do
          sample :bd_tek, amp: 1.6
          sample :hat_cats, amp: 0.8, rate: 1.3, finish: 0.4
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.5, rate: 1.5, finish: 0.2
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.2
          sleep 0.5
        end

        # --- Melody 2nd half ---
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.22 do
          use_synth :chiplead
          2.times do
            play melody_b.tick, release: 0.15, cutoff: rrand(90, 118), amp: 1.9
            sleep 0.5
          end
        end

        # Arpeggio fill on remaining beats
        use_synth :chiplead
        2.times do
          play arp_b.tick, release: 0.12, cutoff: rrand(95, 115), amp: 1.5
          sleep 0.5
        end

        # Beats 2-4 percussion
        with_fx :hpf, cutoff: 90, mix: 1.0 do
          sample :drum_snare_hard, amp: 1.2
          sample :hat_cats, amp: 0.7, rate: 1.3, finish: 0.35
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.2
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.2
          sleep 0.5
          sample :bd_tek, amp: 1.4
          sample :hat_cats, amp: 0.7, rate: 1.3, finish: 0.35
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.5, rate: 1.5, finish: 0.2
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.2
          sleep 0.5
          sample :drum_snare_hard, amp: 1.2
          sample :drum_cymbal_open, amp: 0.65, rate: 1.2, finish: 0.5 if one_in(2)
          sample :hat_cats, amp: 0.6, rate: 1.3, finish: 0.3
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.2
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.45, rate: 1.4, finish: 0.2
          sleep 0.5
        end
      end
    end

    # -------------------------------------------------------
    # KEY CHANGE TRANSITION: A → B (long drone bridge)
    # -------------------------------------------------------
    use_synth :supersaw
    play :b2, cutoff: 90, release: 8, amp: 1.1
    use_synth :blade
    play_chord chord(:b2, :major), cutoff: 90, release: 8, amp: 0.65
    use_synth :bass_foundation
    play :b1, cutoff: 68, release: 8, amp: 1.0
    sample :bd_tek, amp: 1.6
    sample :drum_cymbal_open, amp: 0.75, rate: 1.0, finish: 0.7
    sleep 1
    sample :drum_cymbal_closed, amp: 0.6, rate: 1.3, finish: 0.3
    sleep 1
    sample :bd_tek, amp: 1.5
    sleep 1
    sample :drum_snare_hard, amp: 1.2
    sample :drum_cymbal_open, amp: 0.7, rate: 1.0, finish: 0.6
    sleep 1

    # -------------------------------------------------------
    # SECTION 3: B major — Supersaw anthem drop (full dancefloor)
    # Melody: supersaw | Harmony: tech_saws + blade
    # Bass: subpulse four-on-the-floor | Percussion: heavy drop beat
    # -------------------------------------------------------
    melody_c  = (ring :b4, :ds5, :fs5, :b5, :fs5, :ds5, :b4, :gs4)
    bass_c    = (ring :b2, :b2, :fs3, :gs3)
    bass_s3   = (ring :b2, :b2, :fs2, :gs2)
    chords_3  = (ring
      chord(:b3, :major),
      chord(:fs3, :dom7),
      chord(:gs3, :minor),
      chord(:fs3, :major)
    )

    2.times do
      # Long drone foundations
      use_synth :supersaw
      play :b2, release: 8, cutoff: 88, amp: 0.9
      use_synth :blade
      play_chord chord(:b2, :major), cutoff: 88, release: 16, amp: 0.52
      use_synth :bass_foundation
      play :b1, cutoff: 65, release: 8, amp: 1.0

      4.times do
        # --- Melody ---
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          with_fx :reverb, room: 0.28, mix: 0.30 do
            use_synth :supersaw
            2.times do
              play melody_c.tick, release: 0.18, cutoff: (line 88, 115, steps: 16).tick, amp: 1.9
              sleep 0.5
            end
          end
        end

        # --- Harmony chord ---
        with_fx :reverb, room: 0.35, mix: 0.32 do
          use_synth :tech_saws
          play_chord chords_3.tick, cutoff: (line 85, 110, steps: 8).look, release: 0.9, amp: 0.75
        end

        # --- Bass ---
        use_synth :supersaw
        play bass_c.tick, release: 0.22, cutoff: 82, amp: 0.9
        use_synth :subpulse
        play bass_s3.tick, cutoff: 78, release: 0.35, amp: 1.1

        # --- Percussion beat 1 ---
        sample :bd_tek, amp: 1.7
        sample :drum_cymbal_closed, amp: 0.7, rate: 1.4, finish: 0.3
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.5, rate: 1.4, finish: 0.25

        # --- Melody 2nd half ---
        with_fx :lpf, cutoff: 110, mix: 1.0 do
          with_fx :reverb, room: 0.28, mix: 0.30 do
            use_synth :supersaw
            2.times do
              play melody_c.tick, release: 0.18, cutoff: (line 88, 115, steps: 16).tick, amp: 1.9
              sleep 0.5
            end
          end
        end

        # Beats 2-4 percussion
        sample :drum_snare_hard, amp: 1.4
        sample :drum_cymbal_closed, amp: 0.65, rate: 1.4, finish: 0.3
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.5, rate: 1.4, finish: 0.25
        sleep 0.5
        sample :bd_tek, amp: 1.5
        sample :hat_cats, amp: 0.75, rate: 1.2, finish: 0.4
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.55, rate: 1.4, finish: 0.25
        sleep 0.5
        sample :drum_snare_hard, amp: 1.4
        sample :drum_cymbal_open, amp: 0.7, rate: 1.1, finish: 0.5 if one_in(2)
        sample :hat_cats, amp: 0.6, rate: 1.2, finish: 0.3
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.55, rate: 1.4, finish: 0.25
        sleep 0.5
      end
    end

    # -------------------------------------------------------
    # TRANSITION 3→4: Drone bridge to chiplead climax (B major)
    # -------------------------------------------------------
    use_synth :supersaw
    play :b2, cutoff: 92, release: 8, amp: 1.1
    use_synth :blade
    play_chord chord(:b2, :major), cutoff: 92, release: 8, amp: 0.65
    use_synth :bass_foundation
    play :b1, cutoff: 70, release: 8, amp: 1.0
    sample :bd_tek, amp: 1.7
    sample :drum_cymbal_open, amp: 0.8, rate: 1.0, finish: 0.8
    sleep 1
    sample :drum_cymbal_closed, amp: 0.6, rate: 1.3, finish: 0.3
    sleep 1
    sample :bd_tek, amp: 1.6
    sleep 1
    sample :drum_snare_hard, amp: 1.4
    sample :drum_cymbal_open, amp: 0.75, rate: 1.0, finish: 0.7
    sleep 1

    # -------------------------------------------------------
    # SECTION 4: B major — Chiplead climax (maximum energy)
    # Melody: chiplead + arp | Harmony: blade + tech_saws
    # Bass: dense walking subpulse | Percussion: climax beat
    # -------------------------------------------------------
    melody_d  = (ring :b4, :ds5, :fs5, :as5, :b5, :as5, :fs5, :ds5)
    arp_d     = (ring :b5, :fs5, :ds5, :b4, :ds5, :fs5, :b5, :ds6)
    bass_s4   = (ring :b2, :ds3, :fs2, :b2, :gs2, :fs2, :ds2, :b2)
    chords_4  = (ring
      chord(:b3, :major7),
      chord(:e3, :major),
      chord(:fs3, :dom7),
      chord(:b3, :major)
    )

    2.times do
      # Long drone foundations
      use_synth :supersaw
      play :b3, release: 8, cutoff: 90, amp: 0.7
      use_synth :blade
      play_chord chord(:b2, :major7), cutoff: 90, release: 16, amp: 0.56
      use_synth :bass_foundation
      play :b1, cutoff: 65, release: 8, amp: 0.9

      4.times do
        # --- Melody: chiplead lead ---
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.20 do
          use_synth :chiplead
          2.times do
            play melody_d.tick, release: 0.15, cutoff: rrand(92, 120), amp: 2.0
            sleep 0.5
          end
        end

        # --- Harmony chord ---
        use_synth :tech_saws
        play_chord chords_4.tick, cutoff: rrand(88, 112), release: 0.88, amp: 0.78

        # --- Bass ---
        use_synth :bass_foundation
        play :b1, cutoff: 65, release: 0.4, amp: 0.75
        use_synth :subpulse
        2.times do
          play bass_s4.tick, cutoff: 80, release: 0.4, amp: 1.0
          sleep 0.5
        end

        # --- Percussion beat 1 ---
        sample :bd_tek, amp: 1.7
        sample :hat_cats, amp: 0.9, rate: 1.3, finish: 0.45
        sample :drum_cymbal_closed, amp: 0.7, rate: 1.5, finish: 0.25
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.55, rate: 1.4, finish: 0.2
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.5, rate: 1.4, finish: 0.2
        sleep 0.5

        # --- Melody arpeggio fill ---
        use_synth :chiplead
        2.times do
          play arp_d.tick, release: 0.12, cutoff: rrand(98, 118), amp: 1.6
          sleep 0.5
        end

        # Melody continues
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.20 do
          use_synth :chiplead
          2.times do
            play melody_d.tick, release: 0.15, cutoff: rrand(92, 120), amp: 2.0
            sleep 0.5
          end
        end

        # Arpeggio fills remaining
        use_synth :chiplead
        2.times do
          play arp_d.tick, release: 0.12, cutoff: rrand(98, 118), amp: 1.6
          sleep 0.5
        end

        # Beats 2-4 percussion
        sample :drum_snare_hard, amp: 1.5
        sample :hat_cats, amp: 0.75, rate: 1.3, finish: 0.4
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.55, rate: 1.4, finish: 0.2
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.5, rate: 1.4, finish: 0.2
        sleep 0.5
        sample :bd_tek, amp: 1.5
        sample :hat_cats, amp: 0.8, rate: 1.3, finish: 0.4
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.55, rate: 1.5, finish: 0.2
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.5, rate: 1.4, finish: 0.2
        sleep 0.5
        sample :drum_snare_hard, amp: 1.5
        sample :drum_cymbal_open, amp: 0.85, rate: 1.1, finish: 0.6
        sample :hat_cats, amp: 0.7, rate: 1.2, finish: 0.35
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.55, rate: 1.4, finish: 0.2
        sleep 0.25
        sample :drum_cymbal_closed, amp: 0.5, rate: 1.4, finish: 0.2
        sleep 0.5
      end
    end

  end
end