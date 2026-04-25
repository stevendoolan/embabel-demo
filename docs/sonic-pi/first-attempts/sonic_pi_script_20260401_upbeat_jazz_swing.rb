# Upbeat Jazz Swing
# Style: Jazz with uplifting mood
# Key: F Major, 4/4 time, 160 BPM

use_bpm 160

# Piano comping with jazz voicings
live_loop :piano_comp do
  use_synth :piano

  # Bar 1: F major 9
  play_chord chord(:f4, :maj9), sustain: 0.9, amp: 0.5
  sleep 1

  # Bar 2: Dm7
  play_chord chord(:d4, :m7), sustain: 0.9, amp: 0.5
  sleep 1

  # Bar 3: Gm7
  play_chord chord(:g4, :m7), sustain: 0.9, amp: 0.5
  sleep 1

  # Bar 4: C7
  play_chord chord(:c4, :dom7), sustain: 0.9, amp: 0.5
  sleep 1
end

# Brass melody - uplifting jazz swing phrase
live_loop :brass_melody do
  use_synth :tri

  # Bar 1
  play :f4, release: 0.4, amp: 0.7
  sleep 0.5
  play :g4, release: 0.4, amp: 0.6
  sleep 0.5
  play :a4, release: 0.8, amp: 0.7
  sleep 1

  # Bar 2
  play :c5, release: 0.4, amp: 0.7
  sleep 0.5
  play :a4, release: 0.4, amp: 0.6
  sleep 0.5
  play :f4, release: 0.8, amp: 0.7
  sleep 1

  # Bar 3
  play :g4, release: 0.4, amp: 0.7
  sleep 0.5
  play :as4, release: 0.4, amp: 0.6
  sleep 0.5
  play :d5, release: 0.8, amp: 0.7
  sleep 1

  # Bar 4
  play :c5, release: 0.4, amp: 0.7
  sleep 0.5
  play :as4, release: 0.4, amp: 0.6
  sleep 0.5
  play :a4, release: 1.8, amp: 0.7
  sleep 1
end

# Walking bass line
live_loop :walking_bass do
  use_synth :bass_foundation

  # Bar 1: F
  play :f2, release: 0.4, amp: 0.8
  sleep 1

  # Bar 2: D
  play :d2, release: 0.4, amp: 0.8
  sleep 1

  # Bar 3: G
  play :g2, release: 0.4, amp: 0.8
  sleep 1

  # Bar 4: C
  play :c2, release: 0.4, amp: 0.8
  sleep 1
end

# Swing drum pattern
live_loop :swing_drums do
  # Emphasized first beat
  sample :drum_bass_hard, amp: 1.2
  sleep 0.5
  sample :hat_cats, amp: 0.4
  sleep 0.5

  # Beat 2
  sample :drum_bass_soft, amp: 0.7
  sleep 0.5
  sample :hat_cats, amp: 0.5
  sleep 0.5

  # Beat 3
  sample :drum_snare_soft, amp: 0.8
  sleep 0.5
  sample :hat_cats, amp: 0.4
  sleep 0.5

  # Beat 4
  sample :drum_bass_soft, amp: 0.7
  sleep 0.5
  sample :hat_cats, amp: 0.5
  sleep 0.5
end

# Ride cymbal swing pattern
live_loop :ride_cymbal do
  sample :drum_cymbal_closed, amp: 0.3
  sleep 0.33
  sample :drum_cymbal_closed, amp: 0.2
  sleep 0.67
end

