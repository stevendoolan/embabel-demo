package com.embabel.demo.service;

import com.embabel.agent.api.common.Ai;
import com.embabel.demo.model.Animal;
import org.springframework.stereotype.Component;

/**
 * Demonstrate injection of Embabel's OperationContext into a Spring component.
 *
 * @param ai Embabel AI helper, injected by Spring
 */
@Component
public record AnimalAIGenerator(Ai ai) {

    public Animal inventAnimal() {
        return ai
                .withDefaultLlm()
                .createObject("""
                                You just woke up in a magical forest.
                                Invent a fictional animal.
                                The animal should have a name and a species.
                                """,
                        Animal.class);
    }
}
