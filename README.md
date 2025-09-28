> # Security Warning!
> **This is a Demo project that is publicly available on GitHub!!**
>
> **Public Location: https://github.com/stevendoolan/embabel-demo**
> 
> We use this project to provide the Embabel Engineers with a working example of an Embabel agent when we need help.
> This project is not secure, and should not be used in production. It is provided for educational purposes only.

# About this project
This project is based on the Embabel Java Agent Template, which is available on GitHub.
Please keep this project up to date as java-agent-template is updated.

https://github.com/embabel/java-agent-template

# Updates 
## Update 27 SEP 2025: Connects to Private OpenAI

I have got this working with a private OpenAI instance.  I set the following environment variables:
```bash
export OPENAI_BASE_URL=https://<your-private-openai-domain>
export OPENAI_API_KEY=<your-api-key>
```

My API Key only has access to gpt-4o and gpt-4o-lite. 
These aren't provided out-of-the-box by Embabel, so I had to implement them myself in
[LegacyOpenAiModels.java](src/main/java/com/embabel/demo/LegacyOpenAiModels.java).
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

I fixed this by adding into [application.properties](src/main/resources/application.properties):
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
