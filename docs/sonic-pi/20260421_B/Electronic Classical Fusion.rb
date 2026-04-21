use_debug false
use_bpm 128

# Electronic Classical Fusion
# Dramatic electronic piece with key change from C major to A minor

with_fx :level, amp: 0.8 do

  # Main melody - Lead voice
  live_loop :melody do
    use_synth :mod_saw
    with_fx :reverb, room: 0.4, mix: 0.4 do
      with_fx :lpf, cutoff: 100, mix: 0.5 do
        # C major section (bars 1-2)
        play :c4, cutoff: 110, release: 0.4, amp: 1.3
        sleep 0.5
        play :e4, cutoff: 100, release: 0.3, amp: 1.2
        sleep 0.5
        play :g4, cutoff: 120, release: 0.5, amp: 1.4
        sleep 1
        play :c5, cutoff: 130, release: 0.8, amp: 1.5
        sleep 1
        play :b4, cutoff: 115, release: 0.4, amp: 1.3
        sleep 0.5
        play :g4, cutoff: 100, release: 0.3, amp: 1.2
        sleep 0.5

        # A minor section (bars 3-4)
        use_synth :pluck
        play :a4, cutoff: 105, release: 0.6, amp: 1.4
        sleep 0.5
        play :c5, cutoff: 120, release: 0.4, amp: 1.3
        sleep 0.5
        play :e5, cutoff: 125, release: 0.5, amp: 1.5
        sleep 0.5
        play :d5, cutoff: 110, release: 0.3, amp: 1.2
        sleep 0.5
        play :c5, cutoff: 115, release: 0.8, amp: 1.4
        sleep 1
        play :b4, cutoff: 100, release: 0.4, amp: 1.3
        sleep 0.5
        play :a4, cutoff: 90, release: 1.0, amp: 1.5
        sleep 0.5
      end
    end
  end

  # Harmonic chord progression
  live_loop :harmony do
    use_synth :piano
    with_fx :reverb, room: 0.4, mix: 0.4 do
      # C major section
      play_chord chord(:c4, :major), sustain: 1.5, release: 0.5, amp: 0.5, cutoff: 90
      sleep 2
      play_chord chord(:g3, :major), sustain: 1.5, release: 0.5, amp: 0.5, cutoff: 85
      sleep 2

      # A minor section
      play_chord chord(:a3, :minor), sustain: 1.5, release: 0.5, amp: 0.5, cutoff: 90
      sleep 2
      play_chord chord(:e3, :minor), sustain: 1.5, release: 0.5, amp: 0.5, cutoff: 85
      sleep 2
    end
  end

  # Deep pad foundation
  live_loop :pad_foundation do
    use_synth :blade
    with_fx :reverb, room: 0.4, mix: 0.4 do
      # C major section
      play_chord chord(:c3, :major), sustain: 3.5, release: 0.5, amp: 0.3, cutoff: 85
      sleep 2
      play_chord chord(:g2, :major), sustain: 1.5, release: 0.5, amp: 0.3, cutoff: 80
      sleep 2

      # A minor section
      play_chord chord(:a2, :minor), sustain: 1.5, release: 0.5, amp: 0.35, cutoff: 85
      sleep 2
      play_chord chord(:e2, :minor), sustain: 1.5, release: 0.5, amp: 0.3, cutoff: 80
      sleep 2
    end
  end

  # Atmospheric texture layer
  live_loop :atmosphere do
    use_synth :dark_ambience
    with_fx :reverb, room: 0.5, mix: 0.45 do
      play :c2, sustain: 3.5, release: 0.5, amp: 0.25, cutoff: 90
      sleep 4
      play :a1, sustain: 3.5, release: 0.5, amp: 0.25, cutoff: 90
      sleep 4
    end
  end

  # Arpeggiated harmony
  live_loop :arp_harmony do
    use_synth :hollow

    notes_c = (ring :c3, :e3, :g3, :c4)
    4.times do
      play notes_c.tick, cutoff: (line 85, 105, steps: 4).look, release: 0.3, amp: 0.4
      sleep 0.5
    end

    notes_g = (ring :g2, :b2, :d3, :g3)
    4.times do
      play notes_g.tick, cutoff: (line 85, 105, steps: 4).look, release: 0.3, amp: 0.4
      sleep 0.5
    end

    notes_a = (ring :e3, :c3, :a2, :e2)
    4.times do
      play notes_a.tick, cutoff: (line 100, 80, steps: 4).look, release: 0.3, amp: 0.4
      sleep 0.5
    end

    notes_e = (ring :e3, :c3, :a2, :e2)
    4.times do
      play notes_e.tick, cutoff: (line 100, 80, steps: 4).look, release: 0.3, amp: 0.4
      sleep 0.5
    end
  end

  # Main percussion
  live_loop :main_perc do
    with_fx :hpf, cutoff: 100, mix: 0.3 do
      with_fx :reverb, room: 0.25, mix: 0.25 do
        # Bar 1
        sample :bd_haus, amp: 1.2, cutoff: 95
        sleep 0.5
        sample :hat_cats, amp: 0.5, release: 0.1
        sleep 0.5
        sample :bd_haus, amp: 0.7, cutoff: 90
        sleep 0.5
        sample :hat_cats, amp: 0.5, release: 0.1
        sleep 0.5

        # Bar 2
        sample :bd_haus, amp: 0.7, cutoff: 90
        sample :elec_snare, amp: 0.6, cutoff: 100
        sleep 0.5
        sample :hat_cats, amp: 0.5, release: 0.1
        sleep 0.5
        sample :bd_haus, amp: 0.7, cutoff: 90
        sleep 0.5
        sample :hat_cats, amp: 0.55, release: 0.1
        sleep 0.5

        # Bar 3
        sample :bd_haus, amp: 0.8, cutoff: 95
        sleep 0.5
        sample :hat_cats, amp: 0.5, release: 0.1
        sleep 0.5
        sample :bd_haus, amp: 0.7, cutoff: 90
        sample :elec_snare, amp: 0.65, cutoff: 105
        sleep 0.5
        sample :hat_cats, amp: 0.5, release: 0.1
        sleep 0.5

        # Bar 4
        sample :bd_haus, amp: 0.7, cutoff: 90
        sleep 0.5
        sample :hat_cats, amp: 0.5, release: 0.1
        sleep 0.5
        sample :bd_haus, amp: 0.7, cutoff: 90
        sample :elec_snare, amp: 0.6, cutoff: 100
        sleep 0.5
        sample :hat_cats, amp: 0.55, release: 0.1
        sleep 0.5
      end
    end
  end

  # Cymbals and timpani accents
  live_loop :accents do
    with_fx :lpf, cutoff: 100, mix: 0.4 do
      # Timpani on chord changes
      sample :bd_haus, amp: 0.65, rate: 0.7, cutoff: 80
      sleep 2
      sample :bd_haus, amp: 0.55, rate: 0.7, cutoff: 80
      sleep 1.5
      sample :elec_cymbal, amp: 0.3, rate: 0.9, release: 0.5 if one_in(2)
      sleep 0.5

      sample :bd_haus, amp: 0.6, rate: 0.65, cutoff: 75
      sleep 2
      sample :bd_haus, amp: 0.6, rate: 0.65, cutoff: 75
      sleep 2
    end
  end

end