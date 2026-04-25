use_debug false
use_bpm 128

# Java User Group Dance Anthem
# Electronic / Energetic

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening with saw lead melody, prophet harmony pads, and simple four-on-the-floor groove
    2.times do
      in_thread do
        use_synth :fm
        play :c2, release: 16, divisor: 4, depth: 15, cutoff: 85, amp: 0.3
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :prophet
          play_chord chord(:c3, :major), cutoff: 85, release: 16, amp: 0.5
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110, mix: 0.3 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            use_synth :saw
            notes = (ring :c4, :e4, :g4, :c5, :e4, :g4, :a4, :g4)
            16.times do
              play notes.tick, cutoff: (line 80, 120, steps: 16).look, release: 0.15, amp: 0.9
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :fm
          chords = (ring chord(:c3, :major), chord(:a2, :minor), chord(:f3, :major), chord(:g3, :major))
          4.times do
            play_chord chords.tick, cutoff: (line 80, 100, steps: 4).look, release: 3.5, amp: 0.4, divisor: 2, depth: 8
            sleep 4
          end
        end
      end
      
      16.times do
        sample :bd_haus, amp: 0.5
        sample :hat_psych, amp: 0.35
        sleep 0.25
        sample :hat_psych, amp: 0.25
        sleep 0.25
        sample :elec_hi_snare, amp: 0.45
        sample :hat_psych, amp: 0.35
        sleep 0.25
        sample :hat_psych, amp: 0.25
        sleep 0.25
      end
    end
    
    # Transition drone between sections 1 and 2
    use_synth :prophet
    play :c2, cutoff: 90, release: 8, amp: 0.6
    
    in_thread do
      4.times do
        sample :bd_haus, amp: 0.55
        sleep 1
      end
    end
    
    sleep 4
    
    # Section 2: Build intensity with supersaw melody, layered fm/prophet harmony, and cymbal accents
    3.times do
      in_thread do
        use_synth :fm
        play :c2, release: 14, divisor: 6, depth: 18, cutoff: 88, amp: 0.25
      end
      
      in_thread do
        use_synth :prophet
        play_chord chord(:c3, :major), cutoff: 90, release: 14, amp: 0.55
      end
      
      in_thread do
        use_synth :supersaw
        melody = (knit :c4, 2, :e4, 2, :g4, 1, :a4, 1, :g4, 1, :e4, 1, :c5, 2, :g4, 2, :e4, 2, :d4, 2)
        16.times do
          play melody.tick, cutoff: rrand(95, 115), release: 0.2, detune: 0.1, amp: 0.85
          sleep 0.25
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 95, mix: 0.3 do
          use_synth :fm
          progression = (knit chord(:c3, :major), 4, chord(:e3, :minor), 4, chord(:a2, :minor), 4, chord(:g3, :major), 4)
          4.times do
            play_chord progression.tick, cutoff: (line 85, 105, steps: 4).look, release: 3.8, amp: 0.45, divisor: 3, depth: 10
            sleep 4
          end
        end
      end
      
      with_fx :hpf, cutoff: 100, mix: 0.25 do
        16.times do |i|
          sample :bd_haus, amp: 0.55
          sample :hat_psych, amp: 0.4
          sample :elec_cymbal, amp: 0.25 if i % 8 == 0
          sleep 0.25
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :elec_hi_snare, amp: 0.5
          sample :hat_psych, amp: 0.4
          sleep 0.25
          sample :hat_psych, amp: 0.3
          sample :elec_cymbal, amp: 0.2 if one_in(8)
          sleep 0.25
        end
      end
    end
    
    # Transition drone between sections 2 and 3
    use_synth :blade
    play :c2, cutoff: 95, release: 8, amp: 0.5
    
    in_thread do
      4.times do
        sample :bd_haus, amp: 0.6
        sleep 1
      end
    end
    
    sleep 4
    
    # Section 3: Peak with tb303 acid lead, rich harmony voicings, and full groove with fills
    4.times do
      in_thread do
        use_synth :fm
        play :c2, release: 16, divisor: 8, depth: 20, cutoff: 90, amp: 0.3
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :prophet
          play_chord chord(:c3, :major), cutoff: 95, release: 16, amp: 0.6
        end
      end
      
      in_thread do
        with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
          use_synth :tb303
          acid_line = (ring :c4, :e4, :g4, :c5, :e5, :c5, :a4, :g4, :e4, :g4, :a4, :c5, :g4, :e4, :c4, :e4)
          16.times do
            play acid_line.tick, cutoff: rrand(90, 125), release: 0.12, res: 0.85, amp: 0.9
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :hoover
          rich_chords = (ring chord(:c3, :major7), chord(:a2, :minor7), chord(:f3, :major7), chord(:g3, :dom7))
          4.times do
            play_chord rich_chords.tick, cutoff: (line 88, 110, steps: 4).look, release: 3.5, amp: 0.5
            sleep 4
          end
        end
      end
      
      16.times do |i|
        sample :bd_haus, amp: 0.6
        sample :hat_psych, amp: 0.45
        sleep 0.25
        sample :hat_psych, amp: 0.35
        sample :elec_cymbal, amp: 0.3 if i % 4 == 3
        sleep 0.25
        sample :elec_hi_snare, amp: 0.55
        sample :hat_psych, amp: 0.45
        sleep 0.25
        sample :hat_psych, amp: 0.35
        sleep 0.25
      end
    end
    
    # Final transition drone
    use_synth :prophet
    play :c2, cutoff: 100, release: 10, amp: 0.6
    
    4.times do
      sample :bd_haus, amp: 0.6
      sample :elec_cymbal, amp: 0.35
      sleep 1
    end
    
  end
end