package com.github.stevendoolan.embabeldemo.model.dadjoke;

import java.util.List;

public record DadJokeResult(
    JokeAndRating bestJoke,
    List<JokeAndRating> otherJokes) {
}
