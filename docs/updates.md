[← Previous: Agents](agents/index.md) | [Back to Index](../README.md)

---

# Updates

## Update 5 APR 2026: Docker Hub
embabel-demo is now available on Docker Hub as
[stevendoolan/embabel-demo:latest](https://hub.docker.com/r/stevendoolan/embabel-demo).

Run it with Docker Compose or pull directly:
```bash
docker pull stevendoolan/embabel-demo:latest
```

See [Docker](docker.md) for full instructions.

## Update 7 DEC 2025:
Combined Embabel with Sonic Pi by Sam Aaron to create music using AI!

See the new Agent:
- [SonicPiAgent.java](../src/main/java/com/embabel/demo/agent/SonicPiAgent.java)

How to use:
1. Install Sonic Pi from https://sonic-pi.net/ - on macOS: `brew install --cask sonic-pi`
2. Start Sonic Pi.
3. Start the Embabel service with Ollama and shell:
   ```bash
   mvn spring-boot:run -Pollama,shell
   ```
4. In the shell, enter the command:
   ```shell
   x "Write a song like Mozart"
   ```
5. There will be two Sonic PI *.rb scripts saved into the `target` directory:
    - `sonic_pi_*.rb` - the generated Sonic Pi melody
    - `sonic_pi-*_with_background_track.rb` - the full song
6. Copy the contents of the `*.rb` files into Sonic Pi and press the "Run" button to play.


## Update 6 DEC 2025: Upgraded to new Embabel Version 0.3.0
This project has been upgraded to use Embabel version 0.3.0, which is now available in Maven Central!

Postman Collection has been created to test the endpoints:
[embabel-demo.postman_collection.json](../postman/embabel-demo.postman_collection.json)

Legacy OpenAI Models have been removed as I don't need them anymore (gpt-4o, gpt-4o-lite).

### Fibonacci Agent
Added a Fibonacci Agent as an example of Tool Use:
- [FibonacciAgent.java](../src/main/java/com/embabel/demo/agent/FibonacciAgent.java)
- [FibonacciCalculator.java](../src/main/java/com/embabel/demo/tool/FibonacciCalculator.java)

How to use the Fibonacci Agent using the REST endpoint:
1. Start the service with OpenAI:
   ```bash
   mvn spring-boot:run -Popenai
   ```

2. Send a GET request: http://localhost:48080/compute-fibonacci?iterations=10

How to use the Fibonacci Agent using the Shell Client:
1. Start the service with OpenAI and shell:
   ```bash
   mvn spring-boot:run -Popenai -Pshell
   ```

2. Enter the following command in the shell to compute the 10th Fibonacci number:
   ```shell
   fibonacci
   ```

3. To compute any Fibonacci number, replace 10 with your desired number:
   ```shell
   x "What is the 10th Fibonacci number?"
   ```


## Update 27 SEP 2025: Connects to Private OpenAI

I have got this working with a private OpenAI instance.  I set the following environment variables:
```bash
export OPENAI_BASE_URL=https://<your-private-openai-domain>
export OPENAI_API_KEY=<your-api-key>
```

My API Key only has access to gpt-4o and gpt-4o-lite.
These aren't provided out-of-the-box by Embabel, so I had to implement them myself in
[LegacyOpenAiModels.java](../src/main/java/com/embabel/demo/LegacyOpenAiModels.java).
Is there a better way of doing this?

Start the service with OpenAI:
```bash
mvn spring-boot:run -Popenai
```

Start the service with Ollama:
```bash
mvn spring-boot:run -Pollama
```

## Steven's Update 3 SEP 2025: Jasper Blues fixed it!
Thanks very much Jasper Blues for fixing my broken repo!

The problem was the test dependency using 0.1.2-SNAPSHOT.  Removing this fixed the problems listed below.
```xml
        <dependency>
            <groupId>com.embabel.agent</groupId>
            <artifactId>embabel-agent-test</artifactId>
            <!-- This is later than agent version, but will come back in sync in future -->
            <version>0.1.2-SNAPSHOT</version>
            <scope>test</scope>
        </dependency>
```
See Rod Johnson's original commit to fix java-agent-template:
https://github.com/embabel/java-agent-template/commit/488f088f914066b6c3f452d1c69a59e7ceeb89d5

## Steven's Update 2 SEP 2025: I broke it and I don't know how! :(

My first error was:
```
Web application could not be started as there was no
org.springframework.boot.web.servlet.server.ServletWebServerFactory bean defined in the context.
```

I fixed this by adding into [application.properties](../src/main/resources/application.properties):
```
spring.main.web-application-type=none
```

Now it won't start, with a new error:
```
Parameter 1 of constructor in
com.embabel.agent.mcpserver.support.PerGoalMcpToolExportCallbackPublisher
required a bean of type 'io.modelcontextprotocol.server.McpSyncServer'
that could not be found.
```

I think it was the refactor where I changed the base package from `com.embabel.template` to `com.embabel.demo`.

I took a fresh template and less refactors. Please see https://github.com/stevendoolan/embabel-demo2

---

[← Previous: Agents](agents/index.md) | [Back to Index](../README.md)
