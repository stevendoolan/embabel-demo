# Electric Symphony
# Electronic / Dramatic / 128 BPM / 4/4 Time
# Key: Am → C

use_debug false
use_bpm 128

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do
    
    # Section 1: Dark atmospheric opening in Am
    # Melody: saw lead with drone foundation
    # Harmony: dark_ambience pads with hollow chords
    # Bass: sustained foundation with subtle tb303 pulse
    # Percussion: sparse, building tension
    3.times do
      in_thread do
        use_synth :prophet
        play :a2, release: 12, cutoff: 85, amp: 0.5
        
        with_fx :lpf, cutoff: 100 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            use_synth :saw
            melody_notes = (ring :a3, :c4, :e4, :a4, :e4, :c4, :d4, :e4)
            16.times do
              play melody_notes.tick, cutoff: rrand(90, 110), release: 0.2, amp: 0.9
              sleep 0.25
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :dark_ambience
          play_chord chord(:a2, :minor), cutoff: 85, release: 12, amp: 0.6
          
          use_synth :hollow
          chords_progression = [chord(:a3, :minor), chord(:c3, :major), chord(:d3, :minor), chord(:e3, :minor)]
          4.times do |i|
            play_chord chords_progression[i], cutoff: (line 80, 100, steps: 4).look, release: 4, amp: 0.5
            sleep 4
          end
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :a1, cutoff: 65, release: 8, amp: 0.75
        sleep 2
        
        use_synth :tb303
        bass_pattern = (ring :a2, :a2, :e2, :a2)
        4.times do
          play bass_pattern.tick, cutoff: 70, release: 0.8, res: 0.8, amp: 0.6
          sleep 1
        end
        
        use_synth :bass_foundation
        play :e2, cutoff: 68, release: 4, amp: 0.7
        sleep 2
      end
      
      in_thread do
        4.times do
          sample :bd_haus, amp: 0.6
          sleep 0.5
          sample :elec_tick, amp: 0.3
          sleep 0.25
          sample :elec_tick, amp: 0.25
          sleep 0.25
          sample :elec_snare, amp: 0.5
          sleep 0.5
          sample :hat_psych, amp: 0.35
          sleep 0.25
          sample :hat_psych, amp: 0.3
          sleep 0.25
        end
      end
      
      sleep 16
    end
    
    # Transition drone - bridges to next section
    use_synth :prophet
    play :a2, cutoff: 90, release: 8, amp: 0.6
    sample :drum_cymbal_soft, amp: 0.5, rate: 0.9
    sleep 4
    
    # Section 2: Building intensity with supersaw in Am
    # Melody: faster rhythmic patterns with supersaw
    # Harmony: layered pads with voice leading
    # Bass: walking bass pattern with syncopation
    # Percussion: faster patterns, more layers
    3.times do
      in_thread do
        use_synth :fm
        play :a2, release: 10, divisor: 3, depth: 15, cutoff: 80, amp: 0.4
        
        use_synth :supersaw
        melody_pattern = (ring :a4, :gs4, :a4, :c5, :e5, :d5, :c5, :a4)
        cutoff_line = (line 85, 115, steps: 16)
        16.times do
          play melody_pattern.tick, cutoff: cutoff_line.tick, release: 0.15, amp: 0.95
          sleep 0.25
        end
      end
      
      in_thread do
        use_synth :dark_ambience
        play_chord chord(:a2, :minor7), cutoff: 80, release: 10, amp: 0.55
        
        with_fx :lpf, cutoff: 100 do
          use_synth :prophet
          harmonic_sequence = [chord(:a3, :minor7), chord(:f3, :major7), chord(:c3, :major), chord(:g3, :dom7)]
          4.times do |i|
            play_chord harmonic_sequence[i], cutoff: rrand(85, 105), release: 3.5, amp: 0.6
            sleep 4
          end
        end
      end
      
      in_thread do
        with_fx :lpf, cutoff: 85 do
          use_synth :bass_foundation
          play :a1, cutoff: 68, release: 6, amp: 0.75
          sleep 1
          
          use_synth :tb303
          syncopated_bass = (ring :a2, :e2, :g2, :a2, :c3, :a2, :g2, :e2)
          cutoff_vals = (line 72, 88, steps: 8)
          8.times do
            play syncopated_bass.tick, cutoff: cutoff_vals.tick, release: 0.5, res: 0.85, amp: 0.65
            sleep 0.5
          end
          
          use_synth :chipbass
          play :e2, cutoff: 75, release: 2, amp: 0.6
          sleep 2
        end
      end
      
      in_thread do
        with_fx :hpf, cutoff: 100 do
          16.times do
            sample :bd_haus, amp: 0.7
            sample :hat_psych, amp: 0.4
            sleep 0.25
            sample :hat_psych, amp: 0.35
            sleep 0.25
            sample :elec_snare, amp: 0.6
            sample :hat_psych, amp: 0.4
            sample :elec_tick, amp: 0.4 if one_in(3)
            sleep 0.25
            sample :hat_psych, amp: 0.35
            sleep 0.25
          end
        end
      end
      
      sleep 16
    end
    
    # Transition drone with key change preparation
    use_synth :prophet
    play :c3, cutoff: 95, release: 10, amp: 0.65
    sample :drum_cymbal_soft, amp: 0.6, rate: 1.0
    4.times do
      sample :elec_tick, amp: 0.5
      sleep 0.25
    end
    sleep 3
    
    # Section 3: KEY CHANGE to C major - climactic resolution
    # Melody: prophet synth for dramatic lead voice
    # Harmony: full voiced chords with classical voice leading
    # Bass: powerful root notes with rhythmic accents
    # Percussion: dense patterns supporting climax
    4.times do
      in_thread do
        use_synth :dsaw
        play :c2, release: 12, cutoff: 75, amp: 0.45
        
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :prophet
          climax_melody = (ring :c4, :e4, :g4, :c5, :g4, :e4, :f4, :g4)
          cutoff_ramp = (line 95, 125, steps: 16)
          16.times do
            play climax_melody.tick, cutoff: cutoff_ramp.tick, release: 0.25, amp: 1.0
            sleep 0.25
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :dark_ambience
          play_chord chord(:c2, :major), cutoff: 75, release: 14, amp: 0.65
          
          use_synth :prophet
          climax_chords = [chord(:c3, :major), chord(:f3, :major), chord(:g3, :dom7), chord(:c3, :major)]
          cutoff_sweep = (line 90, 120, steps: 4)
          4.times do |i|
            play_chord climax_chords[i], cutoff: cutoff_sweep.tick, release: 3.8, amp: 0.7
            sleep 4
          end
        end
      end
      
      in_thread do
        use_synth :bass_foundation
        play :c2, cutoff: 70, release: 8, amp: 0.8
        sleep 2
        
        use_synth :tb303
        climax_bass = (ring :c2, :g2, :c3, :g2, :f2, :c2, :g2, :c2)
        cutoff_climb = (line 75, 90, steps: 8)
        8.times do
          play climax_bass.tick, cutoff: cutoff_climb.tick, release: 0.6, res: 0.85, amp: 0.7
          sleep 0.5
        end
        
        use_synth :chipbass
        play :g2, cutoff: 78, release: 2, amp: 0.65
        sleep 1
      end
      
      in_thread do
        with_fx :reverb, room: 0.25, mix: 0.25 do
          4.times do
            sample :bd_haus, amp: 0.8
            sample :hat_psych, amp: 0.45
            sleep 0.25
            sample :hat_psych, amp: 0.4
            sample :elec_tick, amp: 0.35
            sleep 0.25
            sample :elec_snare, amp: 0.7
            sample :hat_psych, amp: 0.45
            sample :drum_cymbal_soft, amp: 0.4 if spread(3, 8).tick
            sleep 0.25
            sample :hat_psych, amp: 0.4
            sleep 0.25
          end
        end
      end
      
      sleep 16
    end
    
    # Final transition drone - closing atmosphere
    use_synth :prophet
    play :c3, cutoff: 100, release: 12, amp: 0.7
    sample :drum_cymbal_soft, amp: 0.65, rate: 0.85
    sleep 6
    
  end
end