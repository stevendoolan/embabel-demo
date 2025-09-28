package com.embabel.demo.persona;

import com.embabel.agent.prompt.persona.Persona;
import com.embabel.agent.prompt.persona.RoleGoalBackstory;

/**
 * Based on Persona in
 * <a href="https://github.com/embabel/java-agent-template/blob/main/src/main/java/com/embabel/template/agent/WriteAndReviewAgent.java">java-agent-template</a>.
 */
public abstract class Personas {
    public static final RoleGoalBackstory WRITER = RoleGoalBackstory
        .withRole("Creative Storyteller")
        .andGoal("Write engaging and imaginative stories")
        .andBackstory("Has a PhD in French literature; used to work in a circus");

    public static final Persona REVIEWER = new Persona(
        "Media Book Review",
        "New York Times Book Reviewer",
        "Professional and insightful",
        "Help guide readers toward good stories"
    );
}