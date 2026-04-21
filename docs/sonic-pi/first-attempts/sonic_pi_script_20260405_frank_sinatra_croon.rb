# Moonlight Serenade
# A romantic jazz ballad in F major

use_bpm 72

# Bass Line
live_loop :jazz_bass do
  use_synth :fm
  use_synth_defaults amp: 0.6, attack: 0.05, release: 0.3

  notes = [:f2, :f2, :bb2, :bb2, :c3, :c3, :f2, :f2,
           :d2, :d2, :g2, :g2, :c3, :c3, :f2, :f2]

  16.times do |i|
    play notes[i], amp: 0.5
    sleep 1
  end
end

# Main Chord Progression
live_loop :jazz_chords do
  use_synth :piano
  use_synth_defaults amp: 0.5, attack: 0.01, sustain: 3, release: 1

  chords_progression = [
    chord(:f3, :major7),
    chord(:bb3, :major7),
    chord(:g3, :minor7),
    chord(:c3, :dom7),
    chord(:f3, :major7),
    chord(:d3, :minor7),
    chord(:g3, :minor7),
    chord(:c3, :dom7)
  ]

  chords_progression.each do |c|
    play_chord c, sustain: 3.5, amp: 0.4
    sleep 4
  end
end

# Primary Melody - Sine
live_loop :melody_sine do
  use_synth :sine
  use_synth_defaults amp: 0.4, attack: 0.1, release: 0.3

  # Bar 1
  play :c5, amp: 0.5
  sleep 1
  play :d5
  sleep 1
  play :c5
  sleep 1
  play :a4
  sleep 1

  # Bar 2
  play :f4, sustain: 1.5, release: 0.5
  sleep 2
  play :g4
  sleep 1
  play :a4
  sleep 1

  # Bar 3
  play :bb4
  sleep 1
  play :c5
  sleep 1
  play :d5, sustain: 1.5, release: 0.5
  sleep 2

  # Bar 4
  play :c5, sustain: 3, release: 1
  sleep 4

  # Bar 5
  play :a4, amp: 0.5
  sleep 1
  play :bb4
  sleep 1
  play :a4
  sleep 1
  play :g4
  sleep 1

  # Bar 6
  play :f4, sustain: 1.5, release: 0.5
  sleep 2
  play :e4
  sleep 1
  play :f4
  sleep 1

  # Bar 7
  play :g4
  sleep 1
  play :a4
  sleep 1
  play :bb4
  sleep 1
  play :c5
  sleep 1

  # Bar 8
  play :f4, sustain: 3, release: 1
  sleep 4
end

# Melody Harmony - Piano
live_loop :melody_piano do
  use_synth :piano
  use_synth_defaults amp: 0.3, attack: 0.05, release: 0.4

  sleep 2

  # Bar 1 harmony
  play :a4
  sleep 1
  play :f4
  sleep 1
  play :e4
  sleep 1
  play :f4
  sleep 1

  # Bar 2
  play :d4
  sleep 2
  play :e4
  sleep 1
  play :f4
  sleep 1

  # Bar 3
  play :g4
  sleep 1
  play :a4
  sleep 1
  play :bb4
  sleep 2

  # Bar 4
  play :a4, sustain: 2.5, release: 1
  sleep 4

  # Bar 5
  play :f4
  sleep 1
  play :g4
  sleep 1
  play :f4
  sleep 1
  play :e4
  sleep 1

  # Bar 6
  play :d4
  sleep 2
  play :c4
  sleep 1
  play :d4
  sleep 1

  # Bar 7
  play :e4
  sleep 1
  play :f4
  sleep 1
  play :g4
  sleep 1
  play :a4
  sleep 1

  # Bar 8
  play :c4, sustain: 2.5, release: 1
  sleep 2
end

# Extended Jazz Chords - Piano
live_loop :harmony_piano_extended do
  use_synth :piano
  use_synth_defaults amp: 0.35, attack: 0.02, sustain: 3.5, release: 1.2

  # Bar 1 - Fmaj9
  play_chord [:f3, :a3, :c4, :e4, :g4], sustain: 3.5, release: 1.2
  sleep 4

  # Bar 2 - Bb6/9
  play_chord [:bb3, :d4, :f4, :g4, :c5], sustain: 3.5, release: 1.2
  sleep 4

  # Bar 3 - Gm9
  play_chord [:g3, :bb3, :d4, :f4, :a4], sustain: 3.5, release: 1.2
  sleep 4

  # Bar 4 - C9
  play_chord [:c3, :e3, :g3, :bb3, :d4], sustain: 3.5, release: 1.2
  sleep 4

  # Bar 5 - Fmaj9
  play_chord [:f3, :a3, :c4, :e4, :g4], sustain: 3.5, release: 1.2
  sleep 4

  # Bar 6 - Dm9
  play_chord [:d3, :f3, :a3, :c4, :e4], sustain: 3.5, release: 1.2
  sleep 4

  # Bar 7 - Gm7
  play_chord [:g3, :bb3, :d4, :f4], sustain: 3.5, release: 1.2
  sleep 4

  # Bar 8 - C7b9
  play_chord [:c3, :e3, :g3, :bb3, :db4], sustain: 3.5, release: 1.2
  sleep 4
