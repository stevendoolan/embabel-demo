# Java User Group Dance Anthem
# Electronic dance track in C major, 128 BPM, 4/4 time
# Style: Electronic Dance
# Mood: Energetic and uplifting

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening in C major - Supersaw lead with atmospheric drone
    3.times do
      with_fx :reverb, room: 0.3, mix: 0.3 do
        use_synth :prophet
        play :c2, release: 8, cutoff: 90, amp: 0.5
        
        use_synth :prophet
        play_chord chord(:c3, :major), cutoff: 85, release: 16, amp: 0.5
        
        use_synth :subpulse
        play :c2, cutoff: 70, release: 8, amp: 0.6
        
        with_fx :lpf, cutoff: 100, mix: 0.8 do
          use_synth :supersaw
          melody_c = (ring :c4, :e4, :g4, :a4, :g4, :e4, :d4, :c4)
          cutoffs = (line 80, 110, steps: 8)
          
          use_synth :tech_saws
          chords_c = (ring chord(:c4, :major), chord(:f4, :major), chord(:g4, :major), chord(:a4, :minor))
          
          use_synth :tb303
          bass_pattern_c = (ring :c2, :c2, :g2, :c2, :c2, :g2, :f2, :g2)
          
          2.times do
            with_fx :hpf, cutoff: 90, mix: 0.8 do
              8.times do
                use_synth :supersaw
                play melody_c.tick, release: 0.2, cutoff: cutoffs.look, amp: 0.9
                
                if look % 2 == 0
                  use_synth :tech_saws
                  play_chord chords_c.look / 2, cutoff: 95, release: 0.8, amp: 0.5
                end
                
                use_synth :tb303
                play bass_pattern_c.look, cutoff: 75, release: 0.4, res: 0.7, amp: 0.7
                
                sample :bd_haus, amp: 0.7
                sample :hat_psych, amp: 0.3
                sleep 0.25
                sample :hat_psych, amp: 0.2
                sleep 0.25
              end
            end
          end
        end
      end
    end
    
    # Transition - Long drone bridges to next section
    use_synth :fm
    play :c2, cutoff: 90, release: 8, divisor: 4, depth: 15, amp: 0.6
    use_synth :prophet
    play_chord chord(:c3, :major7), cutoff: 90, release: 8, amp: 0.55
    use_synth :bass_foundation
    play :c2, cutoff: 70, release: 8, amp: 0.55
    2.times do
      sample :bd_haus, amp: 0.6
      sleep 1
      sample :elec_hi_snare, amp: 0.4
      sleep 1
    end
    
    # Section 2: Build energy - Chiplead with rhythmic variation
    3.times do
      use_synth :fm
      play :c2, release: 12, cutoff: 85, amp: 0.4
      
      use_synth :prophet
      play_chord chord(:c3, :major), cutoff: 88, release: 12, amp: 0.5
      
      use_synth :bass_foundation
      play :c2, cutoff: 75, release: 12, amp: 0.55
      
      use_synth :chiplead
      melody_energetic = (ring :e4, :g4, :a4, :c5, :a4, :g4, :f4, :e4)
      
      with_fx :lpf, cutoff: 100, mix: 0.8 do
        use_synth :supersaw
        progression = (knit chord(:c4, :major), 2, chord(:a3, :minor), 2, chord(:f3, :major), 2, chord(:g3, :major), 2)
        cutoff_line = (line 85, 115, steps: 8)
        
        use_synth :tb303
        walking_bass = (ring :c2, :e2, :g2, :a2, :g2, :e2, :f2, :c2)
        
        8.times do |n|
          with_fx :hpf, cutoff: 90, mix: 0.8 do
            2.times do
              use_synth :chiplead
              play melody_energetic.tick, release: 0.15, cutoff: rrand(90, 115), amp: 0.95
              
              use_synth :tb303
              play walking_bass.look, cutoff: 80, release: 0.5, res: 0.75, amp: 0.7
              
              kick_amp = n == 0 ? 0.8 : 0.7
              sample :bd_haus, amp: kick_amp
              sample :hat_psych, amp: 0.35
              sleep 0.25
              sample :hat_psych, amp: 0.25
              sleep 0.25
            end
            
            if look % 2 == 0
              use_synth :supersaw
              play_chord progression.look / 2, cutoff: cutoff_line.look / 2, release: 1.5, amp: 0.5
            end
            
            sample :elec_hi_snare, amp: 0.6
            sample :hat_psych, amp: 0.35
            sample :elec_cymbal, amp: 0.3 if one_in(4)
            sleep 0.25
            sample :hat_psych, amp: 0.25
            sleep 0.25
          end
        end
      end
    end
    
    # Transition - Sustained drone into key change
    use_synth :prophet
    play :f2, cutoff: 95, release: 10, amp: 0.6
    use_synth :prophet
    play_chord chord(:f3, :major7), cutoff: 92, release: 10, amp: 0.55
    use_synth :subpulse
    play :f2, cutoff: 72, release: 10, amp: 0.6
    2.times do
      sample :bd_haus, amp: 0.6
      sleep 0.5
      sample :hat_psych, amp: 0.25
      sleep 0.5
      sample :elec_hi_snare, amp: 0.5
      sample :elec_cymbal, amp: 0.25
      sleep 1
    end
    
    # Section 3: Key change to F major - FM synth with echo effect
    4.times do
      with_fx :reverb, room: 0.35, mix: 0.35 do
        use_synth :prophet
        play :f2, release: 10, cutoff: 88, amp: 0.45
        
        use_synth :prophet
        play_chord chord(:f3, :major), cutoff: 90, release: 16, amp: 0.55
        
        use_synth :bass_foundation
        play :f2, cutoff: 70, release: 10, amp: 0.55
        
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.25 do
          use_synth :fm
          melody_f = (ring :f4, :a4, :c5, :d5, :c5, :a4, :g4, :f4)
          cutoff_mod = (line 85, 120, steps: 8)
          
          use_synth :tech_saws
          f_progression = (ring chord(:f4, :major), chord(:bb3, :major), chord(:c4, :major), chord(:d4, :minor))
          
          use_synth :tb303
          bass_pattern_f = (ring :f2, :f2, :c3, :f2, :f2, :c3, :g2, :c3)
          
          2.times do
            with_fx :reverb, room: 0.25, mix: 0.25 do
              8.times do |n|
                use_synth :fm
                play melody_f.tick, release: 0.25, cutoff: cutoff_mod.look, divisor: 0.5, depth: 8, amp: 1.0
                
                if look % 2 == 0
                  use_synth :tech_saws
                  play_chord f_progression.look / 2, cutoff: (line 90, 120, steps: 8).look / 2, release: 1.2, amp: 0.5
                end
                
                use_synth :tb303
                play bass_pattern_f.look, cutoff: 78, release: 0.45, res: 0.8, amp: 0.7
                
                kick_amp = n == 0 ? 0.85 : 0.75
                sample :bd_haus, amp: kick_amp
                sample :hat_psych, amp: 0.4
                sleep 0.125
                sample :hat_psych, amp: 0.3
                sleep 0.125
                sample :hat_psych, amp: 0.35
                sleep 0.125
                sample :hat_psych, amp: 0.25
                sleep 0.125
              end
            end
          end
        end
      end
    end
    
    # Final transition - Rich sustained chord
    use_synth :fm
    play :f2, cutoff: 90, release: 12, divisor: 4, depth: 20, amp: 0.6
    use_synth :prophet
    play_chord chord(:f3, :major7), cutoff: 95, release: 12, amp: 0.6
    use_synth :supersaw
    play_chord chord(:f4, :major), cutoff: 100, release: 12, amp: 0.5
    use_synth :subpulse
    play :f2, cutoff: 68, release: 12, amp: 0.6
    4.times do
      sample :bd_haus, amp: 0.7
      sample :elec_cymbal, amp: 0.4
      sleep 1
      sample :elec_hi_snare, amp: 0.5
      sleep 1
    end
    
  end
end