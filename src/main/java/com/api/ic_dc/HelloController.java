package com.api.ic_dc;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String hello() {
        return "API de Despliegue Continuo (IC/DC) V1.0 - ¡Funcionando!";
    }
}