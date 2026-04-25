use_debug false
use_bpm 72

# Smooth Croon
# Jazz in F major, 4/4 time

with_fx :level, amp: 1.2 do
  with_fx :compressor, threshold: 0.4, clamp_time: 0.01, relax_time: 0.1, slope_above: 0.5 do

    # Section 1: Smooth piano intro with warm jazz chords and gentle brushes
    2.times do
      in_thread do
        use_synth :organ_tonewheel
        play_chord chord(:f3, :major7), cutoff: 85, release: 16, amp: 0.3
      end
      
      in_thread do
        use_synth :fm
        play :f2, release: 8, cutoff: 85, divisor: 2, depth: 8, amp: 0.35
      end
      
      in_thread do
        with_fx :lpf, cutoff: 110 do
          with_fx :reverb, room: 0.25, mix: 0.3 do
            use_synth :piano
            melody = (ring :f4, :a4, :c5, :e5, :g5, :c5, :a4, :f4)
            cutoffs = (line 90, 110, steps: 8)
            4.times do
              play melody.tick, cutoff: cutoffs.look, release: 0.3, amp: 0.9
              sleep 0.5
            end
            notes = (ring :f4, :g4, :gs4, :a4, :c5, :bf4, :a4, :g4)
            cutoffs = (line 100, 115, steps: 8)
            4.times do
              play notes.tick, cutoff: cutoffs.look, release: 0.4, amp: 0.95
              sleep 0.5
            end
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.3, mix: 0.35 do
          use_synth :piano
          chords = (knit chord(:f3, :major7), 2, chord(:a3, :minor7), 2)
          cutoffs = (line 85, 100, steps: 4)
          4.times do
            play_chord chords.tick, cutoff: cutoffs.look, release: 1.8, amp: 0.5
            sleep 2
          end
        end
      end
      
      with_fx :reverb, room: 0.25, mix: 0.25 do
        8.times do
          sample :drum_bass_soft, amp: 0.5
          sample :drum_cymbal_closed, amp: 0.35, rate: 0.95
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.25, rate: 0.95
          sleep 0.5
          sample :drum_snare_soft, amp: 0.45 if one_in(3)
          sample :drum_cymbal_closed, amp: 0.3, rate: 0.95
          sleep 0.5
          sample :drum_cymbal_closed, amp: 0.25, rate: 0.95
          sleep 0.5
        end
      end
    end

    # Transition: Warm Rhodes and FM drone bridges sections
    use_synth :rhodey
    play :f2, cutoff: 95, release: 10, amp: 0.5
    use_synth :fm
    play_chord chord(:f2, :major7), cutoff: 88, release: 10, divisor: 3, depth: 8, amp: 0.4
    4.times do
      sample :drum_cymbal_closed, amp: 0.3, rate: 0.95
      sleep 0.5
      sample :drum_cymbal_closed, amp: 0.2, rate: 0.95
      sleep 0.5
    end

    # Section 2: Rhodes lead with bluesy inflections and swing pattern
    3.times do
      in_thread do
        use_synth :fm
        play_chord chord(:f2, :major7), cutoff: 80, release: 14, divisor: 2, depth: 6, amp: 0.3
      end
      
      in_thread do
        use_synth :prophet
        play :f2, release: 12, cutoff: 88, amp: 0.3
      end
      
      in_thread do
        with_fx :reverb, room: 0.28, mix: 0.35 do
          use_synth :rhodey
          phrase1 = (knit :f4, 1, :a4, 1, :d5, 1, :c5, 2, :bf4, 1, :a4, 1, :g4, 1)
          cutoffs1 = (line 95, 125, steps: 8)
          8.times do
            play phrase1.tick, cutoff: cutoffs1.look, release: 0.35, amp: 0.92
            sleep 0.5
          end
          phrase2 = (ring :e5, :d5, :cs5, :c5, :bf4, :a4, :gs4, :g4)
          cutoffs2 = (line 115, 90, steps: 8)
          8.times do
            play phrase2.tick, cutoff: cutoffs2.look, release: 0.3, amp: 0.88
            sleep 0.5
          end
        end
      end
      
      in_thread do
        with_fx :reverb, room: 0.35, mix: 0.4 do
          use_synth :piano
          progression1 = (knit chord(:g3, :minor7), 1, chord(:c3, :dom7), 1, chord(:f3, :major7), 2)
          cutoffs1 = (line 90, 110, steps: 4)
          4.times do
            play_chord progression1.tick, cutoff: cutoffs1.look, release: 1.5, amp: 0.55
            sleep 2
          end
          progression2 = (ring chord(:d3, :minor7), chord(:db3, :dom7), chord(:c3, :minor7), chord(:f3, :dom7))
          cutoffs2 = (line 105, 88, steps: 4)
          4.times do
            play_chord progression2.tick, cutoff: cutoffs2.look, release: 1.6, amp: 0.52
            sleep 2
          end
        end
      end
      
      16.times do
        sample :drum_bass_soft, amp: 0.6
        sample :hat_tap, amp: 0.35, pan: -0.3
        sleep 0.333
        sample :hat_tap, amp: 0.25, pan: 0.3
        sleep 0.167
        sample :drum_cymbal_closed, amp: 0.3, rate: 0.95
        sleep 0.5
        sample :drum_snare_soft, amp: (spread 3, 8).tick ? 0.55 : 0.4
        sample :hat_tap, amp: 0.3
        sleep 0.333
        sample :hat_tap, amp: 0.2, pan: -0.2
        sleep 0.167
        sample :drum_cymbal_closed, amp: 0.25, rate: 0.95
        sleep 0.5
      end
    end

    # Transition: FM synth and organ swell
    use_synth :fm
    play :f2, cutoff: 92, release: 9, divisor: 3, depth: 12, amp: 0.5
    use_synth :organ_tonewheel
    play_chord chord(:f2, :major7), cutoff: 92, release: 11, amp: 0.45
    8.times do
      sample :drum_cymbal_closed, amp: 0.35, rate: 0.93, pan: rrand(-0.4, 0.4)
      sleep 0.5
    end

    # Section 3: FM synth climax with bebop runs and building percussion
    2.times do
      in_thread do
        use_synth :piano
        play_chord chord(:f2, :major7), cutoff: 82, release: 12, amp: 0.35
      end
      
      in_thread do
        use_synth :rhodey
        play :f2, release: 10, cutoff: 85, amp: 0.25
      end
      
      in_thread do
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.25 do
          use_synth :fm
          use_synth_defaults divisor: 2, depth: 6
          run1 = (scale :f4, :major, num_octaves: 2).take(12)
          cutoffs_run = (line 105, 130, steps: 12)
          12.times do
            play run1.tick, cutoff: cutoffs_run.look, release: 0.15, amp: 0.85
            sleep 0.333
          end
          phrase3 = (knit :a5, 2, :g5, 2, :f5, 3, :c5, 1)
          cutoffs3 = (line 120, 95, steps: 8)
          8.times do
            play phrase3.tick, cutoff: cutoffs3.look, release: 0.4, amp: 0.9
            sleep 0.5
          end
        end
      end
      
      in_thread do
        with_fx :echo, phase: 0.375, decay: 1.5, mix: 0.25 do
          use_synth :fm
          use_synth_defaults divisor: 3, depth: 5
          arp_notes = (ring :f3, :a3, :c4, :e4, :g4)
          cutoffs_arp = (line 95, 120, steps: 12)
          12.times do
            play arp_notes.tick, cutoff: cutoffs_arp.look, release: 0.3, amp: 0.6
            sleep 0.333
          end
          final_progression = (knit chord(:c3, :dom7), 2, chord(:f3, :major7), 2)
          cutoffs_final = (line 115, 85, steps: 4)
          4.times do
            play_chord final_progression.tick, cutoff: cutoffs_final.look, release: 1.8, amp: 0.58
            sleep 2
          end
        end
      end
      
      with_fx :hpf, cutoff: 90 do
        12.times do
          sample :drum_bass_soft, amp: 0.65
          sample :hat_tap, amp: 0.4
          sleep 0.333
          sample :hat_tap, amp: 0.3
          sample :drum_snare_soft, amp: 0.5 if one_in(4)
          sleep 0.333
          sample :drum_cymbal_closed, amp: 0.35, rate: 0.95
          sleep 0.334
        end
        8.times do
          sample :drum_bass_soft, amp: 0.7
          sample :drum_cymbal_closed, amp: 0.4, rate: 0.95
          sleep 0.25
          sample :hat_tap, amp: 0.35
          sleep 0.25
          sample :drum_snare_soft, amp: 0.6
          sample :drum_cymbal_closed, amp: 0.3, rate: 0.95
          sleep 0.25
          sample :hat_tap, amp: 0.3
          sleep 0.25
        end
      end
    end

    # Final cadence: Warm blend with gentle fade
    use_synth :piano
    play_chord chord(:f3, :major9), cutoff: 100, release: 6, amp: 0.7
    use_synth :organ_tonewheel
    play_chord chord(:f2, :major7), cutoff: 90, release: 8, amp: 0.5
    8.times do
      sample :drum_cymbal_closed, amp: (line 0.3, 0.15, steps: 8).tick, rate: 0.93
      sleep 0.5
    end

  end
end