# Mozart Song
use_bpm 120

live_loop :foreground do
  use_synth :piano
  play_pattern_timed [:c4, :e4, :g4, :c5, :e5, :g5, :c6], [0.5,0.5,0.5,0.5,0.5,0.5,0.5]
  sleep 0.5
end

live_loop :background do
  use_synth :supersaw
  use_synth_defaults amp: 0.8, attack: 0.1, sustain: 4, release: 0.5, pitch: 0
  with_fx :reverb, mix: 0.4 do
    play_chord chord(:c4, :major), amp: 1.0, sustain: 4
    sleep 4
  end
  sample :drum_cymbal_soft, amp: 0.6
  sleep 1
  sample :hat_snap, amp: 0.4
  sleep 1
  sample :drum_cymbal_soft, amp: 0.6
  sleep 1
  sample :hat_snap, amp: 0.4
  sleep 1
end