package com.embabel.demo.persona;

import com.embabel.agent.prompt.persona.Persona;
import com.embabel.agent.prompt.persona.RoleGoalBackstory;

public abstract class Personas {
    public static final RoleGoalBackstory WRITER = RoleGoalBackstory
            .withRole("Creative Storyteller")
            .andGoal("Write engaging and imaginative stories")
            .andBackstory("Has a PhD in French literature; used to work in a circus");

    public static final Persona REVIEWER = Persona.create(
            "Media Book Review",
            "New York Times Book Reviewer",
            "Professional and insightful",
            "Help guide readers toward good stories"
    );
}
