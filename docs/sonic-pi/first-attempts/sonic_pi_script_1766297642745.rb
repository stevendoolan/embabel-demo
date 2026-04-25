# Midnight Serenade
use_bpm 70

# Melody
live_loop :piano_melody do
  use_synth :piano
  play_pattern_timed [:c4, :e4, :g4, :c5, :e4, :g4, :a3, :c4, :e4, :a4, :c4, :e4], [1,1,1,1,1,1,1,1,1,1,1,1]
  stop
end

live_loop :sine_melody do
  use_synth :sine
  play_pattern_timed [:g4, :b4, :d5, :g5, :b4, :d5, :e4, :g4, :b4, :e5, :g5, :b5], [1,1,1,1,1,1,1,1,1,1,1,1]
  stop
end

live_loop :pluck_melody do
  use_synth :pluck
  play_pattern_timed [:c4, :e4, :g4, :c5, :e4, :g4, :a3, :c4, :e4, :a4, :c4, :e4], [1,1,1,1,1,1,1,1,1,1,1,1]
  stop
end

# Harmony
live_loop :harmony_chords do
  use_synth :organ_tonewheel
  play chord(:c4, :major), sustain: 3, release: 0
  sleep 3
  play chord(:g4, :major), sustain: 3, release: 0
  sleep 3
  play chord(:a3, :minor), sustain: 3, release: 0
  sleep 3
  play chord(:f4, :major), sustain: 3, release: 0
  sleep 3
end

live_loop :harmony_bass do
  use_synth :bass_foundation
  play :c2, sustain: 3, release: 0
  sleep 3
  play :g2, sustain: 3, release: 0
  sleep 3
  play :a2, sustain: 3, release: 0
  sleep 3
  play :f2, sustain: 3, release: 0
  sleep 3
end

# Percussion
live_loop :percussion do
  4.times do
    sample :hat_cats, amp: 0.8
    sleep 1
    sample :drum_snare_soft, amp: 1
    sample :hat_cats, amp: 0.8
    sleep 1
    sample :drum_snare_soft, amp: 1
    sample :hat_cats, amp: 0.8
    sleep 1
  end
end