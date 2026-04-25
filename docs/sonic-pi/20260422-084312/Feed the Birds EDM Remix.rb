# Feed the Birds EDM Remix
# Electronic EDM arrangement in F major at 128 BPM

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Atmospheric intro with saw synth lead, warm pad foundation, minimal percussion
    2.times do
      in_thread do
        use_synth :fm
        play :f2, release: 16, divisor: 8, depth: 10, cutoff: 90, amp: 0.4
        
        with_fx :reverb, room: 0.25, mix: 0.3 do
          use_synth :saw
          melody = (ring :f4, :f4, :e4, :d4, :f4, :d4, :c4)
          durations = (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3)
          
          7.times do
            play melody.tick, cutoff: rrand(90, 110), release: durations.look * 0.8, amp: 0.9
            sleep durations.look
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.35 do
          use_synth :hollow
          play_chord chord(:f3, :major), cutoff: 85, release: 12, amp: 0.5
          
          sleep 6
          use_synth :prophet
          play_chord chord(:c3, :major), cutoff: 80, release: 10, amp: 0.4
          
          sleep 6
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 90, mix: 0.3 do
          with_fx :reverb, room: 0.25, mix: 0.25 do
            7.times do
              sample :bd_haus, amp: 0.5
              sample :hat_psych, amp: 0.2, rate: 1.2
              sleep 0.5
              sample :hat_psych, amp: 0.15, rate: 1.1
              sleep 0.5
              sample :elec_hi_snare, amp: 0.4
              sample :hat_psych, amp: 0.2, rate: 1.2
              sleep 0.5
              sample :hat_psych, amp: 0.15, rate: 1.1
              sleep 0.5
            end
          end
        end
      end
      
      sleep 14
    end
    
    # Transition drone - bridges to Section 2
    use_synth :prophet
    play :f2, cutoff: 95, release: 8, amp: 0.6
    sleep 4
    
    # Section 2: Build energy with supersaw, sustained pad chords, tighter hi-hats
    2.times do
      in_thread do
        use_synth :fm
        play :f2, release: 16, divisor: 12, depth: 15, cutoff: 85, amp: 0.4
        
        with_fx :lpf, cutoff: 110, mix: 0.3 do
          with_fx :echo, phase: 0.25, decay: 1.5, mix: 0.2 do
            use_synth :supersaw
            melody = (ring :f4, :f4, :e4, :d4, :f4, :d4, :c4)
            durations = (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3)
            cutoffs = (line 95, 125, steps: 7)
            
            7.times do
              play melody.tick, cutoff: cutoffs.look, release: durations.look * 0.7, detune: 0.2, amp: 0.95
              sleep durations.look
            end
          end
        end
      end
      
      in_thread do
        use_synth :prophet
        chords_prog = (ring chord(:f3, :major), chord(:bb3, :major), chord(:c3, :sus4), chord(:f3, :major))
        cutoffs = (line 85, 105, steps: 4)
        
        4.times do
          play_chord chords_prog.tick, cutoff: cutoffs.look, release: 10, amp: 0.55
          sleep 3
        end
      end
      
      in_thread do
        7.times do
          sample :bd_haus, amp: 0.6
          sample :hat_psych, amp: 0.25, rate: 1.3
          sleep 0.25
          sample :hat_psych, amp: 0.2, rate: 1.2
          sleep 0.25
          sample :elec_hi_snare, amp: 0.5
          sample :hat_psych, amp: 0.25, rate: 1.3
          sleep 0.25
          sample :hat_psych, amp: 0.2, rate: 1.2
          sleep 0.25
          
          sample :bd_haus, amp: 0.6
          sample :hat_psych, amp: 0.25, rate: 1.3
          sleep 0.25
          sample :hat_psych, amp: 0.2, rate: 1.2
          sleep 0.25
          sample :elec_hi_snare, amp: 0.5
          sample :hat_psych, amp: 0.25, rate: 1.3
          sleep 0.25
          sample :hat_psych, amp: 0.2, rate: 1.2
          sleep 0.25
        end
      end
      
      sleep 14
    end
    
    # Transition drone - bridges to Section 3
    use_synth :blade
    play :f2, cutoff: 100, release: 8, amp: 0.6
    sample :drum_tom_mid_hard, amp: 0.4
    sleep 1
    sample :drum_tom_mid_hard, amp: 0.45, rate: 0.9
    sleep 1
    sample :elec_cymbal, amp: 0.3, rate: 0.8
    sleep 2
    
    # Section 3: Peak energy with pluck, rich layered pads, full drum pattern
    3.times do
      in_thread do
        use_synth :prophet
        play :f2, release: 12, cutoff: 90, amp: 0.4
        
        use_synth :pluck
        melody = (ring :f4, :f4, :e4, :d4, :f4, :d4, :c4)
        durations = (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3)
        
        7.times do
          play melody.tick, cutoff: (line 100, 120, steps: 7).look, release: 0.8, amp: 1.0
          
          if spread(3, 7).look
            in_thread do
              use_synth :saw
              play melody.look + 12, cutoff: 85, release: 0.2, amp: 0.6
            end
          end
          
          sleep durations.look
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 100, mix: 0.3 do
          use_synth :fm
          play_chord chord(:f3, :major), cutoff: 90, release: 14, divisor: 8, depth: 12, amp: 0.6
          
          use_synth :prophet
          chords_seq = (ring chord(:f3, :major), chord(:bb3, :major), chord(:c3, :major), chord(:f3, :sus4))
          
          4.times do
            current_chord = chords_seq.tick
            play_chord current_chord, cutoff: (line 90, 110, steps: 4).look, release: 2.5, amp: 0.5
            sleep 3
          end
        end
      end
      
      in_thread do
        7.times do |i|
          4.times do |b|
            sample :bd_haus, amp: 0.65
            sample :hat_psych, amp: 0.3, rate: 1.4
            sleep 0.25
            sample :hat_psych, amp: 0.25, rate: 1.3
            sleep 0.25
            
            if b == 1 || b == 3
              sample :elec_hi_snare, amp: 0.6
            end
            
            sample :hat_psych, amp: 0.3, rate: 1.4
            sleep 0.25
            sample :hat_psych, amp: 0.25, rate: 1.3
            sleep 0.25
            
            if one_in(4)
              sample :elec_cymbal, amp: 0.25, rate: 1.1
            end
          end
          
          if i % 2 == 1
            2.times do
              sample :drum_tom_mid_hard, amp: 0.4, rate: 1.1
              sleep 0.25
            end
          end
        end
      end
      
      sleep 14
    end
    
    # Outro - final sustained pad with cymbal swell
    use_synth :fm
    play :f2, cutoff: 95, release: 12, divisor: 4, depth: 20, amp: 0.5
    
    use_synth :hollow
    play_chord chord(:f3, :major), cutoff: 85, release: 12, amp: 0.55
    
    sample :bd_haus, amp: 0.6
    sample :elec_cymbal, amp: 0.4, rate: 0.7
    sleep 2
    sample :bd_haus, amp: 0.5
    sleep 1
    sample :elec_cymbal, amp: 0.35, rate: 0.6
    sleep 3
    
  end
end