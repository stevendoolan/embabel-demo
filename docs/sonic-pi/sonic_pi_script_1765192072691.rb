# Mozartian Prelude
use_synth :blade
use_bpm 120

# Melody inspired by Mozart
notes = [:c4, :e4, :g4, :b4, :c5, :b4, :g4, :e4, :c4]
durations = [0.5, 0.5, 0.5, 0.5, 1, 1, 0.5, 0.5, 2]

play_pattern_timed notes, durations
