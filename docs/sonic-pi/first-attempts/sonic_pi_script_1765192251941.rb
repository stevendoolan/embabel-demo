# Für Elise by Ludwig van Beethoven
use_bpm 120
notes = [:e5, :d5, :e5, :d5, :e5, :b4, :d5, :c5, :a4]
durations = [0.5] * notes.length
notes.each_with_index do |n, i|
  play n, release: durations[i]
  sleep durations[i]
end