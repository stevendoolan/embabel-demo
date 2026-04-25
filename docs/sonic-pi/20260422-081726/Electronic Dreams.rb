use_debug false
use_bpm 128

# Electronic Dreams
# Style: Dreamy Electronic, Ambient

with_fx :level, amp: 0.85 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Dreamy FM intro with minimal beats
    2.times do
      in_thread do
        use_synth :fm
        play :c2, release: 16, divisor: 4, depth: 15, cutoff: 85, amp: 0.4
      end
      
      in_thread do
        use_synth :dark_ambience
        play :c2, release: 16, cutoff: 85, amp: 0.3
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.3 do
          melody_notes = (ring :c4, :e4, :g4, :b4, :c5, :b4, :g4, :e4)
          16.times do
            use_synth :fm
            play melody_notes.tick, release: 0.2, cutoff: (line 90, 110, steps: 16).look, divisor: 2, depth: 8, amp: 0.9
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          harmony_chords = (knit chord(:c3, :major), 4, chord(:a3, :minor), 4, chord(:f3, :major), 4, chord(:g3, :major), 4)
          16.times do
            use_synth :hollow
            play_chord harmony_chords.tick, cutoff: (line 80, 105, steps: 16).look, release: 1, amp: 0.4
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 100 do
          with_fx :reverb, room: 0.25, mix: 0.25 do
            16.times do
              sample :bd_808, amp: 0.6
              sample :hat_psych, amp: 0.3
              sleep 0.25
              sample :hat_psych, amp: 0.25
              sleep 0.25
              sample :elec_tick, amp: 0.35 if spread(3, 8).tick
              sleep 0.5
            end
          end
        end
      end
      
      sleep 16
    end
    
    # Transition drone — overlaps into next section
    use_synth :prophet
    play :c2, cutoff: 90, release: 10, amp: 0.6
    sleep 4
    
    # Section 2: Prophet pads with four-on-the-floor beat
    2.times do
      in_thread do
        use_synth :prophet
        play :c2, release: 16, cutoff: 80, amp: 0.3
      end
      
      in_thread do
        use_synth :dark_ambience
        play :c2, release: 16, cutoff: 82, amp: 0.3
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110 do
          with_fx :echo, phase: 0.5, decay: 1.5, mix: 0.2 do
            harmony = (knit :c4, 2, :e4, 2, :g4, 2, :a4, 2, :g4, 2, :e4, 2, :d4, 2, :c4, 2)
            16.times do
              use_synth :prophet
              play harmony.tick, release: 0.3, cutoff: (line 85, 115, steps: 16).look, amp: 0.85
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 100 do
          pad_progression = (ring chord(:c3, :major), chord(:e3, :minor), chord(:a3, :minor), chord(:g3, :major))
          4.times do
            use_synth :mod_sine
            play_chord pad_progression.tick, cutoff: (line 85, 110, steps: 4).look, release: 4, mod_range: 8, mod_phase: 0.5, amp: 0.35
            sleep 4
          end
        end
      end
      
      in_thread do
        16.times do
          sample :bd_808, amp: 0.7
          sample :hat_psych, amp: 0.35
          sleep 0.25
          sample :hat_psych, amp: 0.3
          sleep 0.25
          sample :bd_808, amp: 0.65
          sample :elec_hi_snare, amp: 0.6
          sample :hat_psych, amp: 0.35
          sleep 0.25
          sample :hat_psych, amp: 0.3
          sample :elec_tick, amp: 0.4 if one_in(3)
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Transition drone — bridges to final section
    use_synth :fm
    play :c2, cutoff: 95, release: 10, divisor: 3, depth: 12, amp: 0.6
    sleep 4
    
    # Section 3: Supersaw climax with full intensity percussion
    3.times do
      in_thread do
        use_synth :supersaw
        play :c2, release: 16, cutoff: 90, amp: 0.3
      end
      
      in_thread do
        use_synth :dark_ambience
        play :c2, release: 16, cutoff: 90, amp: 0.3
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          arp_pattern = (scale :c4, :major_pentatonic, num_octaves: 2)
          16.times do
            use_synth :supersaw
            play arp_pattern.choose, release: 0.15, cutoff: rrand(95, 120), amp: 0.9
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.4, mix: 0.45 do
          climax_chords = (knit chord(:c3, :major), 2, chord(:f3, :major), 2, chord(:g3, :major), 2, chord(:c3, :major), 2)
          8.times do
            use_synth :hollow
            play_chord climax_chords.tick, cutoff: (line 90, 120, steps: 8).look, release: 2, amp: 0.4
            sleep 2
          end
        end
      end
      
      in_thread do
        16.times do
          tick
          sample :bd_808, amp: 0.7
          sample :hat_psych, amp: 0.45
          sleep 0.25
          sample :hat_psych, amp: 0.35
          sample :elec_tick, amp: 0.5 if spread(5, 16).look
          sleep 0.25
          sample :bd_808, amp: 0.65
          sample :elec_hi_snare, amp: 0.7
          sample :hat_psych, amp: 0.45
          sleep 0.25
          sample :hat_psych, amp: 0.35
          sample :elec_tick, amp: 0.45 if one_in(2)
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Final sustaining drone fade with sparse beats
    in_thread do
      use_synth :prophet
      play :c2, release: 12, cutoff: 80, amp: 0.4
    end
    
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:c2, :major), release: 12, cutoff: 85, amp: 0.3
    end
    
    in_thread do
      8.times do
        sample :bd_808, amp: 0.5
        sample :hat_psych, amp: 0.25
        sleep 1
      end
    end
    
    sleep 8
    
  end
end