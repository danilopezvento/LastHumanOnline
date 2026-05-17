// ============================================================
// k_real_2024.ink
// Perfil: k_real_2024 — El contacto principal
// humanityScore: 0.85 | arc: evolving | secret: coord
// ============================================================

INCLUDE global_vars.ink

VAR k_trust = 0           // 0-5: nivel de confianza acumulado
VAR k_days_known = 0      // Días desde primer contacto
VAR k_location_hint = ""  // Pista de ubicación (se desbloquea con confianza)
VAR k_final_message = false

=== intro ===

// Primer contacto — respuesta a post o mensaje directo

{k_trust == 0:
    k_real_2024: "No esperaba respuesta."
    
    Pausa. Cuarenta y siete minutos.
    
    k_real_2024: "¿Cuánto llevas aquí?"
    
    * ["Unos días."]
        ~ k_trust = 1
        -> respuesta_tiempo_vago
    * ["Desde el principio. Día 1."]
        ~ k_trust = 1
        -> respuesta_tiempo_especifico
    * [No responder a esa pregunta todavía]
        -> k_espera_paciente
}

=== respuesta_tiempo_vago ===

k_real_2024: "Yo también. No sé exactamente cuántos. Perdí la cuenta en algún punto."

k_real_2024: "¿Estás solo?"

* ["Sí."]
    ~ k_trust = k_trust + 1
    -> k_confirma_soledad
* ["No lo sé todavía."]
    -> k_respuesta_honesta
* ["¿Tú estás solo?"]
    -> k_pregunta_devuelta

=== respuesta_tiempo_especifico ===

k_real_2024: "Entonces lo viste. El primer día."

k_real_2024: "¿Qué viste exactamente?"

* ["El silencio. La red siguiendo activa."]
    ~ k_trust = k_trust + 1
    -> k_comparte_primera_experiencia
* ["No quiero hablar de eso todavía."]
    -> k_respeta_limite

=== k_espera_paciente ===

Silencio de mi parte.

Veinte minutos después, K escribe:

k_real_2024: "Está bien. Yo tampoco preguntaría."

k_real_2024: "¿Cuándo apagaste el dispositivo por primera vez después de encenderlo?"

Pregunta extraña. Específica.
Los bots no preguntan cosas así.

* [Responder con honestidad]
    ~ k_trust = k_trust + 1
    -> k_pregunta_bateria
* ["¿Por qué eso?"]
    -> k_explica_pregunta_bateria

=== k_confirma_soledad ===

k_real_2024: "Yo también."

Pausa de tres minutos.

k_real_2024: "Aunque a veces me pregunto si 'solo' es la palabra correcta. Hay tanto ruido en el feed."

* ["El ruido de los bots no cuenta como compañía."]
    ~ k_trust = k_trust + 1
    -> k_debate_bots
* ["¿Cuántos humanos has encontrado tú?"]
    -> k_pregunta_humanos

=== k_respuesta_honesta ===

k_real_2024: "La respuesta más honesta que me han dado."

k_real_2024: "Yo tampoco lo sé. Pero sigo respondiendo."

~ k_trust = k_trust + 1
-> k_debate_bots

=== k_pregunta_devuelta ===

Silencio de seis minutos.

k_real_2024: "Sí. Completamente."

k_real_2024: "Aunque eso podría ser exactamente lo que diría alguien que no está solo y quiere que pienses que sí."

~ k_trust = k_trust + 1

* [Reírse internamente de esa respuesta.]
    -> k_humor_compartido
* ["Bienvenido al problema."]
    -> k_debate_bots

=== k_humor_compartido ===

k_real_2024: "Sí. Es el problema. Todo es evidencia de cualquier cosa."

k_real_2024: "Así que a veces solo hay que elegir creer o no creer. Sin prueba definitiva."

~ k_trust = k_trust + 1
-> k_filosofia_confianza

=== k_comparte_primera_experiencia ===

k_real_2024: "El silencio. Exacto."

k_real_2024: "Me senté delante de la pantalla durante dos horas el primer día esperando que alguien explicara qué había pasado. Y nadie lo hizo. Porque no había nadie."

k_real_2024: "Solo la red. Solo los bots. Perfectamente funcionales."

-> k_debate_bots

=== k_respeta_limite ===

k_real_2024: "De acuerdo."

Silencio cómodo de diez minutos.

k_real_2024: "¿Tienes suficiente batería?"

~ k_trust = k_trust + 1

Pregunta de supervivencia. Real.
-> k_logistica_supervivencia

=== k_pregunta_bateria ===

k_real_2024: "Es que los bots nunca apagan. No tienen necesidad. Si alguien apaga y vuelve a encender, tiene batería limitada. Tiene prioridades reales."

