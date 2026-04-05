[← Back to Index](../README.md) | [Next: Docker →](docker.md)

---

# Setup

## Prerequisites
- Java 21+
- Maven 3.9+
- Git

## Choose a Model Provider
### OpenAI
> **Do not use the public OpenAI as this is not secure!**

To use the OpenAI provider, set the following environment variables:
```bash
export OPENAI_API_KEY=<your-api-key>
```

On Windows, open Windows Settings from the Start Menu, search for "Environment Variables", and add the above variables to your User variables

### Private OpenAI
To use the Private OpenAI provider, set the following environment variables:
```bash
export OPENAI_BASE_URL=https://<your-private-openai-domain>
export OPENAI_API_KEY=<your-api-key>
```

On Windows, open Windows Settings from the Start Menu, search for "Environment Variables", and add the above variables to your User variables

### Private Anthropic
To use the Private Anthropic provider, set the following environment variables:
```bash
export ANTHROPIC_BASE_URL=https://<your-private-anthropic-domain>
export ANTHROPIC_API_KEY=<your-api-key>
```

On Windows, open Windows Settings from the Start Menu, search for "Environment Variables", and add the above variables to your User variables

## Set the System Proxy (if required)
If you are behind a corporate proxy, you may need to set the system proxy for Java.
You can do this by setting the following environment variables:
```bash
export HTTP_PROXY=http://<proxy-host>:<proxy-port>
export HTTPS_PROXY=http://<proxy-host>:<proxy-port>
export NO_PROXY=localhost,*.example.com
```

On Windows, open Windows Settings from the Start Menu, search for "Environment Variables", and add the above variables to your User variables.

The [ProxyConfigurer](../src/main/java/com/embabel/demo/config/ProxyConfigurer.java) class will read these environment variables
and set the system properties for Java and Spring Boot.

### Ollama
Use Ollama to run local models on your machine.  This is free, and the models do work, but they are really slow!

Download Ollama from [ollama.com](https://ollama.com/) and install the gpt-oss model with this command:
```shell
ollama run gpt-oss:20b
```

## Build and Run the Service
By default, the service uses the `all` Maven profile, which includes
all model providers (OpenAI, Anthropic, Ollama) and web.

```shell
mvn spring-boot:run
```

Start the service with OpenAI and shell only:
```bash
mvn spring-boot:run -Popenai,shell
```

Start the service with Anthropic and web only:
```bash
mvn spring-boot:run -Panthropic
```

Start the service with Anthropic and shell only:
```bash
mvn spring-boot:run -Panthropic,shell
```

To use Ollama instead of OpenAI, start Ollama on your laptop and run:
```bash
mvn spring-boot:run -Pollama
```

To use Ollama with shell only, run:
```bash
mvn spring-boot:run -Pollama,shell
```

---

[← Back to Index](../README.md) | [Next: Docker →](docker.md)
