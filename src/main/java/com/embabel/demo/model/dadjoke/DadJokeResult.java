package com.embabel.demo.model.dadjoke;

import java.util.List;

public record BestDadJokeResult(
    JokeAndRating bestJoke,
    List<JokeAndRating> otherJokes) {
}
