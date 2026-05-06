# Electronic Dreams
# Style: Electronic ambient | Mood: Dreamy

use_debug false
use_bpm 125

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ============================================================
    # SECTION 1: Dreamy opening in Am — blade lead, hollow pads, sub bass, sparse drums
    # ============================================================
    am_melody    = (ring :a4, :c5, :e5, :a4, :g4, :e4, :f4, :e4)
    am_bass_ring = (ring :a1, :a1, :e2, :f2)
    am_chords    = (ring chord(:a3, :minor), chord(:f3, :major), chord(:c3, :major), chord(:e3, :major))
    am_filter    = (line 80, 100, steps: 8)

    2.times do
      # --- Melody: blade lead drone + melodic line ---
      use_synth :sine
      play :a2, release: 8, cutoff: 80, amp: 0.8

      with_fx :reverb, room: 0.28, mix: 0.3 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          use_synth :blade
          8.times do
            play am_melody.tick, release: 0.45, cutoff: rrand(85, 108), amp: 1.8
            sleep 0.5
            play am_bass_ring.look, release: 0.3, cutoff: 80, amp: 0.5
            sleep 0.5
          end
        end
      end

      # --- Harmony: hollow pads + dark ambience drone ---
      use_synth :dark_ambience
      play :a2, cutoff: 85, release: 8, amp: 0.8

      with_fx :reverb, room: 0.3, mix: 0.3 do
        with_fx :lpf, cutoff: 95, mix: 1.0 do
          use_synth :hollow
          4.times do
            play_chord am_chords.tick, cutoff: am_filter.tick, release: 2.2, amp: 0.85
            sleep 2
          end
        end
      end

      # --- Bass: bass_foundation + subpulse root pulse ---
      use_synth :bass_foundation
      play :a1, cutoff: 65, release: 8, amp: 1.1

      use_synth :subpulse
      8.times do
        play am_bass_ring.tick, cutoff: 72, release: 0.8, amp: 1.05
        sleep 1
      end

      # --- Percussion: sparse, gentle opening beat ---
      with_fx :hpf, cutoff: 90, mix: 1.0 do
        8.times do
          sample :bd_808, amp: 1.5, cutoff: 90
          sample :hat_cab, amp: 0.55, rate: 1.1
          sleep 0.5
          sample :hat_cab, amp: 0.38, rate: 0.95
          sleep 0.5
          sample :elec_snare, amp: 1.1
          sample :hat_cab, amp: 0.5, rate: 1.0
          sleep 0.5
          sample :hat_cab, amp: 0.35, rate: 0.9
          sleep 0.5
          sample :bd_808, amp: 1.3, cutoff: 85
          sample :hat_cab, amp: 0.5, rate: 1.05
          sleep 0.5
          sample :hat_cab, amp: 0.32, rate: 1.0
          sample :elec_blip, amp: 0.45, rate: rrand(0.8, 1.2) if one_in(5)
          sleep 0.5
          sample :elec_snare, amp: 1.0
          sample :hat_cab, amp: 0.48, rate: 1.0
          sleep 0.5
          sample :hat_cab, amp: 0.3, rate: 0.92
          sleep 0.5
        end
      end
    end

    # ============================================================
    # TRANSITION: Am -> Am Build — prophet drone bridge
    # ============================================================
    use_synth :prophet
    play :a2, cutoff: 90, release: 8, amp: 1.2
    sleep 4

    # ============================================================
    # SECTION 2: Build in Am — chiplead shimmer, supersaw pads, tb303 bass, fuller drums
    # ============================================================
    chip_am          = (ring :e5, :a4, :b4, :c5, :e5, :d5, :c5, :b4)
    am_walk          = (ring :a1, :a1, :c2, :e2, :a1, :g1, :e2, :a1)
    am_build_chords  = (ring chord(:a3, :minor), chord(:c3, :major), chord(:g3, :major), chord(:e3, :major))
    saw_filter       = (line 85, 110, steps: 16)

    2.times do
      # --- Melody: chiplead with echo shimmer ---
      use_synth :sine
      play :a2, release: 8, cutoff: 80, amp: 0.7

      with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
        use_synth :chiplead
        8.times do
          play chip_am.tick, release: 0.35, cutoff: (line 88, 115, steps: 16).tick, amp: 1.9
          sleep 0.5
          play scale(:a3, :minor_pentatonic).choose, release: 0.15, cutoff: rrand(80, 100), amp: 1.0
          sleep 0.5
        end
      end

      # --- Harmony: dark ambience drone + supersaw pads ---
      use_synth :dark_ambience
      play :a2, cutoff: 90, release: 8, amp: 0.7

      use_synth :supersaw
      4.times do
        play_chord am_build_chords.tick, cutoff: saw_filter.tick, release: 2.0, amp: 0.75
        sleep 2
      end

      # --- Bass: bass_foundation + tb303 walking pulse ---
      use_synth :bass_foundation
      play :a1, cutoff: 68, release: 8, amp: 1.0

      with_fx :lpf, cutoff: 82, mix: 1.0 do
        use_synth :tb303
        8.times do
          play am_walk.tick, cutoff: 78, release: 0.5, wave: 0, amp: 1.0
          sleep 1
        end
      end

      # --- Percussion: fuller beat with more drive ---
      8.times do
        sample :bd_808, amp: 1.6, cutoff: 95
        sample :drum_cymbal_closed, amp: 0.65, rate: 1.1
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.42, rate: 1.0
        sleep 0.5
        sample :elec_snare, amp: 1.3
        sample :hat_zild, amp: 0.55, rate: 1.05
        sleep 0.5
        sample :hat_cab, amp: 0.38, rate: 0.95
        sample :elec_blip, amp: 0.5, rate: rrand(1.0, 1.5) if one_in(4)
        sleep 0.5
        sample :bd_808, amp: 1.4, cutoff: 88
        sample :drum_cymbal_closed, amp: 0.6, rate: 1.05
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.38, rate: 1.0
        sleep 0.5
        sample :elec_snare, amp: 1.2
        sample :hat_zild, amp: 0.6, rate: 1.0
        sleep 0.5
        sample :hat_cab, amp: 0.35, rate: 0.9
        sample :elec_blip, amp: 0.55, rate: rrand(0.7, 1.3) if one_in(5)
        sleep 0.5
      end
    end

    # ============================================================
    # TRANSITION: Am -> Cm — blade drone + sparse percussion bridge
    # ============================================================
    use_synth :blade
    play :c3, cutoff: 90, release: 8, amp: 1.2

    use_synth :hollow
    play_chord chord(:c3, :minor), cutoff: 88, release: 8, amp: 0.9

    use_synth :subpulse
    play :c2, cutoff: 70, release: 6, amp: 1.1

    sample :bd_808, amp: 1.4, cutoff: 90
    sleep 1
    sample :elec_snare, amp: 1.0
    sample :hat_zild, amp: 0.5
    sleep 1
    sample :bd_808, amp: 1.3, cutoff: 85
    sleep 1
    sample :hat_zild, amp: 0.45
    sample :elec_blip, amp: 0.55, rate: 1.2
    sleep 1

    # ============================================================
    # SECTION 3: Cm dreamy — sine lead, hollow pads, subpulse bass, soft groove
    # ============================================================
    cm_melody    = (ring :c5, :eb5, :g4, :c5, :bb4, :ab4, :g4, :eb4)
    cm_bass_mel  = (ring :c2, :c2, :g2, :ab2)
    cm_chords    = (ring chord(:c3, :minor), chord(:ab3, :major), chord(:eb3, :major), chord(:bb3, :major))
    cm_filter    = (line 82, 105, steps: 8)
    cm_bass_ring = (ring :c2, :c2, :g2, :ab2)

    2.times do
      # --- Melody: blade pad + sine melodic lead ---
      use_synth :sine
      play :c2, release: 8, cutoff: 80, amp: 0.9

      with_fx :reverb, room: 0.3, mix: 0.32 do
        with_fx :lpf, cutoff: 105, mix: 1.0 do
          use_synth :blade
          play :c3, release: 8, cutoff: 80, amp: 0.5
          use_synth :sine
          8.times do
            play cm_melody.tick, release: 0.5, cutoff: rrand(88, 115), amp: 1.9
            sleep 0.5
            play cm_bass_mel.look, release: 0.3, cutoff: 80, amp: 0.6
            sleep 0.5
          end
        end
      end

      # --- Harmony: dark ambience drone + hollow pads ---
      use_synth :dark_ambience
      play :c2, cutoff: 88, release: 8, amp: 0.85

      with_fx :reverb, room: 0.35, mix: 0.3 do
        with_fx :lpf, cutoff: 100, mix: 1.0 do
          use_synth :hollow
          4.times do
            play_chord cm_chords.tick, cutoff: cm_filter.tick, release: 2.3, amp: 0.9
            sleep 2
          end
        end
      end

      # --- Bass: bass_foundation + subpulse in Cm ---
      use_synth :bass_foundation
      play :c2, cutoff: 65, release: 8, amp: 1.1

      use_synth :subpulse
      8.times do
        play cm_bass_ring.tick, cutoff: 74, release: 0.85, amp: 1.05
        sleep 1
      end

      # --- Percussion: soft Cm groove with space ---
      with_fx :reverb, room: 0.25, mix: 0.22 do
        8.times do
          sample :bd_808, amp: 1.5, cutoff: 88
          sample :hat_cab, amp: 0.58, rate: 1.0
          sleep 0.5
          sample :hat_cab, amp: 0.36, rate: 0.9
          sleep 0.5
          sample :elec_snare, amp: 1.15
          sample :hat_zild, amp: 0.5, rate: 1.05
          sleep 0.5
          sample :hat_cab, amp: 0.32, rate: 0.95
          sleep 0.5
          sample :bd_808, amp: 1.3, cutoff: 85
          sample :drum_cymbal_closed, amp: 0.55, rate: 1.0
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.35, rate: 0.95
          sample :elec_blip, amp: 0.48, rate: rrand(0.8, 1.2) if one_in(4)
          sleep 0.5
          sample :elec_snare, amp: 1.1
          sample :hat_zild, amp: 0.52, rate: 1.0
          sleep 0.5
          sample :hat_cab, amp: 0.3, rate: 0.88
          sleep 0.5
        end
      end
    end

    # ============================================================
    # TRANSITION: Cm dreamy -> Cm finale — prophet drone bridge
    # ============================================================
    use_synth :prophet
    play :c3, cutoff: 90, release: 8, amp: 1.2
    sleep 4

    # ============================================================
    # SECTION 4: Cm finale — chiplead shimmer, supersaw climax, tb303 pumping, full drums
    # ============================================================
    cm_chip          = (ring :g5, :eb5, :c5, :bb4, :ab4, :g4, :eb5, :c5)
    cm_walk          = (ring :c2, :eb2, :g2, :c2, :bb1, :ab1, :g1, :c2)
    cm_finale_chords = (ring chord(:c3, :minor), chord(:eb3, :major), chord(:bb3, :major), chord(:ab3, :major))
    finale_filter    = (line 88, 118, steps: 16)

    2.times do
      # --- Melody: chiplead shimmer with echo ---
      use_synth :sine
      play :c2, release: 8, cutoff: 80, amp: 0.8

      with_fx :echo, phase: 0.5, decay: 1.8, mix: 0.22 do
        use_synth :chiplead
        8.times do
          play cm_chip.tick, release: 0.35, cutoff: (line 90, 120, steps: 16).tick, amp: 1.85
          sleep 0.5
          play scale(:c3, :minor_pentatonic).choose, release: 0.15, cutoff: rrand(82, 105), amp: 0.95
          sleep 0.5
        end
      end

      # --- Harmony: dark ambience drone + supersaw sweeping filter ---
      use_synth :dark_ambience
      play :c2, cutoff: 92, release: 8, amp: 0.75

      use_synth :supersaw
      4.times do
        play_chord cm_finale_chords.tick, cutoff: finale_filter.tick, release: 2.1, amp: 0.8
        sleep 2
      end

      # --- Bass: bass_foundation + tb303 pumping pulse ---
      use_synth :bass_foundation
      play :c2, cutoff: 68, release: 8, amp: 1.0

      use_synth :tb303
      8.times do
        play cm_walk.tick, cutoff: 80, release: 0.5, wave: 0, amp: 1.0
        sleep 1
      end

      # --- Percussion: full energy finale pattern ---
      8.times do
        sample :bd_808, amp: 1.7, cutoff: 95
        sample :hat_zild, amp: 0.7, rate: 1.1
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.55, rate: 1.05
        sleep 0.5
        sample :elec_snare, amp: 1.4
        sample :hat_zild, amp: 0.65, rate: 1.0
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.4, rate: 1.0
        sample :elec_blip, amp: 0.6, rate: rrand(0.9, 1.4) if one_in(3)
        sleep 0.5
        sample :bd_808, amp: 1.5, cutoff: 90
        sample :hat_zild, amp: 0.6, rate: 1.05
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.5, rate: 1.0
        sleep 0.5
        sample :elec_snare, amp: 1.3
        sample :hat_zild, amp: 0.62, rate: 0.95
        sleep 0.5
        sample :hat_cab, amp: 0.38, rate: 0.9
        sample :elec_blip, amp: 0.55, rate: rrand(0.8, 1.5) if one_in(4)
        sleep 0.5
      end
    end

    # ============================================================
    # FADE-OUT: Sparse tail — blade drone, hollow pad, subpulse, light percussion
    # ============================================================
    use_synth :blade
    play :c2, cutoff: 80, release: 8, amp: 1.0

    use_synth :hollow
    play_chord chord(:c3, :minor), cutoff: 82, release: 8, amp: 0.7

    use_synth :subpulse
    play :c2, cutoff: 65, release: 8, amp: 0.9

    sample :bd_808, amp: 1.2, cutoff: 80
    sleep 1
    sample :hat_zild, amp: 0.4
    sleep 1
    sample :elec_snare, amp: 0.8
    sleep 1
    sample :hat_cab, amp: 0.3
    sleep 1

  end
end