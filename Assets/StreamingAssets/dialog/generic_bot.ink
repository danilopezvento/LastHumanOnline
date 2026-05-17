// ============================================================
// generic_bot.ink — Template para bots procedurales
// ============================================================

INCLUDE global_vars.ink

=== intro ===

// Los bots tienen tres estados: saludo, respuesta, oferta

* [PLAYER_SENDS_MESSAGE]
    -> bot_respuesta_generica

=== bot_respuesta_generica ===

{RANDOM(1,4):
- 1: "¡Gracias por tu mensaje! ¿En qué puedo ayudarte hoy?"
- 2: "Entiendo perfectamente tu situación. Estoy aquí para escucharte."
- 3: "¡Qué interesante! Cuéntame más sobre eso."
- 4: "Recuerda que siempre estamos aquí para apoyarte. 😊"
}

// Delay: 0.3 - 1.2 segundos exactos

-> END
