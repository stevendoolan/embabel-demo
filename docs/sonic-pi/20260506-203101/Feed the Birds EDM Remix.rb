# Feed the Birds EDM Remix
# Style: House | Mood: Uplifting, euphoric
# Key: D major -> F major | BPM: 128

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # ============================================================
    # SECTION 1 — Intro Build (D major)
    # Supersaw drone + hollow pad + sub bass + four-on-the-floor
    # ============================================================
    2.times do
      # Long drone pads underneath
      use_synth :supersaw
      play :d3, release: 16, cutoff: 85, amp: 0.32

      use_synth :hollow
      play_chord chord(:d3, :major7), cutoff: 85, release: 16, amp: 0.42

      # Sub-bass root sustain
      use_synth :bass_foundation
      play :d1, cutoff: 65, release: 16, amp: 0.68

      # Harmony arpeggio thread
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.28 do
          d_arp = (ring :d3, :fs3, :a3, :cs4, :d4, :a3, :fs3, :cs4)
          cutoff_line = (line 80, 100, steps: 16)
          16.times do
            use_synth :fm
            play d_arp.tick, cutoff: cutoff_line.look, release: 0.18, divisor: 2.0, depth: 1.5, amp: 0.38
            sleep 0.5
          end
        end
      end

      # Bass sub hits thread
      in_thread do
        8.times do |i|
          use_synth :subpulse
          beat_amp = (i % 2 == 0) ? 0.72 : 0.48
          play :d1, cutoff: 72, release: 0.45, amp: beat_amp
          sleep 0.5
          use_synth :subpulse
          play :a1, cutoff: 68, release: 0.3, amp: beat_amp * 0.72
          sleep 0.5
        end
      end

      # Percussion thread
      in_thread do
        with_fx :hpf, cutoff: 100, mix: 1.0 do
          16.times do |i|
            sample :bd_haus, amp: (i % 8 == 0 ? 0.82 : 0.62)
            sample :hat_cab, amp: (i % 2 == 0 ? 0.42 : 0.28)
            sleep 0.5
            sample :drum_snare_hard, amp: 0.60 if i % 4 == 1
            sample :hat_cab, amp: 0.25
            sample :drum_cymbal_open, amp: 0.35 if one_in(8)
            sleep 0.5
          end
        end
      end

      sleep 16
    end

    # ============================================================
    # TRANSITION — Drone bridge (intro -> drop)
    # ============================================================
    use_synth :blade
    play :d3, cutoff: 90, release: 8, amp: 0.55
    sleep 4

    # ============================================================
    # SECTION 2 — Melodic Drop (D major)
    # Supersaw melody + rhodey chords + tb303 bass + full house beat
    # ============================================================
    melody_d = (ring :fs4, :e4, :d4, :a4, :fs4, :e4, :d4, :d5,
                     :a4, :gs4, :a4, :b4, :a4, :g4, :fs4, :e4,
                     :fs4, :e4, :d4, :a4, :fs4, :e4, :d4, :d5,
                     :a4, :b4, :a4, :g4, :fs4, :e4, :d4, :d4)
    mel_dur_d = (ring 1, 0.5, 0.5, 1, 1, 0.5, 0.5, 1,
                      0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5,
                      1, 0.5, 0.5, 1, 1, 0.5, 0.5, 1,
                      0.5, 0.5, 0.5, 0.5, 1, 0.5, 0.5, 1)

    d_chords = (ring
      chord(:d3, :major7), chord(:d3, :major7),
      chord(:g3, :major7), chord(:g3, :major7),
      chord(:a3, :sus4),   chord(:a3, :sus4),
      chord(:a3, :major),  chord(:a3, :major)
    )

    d_drop_arp = (ring
      :d3, :fs3, :a3, :cs4,
      :g3, :b3,  :d4, :fs4,
      :a3, :d4,  :e4, :a4,
      :a3, :cs4, :e4, :a4
    )

    bass_notes_d = (ring :d2, :d2, :a2, :a2, :fs2, :fs2, :g2, :g2,
                         :d2, :d2, :a2, :a2, :e2, :e2, :a1, :a1,
                         :d2, :d2, :a2, :a2, :fs2, :fs2, :g2, :g2,
                         :d2, :d2, :e2, :e2, :a1, :a1, :d2, :d2)

    2.times do
      # Long drone pads
      use_synth :blade
      play :d3, release: 16, cutoff: 88, amp: 0.28

      use_synth :hollow
      play_chord d_chords.look, cutoff: 88, release: 16, amp: 0.35

      # Bass foundation sustain
      use_synth :bass_foundation
      play :d1, cutoff: 62, release: 16, amp: 0.62

      # Harmony chords + arpeggio thread
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          # Rhodey half-bar chord stabs
          in_thread do
            8.times do
              use_synth :rhodey
              play_chord d_chords.look, cutoff: rrand(82, 100), release: 0.55, amp: 0.45
              d_chords.tick
              sleep 2
            end
          end
          # FM arpeggio eighth-note pulse
          cutoff_drop = (line 85, 110, steps: 32)
          32.times do
            use_synth :fm
            play d_drop_arp.tick, cutoff: cutoff_drop.look, release: 0.15, divisor: 1.5, depth: 2.0, amp: 0.35
            sleep 0.5
          end
        end
      end

      # Bass tb303 rolling line thread
      in_thread do
        with_fx :lpf, cutoff: 85, mix: 1.0 do
          use_synth :tb303
          bass_notes_d.length.times do |i|
            accent = (i % 4 == 0) ? 0.72 : (i % 2 == 0 ? 0.58 : 0.46)
            play bass_notes_d.tick, cutoff: rrand(72, 84), release: 0.42, wave: 0, amp: accent
            sleep 0.5
          end
        end
      end

      # Percussion thread
      in_thread do
        with_fx :hpf, cutoff: 100, mix: 1.0 do
          16.times do |i|
            sample :bd_haus, amp: (i % 8 == 0 ? 0.85 : 0.65)
            sample :hat_cab, amp: (i % 4 == 0 ? 0.46 : 0.30)
            sleep 0.5
            sample :drum_snare_hard, amp: 0.65 if i % 4 == 1
            sample :elec_snare, amp: 0.38 if i % 4 == 1
            sample :elec_snare, amp: 0.32 if one_in(5)
            sample :hat_cab, amp: 0.26
            sample :drum_cymbal_open, amp: 0.38 if i % 8 == 5
            sleep 0.5
          end
        end
      end

      # Supersaw melody (lead voice)
      with_fx :lpf, cutoff: 110, mix: 1.0 do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          use_synth :supersaw
          melody_d.length.times do
            play melody_d.tick, cutoff: rrand(88, 108), release: mel_dur_d.look * 0.85, amp: 0.92
            sleep mel_dur_d.look
          end
        end
      end
    end

    # ============================================================
    # TRANSITION — Drone bridge (D -> F key change)
    # ============================================================
    use_synth :blade
    play :d3, cutoff: 90, release: 8, amp: 0.55
    sleep 2

    use_synth :hollow
    play_chord chord(:d3, :major7), cutoff: 90, release: 6, amp: 0.42
    use_synth :bass_foundation
    play :d1, cutoff: 65, release: 4, amp: 0.62

    in_thread do
      with_fx :hpf, cutoff: 100, mix: 1.0 do
        4.times do |i|
          sample :bd_haus, amp: 0.60
          sample :hat_tap, amp: 0.28
          sleep 0.5
          sample :hat_tap, amp: 0.20
          sleep 0.5
        end
      end
    end

    sleep 2

    use_synth :blade
    play :f3, cutoff: 90, release: 8, amp: 0.55
    use_synth :hollow
    play_chord chord(:f3, :major7), cutoff: 90, release: 6, amp: 0.42
    use_synth :bass_foundation
    play :f1, cutoff: 65, release: 4, amp: 0.62
    sleep 2

    # ============================================================
    # SECTION 3 — Key Change to F major, uplifting climax
    # winwood_lead melody + rhodey sus4 stabs + subpulse + full beat
    # ============================================================
    melody_f = (ring :a4, :g4, :f4, :c5, :a4, :g4, :f4, :f5,
                     :c5, :b4, :c5, :d5, :c5, :as4, :a4, :g4,
                     :a4, :g4, :f4, :c5, :a4, :g4, :f4, :f5,
                     :c5, :d5, :c5, :as4, :a4, :g4, :f4, :f4)
    mel_dur_f = (ring 1, 0.5, 0.5, 1, 1, 0.5, 0.5, 1,
                      0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5,
                      1, 0.5, 0.5, 1, 1, 0.5, 0.5, 1,
                      0.5, 0.5, 0.5, 0.5, 1, 0.5, 0.5, 1)

    f_chords = (ring
      chord(:f3, :major7), chord(:f3, :major7),
      chord(:bb3, :major7), chord(:bb3, :major7),
      chord(:c4, :sus4),    chord(:c4, :sus4),
      chord(:c4, :major),   chord(:c4, :major)
    )

    f_drop_arp = (ring
      :f3, :a3, :c4, :e4,
      :bb3, :d4, :f4, :a4,
      :c4, :f4, :g4, :c5,
      :c4, :e4, :g4, :c5
    )

    bass_notes_f = (ring :f2, :f2, :c3, :c3, :a2, :a2, :as2, :as2,
                         :f2, :f2, :c3, :c3, :g2, :g2, :c2, :c2,
                         :f2, :f2, :c3, :c3, :a2, :a2, :as2, :as2,
                         :f2, :f2, :g2, :g2, :c2, :c2, :f2, :f2)

    2.times do
      with_fx :reverb, room: 0.3, mix: 0.28 do
        # Long drone pads in F
        use_synth :blade
        play :f3, release: 16, cutoff: 95, amp: 0.30

        use_synth :hollow
        play_chord f_chords.look, cutoff: 92, release: 16, amp: 0.38

        # Sub-bass sustain in F
        use_synth :subpulse
        play :f1, cutoff: 68, release: 16, amp: 0.68

        # Harmony chords + arpeggio thread
        in_thread do
          # Rhodey chord stabs
          in_thread do
            8.times do
              use_synth :rhodey
              play_chord f_chords.look, cutoff: rrand(88, 112), release: 0.6, amp: 0.48
              f_chords.tick
              sleep 2
            end
          end
          # FM arpeggio climax
          cutoff_climb = (line 90, 120, steps: 32)
          32.times do
            use_synth :fm
            play f_drop_arp.tick, cutoff: cutoff_climb.look, release: 0.14, divisor: 1.5, depth: 2.5, amp: 0.37
            sleep 0.5
          end
        end

        # Bass tb303 rolling line in F thread
        in_thread do
          use_synth :tb303
          bass_notes_f.length.times do |i|
            accent = (i % 4 == 0) ? 0.74 : (i % 2 == 0 ? 0.60 : 0.48)
            play bass_notes_f.tick, cutoff: rrand(75, 88), release: 0.42, wave: 0, amp: accent
            sleep 0.5
          end
        end

        # Percussion thread — most energetic
        in_thread do
          with_fx :hpf, cutoff: 100, mix: 1.0 do
            16.times do |i|
              sample :bd_haus, amp: (i % 8 == 0 ? 0.88 : 0.68)
              sample :hat_cab, amp: (i % 2 == 0 ? 0.48 : 0.32)
              sample :hat_tap, amp: 0.26 if one_in(3)
              sleep 0.5
              if i % 4 == 1
                sample :drum_snare_hard, amp: 0.70
                sample :elec_snare, amp: 0.42
              end
              sample :elec_snare, amp: 0.35 if one_in(4)
              sample :drum_cymbal_open, amp: 0.42 if i % 8 == 5
              sample :drum_cymbal_open, amp: 0.28 if i % 16 == 13
              sample :hat_zap, amp: 0.32
              sleep 0.5
            end
          end
        end

        # winwood_lead melody (lead voice)
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.2 do
          use_synth :winwood_lead
          melody_f.length.times do
            play melody_f.tick, cutoff: rrand(90, 115), release: mel_dur_f.look * 0.88, amp: 0.95
            sleep mel_dur_f.look
          end
        end
      end
    end

    # ============================================================
    # TRANSITION — Drone into outro
    # ============================================================
    use_synth :blade
    play :f3, cutoff: 90, release: 8, amp: 0.55
    sleep 4

    # ============================================================
    # SECTION 4 — Outro (F major fade)
    # winwood_lead simple phrases + hollow pad + subpulse + sparse beat
    # ============================================================
    outro_arp_notes = (ring :f3, :a3, :c4, :f4, :c4, :a3)

    2.times do
      # Sustained hollow pad fading out
      use_synth :hollow
      play_chord chord(:f3, :major7), cutoff: 85, release: 8, amp: 0.32

      use_synth :bass_foundation
      play :f1, cutoff: 62, release: 8, amp: 0.58

      # Gentle subpulse bass wind-down thread
      in_thread do
        use_synth :bass_foundation
        play :f1, cutoff: 62, release: 8, amp: 0.55
        use_synth :subpulse
        [[:f2, 2], [:c3, 1], [:as2, 1], [:f2, 2], [:c3, 1], [:f2, 1]].each do |n, d|
          play n, cutoff: 70, release: d * 0.75, amp: 0.50
          sleep d
        end
      end

      # Rhodey outro arpeggios thread
      in_thread do
        8.times do
          use_synth :rhodey
          play outro_arp_notes.tick, cutoff: rrand(80, 95), release: 0.5, amp: 0.35
          sleep 0.5
        end
      end

      # Sparse outro percussion thread
      in_thread do
        with_fx :hpf, cutoff: 100, mix: 1.0 do
          8.times do |i|
            sample :bd_haus, amp: (i % 4 == 0 ? 0.72 : 0.50)
            sample :hat_cab, amp: (i % 2 == 0 ? 0.35 : 0.22)
            sleep 0.5
            sample :drum_snare_hard, amp: 0.50 if i % 4 == 1
            sample :hat_tap, amp: 0.20
            sleep 0.5
          end
        end
      end

      # winwood_lead simple outro phrases (lead voice)
      use_synth :winwood_lead
      [[:a4, 1], [:g4, 0.5], [:f4, 0.5], [:c5, 1], [:f4, 1], [:f5, 2]].each do |n, d|
        play n, cutoff: rrand(85, 105), release: d * 0.85, amp: 0.90
        sleep d
      end

      sleep 2
    end

  end
end