end

# Warm Organ Pad
live_loop :harmony_organ_pad do
  use_synth :organ_tonewheel
  use_synth_defaults amp: 0.25, attack: 0.3, sustain: 3.2, release: 1.5, cutoff: 90

  # Bar 1 - Fmaj7 voicing
  play_chord [:a3, :c4, :e4], sustain: 3.2, release: 1.5
  sleep 4

  # Bar 2 - Bbmaj9 voicing
  play_chord [:d4, :f4, :c5], sustain: 3.2, release: 1.5
  sleep 4

  # Bar 3 - Gm7 voicing
  play_chord [:bb3, :d4, :f4], sustain: 3.2, release: 1.5
  sleep 4

  # Bar 4 - C9 voicing
  play_chord [:e3, :bb3, :d4], sustain: 3.2, release: 1.5
  sleep 4

  # Bar 5 - Fmaj9 voicing
  play_chord [:a3, :e4, :g4], sustain: 3.2, release: 1.5
  sleep 4

  # Bar 6 - Dm9 voicing
  play_chord [:f3, :c4, :e4], sustain: 3.2, release: 1.5
  sleep 4

  # Bar 7 - Gm7 voicing
  play_chord [:bb3, :d4, :f4], sustain: 3.2, release: 1.5
  sleep 4

  # Bar 8 - C7 voicing
  play_chord [:e3, :g3, :bb3], sustain: 3.2, release: 1.5
  sleep 4
end

# Counter Melody - Piano
live_loop :harmony_piano_counter do
  use_synth :piano
  use_synth_defaults amp: 0.28, attack: 0.05, release: 0.6

  sleep 2

  # Bar 1 - Counter melody harmony
  play :e4, release: 0.5
  sleep 1
  play :f4, release: 0.5
  sleep 1
  play :e4, release: 0.5
  sleep 1
  play :c4, release: 0.5
  sleep 1

  # Bar 2
  play :d4, sustain: 1.2, release: 0.8
  sleep 2
  play :c4, release: 0.5
  sleep 1
  play :d4, release: 0.5
  sleep 1

  # Bar 3
  play :f4, release: 0.5
  sleep 1
  play :g4, release: 0.5
  sleep 1
  play :f4, sustain: 1.2, release: 0.8
  sleep 2

  # Bar 4
  play :e4, sustain: 2.5, release: 1.2
  sleep 4

  # Bar 5
  play :c4, release: 0.5
  sleep 1
  play :d4, release: 0.5
  sleep 1
  play :c4, release: 0.5
  sleep 1
  play :bb3, release: 0.5
  sleep 1

  # Bar 6
  play :a3, sustain: 1.2, release: 0.8
  sleep 2
  play :g3, release: 0.5
  sleep 1
  play :a3, release: 0.5
  sleep 1

  # Bar 7
  play :bb3, release: 0.5
  sleep 1
  play :c4, release: 0.5
  sleep 1
  play :d4, release: 0.5
  sleep 1
  play :e4, release: 0.5
  sleep 1

  # Bar 8
  play :a3, sustain: 2.5, release: 1.2
  sleep 2
end

# Swing Ride Cymbal Pattern
live_loop :swing_ride_cymbal do
  # Beat 1 - strong
  sample :drum_cymbal_soft, amp: 1.4, rate: 1.0
  sleep 0.666
  sample :drum_cymbal_soft, amp: 0.9, rate: 1.05
  sleep 0.334

  # Beat 2
  sample :drum_cymbal_soft, amp: 1.0, rate: 1.0
  sleep 0.666
  sample :drum_cymbal_soft, amp: 0.9, rate: 1.05
  sleep 0.334

  # Beat 3 - strong
  sample :drum_cymbal_soft, amp: 1.4, rate: 1.0
  sleep 0.666
  sample :drum_cymbal_soft, amp: 0.9, rate: 1.05
  sleep 0.334

  # Beat 4
  sample :drum_cymbal_soft, amp: 1.0, rate: 1.0
  sleep 0.666
  sample :drum_cymbal_soft, amp: 0.9, rate: 1.05
  sleep 0.334
