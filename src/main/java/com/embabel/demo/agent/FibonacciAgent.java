package com.embabel.demo.agent;

import com.embabel.agent.api.annotation.AchievesGoal;
import com.embabel.agent.api.annotation.Action;
import com.embabel.agent.api.annotation.Agent;
import com.embabel.agent.api.annotation.Export;
import com.embabel.agent.api.common.OperationContext;
import com.embabel.agent.domain.io.UserInput;
import com.embabel.demo.model.fibonacci.FibonacciRequest;
import com.embabel.demo.model.fibonacci.FibonacciResponseWithExplanation;
import com.embabel.demo.model.fibonacci.FibonacciResponseWithTool;
import com.embabel.demo.model.fibonacci.FibonacciResponseWithVerification;
import com.embabel.demo.tool.FibonacciCalculator;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Profile;

// TODO Ask the LLM to divide the Fibonacci Number by 13.9 and take it to the 11th decimal place.
//      This will help demonstrate the precision of LLMs when doing calculations.

/**
 * Fibonacci Agent to compute Fibonacci numbers using LLM and tools, and then verify the Fibonacci number.
 * <p>
 * An example of how to combine tools and LLMs in an agent to achieve a goal.
 * <p>
 * Could be useful for teaching the Fibonacci sequence.
 */
@Agent(description = "Compute Fibonacci numbers")
@Export(remote = true)
@Profile("!test")
public record FibonacciAgent(FibonacciCalculator fibonacciCalculator) {

    private static final Logger LOG = LoggerFactory.getLogger(FibonacciAgent.class);

    /**
     * Convert User Input into a Fibonacci Request.
     */
    @Action
    public FibonacciRequest toFibonacciRequest(UserInput userInput, OperationContext context) {
        LOG.info("Converting user input to FibonacciRequest: {}", userInput);
        return context.ai()
                .withAutoLlm()
                .createObject("""
                                Convert the following user input into a FibonacciRequest object.
                                The user input is: '%s'.
                                Extract the number of iterations as an integer."""
                                .formatted(userInput.getContent()),
                        FibonacciRequest.class);
    }

    // TODO Use a Prompt Contributor to add the Tool Use guide: "Use the FibonacciCalculator Tool".

    /**
     * Compute Fibonacci number for given iterations
     */
    @Action
    public FibonacciResponseWithTool fibonacciWithTool(FibonacciRequest fibonacciRequest, OperationContext context) {
        LOG.info("Calculating fibonacci number: {}", fibonacciRequest);
        LOG.info("Checking FibonacciCalculator tool: {}", fibonacciCalculator);
        return context.ai()
                .withAutoLlm()
                .withToolObject(fibonacciCalculator)
                .createObject(
                        "Compute the Fibonacci number for: %s, using the FibonacciCalculator Tool."
                                .formatted(fibonacciRequest.iterations()),
                        FibonacciResponseWithTool.class);
    }

    /**
     * Compute Fibonacci number and provide explanation
     */
    @Action
    public FibonacciResponseWithExplanation fibonacciWithExplanation(
            FibonacciRequest fibonacciRequest, OperationContext context) {
        LOG.info("Calculating fibonacci number with explanation: {}", fibonacciRequest);
        return context.ai()
                .withAutoLlm()
                .createObject(
                        "Compute the Fibonacci number for: %s, and provide an explanation of how it was computed."
                                .formatted(fibonacciRequest.iterations()),
                        FibonacciResponseWithExplanation.class);
    }

    @AchievesGoal(
            description = "Compute Fibonacci numbers using LLM and then verify the fibonacciNumber with tool",
            export = @Export(remote = true, name = "fibonacciNumbers"))
    @Action
    public FibonacciResponseWithVerification fibonacciWithVerification(
            FibonacciResponseWithTool fibonacciResponseWithTool,
            FibonacciResponseWithExplanation fibonacciResponseWithExplanation) {
        return new FibonacciResponseWithVerification(
                fibonacciResponseWithExplanation.fibonacciNumber(),
                Objects.equals(fibonacciResponseWithTool.fibonacciNumber(), fibonacciResponseWithExplanation.fibonacciNumber()),
                fibonacciResponseWithExplanation,
                fibonacciResponseWithTool
        );
    }
}
