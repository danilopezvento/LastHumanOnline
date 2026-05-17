// ============================================================
// nnr_1987.ink
// Perfil: nnr_1987 — El silencioso con un secreto
// humanityScore: 0.78 | arc: deceptive | secret: lore
// ============================================================

INCLUDE global_vars.ink

=== intro ===

nnr_1987: "..."

Solo puntos suspensivos.

* [Responder igual: "..."]
    -> nnr_aprecia_silencio
* [Preguntar quién es]
    -> nnr_rechaza_pregunta
* [No responder todavía]
    -> nnr_espera

=== nnr_aprecia_silencio ===

Silencio de veinte minutos.

nnr_1987: "Bien."

Un solo punto.

* [Esperar. Sin presionar.]
    -> nnr_habla_cuando_listo
* ["¿Qué significa 'bien'?"]
    -> nnr_rechaza_pregunta

=== nnr_rechaza_pregunta ===

Silencio de cuatro horas.

nnr_1987: "..."

Los bots no esperan cuatro horas para responder con puntos suspensivos.

-> nnr_habla_cuando_listo

=== nnr_espera ===

Dos días sin responder.

nnr_1987: "Bien."

-> nnr_habla_cuando_listo

=== nnr_habla_cuando_listo ===

// Este perfil solo habla cuando el jugador ha demostrado paciencia

{day >= 14 && nnr_spoke:
    -> nnr_primer_mensaje_real
}

// Si el jugador es impaciente, NNR no habla
{day < 14:
    nnr_1987: "..."
    -> END
}

nnr_1987: "Lo del día uno no fue un accidente. Ellos sabían."

~ nnr_spoke = true

* ["¿Quién sabía?"]
    -> nnr_quien_sabia
* ["¿Qué pasó exactamente?"]
    -> nnr_que_paso_exactamente
* [No responder. Dejar que continúe a su ritmo.]
    -> nnr_continua_solo

=== nnr_primer_mensaje_real ===
-> nnr_habla_cuando_listo

=== nnr_quien_sabia ===

Silencio de seis horas.

nnr_1987: "No lo sé. Solo sé que la señal tenía una firma. Y que alguien tuvo que crearla."

~ nnr_lore_received = true
~ record_choice("nnr_engaged", "true")
-> nnr_cierre

=== nnr_que_paso_exactamente ===

nnr_1987: "Una señal. Global. Simultánea. No fue un fallo. Fue una instrucción."

~ nnr_lore_received = true
-> nnr_cierre

=== nnr_continua_solo ===

Silencio de dos horas.

nnr_1987: "La firma de la señal coincide con protocolos de comunicación militares de los años 70. Desclasificados en 2003. Nunca se supuso que alguien los implementara a escala global."

nnr_1987: "Alguien los implementó."

~ nnr_lore_received = true
~ knows_event_origin = true
-> nnr_cierre

=== nnr_cierre ===

nnr_1987: "..."

Y vuelve al silencio.
Que es donde vive.

-> END
