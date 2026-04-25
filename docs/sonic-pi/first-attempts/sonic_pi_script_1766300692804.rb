# Song Title: Electric Pulse

use_bpm 128

# Percussion loop
live_loop :drums do
  # Bar 1
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :drum_snare_soft, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1

  # Bar 2
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  # snare roll
  8.times do
    sample :drum_snare_soft, amp: 3
    sleep 0.125
  end
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1

  # Bar 3
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :drum_snare_soft, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1

  # Bar 4
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :drum_snare_soft, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  sample :bd_ada, amp: 3
  sample :hat_zan, amp: 2
  sleep 1
  # cymbal roll
  8.times do
    sample :hat_zan, amp: 2
    sleep 0.125
  end
end

# Harmony pad
live_loop :harmony_pad do
  use_synth :saw
  # Bar 1 Gm
  play_chord chord(:g4, :minor), amp: 0.8
  sleep 4
  # Bar 2 Dm
  play_chord chord(:d4, :minor), amp: 0.8
  sleep 4
  # Bar 3 C major
  play_chord chord(:c4, :major), amp: 0.8
  sleep 4
  # Bar 4 C major
  play_chord chord(:c4, :major), amp: 0.8
  sleep 4
end

# Bass line
live_loop :bass do
  use_synth :piano
  # Gm section
  play :g2, release: 0.3, amp: 0.6
  sleep 1
  play :d2, release: 0.3, amp: 0.6
  sleep 1
  play :g2, release: 0.3, amp: 0.6
  sleep 1
  play :d2, release: 0.3, amp: 0.6
  sleep 1
  # C major section
  play :c2, release: 0.3, amp: 0.6
  sleep 1
  play :g2, release: 0.3, amp: 0.6
  sleep 1
  play :c2, release: 0.3, amp: 0.6
  sleep 1
  play :g2, release: 0.3, amp: 0.6
  sleep 1
end

# Melody loop
live_loop :melody do
  # Bar 1 (Gm)
  play :g4, instrument: :sine
  sleep 1
  play :bb4, instrument: :beep
  sleep 1
  play :c5, instrument: :sine
  sleep 1
  play :d5, instrument: :beep
  sleep 1

  # Bar 2 (Gm)
  play :g4, instrument: :sine
  sleep 1
  play :a4, instrument: :beep
  sleep 1
  play :bb4, instrument: :sine
  sleep 1
  play :c5, instrument: :beep
  sleep 1

  # Bar 3 (C major)
  play :c4, instrument: :sine
  sleep 1
  play :e4, instrument: :beep
  sleep 1
  play :g4, instrument: :sine
  sleep 1
  play :a4, instrument: :beep
  sleep 1

  # Bar 4 (C major)
  play :c4, instrument: :sine
  sleep 1
  play :d4, instrument: :beep
  sleep 1
  play :e4, instrument: :sine
  sleep 1
  play :g4, instrument: :beep
  sleep 1
end