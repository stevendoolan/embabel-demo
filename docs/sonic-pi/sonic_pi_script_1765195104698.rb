# Mozartian Melody
use_synth :piano
use_bpm 120

# Verse
play :c4, release: 0.5
play :e4, release: 0.5
play :g4, release: 0.5
play :c5, release: 0.5

# Bridge
use_synth :organ_tonewheel
play :f4, release: 0.8
play :a4, release: 0.8
play :c5, release: 0.8
play :f5, release: 0.8

# Return
use_synth :piano
play :c4, release: 1
sleep 1
play :e4, release: 1
sleep 1
play :g4, release: 1
sleep 1
play :c5, release: 1