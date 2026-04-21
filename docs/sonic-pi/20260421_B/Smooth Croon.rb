use_debug false
use_bpm 72

# Moonlight Serenade
# Romantic Jazz

with_fx :level, amp: 0.8 do

  # Melody - romantic jazz lead
  live_loop :melody do
    with_fx :reverb, room: 0.4, mix: 0.4 do
      use_synth :sine

      # Bar 1 - opening phrase
      play :f4, release: 1.5, cutoff: 100, amp: 1.3
      sleep 1.5
      play :g4, release: 0.4, cutoff: 95, amp: 1.2
      sleep 0.5
      play :a4, release: 0.8, cutoff: 105, amp: 1.2
      sleep 1
      play :g4, release: 0.8, cutoff: 90, amp: 1.1
      sleep 1

      # Bar 2 - continuation
      play :f4, release: 1.5, cutoff: 100, amp: 1.3
      sleep 1.5
      play :e4, release: 0.4, cutoff: 95, amp: 1.2
      sleep 0.5
      play :d4, release: 0.8, cutoff: 105, amp: 1.2
      sleep 1
      play :c4, release: 0.8, cutoff: 90, amp: 1.1
      sleep 1

      # Bar 3 - development
      play :d4, release: 1.5, cutoff: 100, amp: 1.3
      sleep 1.5
      play :e4, release: 0.4, cutoff: 95, amp: 1.2
      sleep 0.5
      play :f4, release: 0.8, cutoff: 105, amp: 1.2
      sleep 1
      play :a4, release: 0.8, cutoff: 110, amp: 1.2
      sleep 1

      # Bar 4 - resolution
      play :g4, release: 1.5, cutoff: 100, amp: 1.3
      sleep 1.5
      play :f4, release: 0.4, cutoff: 95, amp: 1.2
      sleep 0.5
      play :e4, release: 0.8, cutoff: 90, amp: 1.2
      sleep 1
      play :f4, release: 2, cutoff: 85, amp: 1.4
      sleep 1
    end
  end

  # Piano accompaniment - jazz chords
  live_loop :piano_chords do
    use_synth :piano

    # Bar 1 - Fmaj7
    play_chord chord(:f3, :major7), sustain: 3.5, release: 0.5, amp: 0.5
    sleep 4

    # Bar 2 - Dm7
    play_chord chord(:d3, :minor7), sustain: 3.5, release: 0.5, amp: 0.5
    sleep 4

    # Bar 3 - Gm7
    play_chord chord(:g3, :minor7), sustain: 3.5, release: 0.5, amp: 0.5
    sleep 4

    # Bar 4 - C7 to Fmaj7
    play_chord chord(:c3, :dom7), sustain: 1.5, release: 0.5, amp: 0.5
    sleep 2
    play_chord chord(:f3, :major7), sustain: 1.5, release: 0.5, amp: 0.5
    sleep 2
  end

  # Walking bass line
  live_loop :bass do
    use_synth :sine

    # Bar 1 - F walking
    notes = (ring :f2, :a2, :c3, :a2)
    4.times do
      play notes.tick, release: 0.4, cutoff: 70, amp: 0.6
      sleep 1
    end

    # Bar 2 - Dm walking
    notes = (ring :d2, :f2, :a2, :f2)
    4.times do
      play notes.tick, release: 0.4, cutoff: 70, amp: 0.6
      sleep 1
    end

    # Bar 3 - Gm walking
    notes = (ring :g2, :bb2, :d3, :bb2)
    4.times do
      play notes.tick, release: 0.4, cutoff: 70, amp: 0.6
      sleep 1
    end

    # Bar 4 - C7 to F
    play :c2, release: 0.4, cutoff: 70, amp: 0.6
    sleep 1
    play :e2, release: 0.4, cutoff: 70, amp: 0.6
    sleep 1
    play :f2, release: 0.4, cutoff: 70, amp: 0.6
    sleep 1
    play :a2, release: 0.4, cutoff: 70, amp: 0.6
    sleep 1
  end

  # Extended jazz harmony - organ pad
  live_loop :harmony_organ do
    with_fx :reverb, room: 0.4, mix: 0.4 do
      use_synth :organ_tonewheel

      # Bar 1 - Fmaj9
      play_chord chord(:f3, :maj9), sustain: 3.5, release: 0.5, cutoff: 95, amp: 0.3
      sleep 4

      # Bar 2 - Dm9
      play_chord chord(:d3, :m9), sustain: 3.5, release: 0.5, cutoff: 95, amp: 0.3
      sleep 4

      # Bar 3 - Gm9
      play_chord chord(:g3, :m9), sustain: 3.5, release: 0.5, cutoff: 95, amp: 0.3
      sleep 4

      # Bar 4 - C13 to Fmaj9
      play_chord chord(:c3, '13'), sustain: 1.5, release: 0.5, cutoff: 100, amp: 0.3
      sleep 2
      play_chord chord(:f3, :maj9), sustain: 1.5, release: 0.5, cutoff: 90, amp: 0.35
      sleep 2
    end
  end

  # Inner voice movement - piano comping
  live_loop :harmony_piano do
    use_synth :piano

    # Bar 1 - Fmaj9 inner voices
    play :a3, release: 0.8, cutoff: 85, amp: 0.3
    play :e4, release: 0.8, cutoff: 85, amp: 0.3
    sleep 2
    play :c4, release: 0.8, cutoff: 85, amp: 0.25
    sleep 1
    play :a3, release: 0.8, cutoff: 85, amp: 0.25
    sleep 1

    # Bar 2 - Dm9 inner voices
    play :f3, release: 0.8, cutoff: 85, amp: 0.3
    play :c4, release: 0.8, cutoff: 85, amp: 0.3
    sleep 2
    play :a3, release: 0.8, cutoff: 85, amp: 0.25
    sleep 1
    play :e4, release: 0.8, cutoff: 85, amp: 0.25
    sleep 1

    # Bar 3 - Gm9 inner voices
    play :bb3, release: 0.8, cutoff: 85, amp: 0.3
    play :f4, release: 0.8, cutoff: 85, amp: 0.3
    sleep 2
    play :d4, release: 0.8, cutoff: 85, amp: 0.25
    sleep 1
    play :a4, release: 0.8, cutoff: 85, amp: 0.25
    sleep 1

    # Bar 4 - C13 to Fmaj9
    play :e3, release: 0.4, cutoff: 85, amp: 0.3
    play :bb3, release: 0.4, cutoff: 85, amp: 0.3
    sleep 0.5
    play :e3, release: 0.4, cutoff: 85, amp: 0.25
    sleep 0.5
    play :e3, release: 0.8, cutoff: 85, amp: 0.3
    play :a3, release: 0.8, cutoff: 85, amp: 0.3
    sleep 1
    play :a3, release: 1, cutoff: 80, amp: 0.3
    play :e4, release: 1, cutoff: 80, amp: 0.3
    sleep 1
    play :c4, release: 1, cutoff: 80, amp: 0.25
    sleep 1
  end

  # Chromatic passing tones
  live_loop :harmony_fills do
    use_synth :piano

    sleep 3
    play :gs3, release: 0.3, cutoff: 90, amp: 0.2
    sleep 1

    sleep 3
    play :cs4, release: 0.3, cutoff: 90, amp: 0.2
    sleep 1

    sleep 3
    play :fs3, release: 0.3, cutoff: 90, amp: 0.2
    sleep 1

    sleep 1.5
    play :b3, release: 0.2, cutoff: 90, amp: 0.2
    sleep 0.5
    play :e4, release: 0.3, cutoff: 85, amp: 0.2
    sleep 1
    play :g3, release: 0.8, cutoff: 85, amp: 0.25
    sleep 1
  end

  # Jazz drums with swing feel
  live_loop :drums do
    with_fx :reverb, room: 0.25, mix: 0.3 do

      4.times do |bar|

        # Beat 1 - kick and ride
        sample :drum_bass_soft, amp: 0.7
        sample :drum_cymbal_soft, amp: 0.5
        sleep 0.66
        sample :drum_cymbal_soft, amp: 0.3
        sleep 0.34

        # Beat 2 - snare and ride
        sample :drum_snare_soft, amp: 0.6
        sample :drum_cymbal_soft, amp: 0.45
        sleep 0.66
        sample :drum_cymbal_soft, amp: 0.3
        sleep 0.34

        # Beat 3 - kick and ride
        sample :drum_bass_soft, amp: 0.65
        sample :drum_cymbal_soft, amp: 0.5
        sleep 0.66
        sample :drum_cymbal_soft, amp: 0.3
        sleep 0.34

        # Beat 4 - snare and ride
        sample :drum_snare_soft, amp: 0.6
        sample :drum_cymbal_soft, amp: 0.45
        sleep 0.66
        sample :drum_cymbal_soft, amp: 0.35
        sample :drum_snare_soft, amp: 0.35 if bar == 3
        sleep 0.34
      end
    end
  end

end