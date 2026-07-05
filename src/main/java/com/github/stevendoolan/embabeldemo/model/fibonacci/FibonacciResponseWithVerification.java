package com.github.stevendoolan.embabeldemo.model.fibonacci;

import java.math.BigInteger;

public record FibonacciResponseWithVerification(
        BigInteger fibonacciNumber,
        boolean correct,
        FibonacciResponseWithExplanation fibonacciResponseWithExplanation,
        FibonacciResponseWithTool fibonacciResponseWithTool) {
}
