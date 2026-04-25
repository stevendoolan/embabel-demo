# Mozart Song

use_bpm 120

in_thread do
  use_synth :piano
  play_pattern_timed [:c4, :e4, :g4, :c5, :e5, :g5, :c6], [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]
end

in_thread do
  use_synth :organ_tonewheel
  sleep 1
  play_pattern_timed [:g3, :b3, :d4, :g4, :b4, :d5, :g5], [1, 1, 1, 1, 1, 1, 1]
end