package com.embabel.demo.tool;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.assertEquals;

import com.embabel.demo.model.fibonacci.FibonacciResponseWithTool;
import java.math.BigInteger;
import org.junit.jupiter.api.Test;

class FibonacciCalculatorUnitTest {


    FibonacciCalculator fibonacciCalculator = new FibonacciCalculator();

    @Test
    void testCalculateFibonacci_Zero() {
        FibonacciResponseWithTool result = fibonacciCalculator.calculateFibonacci(0);

        assertEquals(BigInteger.ZERO, result.fibonacciNumber());
        assertThat(result.fibonacciSequence())
                .hasSize(1)
                .containsExactly(BigInteger.ZERO);
    }

    @Test
    void testCalculateFibonacci_One() {
        FibonacciResponseWithTool result = fibonacciCalculator.calculateFibonacci(1);

        assertEquals(BigInteger.ONE, result.fibonacciNumber());
        assertThat(result.fibonacciSequence())
                .hasSize(2)
                .containsExactly(BigInteger.ZERO, BigInteger.ONE);
    }

    @Test
    void testCalculateFibonacci_Five() {
        FibonacciResponseWithTool result = fibonacciCalculator.calculateFibonacci(5);

        assertEquals(BigInteger.valueOf(5), result.fibonacciNumber());
        assertThat(result.fibonacciSequence())
                .hasSize(6)
                .element(5).isEqualTo(BigInteger.valueOf(5));
    }

    @Test
    void testCalculateFibonacci_Ten() {
        FibonacciResponseWithTool result = fibonacciCalculator.calculateFibonacci(10);

        assertEquals(BigInteger.valueOf(55), result.fibonacciNumber());
        assertThat(result.fibonacciSequence()).hasSize(11);
    }

    @Test
    void testCalculateFibonacci_SequenceCorrectness() {
        FibonacciResponseWithTool result = fibonacciCalculator.calculateFibonacci(7);

        assertThat(result.fibonacciSequence())
                .containsExactly(
                        BigInteger.ZERO,
                        BigInteger.ONE,
                        BigInteger.ONE,
                        BigInteger.valueOf(2),
                        BigInteger.valueOf(3),
                        BigInteger.valueOf(5),
                        BigInteger.valueOf(8),
                        BigInteger.valueOf(13)
                );
    }

    @Test
    void testCalculateFibonacci_NegativeIterations() {
        assertThatThrownBy(() -> fibonacciCalculator.calculateFibonacci(-1))
                .isInstanceOf(IllegalArgumentException.class);
    }
}