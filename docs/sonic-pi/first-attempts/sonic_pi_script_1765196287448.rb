# Chopin-inspired piece
use_synth :piano
use_bpm 60

# Define a simple chord progression
define :play_chords do
  with_fx :reverb, mix: 0.3 do
    play chord(:c4, :major), release: 4
    sleep 4
    play chord(:f4, :major), release: 4
    sleep 4
    play chord(:g4, :minor), release: 4
    sleep 4
    play chord(:c4, :major), release: 4
    sleep 4
  end
end

# Define a gentle melody
define :melody do
  play :c4, release: 0.5
  sleep 0.5
  play :e4, release: 0.5
  sleep 0.5
  play :g4, release: 0.5
  sleep 0.5
  play :c5, release: 0.5
  sleep 0.5
end

# Play the progression and melody together
in_thread do
  play_chords
end

in_thread do
  sleep 1
  loop do
    melody
    sleep 8
  end
end