# Enhanced piano comping with sophisticated jazz voicings and voice leading
live_loop :harmony_piano do
  use_synth :piano

  # Bar 1: Fmaj9 with voice leading
  play_chord [:f3, :a3, :c4, :e4, :g4], sustain: 0.8, release: 0.2, amp: 0.4
  sleep 0.5
  play_chord [:a3, :c4, :e4], sustain: 0.3, release: 0.1, amp: 0.3
  sleep 0.5

  # Bar 2: Dm7 with extensions
  play_chord [:d3, :f3, :a3, :c4, :e4], sustain: 0.8, release: 0.2, amp: 0.4
  sleep 0.5
  play_chord [:f3, :a3, :c4], sustain: 0.3, release: 0.1, amp: 0.3
  sleep 0.5

  # Bar 3: Gm7 with color tones
  play_chord [:g3, :as3, :d4, :f4], sustain: 0.8, release: 0.2, amp: 0.4
  sleep 0.5
  play_chord [:as3, :d4, :f4], sustain: 0.3, release: 0.1, amp: 0.3
  sleep 0.5

  # Bar 4: C7 with tensions (9th, 13th)
  play_chord [:c3, :e3, :as3, :d4], sustain: 0.8, release: 0.2, amp: 0.4
  sleep 0.5
  play_chord [:e3, :g3, :as3, :d4], sustain: 0.3, release: 0.1, amp: 0.3
  sleep 0.5
end

# Counter-melody harmony line in mid-register
live_loop :harmony_counter do
  use_synth :piano

  # Bar 1: Upper voice harmony
  play :a4, release: 0.3, amp: 0.35
  sleep 0.5
  play :c5, release: 0.3, amp: 0.3
  sleep 0.5
  play :e5, release: 0.6, amp: 0.35
  sleep 1

  # Bar 2: Harmonizing with thirds/sixths
  play :e5, release: 0.3, amp: 0.35
  sleep 0.5
  play :c5, release: 0.3, amp: 0.3
  sleep 0.5
  play :a4, release: 0.6, amp: 0.35
  sleep 1

  # Bar 3: Voice leading through chord tones
  play :as4, release: 0.3, amp: 0.35
  sleep 0.5
  play :d5, release: 0.3, amp: 0.3
  sleep 0.5
  play :f5, release: 0.6, amp: 0.35
  sleep 1

  # Bar 4: Resolution back to tonic
  play :e5, release: 0.3, amp: 0.35
  sleep 0.5
  play :d5, release: 0.3, amp: 0.3
  sleep 0.5
  play :c5, release: 1.5, amp: 0.35
  sleep 1
end

# Enhanced walking bass with chromatic approaches
live_loop :harmony_bass do
  use_synth :bass_foundation

  # Bar 1: F root with approach notes
  play :f2, release: 0.35, amp: 0.7
  sleep 0.5
  play :g2, release: 0.35, amp: 0.6
  sleep 0.5

  # Bar 2: D root walking to next chord
  play :d2, release: 0.35, amp: 0.7
  sleep 0.5
  play :e2, release: 0.35, amp: 0.6
  sleep 0.5

  # Bar 3: G root with chromatic passing tone
  play :g2, release: 0.35, amp: 0.7
  sleep 0.5
  play :gs2, release: 0.35, amp: 0.6
  sleep 0.5

  # Bar 4: C7 with leading tone back to F
  play :c2, release: 0.35, amp: 0.7
  sleep 0.5
  play :e2, release: 0.35, amp: 0.6
  sleep 0.5
end

# Inner voice movements for harmonic richness
live_loop :inner_voices do
  use_synth :piano

  # Sustained inner voices that create tension and release
  # Bar 1-2: ii-V preparation
  play :c4, sustain: 1.8, release: 0.2, amp: 0.25
  play :e4, sustain: 1.8, release: 0.2, amp: 0.25
  sleep 2

  # Bar 3-4: Resolution phrase
  play :d4, sustain: 1.8, release: 0.2, amp: 0.25
  play :f4, sustain: 1.8, release: 0.2, amp: 0.25
  sleep 2
end

