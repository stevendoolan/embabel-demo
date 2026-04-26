use_debug false

# Feed the Birds EDM Remix
# Style: EDM / Electronic Dance
# Mood: Uplifting and energetic

use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Opening - atmospheric intro with melody, harmony, and light percussion
    2.times do
      use_synth :prophet
      play :f2, release: 16, cutoff: 85, amp: 0.5
      
      in_thread do
        use_synth :prophet
        play_chord chord(:f3, :sus2), cutoff: 85, release: 16, amp: 0.4
      end
      
      in_thread do
        with_fx :lpf, cutoff: 100 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            use_synth :supersaw
            melody_notes = (ring :f4, :f4, :e4, :d4, :f4, :d4, :c4)
            melody_durs = (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3)
            
            7.times do
              play melody_notes.tick, cutoff: (line 90, 120, steps: 7).tick, release: 0.3, amp: 1.0
              sleep melody_durs.look
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :hollow
          harmony_chords = (ring chord(:f3, :major), chord(:f3, :sus2), chord(:c3, :major7), chord(:f3, :major))
          
          7.times do
            play_chord harmony_chords.tick, cutoff: (line 80, 95, steps: 7).tick, release: 2.5, amp: 0.3
            sleep (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3).look
          end
        end
      end
      
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.5
          sample :hat_bdu, amp: 0.25
          sleep 0.5
          sample :hat_bdu, amp: 0.2
          sleep 0.5
        end
        
        3.times do
          sample :bd_haus, amp: 0.55
          sample :hat_bdu, amp: 0.25
          sample :elec_tick, amp: 0.3 if one_in(3)
          sleep 0.5
          sample :hat_bdu, amp: 0.2
          sleep 0.5
        end
        
        sample :bd_haus, amp: 0.6
        sample :hat_bdu, amp: 0.25
        sleep 0.5
        sample :hat_bdu, amp: 0.2
        sleep 0.5
      end
      
      sleep 16
    end
    
    # Transition drone between Section 1 and Section 2
    use_synth :fm
    play :f2, cutoff: 90, release: 10, depth: 15, amp: 0.6
    sleep 4
    
    # Section 2: Building energy - pluck melody, warm harmony, active percussion
    3.times do
      use_synth :blade
      play :f2, release: 12, cutoff: 80, amp: 0.4
      
      in_thread do
        use_synth :hollow
        play_chord chord(:f2, :major7), cutoff: 88, release: 12, amp: 0.5
      end
      
      in_thread do
        use_synth :pluck
        harmony_notes = (ring :f3, :a3, :c4, :a3, :c4, :c4, :a3)
        
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.25 do
          7.times do
            play harmony_notes.tick, cutoff: rrand(95, 115), release: 0.2, amp: 0.9
            sleep (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3).look
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 100 do
          use_synth :prophet
          pad_progression = (ring chord(:f3, :major7), chord(:c3, :major7), chord(:d3, :minor7), chord(:c3, :major7))
          
          7.times do
            play_chord pad_progression.tick, cutoff: rrand(85, 105), release: 2.0, amp: 0.35
            sleep (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3).look
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          4.times do
            sample :bd_haus, amp: 0.65
            sample :hat_bdu, amp: 0.3
            sleep 0.25
            sample :hat_bdu, amp: 0.25
            sleep 0.25
            sample :elec_snare, amp: 0.55
            sample :hat_bdu, amp: 0.3
            sleep 0.25
            sample :hat_bdu, amp: 0.25
            sleep 0.25
          end
          
          3.times do
            sample :bd_haus, amp: 0.7
            sample :drum_cymbal_closed, amp: 0.35
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.3
            sleep 0.25
            sample :elec_snare, amp: 0.6
            sample :drum_cymbal_closed, amp: 0.35
            sample :elec_tick, amp: 0.3 if spread(3, 8).tick
            sleep 0.25
            sample :drum_cymbal_closed, amp: 0.3
            sleep 0.25
          end
        end
      end
      
      sleep 16
    end
    
    # Transition drone between Section 2 and Section 3
    use_synth :prophet
    play :f2, cutoff: 95, release: 8, amp: 0.6
    sleep 4
    
    # Section 3: Peak energy - FM lead, rich harmony, full EDM beat
    4.times do
      use_synth :supersaw
      play :f2, release: 14, cutoff: 88, amp: 0.45
      
      in_thread do
        use_synth :prophet
        play_chord chord(:f2, :major7), cutoff: 92, release: 14, amp: 0.5
      end
      
      in_thread do
        use_synth :fm
        bass_melody = (ring :f3, :a3, :c4, :d4, :f4, :d4, :c4)
        cutoff_ramp = (line 100, 130, steps: 7)
        
        7.times do
          play bass_melody.tick, cutoff: cutoff_ramp.tick, release: 0.25, divisor: 8, depth: 12, amp: 1.0
          sleep (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3).look
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :hollow
          peak_chords = (ring chord(:f3, :major7), chord(:a3, :minor7), chord(:c3, :major7), chord(:f3, :major7))
          cutoff_sweep = (line 90, 120, steps: 7)
          
          7.times do
            play_chord peak_chords.tick, cutoff: cutoff_sweep.tick, release: 1.8, amp: 0.4
            sleep (ring 2.5, 0.5, 3, 0.5, 2, 0.5, 3).look
          end
        end
      end
      
      in_thread do
        8.times do |b|
          kick_amp = (b % 4 == 0) ? 0.9 : 0.75
          sample :bd_haus, amp: kick_amp
          sample :hat_bdu, amp: 0.4
          sample :elec_tick, amp: 0.35 if spread(5, 16).tick
          sleep 0.25
          
          sample :drum_cymbal_closed, amp: 0.35
          sleep 0.25
          
          sample :elec_snare, amp: 0.7
          sample :hat_bdu, amp: 0.4
          sample :elec_tick, amp: 0.3 if one_in(2)
          sleep 0.25
          
          sample :drum_cymbal_closed, amp: 0.35
          sample :elec_tick, amp: 0.25 if spread(3, 8).look
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Final outro - fade out with sustained drone
    use_synth :prophet
    play :f2, cutoff: 90, release: 12, amp: 0.7
    
    in_thread do
      use_synth :dark_ambience
      play_chord chord(:f2, :major), cutoff: 85, release: 12, amp: 0.4
    end
    
    in_thread do
      4.times do |i|
        fade_amp = (line 0.6, 0.3, steps: 4).tick
        sample :bd_haus, amp: fade_amp
        sample :hat_bdu, amp: fade_amp * 0.5
        sleep 1
        sample :elec_snare, amp: fade_amp * 0.8
        sleep 1
      end
    end
    
    sleep 8
    
  end
end