# Java User Group Dance Anthem
# Electronic dance track in C major, 128 BPM, energetic mood

use_debug false
use_bpm 128

with_fx :level, amp: 0.8 do

  # Main melody loop - energetic lead synth
  live_loop :lead_melody do
    use_synth :tech_saws
    with_fx :reverb, room: 0.3, mix: 0.4 do
      notes = (ring :c5, :e5, :g5, :c6, :g5, :e5, :d5, :c5)
      8.times do
        play notes.tick, cutoff: (line 90, 120, steps: 8).look, release: 0.3, amp: 1.3
        sleep 0.5
      end
    end
  end

  # Arpeggio and bass support
  live_loop :arp_bass do
    use_synth :beep
    with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.3 do
      arp_notes = (ring :c4, :e4, :g4, :c5)
      4.times do
        play arp_notes.tick, cutoff: rrand(80, 100), release: 0.1, amp: 1.2
        sleep 0.25
      end
    end

    use_synth :chipbass
    bass_pattern = (knit :c2, 2, :g2, 1, :e2, 1)
    4.times do
      play bass_pattern.tick, cutoff: 70, release: 0.4, amp: 1.5
      sleep 0.25
    end
  end

  # Pulsing bass foundation - deep electronic pulse
  live_loop :bass_pulse do
    use_synth :bass_foundation
    bass_notes = (knit :c2, 8, :f2, 4, :g2, 4)
    16.times do
      play bass_notes.tick, cutoff: (line 80, 95, steps: 16).look, release: 0.3, amp: 0.5
      sleep 0.25
    end
  end

  # Layered synth pads - atmospheric foundation
  live_loop :synth_pads do
    use_synth :supersaw
    with_fx :reverb, room: 0.4, mix: 0.4 do
      chords = knit(chord(:c4, :major), 4, chord(:f4, :major), 2, chord(:g4, :major), 2)
      8.times do
        play_chord chords.tick, cutoff: (line 85, 110, steps: 8).look, release: 4, amp: 0.4
        sleep 0.5
      end
    end
  end

  # Bright chord stabs - celebratory upbeat emphasis
  live_loop :chord_stabs do
    use_synth :hoover
    with_fx :lpf, cutoff: 100, mix: 0.5 do
      stab_chords = (ring chord(:c3, :major), chord(:e3, :minor), chord(:g3, :major), chord(:c3, :major))
      4.times do
        if spread(3, 4).tick
          play_chord stab_chords.look, cutoff: rrand(95, 120), release: 0.2, amp: 0.55
        end
        sleep 1
      end
    end
  end

  # Main drum pattern - four-on-the-floor kick with snare backbeat
  live_loop :main_drums do
    with_fx :hpf, cutoff: 100, mix: 0.5 do
      with_fx :reverb, room: 0.2, mix: 0.25 do
        4.times do |beat|
          sample :bd_808, amp: beat == 0 ? 2.5 : 2.0
          sleep 0.5

          if beat == 1 || beat == 3
            sample :elec_hi_snare, amp: 0.6
          end
          sleep 0.5
        end
      end
    end
  end

  # Hi-hat pattern - driving rhythm with variation
  live_loop :hi_hats do
    with_fx :lpf, cutoff: 105, mix: 0.5 do
      8.times do
        if spread(7, 8).tick
          sample :hat_psych, amp: 0.5, rate: 1.2
        end
        sleep 0.125
      end
    end
  end

  # Cymbal accents - adds energy on phrase transitions
  live_loop :cymbals do
    sleep 3.5
    sample :elec_cymbal, amp: 0.3, rate: 0.9 if one_in(2)
    sleep 4.5
  end

end