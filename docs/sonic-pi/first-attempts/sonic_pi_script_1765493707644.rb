# Electronic Dance Inspired Mix
use_bpm 128

# Lead melody
live_loop :lead do
  use_synth :tech_saws
  128.times do |i|
    notes = i < 64 ? [:c4, :e4, :g4, :b4] : [:g4, :b4, :d5, :f5]
    play notes[i % notes.length]
    sleep 1
  end
  stop
end

# Bass line
live_loop :bass do
  use_synth :bass_highend
  128.times do |i|
    notes = i < 64 ? [:c2, :g2, :a2, :e2] : [:g2, :d2, :e2, :b1]
    play notes[i % notes.length]
    sleep 2
  end
  stop
end

# Drum groove
live_loop :drums do
  128.times do |i|
    sample :bd_ada
    sleep 1
    sample :drum_snare_soft
    sleep 1
  end
  stop
end

# Harmony Pad
live_loop :harmony_pad do
  use_synth :supersaw
  32.times do |i|
    if i < 8
      case i
      when 0..1
        chord_notes = chord(:a, :minor)
      when 2..3
        chord_notes = chord(:d, :minor)
      when 4..5
        chord_notes = chord(:e, :minor)
      else
        chord_notes = chord(:f, :major)
      end
    else
      case i
      when 8..9
        chord_notes = chord(:g, :minor)
      when 10..11
        chord_notes = chord(:c, :major)
      when 12..13
        chord_notes = chord(:d, :minor7)
      else
        chord_notes = chord(:f, :major)
      end
    end
    play chord_notes, amp: 0.5, sustain: 2
    sleep 4
  end
  stop
end

# Harmony Bass
live_loop :harmony_bass do
  use_synth :bass_foundation
  32.times do |i|
    if i < 8
      case i
      when 0..1
        play note(:a2)
      when 2..3
        play note(:d2)
      when 4..5
        play note(:e2)
      else
        play note(:f2)
      end
    else
      case i
      when 8..9
        play note(:g2)
      when 10..11
        play note(:c2)
      when 12..13
        play note(:d2)
      else
        play note(:f2)
      end
    end
    sleep 4
  end
  stop
end

# Background Drums
live_loop :bg_drums do
  128.times do |i|
    sample :bd_808 if i % 4 == 0 || i % 4 == 2
    sample :drum_snare_hard if i % 4 == 1 || i % 4 == 3
    sample :hat_zap
    sleep 0.5
    sample :hat_zap
    sleep 0.5
    sample :drum_snare_hard, amp: 0.5 if i % 16 == 0
  end
  stop
end