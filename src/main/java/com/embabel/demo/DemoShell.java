package com.embabel.demo;

import com.embabel.demo.service.AnimalInventor;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;

@ShellComponent
public record DemoShell(AnimalInventor animalInventor) {

    @ShellMethod("Invent an animal")
    String animal() {
        return animalInventor.inventAnimal().toString();
    }
}
