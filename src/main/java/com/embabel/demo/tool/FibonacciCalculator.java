package com.embabel.demo.tool;

import com.embabel.demo.model.fibonacci.FibonacciResponseWithTool;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.tool.annotation.Tool;
import org.springframework.stereotype.Component;

@Component
public class FibonacciCalculator {

    private static final Logger LOG = LoggerFactory.getLogger(FibonacciCalculator.class);

    @Tool
    public FibonacciResponseWithTool calculateFibonacci(int iterations) {
        LOG.info("Calculating Fibonacci number for {} iterations", iterations);
        if (iterations < 0) {
            throw new IllegalArgumentException("Iterations must be non-negative");
        }

        List<BigInteger> fibonacciSequence = new ArrayList<>();
        BigInteger a = BigInteger.ZERO;
        fibonacciSequence.add(a);
        if (iterations == 0) {
            LOG.info("Fibonacci number for 0 iterations is {}", a);
            return new FibonacciResponseWithTool(a, fibonacciSequence);
        }

        BigInteger b = BigInteger.ONE;
        fibonacciSequence.add(b);
        for (int i = 2; i <= iterations; i++) {
            BigInteger fibonacciNumber = a.add(b);
            fibonacciSequence.add(fibonacciNumber);
            LOG.info("Calculated fibonacci number: {}", fibonacciNumber);
            a = b;
            b = fibonacciNumber;
        }

        BigInteger fibonacciNumber = fibonacciSequence.get(iterations);
        LOG.info("Fibonacci number for {} iterations is {}", iterations, fibonacciNumber);
        return new FibonacciResponseWithTool(
                fibonacciNumber,
                fibonacciSequence
        );
    }
}
