# Digital Baroque
# Style: Baroque-electronic hybrid | Mood: Dynamic, building intensity

use_debug false
use_bpm 128

with_fx :level, amp: 1.0 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # =============================================
    # SECTION 1: Opening — Dm, baroque hybrid beat
    # Melody: chiplead baroque arpeggios
    # Harmony: blade drone + hollow chords
    # Bass: bass_foundation root + subpulse continuo
    # Percussion: light crisp baroque hybrid beat
    # =============================================

    dm_notes     = (ring :d4, :f4, :a4, :c5, :d5, :a4, :f4, :e4)
    dm_walk      = (ring :d2, :a2, :f2, :c2, :d2, :a2, :f2, :g2)
    dm_chords    = (ring chord(:d3, :minor), chord(:bb2, :major), chord(:f3, :major), chord(:c3, :major))

    2.times do
      # --- Melody drone underneath ---
      use_synth :fm
      play :d3, release: 8, divisor: 2, depth: 12, cutoff: 85, amp: 1.0

      # --- Harmony: blade sustained drone ---
      with_fx :reverb, room: 0.25, mix: 0.32 do
        use_synth :blade
        play_chord chord(:d2, :minor), cutoff: 85, release: 8, amp: 0.85
      end

      # --- Bass: sustained root ---
      use_synth :bass_foundation
      play :d2, cutoff: 68, release: 7.5, amp: 1.1

      # --- Melody: chiplead baroque arpeggios ---
      with_fx :reverb, room: 0.25, mix: 0.28 do
        use_synth :chiplead
        8.times do |i|
          # --- Harmony: hollow chord every 4 beats ---
          if i % 4 == 0
            use_synth :hollow
            play_chord dm_chords.tick, cutoff: (line 80, 105, steps: 4).look, release: 3.8, amp: 0.9
          end
          # --- Bass: subpulse continuo ---
          use_synth :subpulse
          play dm_walk.tick, cutoff: 72, release: 0.7, amp: 0.85

          # --- Melody notes ---
          use_synth :chiplead
          play dm_notes.tick, cutoff: (line 85, 115, steps: 16).look, release: 0.12, amp: 1.9
          # --- Percussion ---
          sample :bd_haus, amp: (i % 4 == 0 ? 1.6 : 1.3)
          sample :drum_cymbal_closed, amp: 0.7, rate: 1.1
          sleep 0.5

          use_synth :chiplead
          play dm_notes.tick, cutoff: (line 85, 115, steps: 16).look, release: 0.12, amp: 1.9
          sample :drum_cymbal_closed, amp: 0.5, rate: 1.2
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.45, rate: 1.0 if one_in(2)
          sleep 0.25

          # Beat 2
          use_synth :chiplead
          play dm_notes.tick, cutoff: (line 85, 115, steps: 16).look, release: 0.12, amp: 1.9
          sample :drum_snare_hard, amp: 1.2
          sample :hat_zild, amp: 0.7
          sleep 0.5

          use_synth :chiplead
          play dm_notes.tick, cutoff: (line 85, 115, steps: 16).look, release: 0.12, amp: 1.9
          sample :drum_cymbal_closed, amp: 0.5, rate: 1.1
          sleep 0.25
          sample :hat_zild, amp: 0.45 if one_in(3)
          sleep 0.25
        end
      end
    end

    # =============================================
    # SECTION 1 REPRISE: Dm with echo + rhodey arps
    # =============================================

    dm_harm      = (ring :d4, :a4, :f4, :c5)
    dm_arp       = (ring :d3, :f3, :a3, :c4, :f3, :a3, :d4, :a3)
    dm_pad_chords = (ring chord(:d3, :minor), chord(:a2, :minor), chord(:bb2, :major), chord(:c3, :major))
    dm_cont      = (ring :d2, :c2, :f2, :a2)

    2.times do
      # --- Melody drone ---
      use_synth :fm
      play :d3, release: 8, divisor: 3, depth: 16, cutoff: 90, amp: 0.9

      # --- Harmony: blade drone + hollow pads ---
      use_synth :blade
      play_chord chord(:d2, :minor), cutoff: 90, release: 8, amp: 0.8

      # --- Bass: foundation + tb303 continuo ---
      use_synth :bass_foundation
      play :d2, cutoff: 65, release: 7.5, amp: 1.05

      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          8.times do |i|
            # Harmony: rhodey arp + hollow pad
            with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.22 do
              use_synth :rhodey
              play dm_arp.tick, cutoff: rrand(85, 110), release: 0.55, amp: 0.9
            end
            if i % 4 == 0
              use_synth :hollow
              play_chord dm_pad_chords.tick, cutoff: 88, release: 3.8, amp: 0.85
            end

            # Melody
            use_synth :chiplead
            play dm_harm.tick, cutoff: rrand(88, 115), release: 0.15, amp: 2.0
            # Bass tb303
            use_synth :tb303
            play dm_cont.tick, cutoff: 78, res: 0.5, release: 0.6, amp: 0.8
            # Percussion
            sample :bd_haus, amp: (i % 4 == 0 ? 1.6 : 1.3)
            sample :drum_cymbal_closed, amp: 0.65, rate: 1.0
            sleep 0.5

            sample :elec_blip2, amp: 0.7, rate: 1.4 if one_in(3)
            use_synth :chiplead
            play dm_harm.look, cutoff: rrand(80, 105), release: 0.1, amp: 1.8
            use_synth :tb303
            play :d2, cutoff: 70, res: 0.4, release: 0.4, amp: 0.75
            sample :drum_cymbal_closed, amp: 0.5, rate: 1.15 if one_in(2)
            sleep 0.25
            sample :elec_hi_snare, amp: 0.6 if one_in(4)
            sleep 0.25

            sample :drum_snare_hard, amp: 1.1
            sample :hat_zild, amp: 0.65
            sleep 0.5

            sample :drum_cymbal_closed, amp: 0.4, rate: 1.0 if one_in(2)
            sleep 0.5
          end
        end
      end
    end

    # =============================================
    # TRANSITION: Dm -> Em drone bridge
    # =============================================

    use_synth :fm
    play :d2, cutoff: 90, release: 8, divisor: 2, depth: 10, amp: 1.2
    use_synth :blade
    play_chord chord(:d2, :minor), cutoff: 85, release: 8, amp: 0.75
    use_synth :hollow
    play_chord chord(:e2, :minor), cutoff: 82, release: 8, amp: 0.72
    use_synth :bass_foundation
    play :d1, cutoff: 65, release: 5, amp: 1.1
    use_synth :subpulse
    play :d2, cutoff: 70, release: 4, amp: 0.85
    sample :drum_snare_hard, amp: 1.0
    sleep 1
    sample :hat_zild, amp: 0.6
    sleep 1
    sample :bd_haus, amp: 1.4
    sleep 1
    sample :hat_zild, amp: 0.55
    sleep 1

    # =============================================
    # SECTION 2: Key change to Em — rising intensity
    # Melody: fm synth runs
    # Harmony: blade + hollow Em chords
    # Bass: bass_foundation + subpulse Em walk
    # Percussion: tighter electronic hybrid beat
    # =============================================

    em_notes     = (ring :e4, :gs4, :b4, :d5, :e5, :b4, :gs4, :fs4)
    em_chords    = (ring chord(:e3, :minor), chord(:c3, :major), chord(:g3, :major), chord(:d3, :major))
    em_walk      = (ring :e2, :b2, :gs2, :d2, :e2, :b2, :gs2, :a2)

    2.times do
      # --- Melody drones ---
      use_synth :fm
      play :e3, release: 8, divisor: 2, depth: 14, cutoff: 92, amp: 1.0
      use_synth :dsaw
      play :e2, release: 8, cutoff: 80, amp: 0.45

      # --- Harmony: blade Em drone ---
      with_fx :reverb, room: 0.3, mix: 0.35 do
        use_synth :blade
        play_chord chord(:e2, :minor), cutoff: 92, release: 8, amp: 0.88
      end

      # --- Bass: deep E root ---
      use_synth :bass_foundation
      play :e2, cutoff: 70, release: 7.5, amp: 1.1

      with_fx :hpf, cutoff: 90, mix: 1.0 do
        8.times do |i|
          # Harmony hollow chord every 4 steps
          if i % 4 == 0
            use_synth :hollow
            play_chord em_chords.tick, cutoff: (line 85, 112, steps: 4).look, release: 3.8, amp: 0.88
          end
          # Bass subpulse
          use_synth :subpulse
          play em_walk.tick, cutoff: 75, release: 0.75, amp: 0.9

          # Melody
          with_fx :reverb, room: 0.3, mix: 0.28 do
            use_synth :fm
            play em_notes.tick, cutoff: (line 90, 125, steps: 16).look, release: 0.1, amp: 1.9
          end

          # Percussion — beat 1
          sample :bd_haus, amp: (i % 4 == 0 ? 1.7 : 1.5)
          sample :drum_cymbal_closed, amp: 0.75, rate: 1.05
          sleep 0.25
          sample :bd_haus, amp: 1.2 if one_in(3)
          sleep 0.25

          use_synth :fm
          play em_notes.tick, cutoff: (line 90, 125, steps: 16).look, release: 0.1, amp: 1.9
          sample :elec_snare, amp: 0.8
          sample :drum_cymbal_closed, amp: 0.55, rate: 1.1
          sleep 0.25
          sample :drum_cymbal_closed, amp: 0.45, rate: 1.2 if one_in(2)
          sleep 0.25

          # Beat 2
          use_synth :fm
          play em_notes.tick, cutoff: (line 90, 125, steps: 16).look, release: 0.1, amp: 1.9
          sample :drum_snare_hard, amp: 1.3
          sample :elec_hi_snare, amp: 0.9
          sample :hat_zild, amp: 0.75
          sleep 0.5

          use_synth :fm
          play em_notes.tick, cutoff: (line 90, 125, steps: 16).look, release: 0.1, amp: 1.9
          sample :drum_cymbal_closed, amp: 0.5, rate: 1.0
          sleep 0.25
          sample :elec_snare, amp: 0.65 if one_in(3)
          sleep 0.25
        end
      end
    end

    # =============================================
    # TRANSITION: Em section bridge
    # =============================================

    use_synth :fm
    play :e3, release: 8, divisor: 2, depth: 10, cutoff: 90, amp: 1.1
    use_synth :blade
    play_chord chord(:e2, :minor), cutoff: 90, release: 8, amp: 0.82
    use_synth :bass_foundation
    play :e2, cutoff: 68, release: 8, amp: 1.0
    sleep 4

    # =============================================
    # SECTION 3: Climax — Em, full hybrid drum fury
    # Melody: dsaw runs
    # Harmony: blade + hollow + rhodey arps
    # Bass: bass_foundation + tb303 drive
    # Percussion: euclidean dense patterns
    # =============================================

    em_run       = (ring :e4, :fs4, :gs4, :a4, :b4, :a4, :gs4, :fs4,
                        :e4, :b3, :e4, :gs4, :b4, :e5, :b4, :gs4)
    em_arp       = (ring :e3, :gs3, :b3, :e4, :b3, :gs3, :d4, :b3,
                        :e4, :gs3, :b3, :d4, :e4, :b3, :gs3, :e3)
    em_pad_chords = (ring chord(:e3, :minor), chord(:b2, :minor), chord(:c3, :major), chord(:d3, :major))
    em_climax    = (ring :e2, :b2, :gs2, :a2, :e2, :d2, :b2, :e2)
    em_hits      = (spread 5, 8)
    kick_spread  = (spread 5, 8)
    snare_spread = (spread 3, 8)

    2.times do
      # --- Melody drones ---
      use_synth :fm
      play :e3, release: 16, divisor: 3, depth: 18, cutoff: 88, amp: 0.85
      use_synth :dsaw
      play :e2, release: 16, cutoff: 75, amp: 0.45

      # --- Harmony: blade + hollow drones ---
      use_synth :blade
      play_chord chord(:e2, :minor), cutoff: 95, release: 16, amp: 0.9
      use_synth :hollow
      play_chord chord(:e2, :minor7), cutoff: 88, release: 16, amp: 0.78

      # --- Bass: deep E1 root ---
      with_fx :lpf, cutoff: 85, mix: 1.0 do
        use_synth :bass_foundation
        play :e1, cutoff: 62, release: 15, amp: 1.15
      end

      with_fx :lpf, cutoff: 115, mix: 1.0 do
        16.times do |i|
          note = em_run.tick

          # Harmony: rhodey arp every step + hollow pad every 8 steps
          use_synth :rhodey
          play em_arp.tick, cutoff: (line 90, 120, steps: 16).look, release: 0.45, amp: 0.9
          if i % 8 == 0
            use_synth :hollow
            play_chord em_pad_chords.tick, cutoff: 92, release: 7.8, amp: 0.82
          end

          # Bass tb303 + subpulse
          use_synth :tb303
          play em_climax.tick, cutoff: 82, res: 0.55, release: 0.5, amp: 0.85

          # Melody dsaw
          use_synth :dsaw
          play note, cutoff: rrand(95, 120), release: 0.12, amp: 2.0

          # Percussion euclidean
          sample :bd_haus, amp: 1.7 if kick_spread.tick
          sample :drum_cymbal_closed, amp: 0.8, rate: 1.1
          sample :elec_blip, amp: 0.8, rate: 1.2 if em_hits.look
          sample :hat_snap, amp: 0.6 if one_in(4)
          sleep 0.25

          sample :elec_hi_snare, amp: 1.0 if snare_spread.look
          sample :drum_cymbal_closed, amp: 0.55, rate: 1.05 if one_in(2)

          use_synth :subpulse
          play :e2, cutoff: 74, release: 0.35, amp: 0.78
          sleep 0.25

          sample :drum_snare_hard, amp: 1.4 if snare_spread.look
          sample :hat_zild, amp: 0.75
          sleep 0.25

          sample :elec_snare, amp: 0.9 if one_in(2)
          sample :drum_cymbal_closed, amp: 0.5, rate: 1.2 if one_in(2)
          sleep 0.25
        end
      end
    end

    # =============================================
    # OUTRO: Em resolution — fade and decay
    # =============================================

    with_fx :reverb, room: 0.3, mix: 0.35 do
      use_synth :blade
      play_chord chord(:e3, :minor), cutoff: 90, release: 12, amp: 0.85
      use_synth :hollow
      play_chord chord(:e2, :minor), cutoff: 85, release: 10, amp: 0.75
      use_synth :rhodey
      play_chord chord(:e4, :minor), cutoff: 100, release: 8, amp: 0.72
    end

    use_synth :fm
    play :e3, release: 12, divisor: 2, depth: 8, cutoff: 90, amp: 1.1
    use_synth :chiplead
    play :e5, release: 6, cutoff: 100, amp: 1.8
    use_synth :bass_foundation
    play :e2, cutoff: 68, release: 10, amp: 1.1
    use_synth :subpulse
    play :e1, cutoff: 65, release: 8, amp: 0.9

    with_fx :reverb, room: 0.25, mix: 0.25 do
      4.times do
        sample :drum_snare_hard, amp: 1.1
        sleep 0.5
        sample :elec_hi_snare, amp: 0.8
        sleep 0.5
        sample :hat_zild, amp: 0.6
        sleep 0.5
        sample :drum_cymbal_closed, amp: 0.5, rate: 1.0
        sleep 0.5
      end
    end

  end
end