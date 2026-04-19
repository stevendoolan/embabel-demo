package com.embabel.demo.agent;

import com.embabel.agent.api.annotation.AchievesGoal;
import com.embabel.agent.api.annotation.Action;
import com.embabel.agent.api.annotation.Agent;
import com.embabel.agent.api.annotation.Export;
import com.embabel.agent.api.common.OperationContext;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.common.ai.model.LlmOptions;
import com.embabel.demo.model.sonicpi.SonicPiMetadata;
import com.embabel.demo.model.sonicpi.SonicPiScriptWithMelody;
import com.embabel.demo.model.sonicpi.SonicPiScriptWithHarmony;
import com.embabel.demo.model.sonicpi.SonicPiScriptWithPercussion;
import com.embabel.demo.prompt.persona.SonicPiExamplesContributor;
import com.embabel.demo.prompt.persona.SonicPiPromptContributor;
import java.io.File;
import java.time.Duration;
import java.io.FileWriter;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Embabel agent that converts a free-text user prompt into a runnable Sonic Pi Ruby script through
 * a multi-step LLM pipeline: extract metadata, generate melody, add harmony, add percussion, and
 * combine all tracks into a single script. Each step uses Jinja templates and prompt contributors
 * for Sonic Pi instructions and example songs (few-shot context).
 *
 * <p>Exposed as an MCP tool via {@code @Export} so it can be invoked remotely.
 */
// TODO Use a document-recognition LLM to read a PDF of sheet music and convert it to Sonic Pi code.
@Agent(description = "Write Sonic Pi code to play a melody based on user input")
public class SonicPiAgent {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiAgent.class);

    private final SonicPiPromptContributor sonicPiPromptContributor;
    private final SonicPiExamplesContributor sonicPiExamplesContributor;

    public SonicPiAgent(SonicPiPromptContributor sonicPiPromptContributor,
                        SonicPiExamplesContributor sonicPiExamplesContributor) {
        this.sonicPiPromptContributor = sonicPiPromptContributor;
        this.sonicPiExamplesContributor = sonicPiExamplesContributor;
    }

    /**
     * The reason for the SonicPiPromptContributor here is to provide data for the instruments
     * in the SonicPiMetadata.
     */
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
                .withPromptContributor(sonicPiExamplesContributor)
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
                .withPromptContributor(sonicPiPromptContributor)
                .withPromptContributor(sonicPiExamplesContributor)
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
                .withPromptContributor(sonicPiPromptContributor)
                .withPromptContributor(sonicPiExamplesContributor)
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
    public String combineAllSonicPiScripts(
            SonicPiMetadata sonicPiMetadata,
            SonicPiScriptWithMelody sonicPiScriptWithMelody,
            SonicPiScriptWithHarmony sonicPiScriptWithHarmony,
            SonicPiScriptWithPercussion sonicPiScriptWithPercussion,
            OperationContext context) {

        LOG.info("Combining all Sonic Pi scripts into one final script from the following parts:");
        LOG.info("{}", sonicPiScriptWithMelody.scriptContent());
        LOG.info("{}", sonicPiScriptWithHarmony.scriptContent());
        LOG.info("{}", sonicPiScriptWithPercussion.scriptContent());

        var scriptContent = context.ai()
                .withLlm(LlmOptions.withAutoLlm().withTemperature(1.0).withTimeout(Duration.ofSeconds(120)))
                .withPromptContributor(sonicPiPromptContributor)
                .withPromptContributor(sonicPiExamplesContributor)
                .withTemplate("sonicpi/combine-all-parts.jinja")
                .createObject(String.class, Map.of(
                        "melodyScriptContent", sonicPiScriptWithMelody.scriptContent(),
                        "harmonyScriptContent", sonicPiScriptWithHarmony.scriptContent(),
                        "percussionScriptContent", sonicPiScriptWithPercussion.scriptContent()));

        var filename = "sonic_pi_script_%s.rb".formatted(System.currentTimeMillis());
        writeFile(filename, scriptContent);
        return scriptContent;
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
