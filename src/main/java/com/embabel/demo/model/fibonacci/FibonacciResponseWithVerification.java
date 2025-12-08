package com.embabel.demo.model.fibonacci;

import java.math.BigInteger;

public record FibonacciResponseWithVerification(
        BigInteger fibonacciNumber,
        boolean correct,
        FibonacciResponseWithExplanation fibonacciResponseWithExplanation,
        FibonacciResponseWithTool fibonacciResponseWithTool) {
}