# Main swing ride cymbal pattern - authentic jazz triplet feel
live_loop :ride_pattern do
  # Beat 1 - triplet swing
  sample :drum_cymbal_closed, amp: 1.0, rate: 1.1
  sleep 0.33
  sample :drum_cymbal_closed, amp: 0.6, rate: 1.1
  sleep 0.67

  # Beat 2 - triplet swing with accent
  sample :drum_cymbal_closed, amp: 0.9, rate: 1.1
  sleep 0.33
  sample :drum_cymbal_closed, amp: 0.5, rate: 1.1
  sleep 0.67

  # Beat 3 - triplet swing
  sample :drum_cymbal_closed, amp: 1.0, rate: 1.1
  sleep 0.33
  sample :drum_cymbal_closed, amp: 0.6, rate: 1.1
  sleep 0.67

  # Beat 4 - triplet swing with accent
  sample :drum_cymbal_closed, amp: 0.9, rate: 1.1
  sleep 0.33
  sample :drum_cymbal_closed, amp: 0.5, rate: 1.1
  sleep 0.67
end

# Syncopated snare hits on beats 2 and 4 - classic jazz comping
live_loop :snare_backbeat do
  # Beat 1 - rest
  sleep 1

  # Beat 2 - snare hit with variations
  sample :drum_snare_soft, amp: 1.3, rate: 1.05
  sleep 1

  # Beat 3 - rest
  sleep 1

  # Beat 4 - snare hit
  sample :drum_snare_soft, amp: 1.4, rate: 1.05
  sleep 1
end

# Additional syncopated snare accents for jazz feel
live_loop :snare_syncopation do
  # Bar 1
  sleep 0.5
  sample :drum_snare_soft, amp: 0.5, rate: 1.1
  sleep 1.5

  # Bar 2 - syncopated hit
  sleep 0.75
  sample :drum_snare_soft, amp: 0.6, rate: 1.08
  sleep 1.25

  # Bar 3
  sleep 0.5
  sample :drum_snare_soft, amp: 0.5, rate: 1.1
  sleep 1.5

  # Bar 4 - syncopated accent
  sleep 0.25
  sample :drum_snare_soft, amp: 0.7, rate: 1.06
  sleep 1.75
end

# Hi-hat accents for rhythmic variety
live_loop :hihat_accents do
  # Accent pattern - every other beat
  sample :hat_tap, amp: 0.9
  sleep 0.5
  sleep 0.5

  sample :hat_tap, amp: 1.1
  sleep 0.5
  sleep 0.5

  sample :hat_tap, amp: 0.8
  sleep 0.5
  sleep 0.5

  sample :hat_tap, amp: 1.0
  sleep 0.5
  sleep 0.5
end

# Additional hi-hat swing rhythms
live_loop :hihat_swing do
  # Swung eighth notes
  sleep 0.33
  sample :hat_tap, amp: 0.5, rate: 1.2
  sleep 0.67

  sleep 0.33
  sample :hat_tap, amp: 0.4, rate: 1.2
  sleep 0.67

  sleep 0.33
  sample :hat_tap, amp: 0.5, rate: 1.2
  sleep 0.67

  sleep 0.33
  sample :hat_tap, amp: 0.4, rate: 1.2
  sleep 0.67
end

# Bass drum foundation - supporting the walking bass
live_loop :kick_pattern do
  # Beat 1 - strong
  sample :drum_bass_soft, amp: 1.5, rate: 0.95
  sleep 1

  # Beat 2 - lighter
  sample :drum_bass_soft, amp: 0.9, rate: 0.95
  sleep 1

  # Beat 3 - medium
  sample :drum_bass_soft, amp: 1.2, rate: 0.95
  sleep 1

  # Beat 4 - lighter with syncopation
  sample :drum_bass_soft, amp: 0.9, rate: 0.95
  sleep 0.75
  sample :drum_bass_soft, amp: 0.6, rate: 1.0
  sleep 0.25
end

# Occasional bass drum fills
live_loop :kick_fills do
  # Every 4 bars - fill pattern
  sleep 15.5
  sample :drum_bass_soft, amp: 1.0, rate: 0.9
  sleep 0.25
  sample :drum_bass_soft, amp: 0.8, rate: 0.95
  sleep 0.25
end