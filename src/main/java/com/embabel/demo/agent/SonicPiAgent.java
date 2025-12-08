package com.embabel.demo.agent;

import com.embabel.agent.api.annotation.AchievesGoal;
import com.embabel.agent.api.annotation.Action;
import com.embabel.agent.api.annotation.Agent;
import com.embabel.agent.api.annotation.Export;
import com.embabel.agent.api.common.OperationContext;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.sonicpi.SonicPiRequest;
import com.embabel.demo.model.sonicpi.SonicPiScript;
import com.embabel.demo.model.sonicpi.SonicPiScriptWithBackgroundTrack;
import java.io.File;
import java.io.FileWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Agent(description = "Write Sonic Pi code to play a melody based on user input")
public record SonicPiAgent() {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiAgent.class);

    // TODO Use a Prompt Contributor to provide all of the available instruments and samples.
    private static final String SAMPLES = """
            :bd_ada, :bd_pure, :bd_808, :bd_zum, :bd_gas, :bd_sone, :bd_haus, :bd_zome, :bd_boom, :bd_klub,
            :bd_fat, :bd_tek, :bd_mehackit, :bd_chip, :bd_jazz, :bass_hit_c, :bass_hard_c, :bass_thick_c, 
            :bass_drop_c, :bass_woodsy_c, :bass_voxy_c, :bass_voxy_hit_c, :bass_dnb_f, :bass_trance_c, 
            :drum_heavy_kick, :drum_tom_mid_soft, :drum_tom_mid_hard, :drum_tom_lo_soft, :drum_tom_lo_hard, 
            :drum_tom_hi_soft, :drum_tom_hi_hard, :drum_splash_soft, :drum_splash_hard, :drum_snare_soft, 
            :drum_snare_hard, :drum_cymbal_soft, :drum_cymbal_hard, :drum_cymbal_open, :drum_cymbal_closed, 
            :drum_cymbal_pedal, :drum_bass_soft, :drum_bass_hard, :drum_cowbell, :drum_roll, 
            :elec_triangle, :elec_snare, :elec_lo_snare, :elec_hi_snare, :elec_mid_snare, :elec_cymbal, 
            :elec_soft_kick, :elec_filt_snare, :elec_fuzz_tom, :elec_chime, :elec_bong, :elec_twang, 
            :elec_wood, :elec_pop, :elec_beep, :elec_blip, :elec_blip2, :elec_ping, :elec_bell, :elec_flip, 
            :elec_tick, :elec_hollow_kick, :elec_twip, :elec_plip, :elec_blup, 
            :hat_snap, :hat_zan, :hat_zap, :hat_tap, :hat_cats, :hat_bdu, :hat_psych, :hat_raw, :hat_zild, 
            :hat_gump, :hat_noiz, :hat_sci, :hat_star, :hat_gem, :hat_yosh, :hat_mess, :hat_cab, :hat_gnu, 
            :hat_hier, :hat_metal, :hat_len
            """;

    private static final String INSTRUMENTS = """
            :bass_foundation, :bass_highend, :beep, :blade, :bnoise, :chipbass, :chiplead, :chipnoise, :dark_ambience, 
            :dpulse, :dsaw, :dtri, :dull_bell, :fm, :gabberkick, :gnoise, :growl, :hollow, :hoover, :kalimba, :mod_beep, 
            :mod_dsaw, :mod_fm, :mod_pulse, :mod_saw, :mod_sine, :mod_tri, :noise, :organ_tonewheel, :piano, :pluck, 
            :rhodey, :rodeo, :saw, :sine, :sound_in, :sound_in_stereo, :square, :subpulse, 
            :supersaw, :tb303, :tech_saws, :tri, :winwood_lead, :zawa
            """;


    @Action
    public SonicPiRequest toSonicPiRequest(UserInput userInput, OperationContext context) {
        LOG.info("Converting user input to SonicPiRequest: {}", userInput);
        return context.ai()
                .withAutoLlm()
                .createObject("""
                                Convert the following user input into a SonicPiRequest object.
                                The user input is: '%s'.
                                Extract the melody description as a string.
                                Only use these instruments: %s."""
                                .formatted(
                                        userInput.getContent(),
                                        INSTRUMENTS),
                        SonicPiRequest.class);
    }

    @Action
    public SonicPiScript createMelody(SonicPiRequest sonicPiRequest, OperationContext context) {
        LOG.info("Creating melody for SonicPiRequest: {}", sonicPiRequest);
        SonicPiScript sonicPiScript = context.ai()
                .withAutoLlm()
                .createObject("""
                                Write a Sonic Pi code snippet to play a melody based on the following user input: '%s'.
                                Ensure the code is ready to run in Sonic Pi without any modifications.
                                Do not use '#' in note names (e.g., use ':c4' instead of ':c#4').
                                Base the song title on '%s'.
                                Set the mood to '%s'.
                                Use the following instruments: '%s'.
                                Only use instruments from the provided list:
                                <instruments>
                                %s
                                </instruments>
                                Provide a comment at the top of the script content with the song title."""
                                .formatted(
                                        sonicPiRequest.style(),
                                        sonicPiRequest.songTitle(),
                                        sonicPiRequest.mood(),
                                        sonicPiRequest.instruments(),
                                        INSTRUMENTS),
                        SonicPiScript.class);

        String fileName = "sonic_pi_script_" + System.currentTimeMillis() + ".rb";
        writeFile(fileName, sonicPiScript.scriptContent());
        return sonicPiScript;
    }

    @Action
    public SonicPiScriptWithBackgroundTrack addBackgroundTrack(
            SonicPiScript sonicPiScript, SonicPiRequest sonicPiRequest, OperationContext context) {
        LOG.info("Adding background track to SonicPiScript: {}", sonicPiScript);
        return context.ai()
                .withAutoLlm()
                .createObject("""
                                Based on the following Sonic Pi script content:
                                <scriptContent>
                                %s
                                </scriptContent>
                                Add a background track as per this description: '%s'.
                                Make the background track complement the existing melody.
                                The track must be DJ friendly and loop seamlessly.
                                Must be smashingly good.
                                Must be loud.
                                Do not use piano or guitar for the background track.
                                We want a rich, full sound using drums, bass, synths, and pads.
                                Use live_loops to create the foreground and background tracks.
                                Ensure the code is ready to run in Sonic Pi without any modifications.
                                Do not use '#' in note names (e.g., use ':c4' instead of ':c#4').
                                Only use these instruments:
                                <instruments>
                                %s
                                </instruments>
                                Drums/percussion must be played using `sample`, and not using `play_pattern_timed`:
                                <samples>
                                %s.
                                </samples>
                                Provide a comment at the top of the script content with the song title."""
                                .formatted(
                                        sonicPiScript.scriptContent(),
                                        sonicPiRequest.backgroundTrackDescription(),
                                        INSTRUMENTS,
                                        SAMPLES),
                        SonicPiScriptWithBackgroundTrack.class);
    }

    @AchievesGoal(
            description = "Sonic Pi code has been generated based on user input",
            export = @Export(remote = true, name = "sonicPiCode"))
    @Action
    public SonicPiScriptWithBackgroundTrack generateSonicPiCode(SonicPiScriptWithBackgroundTrack sonicPiScriptWithBackgroundTrack) {
        String fileName = "sonic_pi_script_" + System.currentTimeMillis() + "_with_background_track.rb";
        writeFile(fileName, sonicPiScriptWithBackgroundTrack.scriptContent());
        return sonicPiScriptWithBackgroundTrack;
    }

    private static void writeFile(String fileName, String scriptContent) {
        try (FileWriter fileWriter = new FileWriter(fileName)) {
            fileWriter.write(scriptContent);
        } catch (java.io.IOException e) {
            throw new RuntimeException("Failed to write Sonic Pi script to file", e);
        }

        File file = new File(fileName);
        LOG.info("Sonic Pi code has been saved to file: {}", file.getAbsolutePath());
    }
}
