# Java User Group Dance Anthem
# Electronic · Energetic · 128 BPM · Key of C

use_bpm 128
use_debug false

# Melody - Lead voice (supersaw and saw synths)
live_loop :jug_melody do
  with_fx :reverb, room: 0.5 do
    with_fx :echo, phase: 0.375, decay: 4, mix: 0.3 do
      use_synth :supersaw
      use_synth_defaults release: 0.6, amp: 1.3, detune: 0.2, cutoff: 100

      2.times do
        play :c4, attack: 0.05
        sleep 0.5
        play :e4, attack: 0.05
        sleep 0.5
        play :g4, attack: 0.05
        sleep 0.5
        play :c5, attack: 0.05, amp: 1.5
        sleep 1.5

        play :d4, attack: 0.05
        sleep 0.5
        play :f4, attack: 0.05
        sleep 0.5
        play :a4, attack: 0.05
        sleep 0.5
        play :d5, attack: 0.05, amp: 1.5
        sleep 1.5
      end
    end
  end

  with_fx :reverb, room: 0.5 do
    with_fx :echo, phase: 0.25, decay: 3, mix: 0.3 do
      use_synth :saw
      use_synth_defaults release: 0.4, amp: 1.4, cutoff: 95

      2.times do
        play :g4, attack: 0.05
        sleep 0.25
        play :a4, attack: 0.05
        sleep 0.25
        play :c5, attack: 0.05, amp: 1.5
        sleep 0.5
        play :e5, attack: 0.05, amp: 1.5
        sleep 1
        play :d5, attack: 0.05
        sleep 1

        play :c5, attack: 0.05, amp: 1.4
        sleep 0.5
        play :g4, attack: 0.05
        sleep 0.5
        play :e4, attack: 0.05
        sleep 0.5
        play :c4, attack: 0.05, amp: 1.3
        sleep 1.5
      end
    end
  end
end

# Bass - Driving low-end foundation
live_loop :jug_bass do
  with_fx :distortion, distort: 0.3 do
    use_synth :tech_saws
    use_synth_defaults release: 0.3, amp: 0.9, cutoff: 70

    4.times do
      play :c2
      sleep 1
      play :c2
      sleep 0.5
      play :c2
      sleep 0.5
      play :c3
      sleep 1
      play :c2
      sleep 1

      play :g2
      sleep 1
      play :g2
      sleep 0.5
      play :g2
      sleep 0.5
      play :g2
      sleep 1
      play :g2
      sleep 1
    end
  end
end

# Harmony - Atmospheric pads
live_loop :jug_pads do
  with_fx :reverb, room: 0.8 do
    use_synth :dark_ambience
    use_synth_defaults attack: 2, release: 6, amp: 0.4, cutoff: 85

    play_chord chord(:c3, :major), sustain: 6
    sleep 8
    play_chord chord(:g3, :major), sustain: 6
    sleep 8
    play_chord chord(:a3, :minor), sustain: 6
    sleep 8
    play_chord chord(:f3, :major), sustain: 6
    sleep 8
  end
end

# Harmony - Pulsing rhythmic chords
live_loop :jug_pulse_chords do
  with_fx :reverb, room: 0.5 do
    use_synth :dpulse
    use_synth_defaults release: 0.4, amp: 0.5, cutoff: 90, pulse_width: 0.3

    2.times do
      4.times do
        play_chord chord(:c3, :major)
        sleep 0.5
      end
      4.times do
        play_chord chord(:g3, :major)
        sleep 0.5
      end
      4.times do
        play_chord chord(:a3, :minor)
        sleep 0.5
      end
      4.times do
        play_chord chord(:f3, :major)
        sleep 0.5
      end
    end
  end
end

# Harmony - Sharp chord stabs
live_loop :jug_blade_stabs do
  with_fx :echo, phase: 0.375, decay: 3, mix: 0.3 do
    use_synth :blade
    use_synth_defaults attack: 0.01, release: 0.6, amp: 0.45, cutoff: 95

    8.times do
      sleep 0.5
      play_chord chord(:c4, :major)
      sleep 1
      sleep 0.5
      play_chord chord(:g3, :major)
      sleep 1
      sleep 0.5
      play_chord chord(:a3, :minor)
      sleep 1
      sleep 0.5
      play_chord chord(:f3, :major)
      sleep 1
    end
  end
end

# Percussion - Kick drum
live_loop :jug_kick do
  with_fx :distortion, distort: 0.2 do
    sample :bd_haus, amp: 0.75, cutoff: 100
    sleep 1
  end
end

# Percussion - Hi-hats
live_loop :jug_hats do
  with_fx :reverb, room: 0.2, mix: 0.3 do
    sample :drum_cymbal_closed, amp: 0.35, rate: 1.4
    sleep 0.25
  end
end

# Percussion - Snare drum
live_loop :jug_snare do
  with_fx :echo, phase: 0.5, decay: 2, mix: 0.15 do
    with_fx :reverb, room: 0.4 do
      sleep 1
      sample :elec_snare, amp: 0.6, rate: 1.1
      sleep 1
      sample :elec_snare, amp: 0.55, rate: 1.1
      sleep 0.5
      sample :hat_psych, amp: 0.25, rate: 2
      sleep 0.5
    end
  end
end