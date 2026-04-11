package com.embabel.demo.agent;

import com.embabel.agent.api.annotation.AchievesGoal;
import com.embabel.agent.api.annotation.Action;
import com.embabel.agent.api.annotation.Agent;
import com.embabel.agent.api.annotation.Export;
import com.embabel.agent.api.common.OperationContext;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.common.ai.model.LlmOptions;
import com.embabel.demo.model.dadjoke.DadJokeResult;
import com.embabel.demo.model.dadjoke.JokeAndRating;
import com.embabel.demo.model.dadjoke.Jokes;
import com.embabel.demo.model.dadjoke.JokesAndRatings;
import java.util.Comparator;
import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;

/**
 * Agent that creates a dad joke.
 * <p>
 * Inspired / directly copied from this YouTube video by Coffee + Software's James Ward and Josh Long:
 * <a href="https://www.youtube.com/watch?v=kpeYvKha5oE&t=5s">https://www.youtube.com/watch?...</a>
 */
@Agent(description = "Create a dad joke")
@Profile("!test")
public class DadJokeAgent {

    private int jokeCount;

    public DadJokeAgent(
        @Value("${dadjoke.joke-count:5}") int jokeCount) {
        this.jokeCount = jokeCount;
    }

    @Action
    public Jokes writeJokes(UserInput userInput, OperationContext context) {
        return context.ai()
                .withLlm(LlmOptions.withLlmForRole("best").withTemperature(0.8))
                .createObject("Write %s Dad Jokes based on: %s".formatted(jokeCount, userInput.getContent()), Jokes.class);
    }

    @Action
    public JokesAndRatings rateJokes(Jokes jokes, OperationContext context) {
        List<JokeAndRating> list = jokes.jokes().stream().parallel().map(joke -> context.ai()
                .withLlm(LlmOptions.withLlmForRole("cheapest").withTemperature(0.1))
                .createObject("On a scale from 1 to %s, rate this joke: %s".formatted(jokeCount, joke), JokeAndRating.class)).toList();
        return new JokesAndRatings(list);
    }

    @AchievesGoal(
            description = "Create a dad joke",
            export = @Export(remote = true, name = "dadJoke", startingInputTypes = {UserInput.class}))
    @Action
    public DadJokeResult createDadJoke(JokesAndRatings jokesAndRatings) {
        JokeAndRating bestJoke = jokesAndRatings.jokeAndRatings().stream()
                .max(Comparator.comparingDouble(a -> a.rating().score()))
                .orElseThrow();
        List<JokeAndRating> otherJokes = jokesAndRatings.jokeAndRatings().stream()
                .filter(j -> j != bestJoke)
                .toList();
        return new DadJokeResult(bestJoke, otherJokes);
    }
}
