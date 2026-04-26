use_debug false
use_bpm 128

# Java User Group Dance Anthem
# Electronic / Energetic / 4/4 time

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Opening with supersaw lead, FM pads, and four-on-the-floor
    2.times do
      use_synth :prophet
      play :c2, release: 16, cutoff: 85, amp: 0.4
      
      with_fx :reverb, room: 0.35, mix: 0.3 do
        use_synth :fm
        play_chord chord(:c3, :major), release: 16, cutoff: 85, divisor: 8, depth: 10, amp: 0.55
      end
      
      with_fx :lpf, cutoff: 110 do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          use_synth :supersaw
          melody1 = (ring :c4, :e4, :g4, :c5, :g4, :e4, :c4, :e4)
          cutoffs1 = (line 90, 120, steps: 8)
          
          with_fx :hpf, cutoff: 100 do
            2.times do
              8.times do
                play melody1.tick, release: 0.2, cutoff: cutoffs1.look, amp: 0.9
                
                sample :bd_haus, amp: 0.7
                sample :hat_psych, amp: 0.35
                sleep 0.25
                sample :hat_psych, amp: 0.25
                sleep 0.25
              end
            end
          end
        end
      end
      
      with_fx :reverb, room: 0.35, mix: 0.3 do
        use_synth :hollow
        chord_progression = (ring chord(:c3, :major), chord(:e3, :minor), chord(:g3, :major), chord(:c3, :major))
        
        4.times do
          play_chord chord_progression.tick, release: 4, cutoff: 90, amp: 0.5
          sleep 4
        end
      end
    end

    # Transition drone
    use_synth :fm
    play :c2, release: 8, cutoff: 90, divisor: 4, depth: 15, amp: 0.6
    use_synth :prophet
    play_chord chord(:c3, :major), release: 8, cutoff: 85, amp: 0.6
    8.times do
      sample :bd_haus, amp: 0.65
      sleep 0.5
    end

    # Section 2: Tech saws lead with prophet pads and building percussion
    2.times do
      use_synth :blade
      play :c2, release: 16, cutoff: 80, amp: 0.35
      
      use_synth :prophet
      chord_progression2 = (knit chord(:c3, :major), 1, chord(:f3, :major), 1, chord(:g3, :major), 1, chord(:a3, :minor), 1)
      
      use_synth :tech_saws
      melody2 = (ring :e4, :g4, :a4, :g4, :c5, :a4, :g4, :e4)
      
      2.times do
        8.times do
          play melody2.tick, release: 0.15, cutoff: rrand(100, 120), amp: 0.95
          
          sample :bd_haus, amp: 0.8
          sample :hat_psych, amp: 0.4
          sample :elec_tick, amp: 0.4 if one_in(3)
          sleep 0.25
          sample :hat_psych, amp: 0.3
          sleep 0.25
        end
      end
      
      4.times do
        play_chord chord_progression2.tick, release: 8, cutoff: 88, amp: 0.6
        
        16.times do
          sample :elec_hi_snare, amp: 0.7 if (tick % 4) == 2
          sample :hat_psych, amp: 0.4
          sample :elec_tick, amp: 0.35 if spread(3, 8).look
          sleep 0.25
        end
      end
    end

    # Transition drone
    use_synth :prophet
    play :c2, release: 8, cutoff: 95, amp: 0.6
    use_synth :fm
    play_chord chord(:c3, :major), release: 8, cutoff: 90, divisor: 6, depth: 12, amp: 0.6
    8.times do
      sample :bd_haus, amp: 0.7
      sleep 0.5
    end

    # Section 3: Beep synth climax with layered pads and peak percussion
    3.times do
      use_synth :fm
      play :c2, release: 12, cutoff: 88, divisor: 6, depth: 18, amp: 0.45
      
      with_fx :lpf, cutoff: 100 do
        use_synth :hollow
        play_chord chord(:c3, :major), release: 12, cutoff: 95, amp: 0.55
      end
      
      with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
        use_synth :beep
        melody3 = (knit :c5, 2, :e5, 2, :g5, 2, :a5, 1, :g5, 1)
        cutoffs3 = (line 85, 125, steps: 16)
        
        with_fx :reverb, room: 0.25, mix: 0.25 do
          2.times do
            8.times do
              play melody3.tick, release: 0.12, cutoff: cutoffs3.look, amp: 1.0
              
              sample :bd_haus, amp: 0.85
              sample :hat_psych, amp: 0.45
              sample :elec_tick, amp: 0.5
              sleep 0.25
              sample :hat_psych, amp: 0.35
              sample :elec_tick, amp: 0.4 if one_in(2)
              sleep 0.25
            end
          end
        end
      end
      
      with_fx :lpf, cutoff: 100 do
        use_synth :fm
        chord_progression3 = (ring chord(:c3, :major), chord(:f3, :major), chord(:g3, :major), chord(:c3, :major))
        cutoffs_chord = (line 80, 110, steps: 8)
        
        2.times do
          4.times do
            play_chord chord_progression3.tick, release: 4, cutoff: cutoffs_chord.look, divisor: 7, depth: 14, amp: 0.6
            
            16.times do
              sample :elec_hi_snare, amp: 0.75 if (tick % 4) == 2
              sample :hat_psych, amp: 0.45
              sleep 0.25
            end
          end
        end
      end
    end

    # Final fadeout
    use_synth :prophet
    play :c2, release: 16, cutoff: 90, amp: 0.5
    play_chord chord(:c3, :major), release: 16, cutoff: 85, amp: 0.6
    
    16.times do
      sample :bd_haus, amp: 0.6
      sample :hat_psych, amp: 0.3
      sleep 0.5
    end

  end
end