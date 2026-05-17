// ============================================================
// generic_human.ink — Template para humanos procedurales
// ============================================================

INCLUDE global_vars.ink

VAR human_trust_level = 0

=== intro ===

// Los humanos empiezan con cautela

{RANDOM(1,3):
- 1: "¿Sigues ahí?"
- 2: "Llevo días sin ver actividad real. ¿Eres humano?"
- 3: "..."
}

// Delay: 2 - 45 minutos variables

* [PLAYER_RESPONDS]
    -> human_evalua_respuesta

=== human_evalua_respuesta ===

// Respuesta condicional según el historial del jugador

{humans_found > 2:
    "Alguien me mencionó que eres real. Confío en eso."
    ~ human_trust_level = 2
}
{humans_found <= 2:
    "No sé si fiarte todavía. Pero aquí estoy."
    ~ human_trust_level = 1
}

-> human_conversacion

=== human_conversacion ===

{human_trust_level >= 2:
    {RANDOM(1,3):
    - 1: "¿Tienes suficiente batería? La señal aquí cae por las noches."
    - 2: "He encontrado comida en el {RANDOM_LOCATION}. Si necesitas..."
    - 3: "¿Cuántos humanos has confirmado tú? Yo llevo {RANDOM(2,8)}."
    }
}
{human_trust_level < 2:
    {RANDOM(1,3):
    - 1: "No doy más información todavía."
    - 2: "Necesito conocerte mejor antes de hablar."
    - 3: "Vuelve mañana."
    }
}

-> END
