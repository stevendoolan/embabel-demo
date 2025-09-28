package com.embabel.demo.agent;

import com.embabel.agent.api.annotation.AchievesGoal;
import com.embabel.agent.api.annotation.Action;
import com.embabel.agent.api.annotation.Agent;
import com.embabel.agent.api.annotation.Export;
import com.embabel.agent.api.common.OperationContext;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.dadjoke.JokeAndRating;
import com.embabel.demo.model.dadjoke.Jokes;
import com.embabel.demo.model.dadjoke.JokesAndRatings;
import java.util.Comparator;
import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;

@Agent(description = "Create the best dad joke ever")
@Profile("!test")
public class BestDadJokeAgent {

    private int jokeCount;

    public BestDadJokeAgent(
        @Value("${bestdadjoke.joke-count:5}") int jokeCount) {
        this.jokeCount = jokeCount;
    }

    @Action
    public Jokes writeJokes(UserInput userInput, OperationContext context) {
        return context.ai()
                .withDefaultLlm()
                .createObject("Write %s Dad Jokes based on: %s".formatted(jokeCount, userInput.getContent()), Jokes.class);
    }

    @Action
    public JokesAndRatings rateJokes(Jokes jokes, OperationContext context) {
        List<JokeAndRating> list = jokes.jokes().stream().parallel().map(joke -> context.ai()
                .withDefaultLlm()
                .createObject("On a scale from 1 to %s, rate this joke: %s".formatted(jokeCount, joke), JokeAndRating.class)).toList();
        return new JokesAndRatings(list);
    }

    @AchievesGoal(
            description = "Create the best dad joke ever",
            export = @Export(remote = true, name = "bestDadJoke"))
    @Action
    public JokeAndRating createBestDadJoke(JokesAndRatings jokesAndRatings) {
        return jokesAndRatings.jokeAndRatings().stream().max(Comparator.comparingDouble(a -> a.rating().score()))
                .orElseThrow();
    }
}
