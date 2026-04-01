package com.embabel.demo.agent;

import com.embabel.agent.api.annotation.AchievesGoal;
import com.embabel.agent.api.annotation.Action;
import com.embabel.agent.api.annotation.Agent;
import com.embabel.agent.api.annotation.Export;
import com.embabel.agent.api.common.OperationContext;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.common.ai.model.LlmOptions;
import com.embabel.demo.model.sonicpi.SonicPiCompleteScript;
import com.embabel.demo.model.sonicpi.SonicPiMetadata;
import com.embabel.demo.model.sonicpi.SonicPiScript;
import com.embabel.demo.model.sonicpi.SonicPiScriptWithMelody;
import com.embabel.demo.model.sonicpi.SonicPiScriptWithHarmony;
import com.embabel.demo.model.sonicpi.SonicPiScriptWithPercussion;
import com.embabel.demo.prompt.persona.SonicPiPromptContributor;
import java.io.File;
import java.io.FileWriter;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// TODO Use an document-recognition LLM to read a PDF of sheet music and convert it to Sonic Pi code.

@Agent(description = "Write Sonic Pi code to play a melody based on user input")
public record SonicPiAgent(
        SonicPiPromptContributor sonicPiPromptContributor) {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiAgent.class);

    @Action
    public SonicPiMetadata toSonicPiMetadata(UserInput userInput, OperationContext context) {
        LOG.info("Converting user input to {}", userInput);
        return context.ai()
                .withLlm(LlmOptions.withAutoLlm().withTemperature(1.0))
                .withPromptContributor(sonicPiPromptContributor)
                .withTemplate("sonicpi/to-meta-data.jinja")
                .createObject(SonicPiMetadata.class, Map.of(
                        "userInput", userInput.getContent()
                ));
    }

    @Action
    public SonicPiScriptWithMelody createMelody(SonicPiMetadata sonicPiMetadata, OperationContext context) {
        LOG.info("Creating melody for {}", sonicPiMetadata);
        return context.ai()
                .withLlm(LlmOptions.withAutoLlm().withTemperature(1.0))
                .withPromptContributor(sonicPiPromptContributor)
                .withTemplate("sonicpi/create-melody.jinja")
                .createObject(SonicPiScriptWithMelody.class, Map.of(
                        "style", sonicPiMetadata.style(),
                        "songTitle", sonicPiMetadata.songTitle(),
                        "composerName", sonicPiMetadata.composerName(),
                        "tempoBpm", sonicPiMetadata.tempoBpm(),
                        "mood", sonicPiMetadata.mood(),
                        "key", sonicPiMetadata.key(),
                        "keyChange", sonicPiMetadata.keyChange(),
                        "timeSignature", sonicPiMetadata.timeSignature(),
                        "measures", sonicPiMetadata.measures(),
                        "melodyInstruments", String.join(", ", sonicPiMetadata.melodyInstruments())));
    }

    @Action
    public SonicPiScriptWithHarmony addHarmony(
            SonicPiScriptWithMelody sonicPiScriptWithMelody, SonicPiMetadata sonicPiMetadata, OperationContext context) {
        LOG.info("Adding harmony track to {}", sonicPiScriptWithMelody);
        return context.ai()
                .withLlm(LlmOptions.withAutoLlm().withTemperature(1.0))
                .withTemplate("sonicpi/add-harmony.jinja")
                .createObject(SonicPiScriptWithHarmony.class, Map.of(
                        "melodyScriptContent", sonicPiScriptWithMelody.scriptContent(),
                        "harmonyDescription", sonicPiMetadata.harmonyDescription(),
                        "harmonyInstruments", String.join(", ", sonicPiMetadata.harmonyInstruments())));
    }

    @Action
    public SonicPiScriptWithPercussion addPercussion(
            SonicPiScriptWithMelody sonicPiScriptWithMelody, SonicPiMetadata sonicPiMetadata, OperationContext context) {
        LOG.info("Adding percussion track to {}", sonicPiScriptWithMelody);
        return context.ai()
                .withLlm(LlmOptions.withAutoLlm().withTemperature(1.0))
                .withTemplate("sonicpi/add-percussion.jinja")
                .createObject(SonicPiScriptWithPercussion.class, Map.of(
                        "melodyScriptContent", sonicPiScriptWithMelody.scriptContent(),
                        "percussionDescription", sonicPiMetadata.percussionDescription(),
                        "percussionSamples", String.join(", ", sonicPiMetadata.percussionSamples())));
    }

    @AchievesGoal(
            description = "Sonic Pi code has been generated based on user input",
            export = @Export(remote = true, name = "sonicPiCode", startingInputTypes = {UserInput.class}))
    @Action
    public SonicPiScript combineAllSonicPiScripts(
            SonicPiMetadata sonicPiMetadata,
            SonicPiScriptWithMelody sonicPiScriptWithMelody,
            SonicPiScriptWithHarmony sonicPiScriptWithHarmony,
            SonicPiScriptWithPercussion sonicPiScriptWithPercussion,
            OperationContext context) {

        LOG.info("Combining all Sonic Pi scripts into one final script from the following parts:");
        LOG.info("{}", sonicPiScriptWithMelody.scriptContent());
        LOG.info("{}", sonicPiScriptWithHarmony.scriptContent());
        LOG.info("{}", sonicPiScriptWithPercussion.scriptContent());

        var sonicPiCompleteScript = context.ai()
                .withLlm(LlmOptions.withAutoLlm().withTemperature(1.0))
                .withPromptContributor(sonicPiPromptContributor)
                .withTemplate("sonicpi/combine-all-parts.jinja")
                .createObject(SonicPiCompleteScript.class, Map.of(
                        "melodyScriptContent", sonicPiScriptWithMelody.scriptContent(),
                        "harmonyScriptContent", sonicPiScriptWithHarmony.scriptContent(),
                        "percussionScriptContent", sonicPiScriptWithPercussion.scriptContent()));

        var sonicPiScript = new SonicPiScript(
                sonicPiMetadata,
                sonicPiCompleteScript
        );
        writeFile(sonicPiScript.filename(), sonicPiCompleteScript.scriptContent());
        return sonicPiScript;
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
