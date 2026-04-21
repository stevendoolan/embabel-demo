use_debug false
use_bpm 72

# Jazz in F major, 4/4 time - Smooth Croon

with_fx :level, amp: 0.85 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Smooth opening with Rhodes melody, warm piano chords, and gentle ride pattern
    2.times do
      in_thread do
        use_synth :prophet
        play :f2, release: 8, cutoff: 85, amp: 0.5
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :hollow
          play_chord chord(:f3, :major7), cutoff: 85, release: 8, amp: 0.3
          
          use_synth :piano
          chords_prog = [
            chord(:f3, :major7),
            chord(:d3, :minor7),
            chord(:bf3, :major7),
            chord(:c3, :dom7)
          ]
          
          4.times do |i|
            play_chord chords_prog[i], cutoff: rrand(90, 105), release: 1.8, amp: 0.4
            sleep 2
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          8.times do
            sample :drum_cymbal_soft, rate: 0.9, amp: 0.4
            sample :drum_bass_soft, amp: 0.6
            sleep 0.5
            sample :drum_cymbal_soft, rate: 0.9, amp: 0.3
            sleep 0.5
            sample :drum_cymbal_soft, rate: 0.9, amp: 0.35
            sample :drum_snare_soft, amp: 0.5
            sleep 0.5
            sample :drum_cymbal_soft, rate: 0.9, amp: 0.3
            sample :hat_cats, amp: 0.25 if one_in(3)
            sleep 0.5
          end
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.3 do
        use_synth :rhodey
        melody = (ring :f4, :a4, :c5, :f5, :e5, :d5, :c5, :a4)
        8.times do
          play melody.tick, release: 0.4, cutoff: rrand(90, 110), amp: 0.9
          sleep 0.5
        end
      end
    end
    
    # Transition drone - bridges to Section 2
    use_synth :fm
    play :f2, release: 8, cutoff: 90, divisor: 3, depth: 15, amp: 0.6
    4.times do
      sample :drum_cymbal_soft, rate: 0.85, amp: 0.35, pan: rrand(-0.3, 0.3)
      sleep 1
    end
    
    # Section 2: Sine wave countermelody, floating hollow chords, active hi-hat pattern
    2.times do
      in_thread do
        use_synth :prophet
        play :f2, release: 8, cutoff: 80, amp: 0.4
      end
      
      in_thread do
        use_synth :hollow
        play_chord chord(:c3, :major7), cutoff: 90, release: 8, amp: 0.3
        
        use_synth :piano
        jazz_chords = knit(
          chord(:c3, :major7), 2,
          chord(:a3, :minor7), 2,
          chord(:d3, :minor7), 2,
          chord(:g3, :dom7), 2
        )
        
        8.times do
          play_chord jazz_chords.tick, cutoff: (line 85, 110, steps: 8).look, release: 0.9, amp: 0.4
          sleep 1
        end
      end
      
      in_thread do
        8.times do
          sample :drum_bass_soft, amp: 0.7
          sample :hat_cats, amp: 0.3
          sleep 0.25
          sample :elec_tick, amp: 0.25, rate: 1.2
          sleep 0.25
          sample :drum_snare_soft, amp: 0.6
          sample :hat_cats, amp: 0.35
          sleep 0.25
          sample :drum_cymbal_soft, rate: 0.9, amp: 0.3
          sleep 0.25
          sample :hat_cats, amp: 0.3
          sleep 0.25
          sample :elec_tick, amp: 0.2, rate: 1.1
          sleep 0.25
          sample :drum_snare_soft, amp: 0.55
          sample :drum_cymbal_soft, rate: 0.9, amp: 0.35
          sleep 0.5
        end
      end
      
      with_fx :lpf, cutoff: 100, mix: 0.3 do
        use_synth :sine
        counter = (ring :c5, :d5, :e5, :f5, :g5, :a5, :g5, :f5)
        8.times do
          play counter.tick, release: 0.3, cutoff: (line 85, 115, steps: 8).look, amp: 0.85
          sleep 0.5
        end
      end
    end
    
    # Transition drone - FM pad sustains underneath
    use_synth :fm
    play_chord chord(:f2, :major7), release: 12, cutoff: 85, divisor: 3, depth: 12, amp: 0.6
    3.times do
      sample :elec_tick, amp: 0.3, rate: 1.3, pan: -0.2
      sleep 0.25
      sample :elec_tick, amp: 0.25, rate: 1.1, pan: 0.2
      sleep 0.25
    end
    sleep 2.5
    
    # Section 3: Combined Rhodes and sine melody, sophisticated harmony finale, full percussion texture
    3.times do
      in_thread do
        use_synth :fm
        play :f2, release: 10, cutoff: 85, divisor: 4, depth: 12, amp: 0.4
      end
      
      in_thread do
        use_synth :hollow
        play_chord chord(:f3, :major7), cutoff: 82, release: 10, amp: 0.3
        
        use_synth :piano
        finale_chords = [
          chord(:f3, :major7),
          chord(:d3, :minor7),
          chord(:g3, :dom7),
          chord(:c3, :major7)
        ]
        
        4.times do |i|
          play_chord finale_chords[i], cutoff: rrand(88, 108), release: 1.5, amp: 0.45
          sleep 2
        end
      end
      
      in_thread do
        4.times do
          sample :drum_bass_soft, amp: 0.75
          sample :drum_cymbal_soft, rate: 0.9, amp: 0.4
          sleep 0.5
          sample :hat_cats, amp: 0.35
          sleep 0.5
          sample :drum_snare_soft, amp: 0.65
          sample :drum_cymbal_soft, rate: 0.9, amp: 0.38
          sample :elec_tick, amp: 0.3, rate: rrand(1.0, 1.4) if one_in(2)
          sleep 0.5
          sample :hat_cats, amp: 0.3
          sleep 0.5
        end
        
        4.times do
          sample :drum_bass_soft, amp: 0.7
          sample :hat_cats, amp: 0.35
          sleep 0.25
          sample :elec_tick, amp: 0.25, rate: 1.2
          sleep 0.25
          sample :drum_snare_soft, amp: 0.6
          sample :drum_cymbal_soft, rate: 0.9, amp: 0.35
          sleep 0.25
          sample :hat_cats, amp: 0.3
          sleep 0.25
        end
      end
      
      with_fx :reverb, room: 0.3, mix: 0.35 do
        use_synth :rhodey
        finale = (knit :f4, 2, :a4, 2, :c5, 1, :d5, 1, :c5, 1, :a4, 1)
        4.times do
          play finale.tick, release: 0.5, cutoff: rrand(95, 115), amp: 0.9
          sleep 0.5
        end
        
        use_synth :sine
        harmony = (ring :a4, :c5, :e5, :f5)
        4.times do
          play harmony.tick, release: 0.4, cutoff: 100, amp: 0.8
          sleep 0.5
        end
      end
    end
    
    # Ending drone - warm hollow pad fades out
    use_synth :hollow
    play_chord chord(:f2, :major7), release: 16, cutoff: 80, amp: 0.45
    6.times do
      sample :drum_cymbal_soft, rate: 0.85, amp: (line 0.35, 0.15, steps: 6).tick, pan: rrand(-0.4, 0.4)
      sleep 1
    end
    sleep 2
    
  end
end