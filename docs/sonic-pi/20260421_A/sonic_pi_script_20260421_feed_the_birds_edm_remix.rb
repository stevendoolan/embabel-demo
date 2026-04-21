# Feed the Birds (EDM Remix)
# Electronic/Uplifting EDM Remix in F Major

use_bpm 128

# Kick and snare drums
live_loop :edm_drums do
  with_fx :distortion, distort: 0.3 do
    sample :bd_haus, amp: 0.8, cutoff: 100
    sleep 0.5
    sample :drum_snare_hard, amp: 0.6
    sleep 0.5
  end
end

# Hi-hats and cymbal accents
live_loop :hi_hats_cymbals do
  with_fx :reverb, room: 0.3 do
    8.times do
      sample :hat_zild, amp: 0.4, rate: 1.5
      sleep 0.25
    end
    at 7.5 do
      with_fx :echo, phase: 0.5, decay: 3, mix: 0.4 do
        sample :elec_cymbal, amp: 0.3, rate: 0.9
      end
    end
  end
end

# Bass line
live_loop :edm_bass do
  use_synth :tb303
  use_synth_defaults cutoff: 70, res: 0.8, release: 0.4

  2.times do
    play :f2, amp: 0.7
    sleep 0.5
    play :f2, amp: 0.6
    sleep 0.5
  end
end

# Lead melody
live_loop :melody_lead do
  with_fx :reverb, room: 0.6 do
    with_fx :echo, phase: 0.375, decay: 4 do
      use_synth :saw
      use_synth_defaults release: 0.3, cutoff: 110

      play :f4, amp: 1.3
      sleep 0.5
      play :g4, amp: 1.2
      sleep 0.5
      play :a4, amp: 1.4
      sleep 1

      play :c5, amp: 1.5
      sleep 0.75
      play :bf4, amp: 1.3
      sleep 0.25
      play :a4, amp: 1.4
      sleep 1

      play :f4, amp: 1.3
      sleep 0.5
      play :a4, amp: 1.4
      sleep 0.5
      play :c5, amp: 1.5
      sleep 0.5
      play :d5, amp: 1.4
      sleep 0.5

      play :c5, amp: 1.5, release: 1.5
      sleep 2
    end
  end
end

# Melody harmony chords
live_loop :melody_harmony do
  with_fx :reverb, room: 0.5 do
    use_synth :supersaw
    use_synth_defaults release: 0.4, cutoff: 100, detune: 0.2

    2.times do
      play_chord chord(:f4, :major), amp: 0.5
      sleep 2
    end

    play_chord chord(:f4, :major), amp: 0.5
    sleep 1
    play_chord chord(:bf4, :major), amp: 0.5
    sleep 1

    play_chord chord(:f4, :major), amp: 0.6, release: 1.5
    sleep 2
  end
end

# Plucked arpeggio
live_loop :pluck_arp do
  use_synth :pluck
  use_synth_defaults release: 0.2

  4.times do
    play :f4, amp: 0.6
    sleep 0.25
    play :a4, amp: 0.5
    sleep 0.25
    play :c5, amp: 0.7
    sleep 0.25
    play :a4, amp: 0.5
    sleep 0.25
  end
end

# Warm pad progressions
live_loop :warm_pads do
  with_fx :reverb, room: 0.8 do
    use_synth :dark_ambience
    use_synth_defaults release: 7.5, cutoff: 80

    play_chord chord(:f3, :major), sustain: 7, amp: 0.4
    sleep 8
  end
end

# Atmospheric chords and buildup
live_loop :atmospheric_buildup do
  with_fx :reverb, room: 0.6 do
    with_fx :echo, phase: 0.75, decay: 4 do
      use_synth :tech_saws
      use_synth_defaults release: 1.5, cutoff: 90

      2.times do
        play_chord chord(:f3, :major7), amp: 0.3
        sleep 2
        play_chord chord(:d3, :minor7), amp: 0.3
        sleep 1
        play_chord chord(:c3, :major7), amp: 0.3
        sleep 1
      end
    end
  end
end
