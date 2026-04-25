# Java User Group Dance Anthem
# Electronic / Energetic / 4/4 / Key of C

use_debug false
use_bpm 128

with_fx :level, amp: 0.5 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Opening - Chipbass melody with supersaw pad and simple drums (4 bars, repeat 2x)
    2.times do
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          use_synth :chipbass
          notes = (ring :c4, :e4, :g4, :c5, :e4, :g4, :a4, :g4)
          16.times do
            play notes.tick, cutoff: rrand(90, 110), release: 0.2, amp: 0.8
            sleep 0.25
          end
        end
      end

      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :supersaw
          chords_ring = (ring chord(:c3, :major), chord(:a2, :minor), chord(:f3, :major), chord(:g3, :major))
          4.times do
            play_chord chords_ring.tick, cutoff: 100, release: 3.5, amp: 0.3
            sleep 4
          end
        end
      end

      16.times do
        sample :bd_haus, amp: 0.5
        sleep 0.5
        sample :elec_hi_snare, amp: 0.4
        sample :hat_psych, amp: 0.25
        sleep 0.5
      end
    end

    # Transition 1
    use_synth :saw
    play :c5, cutoff: 100, release: 2, amp: 0.7
    sleep 2

    # Section 2: Build - Saw synth melody with FM pulsing chords and hi-hat patterns (4 bars, repeat 2x)
    2.times do
      in_thread do
        with_fx :lpf, cutoff: 120, mix: 0.3 do
          with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
            use_synth :saw
            melody = (ring :c4, :d4, :e4, :g4, :e4, :d4, :c4, :g3)
            16.times do |i|
              play melody.tick, cutoff: (line 80, 120, steps: 16).look, release: 0.15, amp: 0.9
              sleep 0.25
            end
          end
        end
      end

      in_thread do
        use_synth :fm
        progression = (ring chord(:c3, :major), chord(:d3, :minor), chord(:e3, :minor), chord(:g3, :major))
        4.times do
          play_chord progression.tick, cutoff: (line 85, 115, steps: 4).look, release: 3.8, amp: 0.35, divisor: 0.5, depth: 2
          sleep 4
        end
      end

      with_fx :hpf, cutoff: 100, mix: 0.3 do
        16.times do
          sample :bd_haus, amp: 0.6
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.2
          sleep 0.25
          sample :elec_hi_snare, amp: 0.5
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :hat_psych, amp: 0.2
          sleep 0.25
        end
      end
    end

    # Transition 2
    use_synth :beep
    play :g4, cutoff: 95, release: 1.5, amp: 0.7
    sleep 1.5

    # Section 3: Peak - Beep synth energetic finale with TB303 arpeggios and full drums (4 bars, repeat 3x)
    3.times do
      in_thread do
        use_synth :beep
        pattern = (knit :c5, 2, :e5, 2, :g5, 4, :a5, 2, :g5, 2, :e5, 4)
        16.times do
          play pattern.tick, cutoff: rrand(100, 120), release: 0.1, amp: 1.0
          sleep 0.25
        end
      end

      in_thread do
        with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.25 do
          use_synth :tb303
          arp_notes = (ring :c3, :e3, :g3, :c4, :g3, :e3, :a3, :f3)
          16.times do
            play arp_notes.tick, cutoff: rrand(90, 110), release: 0.15, amp: 0.4, res: 0.8
            sleep 0.25
          end
        end
      end

      16.times do |i|
        sample :bd_haus, amp: 0.7
        sample :hat_psych, amp: 0.35
        sample :elec_cymbal, amp: 0.3, rate: 2 if one_in(8)
        sleep 0.25
        sample :hat_psych, amp: 0.25
        sleep 0.25
        sample :elec_hi_snare, amp: 0.6
        sample :hat_psych, amp: 0.35
        sleep 0.25
        sample :hat_psych, amp: 0.25
        sample :elec_hi_snare, amp: 0.4 if spread(3, 8).tick
        sleep 0.25
      end
    end

  end
end