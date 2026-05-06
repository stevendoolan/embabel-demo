# Electronic Dreams
# Style: Dreamy electronic | Mood: Ethereal and evolving

use_debug false
use_bpm 128

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ================================================================
    # SECTION 1: Dreamy opening in Am — chiplead melody + pads + bass + light percussion
    # ================================================================
    2.times do
      # --- Drones and pads ---
      use_synth :mod_sine
      play :a2, release: 16, cutoff: 85, amp: 0.9, mod_range: 2, mod_phase: 0.5

      use_synth :hollow
      play_chord chord(:a2, :minor), cutoff: 88, release: 16, amp: 0.75

      use_synth :bass_foundation
      play :a1, cutoff: 68, release: 16, amp: 1.05

      # --- Chiplead melody ---
      with_fx :reverb, room: 0.28, mix: 0.3 do
        use_synth :chiplead
        am_melody = (ring :a4, :c5, :e5, :a4, :g4, :e4, :c5, :e5,
                         :a4, :b4, :c5, :e5, :d5, :c5, :b4, :a4)
        cutoff_line = (line 88, 108, steps: 16)
        16.times do
          play am_melody.tick, release: 0.22, cutoff: cutoff_line.tick, amp: 1.8
          sleep 0.5
        end
      end
    end

    # ================================================================
    # SECTION 1b: Am groove — melody percussion layer + walking bass + supersaw chords
    # ================================================================
    am_chords = (ring chord(:a3, :minor), chord(:f3, :major), chord(:c3, :major), chord(:g3, :major))
    cutoff_swell = (line 82, 105, steps: 16)
    bass_am = (ring :a2, :a2, :e2, :a2, :a2, :e2, :a2, :g2)
    bass_groove = (ring :a2, :e2, :a2, :a2, :e2, :a2, :g2, :e2)

    2.times do
      # --- Drones ---
      use_synth :mod_sine
      play :a2, release: 8, cutoff: 80, amp: 0.7, mod_range: 2, mod_phase: 0.5

      use_synth :hollow
      play_chord chord(:a2, :minor), cutoff: 85, release: 8, amp: 0.7

      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 1.0

      # --- Supersaw chords ---
      with_fx :reverb, room: 0.32, mix: 0.3 do
        use_synth :supersaw
        play_chord am_chords.tick, cutoff: cutoff_swell.tick, release: 3.8, amp: 0.55
        sleep 4
        play_chord am_chords.tick, cutoff: cutoff_swell.tick, release: 3.8, amp: 0.55
        sleep 4
      end

      # --- Sub-bass eighth-note groove (in parallel via in_thread) ---
      in_thread do
        with_fx :lpf, cutoff: 85, mix: 1.0 do
          16.times do
            use_synth :subpulse
            play bass_groove.tick, cutoff: 78, release: 0.38, amp: 1.0
            sleep 0.5
          end
        end
      end

      # --- Percussion: kick + snare + hats ---
      with_fx :hpf, cutoff: 95, mix: 1.0 do
        8.times do
          sample :elec_soft_kick, amp: 0.7
          sample :hat_snap, amp: 0.5
          sleep 0.5
          sample :hat_snap, amp: 0.3
          sleep 0.5
          sample :elec_snare, amp: 0.6
          sample :hat_snap, amp: 0.35
          sleep 0.5
          sample :hat_snap, amp: 0.25
          sleep 0.5
        end
      end
    end

    # ================================================================
    # TRANSITION 1: Am -> Cm drone bridge
    # ================================================================
    use_synth :dsaw
    play :a2, cutoff: 90, release: 8, amp: 1.1
    use_synth :hollow
    play_chord chord(:a2, :minor), cutoff: 90, release: 8, amp: 0.85
    use_synth :bass_foundation
    play :a1, cutoff: 75, release: 8, amp: 1.1
    sample :elec_cymbal, amp: 0.9
    sample :elec_soft_kick, amp: 0.5
    sleep 4

    # ================================================================
    # SECTION 2: Key change to Cm — dsaw melody + blade pads + tb303 bass + syncopated drums
    # ================================================================
    cm_chords = (ring chord(:c3, :minor), chord(:ab3, :major), chord(:eb3, :major), chord(:bb3, :major))
    cutoff_ramp = (line 85, 115, steps: 16)
    cm_bass = (ring :c2, :c2, :g2, :c2, :bb1, :g1, :c2, :eb2)

    2.times do
      # --- Drones and pads ---
      use_synth :mod_sine
      play :c3, release: 16, cutoff: 82, amp: 0.85, mod_range: 3, mod_phase: 0.75

      use_synth :supersaw
      play_chord chord(:c2, :minor), cutoff: 90, release: 16, amp: 0.7

      use_synth :bass_foundation
      play :c2, cutoff: 70, release: 16, amp: 1.05

      # --- dsaw melody ---
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.22 do
          use_synth :dsaw
          cm_melody = (ring :c5, :eb5, :g5, :c5, :bb4, :g4, :eb5, :g5,
                           :c5, :d5, :eb5, :g5, :f5, :eb5, :d5, :c5)
          cutoff_ramp2 = (line 85, 115, steps: 16)
          16.times do
            play cm_melody.tick, release: 0.18, cutoff: cutoff_ramp2.tick, amp: 1.9
            sleep 0.5
          end
        end
      end

      # --- Blade chords (in_thread so they don't block melody) ---
      in_thread do
        with_fx :lpf, cutoff: 108, mix: 1.0 do
          use_synth :blade
          play_chord cm_chords.tick, cutoff: cutoff_ramp.tick, release: 3.8, amp: 0.65
          sleep 4
          play_chord cm_chords.tick, cutoff: cutoff_ramp.tick, release: 3.8, amp: 0.65
          sleep 4
        end
      end

      # --- tb303 bass ---
      in_thread do
        16.times do
          use_synth :tb303
          play cm_bass.tick, cutoff: 82, release: 0.4, amp: 0.9, res: 0.8
          sleep 0.5
        end
      end

      # --- Percussion: syncopated Cm pattern ---
      with_fx :hpf, cutoff: 100, mix: 1.0 do
        8.times do
          sample :elec_soft_kick, amp: 0.8
          sample :hat_cab, amp: 0.85
          sleep 0.25
          sample :hat_cab, amp: 0.55
          sleep 0.25
          sample :elec_soft_kick, amp: 0.35 if one_in(3)
          sample :hat_cab, amp: 0.6
          sleep 0.5
          sample :elec_snare, amp: 0.65
          sample :hat_cab, amp: 0.75
          sleep 0.25
          sample :elec_blip, amp: 0.7
          sleep 0.25
          sample :hat_cab, amp: 0.55
          sleep 0.5
          sample :elec_soft_kick, amp: 0.7
          sample :hat_cab, amp: 0.8
          sleep 0.25
          sample :hat_cab, amp: 0.5
          sleep 0.25
          sample :elec_blip, amp: 0.65 if one_in(2)
          sample :hat_cab, amp: 0.6
          sleep 0.5
          sample :elec_snare, amp: 0.6
          sample :elec_cymbal, amp: 0.8
          sleep 0.25
          sample :hat_cab, amp: 0.55
          sleep 0.25
          sample :hat_cab, amp: 0.5
          sample :elec_soft_kick, amp: 0.45 if one_in(3)
          sleep 0.5
        end
      end
    end

    # ================================================================
    # TRANSITION 2: Cm intensity bridge
    # ================================================================
    use_synth :dsaw
    play :c3, cutoff: 90, release: 8, amp: 1.0
    use_synth :blade
    play_chord chord(:c3, :minor), cutoff: 88, release: 8, amp: 0.9
    use_synth :bass_foundation
    play :c2, cutoff: 70, release: 8, amp: 1.1
    sample :elec_cymbal, amp: 0.9
    sleep 4

    # ================================================================
    # SECTION 3: Cm climax — chiplead shimmer + supersaw chords + subpulse/tb303 bass + full drums
    # ================================================================
    cm_chords2 = (ring chord(:c3, :minor), chord(:eb3, :major), chord(:bb3, :major), chord(:ab3, :major))
    cutoff_climb = (line 88, 118, steps: 16)
    climax_bass = (ring :c2, :eb2, :g2, :c2, :bb1, :g1, :eb2, :g2)

    2.times do
      # --- Drones ---
      use_synth :dsaw
      play :c2, release: 8, cutoff: 78, amp: 0.8

      use_synth :chiplead
      play :c6, release: 16, cutoff: 95, amp: 0.5

      use_synth :hollow
      play_chord chord(:c2, :minor), cutoff: 85, release: 8, amp: 0.72

      use_synth :bass_foundation
      play :c1, cutoff: 65, release: 8, amp: 1.1

      # --- Supersaw chords ---
      in_thread do
        use_synth :supersaw
        play_chord cm_chords2.tick, cutoff: cutoff_climb.tick, release: 3.8, amp: 0.6
        sleep 4
        play_chord cm_chords2.tick, cutoff: cutoff_climb.tick, release: 3.8, amp: 0.6
        sleep 4
      end

      # --- Alternating subpulse + tb303 bass ---
      in_thread do
        16.times do |i|
          if i.even?
            use_synth :subpulse
            play climax_bass.tick, cutoff: 80, release: 0.42, amp: 1.0
          else
            use_synth :tb303
            play climax_bass.look, cutoff: 76, release: 0.35, amp: 0.88, res: 0.82
          end
          sleep 0.5
        end
      end

      # --- Full driving percussion ---
      with_fx :hpf, cutoff: 100, mix: 1.0 do
        8.times do
          sample :elec_soft_kick, amp: 0.85
          sample :hat_cab, amp: 0.9
          sleep 0.25
          sample :hat_cab, amp: 0.6
          sleep 0.25
          sample :elec_soft_kick, amp: 0.38 if one_in(2)
          sample :elec_blip, amp: 0.7 if one_in(3)
          sleep 0.5
          sample :elec_snare, amp: 0.7
          sample :hat_cab, amp: 0.85
          sleep 0.25
          sample :elec_blip, amp: 0.72
          sleep 0.25
          sample :hat_cab, amp: 0.6
          sleep 0.5
          sample :elec_soft_kick, amp: 0.75
          sample :elec_cymbal, amp: 0.85
          sleep 0.25
          sample :hat_cab, amp: 0.65
          sleep 0.25
          sample :hat_cab, amp: 0.55
          sleep 0.5
          sample :elec_snare, amp: 0.65
          sample :elec_cymbal, amp: 0.9
          sleep 0.25
          sample :elec_blip, amp: 0.68 if one_in(2)
          sleep 0.25
          sample :hat_cab, amp: 0.7
          sleep 0.25
          sample :elec_soft_kick, amp: 0.4 if one_in(2)
          sleep 0.25
        end
      end
    end

    # ================================================================
    # TRANSITION 3: Cm fade into outro
    # ================================================================
    use_synth :mod_sine
    play :c3, cutoff: 88, release: 8, amp: 1.0, mod_range: 1, mod_phase: 1.0
    use_synth :blade
    play_chord chord(:c3, :minor), cutoff: 88, release: 8, amp: 0.9
    use_synth :bass_foundation
    play :c1, cutoff: 70, release: 8, amp: 1.0
    sample :elec_cymbal, amp: 1.0
    sleep 4

    # ================================================================
    # SECTION 4: Outro — sparse Cm resolution, dreamy fade
    # ================================================================
    cm_outro = (ring chord(:c3, :minor), chord(:g3, :minor), chord(:eb3, :major), chord(:bb3, :major))
    cutoff_fade = (line 90, 75, steps: 8)
    outro_bass = (ring :c2, :g1, :eb2, :c2, :bb1, :g1, :c2, :eb2)
    outro_notes = (ring :c5, :g4, :eb5, :c5, :bb4, :g4, :c5, :eb5)

    2.times do
      # --- Long sustaining drones ---
      use_synth :mod_sine
      play :c2, release: 16, cutoff: 75, amp: 0.7, mod_range: 1, mod_phase: 1.0

      use_synth :hollow
      play_chord chord(:c2, :minor), cutoff: 80, release: 16, amp: 0.68

      # --- Supersaw chords slowly fading ---
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.32 do
          use_synth :supersaw
          play_chord cm_outro.tick, cutoff: cutoff_fade.tick, release: 3.8, amp: 0.5
          sleep 4
          play_chord cm_outro.tick, cutoff: cutoff_fade.tick, release: 3.8, amp: 0.5
          sleep 4
        end
      end

      # --- Sparse sub-bass ---
      in_thread do
        8.times do
          use_synth :bass_foundation
          play outro_bass.tick, cutoff: 68, release: 1.8, amp: 0.85
          sleep 1.0
        end
      end

      # --- Chiplead sparse melody ---
      with_fx :reverb, room: 0.3, mix: 0.32 do
        use_synth :chiplead
        8.times do
          play outro_notes.tick, release: 0.35, cutoff: rrand(82, 105), amp: 1.7
          sleep 1.0
        end
      end

      # --- Sparse outro percussion ---
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          8.times do
            sample :elec_soft_kick, amp: 0.6
            sample :hat_cab, amp: 0.65
            sleep 0.5
            sample :hat_cab, amp: 0.45
            sleep 0.5
            sample :elec_snare, amp: 0.5
            sample :hat_cab, amp: 0.55
            sleep 0.5
            sample :hat_cab, amp: 0.4
            sample :elec_blip, amp: 0.5 if one_in(4)
            sleep 0.5
          end
        end
      end
    end

  end
end