# Mozartian Reverie
use_bpm 120

instruments = [:piano, :organ_tonewheel, :sine]

# chord progression
chords = [
  chord(:c4, :major),
  chord(:f4, :major),
  chord(:g4, :major),
  chord(:c4, :major)
]

live_loop :chords do
  chords.each do |ch|
    with_fx :reverb, mix: 0.3 do
      play ch, amp: 0.3, attack: 0.5, release: 1
    end
    sleep 2
  end
end

# melody on piano
live_loop :melody, sync: :chords do
  use_synth :piano
  notes = [:c4, :d4, :e4, :f4, :g4, :a4, :b4, :c5]
  notes.each do |n|
    play n, amp: 0.6, release: 0.5
    sleep 0.5
  end
end

# sustained sine
live_loop :sine_loop, sync: :chords do
  with_fx :compressor, threshold: 0.8 do
    play :c4, synth: :sine, amp: 0.2, sustain: 8, release: 0
    sleep 8
  end
end
