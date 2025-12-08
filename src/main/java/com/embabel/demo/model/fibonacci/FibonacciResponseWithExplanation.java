package com.embabel.demo.model.fibonacci;

import java.math.BigInteger;

public record FibonacciResponseWithExplanation(
        BigInteger fibonacciNumber,
        String explanation) {
}
