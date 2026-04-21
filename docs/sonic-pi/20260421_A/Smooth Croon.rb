# Smooth Croon
# A romantic jazz ballad in F major

use_bpm 80
use_debug false

define :jazz_chord_progression do
  [
    chord(:f3, :major7),
    chord(:d3, :minor7),
    chord(:g3, :minor7),
    chord(:c3, '7')
  ]
end

# Main melody line - piano lead
live_loop :piano_melody do
  with_fx :reverb, room: 0.7, mix: 0.4 do
    use_synth :piano
    
    play :a4, amp: 1.2, release: 0.8
    sleep 1
    play :g4, amp: 1.1, release: 0.6
    sleep 0.5
    play :f4, amp: 1.3, release: 1.2
    sleep 1.5
    play :c5, amp: 1.2, release: 0.5
    sleep 1
    
    play :a4, amp: 1.3, release: 1.5
    sleep 2
    play :f4, amp: 1.1, release: 0.8
    sleep 1
    play :d4, amp: 1.2, release: 0.8
    sleep 1
    
    play :g4, amp: 1.2, release: 0.8
    sleep 1
    play :bf4, amp: 1.3, release: 1.2
    sleep 1.5
    play :a4, amp: 1.1, release: 0.5
    sleep 0.5
    play :g4, amp: 1.2, release: 0.8
    sleep 1
    
    play :f4, amp: 1.4, release: 3.5
    sleep 4
  end
end

# Harmonic foundation - extended chords and inner voices
live_loop :harmony_chords do
  with_fx :reverb, room: 0.8, mix: 0.5 do
    use_synth :piano
    use_synth_defaults release: 3.5, attack: 0.2
    
    play_chord chord(:f3, :major7), amp: 0.4
    play :e4, amp: 0.35, release: 3.8
    sleep 4
    
    play_chord chord(:d3, :minor7), amp: 0.4
    play :e4, amp: 0.35, release: 3.8
    sleep 4
    
    play_chord chord(:g3, :minor7), amp: 0.4
    sleep 2
    play_chord chord(:c3, '7'), amp: 0.4
    play :bf3, amp: 0.35, release: 1.8
    sleep 2
    
    play_chord chord(:f3, :maj9), amp: 0.45
    play :e4, amp: 0.38, release: 3.8
    sleep 4
  end
end

# Inner voice movement
live_loop :inner_voices do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    use_synth :rhodey
    use_synth_defaults release: 2.5, attack: 0.15
    
    play :a3, amp: 0.35
    sleep 1
    play :g3, amp: 0.32
    sleep 1
    play :e3, amp: 0.35
    sleep 2
    
    play :f3, amp: 0.35
    sleep 2
    play :a3, amp: 0.32
    sleep 1
    play :c4, amp: 0.33
    sleep 1
    
    play :bf3, amp: 0.35
    sleep 1.5
    play :d4, amp: 0.33
    sleep 0.5
    play :e3, amp: 0.35
    sleep 1
    play :bf3, amp: 0.34
    sleep 1
    
    play :c4, amp: 0.38
    sleep 1
    play :a3, amp: 0.36
    sleep 1
    play :e3, amp: 0.35, release: 2.0
    sleep 2
  end
end

# Sustained pad layer
live_loop :pad_shimmer do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    with_fx :echo, phase: 1.5, decay: 4, mix: 0.3 do
      use_synth :piano
      use_synth_defaults release: 7.5, attack: 0.5
      
      play_chord chord(:f3, :maj9), amp: 0.3
      sleep 8
      play_chord chord(:g3, :minor7), amp: 0.3
      play_chord chord(:c3, '9'), amp: 0.3
      sleep 8
    end
  end
end

# Bass line
live_loop :bass_line do
  use_synth :fm
  use_synth_defaults release: 0.4, divisor: 1, depth: 0.5
  
  play :f2, amp: 0.8
  sleep 1
  play :a2, amp: 0.6
  sleep 1
  play :c3, amp: 0.7
  sleep 2
  
  play :d2, amp: 0.8
  sleep 2
  play :f2, amp: 0.6
  sleep 1
  play :a2, amp: 0.6
  sleep 1
  
  play :g2, amp: 0.8
  sleep 2
  play :c2, amp: 0.8
  sleep 2
  
  play :f2, amp: 0.9, release: 1.5
  sleep 4
end

# Jazz drum kit pattern
live_loop :jazz_drums do
  with_fx :reverb, room: 0.4, mix: 0.3 do
    4.times do
      sample :drum_bass_soft, amp: 0.7
      sample :drum_cymbal_closed, amp: 0.5, rate: 0.85
      sleep 0.5
      
      sample :drum_cymbal_closed, amp: 0.25, rate: 0.85
      sleep 0.5
      
      sample :drum_snare_soft, amp: 0.5, rate: 0.9
      sample :drum_cymbal_closed, amp: 0.3, rate: 0.85
      sleep 0.5
      
      sample :drum_cymbal_closed, amp: 0.25, rate: 0.85
      sleep 0.5
      
      sample :drum_bass_soft, amp: 0.6
      sample :drum_cymbal_closed, amp: 0.35, rate: 0.85
      sleep 0.5
      
      sample :drum_cymbal_closed, amp: 0.25, rate: 0.85
      sleep 0.5
      
      sample :drum_snare_soft, amp: 0.55, rate: 0.9
      sample :drum_cymbal_closed, amp: 0.3, rate: 0.85
      sleep 0.5
      
      sample :drum_cymbal_closed, amp: 0.25, rate: 0.85
      sleep 0.5
    end
  end
end

# Brush texture layer
live_loop :brush_texture do
  with_fx :reverb, room: 0.5, mix: 0.25 do
    with_fx :echo, phase: 1.5, decay: 2, mix: 0.15 do
      sample :drum_snare_soft, amp: 0.2, rate: 0.5, attack: 0.1, release: 0.8
      sleep 4
      sample :drum_snare_soft, amp: 0.18, rate: 0.6, attack: 0.1, release: 0.7
      sleep 4
      sample :drum_snare_soft, amp: 0.22, rate: 0.55, attack: 0.1, release: 0.9
      sleep 4
      sample :drum_snare_soft, amp: 0.2, rate: 0.5, attack: 0.1, release: 0.8
      sleep 4
    end
  end
end