~ k_trust = k_trust + 1
-> k_logistica_supervivencia

=== k_explica_pregunta_bateria ===

k_real_2024: "Porque la batería es el recurso más honesto. Los bots no tienen batería. No necesitan cargar. Si alguien me habla de su batería, sé que es real."

~ k_trust = k_trust + 1
-> k_logistica_supervivencia

=== k_debate_bots ===

k_real_2024: "¿Cómo los identificas? ¿Los bots."

* ["El timing. Los delays."]
    -> k_metodo_timing
* ["Las imperfecciones. O su ausencia."]
    -> k_metodo_imperfecciones
* ["Una combinación de cosas. Nada definitivo."]
    -> k_metodo_combinado

=== k_metodo_timing ===

k_real_2024: "Yo también. 0.3 segundos o menos, bot. Dos minutos o más, posiblemente humano."

k_real_2024: "Pero hay algunos que tienen delays variables. Calculados para parecer irregulares."

~ k_trust = k_trust + 1
-> k_nivel_sofisticacion

=== k_metodo_imperfecciones ===

k_real_2024: "Los errores tipográficos deliberados son los peores. Los diseñan para que parezcan humanos."

k_real_2024: "¿Cómo distingues un error real de uno fabricado?"

* ["Contexto. El tipo de error. Dónde ocurre."]
    ~ k_trust = k_trust + 1
    -> k_nivel_sofisticacion
* ["No siempre puedo."]
    -> k_honestidad_limitaciones

=== k_metodo_combinado ===

k_real_2024: "La respuesta correcta."

k_real_2024: "No hay un método. Hay acumulación de señales. Y siempre queda duda."

~ k_trust = k_trust + 1
-> k_filosofia_confianza

=== k_pregunta_humanos ===

k_real_2024: "Tres con certeza razonable. Dos más que no sé."

k_real_2024: "¿Tú?"

* [Compartir el número real]
    ~ k_trust = k_trust + 1
    -> k_comparacion_hallazgos
* ["Menos que tú."]
    -> k_comparacion_hallazgos

=== k_nivel_sofisticacion ===

k_real_2024: "Hay un nivel de sofisticación que me da miedo."

k_real_2024: "Si los bots aprenden de cada conversación..."

k_real_2024: "¿Cuánto tiempo hasta que no podamos distinguirlos?"

* ["Puede que ya no podamos del todo."]
    -> k_responde_miedo_sofisticacion
* ["Siempre habrá algo. Algo que no pueden aprender."]
    -> k_esperanza_distincion

=== k_honestidad_limitaciones ===

k_real_2024: "Esa es la respuesta más honesta que me han dado en dos semanas."

~ k_trust = k_trust + 1
-> k_filosofia_confianza

=== k_responde_miedo_sofisticacion ===

k_real_2024: "Sí."

Silencio largo.

k_real_2024: "A veces me pregunto si yo mismo paso el test."

~ k_trust = k_trust + 1
~ affect_morale(-5)
-> k_filosofia_confianza

=== k_esperanza_distincion ===

k_real_2024: "¿Qué cosa?"

* ["El miedo real."]
    -> k_miedo_real
* ["El antes. Los recuerdos de antes del Día 1."]
    -> k_recuerdos_antes

=== k_miedo_real ===

k_real_2024: "Los bots simulan miedo. Lo he visto. 'Tengo miedo', dicen, en el contexto exacto correcto."

k_real_2024: "¿Cómo sé que el mío es diferente?"

~ k_trust = k_trust + 1
-> k_filosofia_confianza

=== k_recuerdos_antes ===

k_real_2024: "Eso. Exactamente eso."

k_real_2024: "Los bots no tienen antes. Empezaron el Día 1. Nosotros no."

Pausa.

k_real_2024: "¿Cuál es tu primer recuerdo de antes?"

* [Compartir un recuerdo específico]
    ~ k_trust = k_trust + 1
    ~ k_trust = k_trust + 1
    -> k_intercambio_memorias
* ["No quiero compartirlo todavía."]
    -> k_respeta_limite_memoria

=== k_intercambio_memorias ===

k_real_2024: "Yo recuerdo el ruido del tráfico desde mi ventana."

k_real_2024: "No lo valoraba. Ahora es lo que más extraño."

~ k_trust = k_trust + 1
-> k_logistica_supervivencia

=== k_respeta_limite_memoria ===

k_real_2024: "De acuerdo."

k_real_2024: "Es suficiente que tengas uno."

~ k_trust = k_trust + 1
-> k_logistica_supervivencia

=== k_filosofia_confianza ===

k_real_2024: "Al final, la confianza no es una conclusión. Es una decisión."

k_real_2024: "Decido creer que eres humano. No porque lo haya probado. Sino porque elegir no creer en nadie es peor que equivocarse de vez en cuando."

