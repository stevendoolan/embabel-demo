# Moonlit Serenade

use_bpm 70

# Melody
live_loop :melody do
  32.times do |bar|
    phrase = bar < 16 ? [:c4, :e4, :g4, :c5] : [:g4, :b4, :d5, :g5]
    synth_name = bar.even? ? :pluck : :sine
    phrase.each do |note|
      synth synth_name, note: note, sustain: 0.8
      sleep 1
    end
  end
end

# Harmony
live_loop :harmony do
  32.times do |bar|
    case bar % 4
    when 0
      c = chord(:c4, :major)
    when 1
      c = chord(:a3, :minor)
    when 2
      c = chord(:f4, :major)
    when 3
      c = chord(:g4, :major)
    end
    use_synth :piano
    play c, sustain: 4
    use_synth :saw
    play c, sustain: 4, amp: 0.3
    sleep 4
  end
end

# Percussion
live_loop :percussion do
  sample :bd_808, amp: 0.7
  sleep 1
  sample :hat_zap, amp: 0.3
  sleep 0.5
  sample :drum_snare_soft, amp: 0.5
  sleep 0.5
  sample :hat_zap, amp: 0.2
  sleep 0.5
  sample :bd_808, amp: 0.7
  sleep 1
  sample :hat_zap, amp: 0.3
  sleep 0.5
  sample :drum_snare_soft, amp: 0.5
  sleep 0.5
  sample :hat_zap, amp: 0.2
  sleep 0.5
end