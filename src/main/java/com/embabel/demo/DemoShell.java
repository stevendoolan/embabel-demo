package com.embabel.demo;

import com.embabel.demo.service.AnimalAIGenerator;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;

@ShellComponent
public record DemoShell(AnimalAIGenerator animalInventor) {

    @ShellMethod("Invent an animal")
    String animal() {
        return animalInventor.inventAnimal().toString();
    }
}