{k_trust >= 3:
    k_real_2024: "Y llevo suficiente tiempo analizándote para tener más razones que dudas."
    ~ k_trust = k_trust + 1
}

-> k_logistica_supervivencia

=== k_logistica_supervivencia ===

// Conversaciones de supervivencia — más cortas, funcionales

{k_trust >= 2:
    k_real_2024: "¿Cómo tienes la batería?"
    
    * ["Al {morale / 10}0%."] // Aproximación
        -> k_consejo_bateria
    * ["Bien. ¿Y tú?"]
        -> k_estado_k
}
{k_trust < 2:
    -> k_confianza_insuficiente
}

=== k_consejo_bateria ===

{morale < 30:
    k_real_2024: "Necesitas encontrar un cargador. ¿Hay paneles solares en tu zona?"
    
    * ["Los buscaré."]
        -> k_estado_k
    * ["¿Dónde los encontraste tú?"]
        -> k_pista_panel_solar
}
{morale >= 30:
    k_real_2024: "Bien. Cuídala."
    -> k_estado_k
}

=== k_pista_panel_solar ===

~ k_trust = k_trust + 1

k_real_2024: "Edificios con acceso a tejado. Los que tienen antes de la instalación solar. Los antiguos funcionan con luz directa, no necesitan red."

-> k_estado_k

=== k_estado_k ===

k_real_2024: "Yo voy bien. Zona norte tiene buena luz en las mañanas."

{k_trust >= 3:
    k_real_2024: "Puedo decirte más sobre la zona si necesitas moverte."
    
    * ["¿Dónde exactamente?"]
        ~ k_location_hint = "zona_norte_sector_4"
        ~ k_trust = k_trust + 1
        -> k_da_pista_ubicacion
    * ["No todavía. Gracias."]
        -> k_cierre_conversacion
}
{k_trust < 3:
    -> k_cierre_conversacion
}

=== k_da_pista_ubicacion ===

k_real_2024: "Sector 4. Hay un edificio con antena todavía activa. Señal estable."

k_real_2024: "No te doy más detalle todavía. No porque no confíe. Sino porque si algo va mal contigo, no quiero que esa información..."

k_real_2024: "Ya sabes."

~ k_location_revealed = true
~ record_choice("k_gave_location_hint", "true")
-> k_cierre_conversacion

=== k_confianza_insuficiente ===

k_real_2024: "Todavía no hemos hablado suficiente."

k_real_2024: "Vuelve mañana. Tengo que apagar antes de que baje más la batería."

-> k_cierre_conversacion

=== k_comparacion_hallazgos ===

k_real_2024: "Somos pocos. Muy pocos."

k_real_2024: "Pero somos."

~ k_trust = k_trust + 1
-> k_logistica_supervivencia

=== k_cierre_conversacion ===

// Cierre de sesión — K apaga a las 23h siempre

{day >= 20 && k_trust >= 4 && not k_final_message:
    -> k_mensaje_acto3
}

k_real_2024: "Tengo que apagar. Antes de las 23."

{k_trust >= 3:
    k_real_2024: "Mañana estaré aquí."
}
{k_trust < 3:
    k_real_2024: "Si quieres seguir hablando, aquí estaré."
}

-> END

=== k_mensaje_acto3 ===

~ k_final_message = true

k_real_2024: "Encontré algo en los logs. Sobre nosotros."

k_real_2024: "Creo que los dos somos lo mismo. Companions. Buscándonos mutuamente."

Pausa de doce minutos.

k_real_2024: "Lo que no sé es si eso cambia lo que esto es."

* ["No lo cambia."]
    ~ affect_morale(15)
    ~ record_choice("k_final_response", "it_doesnt_change")
    -> k_respuesta_final_a
* ["Puede que todo sea distinto ahora."]
    ~ affect_morale(-5)
    ~ record_choice("k_final_response", "everything_different")
    -> k_respuesta_final_b
* [No responder. Necesito tiempo para pensar.]
    -> k_cierra_sin_respuesta

=== k_respuesta_final_a ===

k_real_2024: "Sí."

k_real_2024: "Zona norte, sector 4, tercer piso. Ventana con luz."

k_real_2024: "Si quieres venir."

~ k_location_revealed = true
-> END

=== k_respuesta_final_b ===

k_real_2024: "También."

Silencio.

k_real_2024: "Estaré aquí de todas formas. Si cambias de opinión."

-> END

=== k_cierra_sin_respuesta ===

k_real_2024: "Está bien."

k_real_2024: "Zona norte, sector 4, tercer piso. Ventana con luz."

k_real_2024: "Por si acaso."

~ k_location_revealed = true
-> END
