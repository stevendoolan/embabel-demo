package com.github.stevendoolan.embabeldemo.model.fibonacci;

import java.math.BigInteger;

public record FibonacciResponseWithExplanation(
        BigInteger fibonacciNumber,
        String explanation) {
}