end

# Brush Snare Backbeat
live_loop :brush_snare_backbeat do
  sleep 1
  sample :drum_snare_soft, amp: 1.2, rate: 0.95, pan: -0.1
  sleep 1
  sleep 1
  sample :drum_snare_soft, amp: 1.2, rate: 0.95, pan: 0.1
  sleep 1
end

# Brush Snare Fills and Ghost Notes
live_loop :brush_snare_fills do
  # Bars 1-2: sparse
  sleep 1.5
  sample :drum_snare_soft, amp: 0.5, rate: 1.1
  sleep 2.5

  sleep 1.75
  sample :drum_snare_soft, amp: 0.4, rate: 0.9
  sleep 2.25

  # Bars 3-4: slightly more active
  sleep 1.25
  sample :drum_snare_soft, amp: 0.6, rate: 1.05
  sleep 1.25
  sample :drum_snare_soft, amp: 0.5, rate: 0.95
  sleep 1.5

  sleep 1
  sample :drum_snare_soft, amp: 0.4, rate: 1.0
  sleep 1.5
  sample :drum_snare_soft, amp: 0.5, rate: 0.92
  sleep 1.5

  # Bars 5-6: return to sparse
  sleep 2
  sample :drum_snare_soft, amp: 0.5, rate: 1.08
  sleep 2

  sleep 1.5
  sample :drum_snare_soft, amp: 0.4, rate: 0.88
  sleep 2.5

  # Bars 7-8: building slightly
  sleep 1
  sample :drum_snare_soft, amp: 0.6, rate: 1.03
  sleep 1
  sample :drum_snare_soft, amp: 0.5, rate: 0.97
  sleep 2

  sleep 1.25
  sample :drum_snare_soft, amp: 0.7, rate: 1.0
  sleep 0.75
  sample :drum_snare_soft, amp: 0.5, rate: 0.93
  sleep 2
end

# Walking Bass Drum Pattern
live_loop :soft_kick do
  # Bars 1-2
  sample :drum_bass_soft, amp: 1.3, rate: 0.9
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.88
  sleep 1
  sample :drum_bass_soft, amp: 1.1, rate: 0.92
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.9
  sleep 1

  sample :drum_bass_soft, amp: 1.2, rate: 0.9
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.88
  sleep 1
  sample :drum_bass_soft, amp: 1.0, rate: 0.91
  sleep 1
  sample :drum_bass_soft, amp: 0.8, rate: 0.89
  sleep 1

  # Bars 3-4
  sample :drum_bass_soft, amp: 1.3, rate: 0.9
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.88
  sleep 1
  sample :drum_bass_soft, amp: 1.1, rate: 0.92
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.9
  sleep 1

  sample :drum_bass_soft, amp: 1.2, rate: 0.9
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.88
  sleep 1
  sample :drum_bass_soft, amp: 1.0, rate: 0.91
  sleep 1
  sample :drum_bass_soft, amp: 0.8, rate: 0.89
  sleep 1

  # Bars 5-6
  sample :drum_bass_soft, amp: 1.3, rate: 0.9
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.88
  sleep 1
  sample :drum_bass_soft, amp: 1.1, rate: 0.92
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.9
  sleep 1

  sample :drum_bass_soft, amp: 1.2, rate: 0.9
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.88
  sleep 1
  sample :drum_bass_soft, amp: 1.0, rate: 0.91
  sleep 1
  sample :drum_bass_soft, amp: 0.8, rate: 0.89
  sleep 1

  # Bars 7-8
  sample :drum_bass_soft, amp: 1.3, rate: 0.9
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.88
  sleep 1
  sample :drum_bass_soft, amp: 1.1, rate: 0.92
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.9
  sleep 1

  sample :drum_bass_soft, amp: 1.2, rate: 0.9
  sleep 1
  sample :drum_bass_soft, amp: 0.9, rate: 0.88
  sleep 1
  sample :drum_bass_soft, amp: 1.0, rate: 0.91
  sleep 1
  sample :drum_bass_soft, amp: 0.8, rate: 0.89
  sleep 1
end

# Cymbal Accents and Swells
live_loop :cymbal_accents do
  sleep 8

  # Bar 3 - gentle swell
  sample :drum_cymbal_soft, amp: 1.0, rate: 0.85, attack: 0.5
  sleep 4

  sleep 4

  sleep 8

  # Bar 7 - accent
  sample :drum_cymbal_soft, amp: 1.2, rate: 0.9, attack: 0.3
  sleep 4

  sleep 4
end