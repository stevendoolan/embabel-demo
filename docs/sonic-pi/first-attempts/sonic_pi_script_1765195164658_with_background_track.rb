# Mozartian Melody
use_bpm 120

# Background loop
live_loop :background do
  use_synth :piano
  with_fx :reverb, mix: 0.3 do
    play chord(:c4, :major), release: 4, amp: 0.3
    sleep 4
    play chord(:f4, :minor), release: 4, amp: 0.3
    sleep 4
    play chord(:g4, :minor), release: 4, amp: 0.3
    sleep 4
    play chord(:c5, :major), release: 4, amp: 0.3
    sleep 4
  end
end

# Foreground loop
live_loop :foreground do
  use_synth :piano
  # Verse
  play :c4, release: 0.5
  play :e4, release: 0.5
  play :g4, release: 0.5
  play :c5, release: 0.5
  sleep 2
  # Bridge
  use_synth :organ_tonewheel
  play :f4, release: 0.8
  play :a4, release: 0.8
  play :c5, release: 0.8
  play :f5, release: 0.8
  sleep 2
  # Return
  use_synth :piano
  play :c4, release: 1
  sleep 1
  play :e4, release: 1
  sleep 1
  play :g4, release: 1
  sleep 1
  play :c5, release: 1
  sleep 1
end