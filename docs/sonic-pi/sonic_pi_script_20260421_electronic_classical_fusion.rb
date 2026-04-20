# Electronic Classical Fusion
# Style: Electronic Classical Fusion
# Mood: Dramatic, Atmospheric

use_bpm 120
use_debug false

# Melody definitions
define :melody_am do
  notes = [:a4, :c5, :e5, :d5, :c5, :b4, :a4, :gs4,
           :a4, :e4, :a4, :c5, :b4, :a4, :gs4, :e4]
  timings = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.75, 0.25,
             0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.75, 0.25]
  return notes, timings
end

define :melody_c do
  notes = [:c5, :e5, :g5, :f5, :e5, :d5, :c5, :b4,
           :c5, :g4, :c5, :e5, :d5, :c5, :b4, :g4]
  timings = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.75, 0.25,
             0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.75, 0.25]
  return notes, timings
end

# Lead Melody
live_loop :lead_melody do
  with_fx :reverb, room: 0.7, mix: 0.4 do
    with_fx :echo, phase: 0.375, decay: 6, mix: 0.3 do
      2.times do
        use_synth :piano
        notes, timings = melody_am
        notes.length.times do |i|
          play notes[i], release: timings[i] * 0.9, amp: 1.3
          sleep timings[i]
        end
      end

      2.times do
        use_synth :saw
        notes, timings = melody_c
        notes.length.times do |i|
          play notes[i], release: timings[i] * 0.8, amp: 1.2, cutoff: 90
          sleep timings[i]
        end
      end
    end
  end
end

# Harmony - Supersaw Chords and Atmospheric Pad
live_loop :harmony_layers do
  with_fx :reverb, room: 0.9, mix: 0.7 do
    2.times do
      use_synth :supersaw
      use_synth_defaults release: 7.5, amp: 0.4, cutoff: 85, detune: 0.15
      play_chord chord(:a3, :minor7)
      sleep 4
      play_chord chord(:f3, :major7)

      in_thread do
        use_synth :fm
        play chord(:a3, :minor), release: 7.5, amp: 0.5, divisor: 2, depth: 1.5
      end
      sleep 4
    end

    2.times do
      use_synth :supersaw
      use_synth_defaults release: 7.5, amp: 0.4, cutoff: 85, detune: 0.15
      play_chord chord(:c3, :major7)
      sleep 4
      play_chord chord(:g3, :major)

      in_thread do
        use_synth :fm
        play chord(:c3, :major), release: 7.5, amp: 0.5, divisor: 2, depth: 1.5
      end
      sleep 4
    end
  end
end

# Ambient Layer
live_loop :ambient_layer do
  with_fx :reverb, room: 1, mix: 0.8 do
    with_fx :echo, phase: 1.5, decay: 4, mix: 0.2 do
      use_synth :dark_ambience
      use_synth_defaults release: 15, amp: 0.3, attack: 2

      2.times do
        play :a2
        sleep 8
      end

      2.times do
        play :c2
        sleep 8
      end
    end
  end
end

# Sine Support
live_loop :sine_support do
  with_fx :reverb, room: 0.7, mix: 0.5 do
    use_synth :sine
    use_synth_defaults release: 3.5, amp: 0.4

    2.times do
      4.times do
        play :a3
        sleep 1
        play :c4
        sleep 1
      end
    end

    2.times do
      4.times do
        play :c3
        sleep 1
        play :e3
        sleep 1
      end
    end
  end
end

# Bass Pulse
live_loop :bass_pulse do
  use_synth :fm

  2.times do
    4.times do
      play :a2, release: 0.4, amp: 0.6, divisor: 0.5
      sleep 0.5
      play :a2, release: 0.3, amp: 0.4, divisor: 0.5
      sleep 0.5
    end
  end

  2.times do
    4.times do
      play :c2, release: 0.4, amp: 0.6, divisor: 0.5
      sleep 0.5
      play :c2, release: 0.3, amp: 0.4, divisor: 0.5
      sleep 0.5
    end
  end
end

# Drums and Electronic Percussion
live_loop :drums_and_perc do
  with_fx :distortion, distort: 0.3, mix: 0.2 do
    with_fx :reverb, room: 0.3, mix: 0.4 do
      8.times do
        sample :bd_tek, amp: 1.8, cutoff: 100
        sleep 0.5
        sample :elec_hi_snare, amp: 0.6, rate: 1.1
        in_thread do
          sample :elec_tick, amp: 0.5, rate: 2
        end
        sleep 0.5
        sample :bd_tek, amp: 1.0, cutoff: 95
        in_thread do
          sample :elec_blip, amp: 0.3, rate: 1.5
        end
        sleep 0.5
        sample :elec_hi_snare, amp: 0.7, rate: 1.0
        in_thread do
          sample :elec_tick, amp: 0.4, rate: 1.8
        end
        sleep 0.5
      end
    end
  end
end

# Hi-hats and Orchestral Accents
live_loop :hihats_accents do
  with_fx :echo, phase: 0.375, decay: 2, mix: 0.2 do
    32.times do |i|
      sample :hat_zild, amp: 0.3, rate: 1.2

      if i % 2 == 1
        sample :hat_zild, amp: 0.2, rate: 1.5, pan: rrand(-0.3, 0.3)
      end

      if i % 16 == 0
        in_thread do
          with_fx :reverb, room: 0.5, mix: 0.5 do
            sample :drum_cymbal_pedal, amp: 0.35, rate: 0.9
          end
        end
      end

      sleep 0.25
    end
  end
end