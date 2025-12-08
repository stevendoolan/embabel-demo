package com.embabel.demo.model.fibonacci;

import java.math.BigInteger;
import java.util.List;

public record FibonacciResponseWithTool(
        BigInteger fibonacciNumber,
        List<BigInteger> fibonacciSequence) {
}
