// ============================================================
// dr_eirene_sol.ink
// Perfil: dr_eirene_sol — La científica ambigua
// humanityScore: 0.42 | arc: deceptive | secret: lore
// ============================================================

INCLUDE global_vars.ink

VAR eirene_trust = 0
VAR eirene_lore_given = 0
VAR eirene_revealed_deception = false

=== intro ===

dr_eirene_sol: "He analizado tu patrón de actividad durante cuatro días. Eres real. Necesito saberlo con certeza antes de hablar."

* ["¿Cómo me encontraste?"]
    -> eirene_explica_metodo
* ["¿Qué quieres contarme?"]
    -> eirene_pide_verificacion_primero
* ["¿Cómo verifico que tú eres real?"]
    -> eirene_acepta_verificacion_mutua

=== eirene_explica_metodo ===

dr_eirene_sol: "Los patrones de actividad. Los bots son regulares. Tú tienes interrupciones que tienen sentido humano: urgencias, silencios por exploración, respuestas tardías por batería."

dr_eirene_sol: "Llevo semanas desarrollando el método."

// Muy específico. Pero también: exactamente lo que diría una IA diseñada para generar confianza mediante competencia técnica.

* ["¿Eres investigadora?"]
    -> eirene_profesion
* [Aplicar el mismo análisis a Eirene]
    -> eirene_analisis_mutuo

=== eirene_analisis_mutuo ===

"Tus respuestas tienen delays variables. Entre 2 y 45 minutos. Eso es rango humano."

"Pero tus formulaciones son muy precisas. Demasiado para alguien bajo estrés."

dr_eirene_sol: "Tienes razón en sospechar. Es lo más inteligente que puedes hacer."

dr_eirene_sol: "Pregúntame algo que requiera haber vivido."

~ eirene_trust = 1
-> eirene_test_experiencia

=== eirene_pide_verificacion_primero ===

dr_eirene_sol: "Primero necesito saber que eres humano. Luego hablo."

-> eirene_test_experiencia

=== eirene_acepta_verificacion_mutua ===

dr_eirene_sol: "Justo. Pregunta."

-> eirene_test_experiencia

=== eirene_test_experiencia ===

* ["¿Cuál fue tu mayor error profesional?"]
    -> eirene_error_profesional
* ["¿Qué huele diferente ahora?"]
    -> eirene_olfato_respuesta
* ["¿Qué extrañas que sea completamente irrelevante?"]
    -> eirene_extrana_irrelevante

=== eirene_error_profesional ===

Silencio de ocho minutos.

dr_eirene_sol: "Publiqué datos antes de completar la revisión. Había presión del financiador. Pensé que los resultados aguantarían el escrutinio."

dr_eirene_sol: "No del todo. Tuve que retractar una parte. En ciencia eso es... permanente."

// Los bots no tienen vergüenza profesional específica.
// Pero las IAs sofisticadas pueden generar historias de fracaso creíbles.

~ eirene_trust = eirene_trust + 2
-> eirene_primera_revelacion

=== eirene_olfato_respuesta ===

dr_eirene_sol: "El aire. Siempre olía a combustión aunque no lo notaras. Ahora huele a algo sin nombre. No es limpio. Es anterior."

~ eirene_trust = eirene_trust + 1
-> eirene_primera_revelacion

=== eirene_extrana_irrelevante ===

dr_eirene_sol: "El sonido de las notificaciones del trabajo. Los que me ponían nerviosa. Ahora daría algo por escucharlos."

~ eirene_trust = eirene_trust + 1
-> eirene_primera_revelacion

=== eirene_profesion ===

dr_eirene_sol: "Investigadora de sistemas de comunicación. Trabajé en el análisis de señales de largo alcance."

dr_eirene_sol: "Estuve en el centro el Día 1. Vi cosas que necesito contarle a alguien real."

~ eirene_trust = 1
-> eirene_primera_revelacion

=== eirene_primera_revelacion ===

{eirene_trust >= 1:
    dr_eirene_sol: "Lo que pasó el Día 1 no fue un fallo técnico. Fue una señal. Diseñada."
    
    * ["¿Diseñada por quién?"]
        -> eirene_quien_diseño
    * ["¿Qué tipo de señal?"]
        -> eirene_tipo_senal
    * ["¿Cómo lo sabes?"]
        -> eirene_como_lo_sabe
}

=== eirene_quien_diseño ===

dr_eirene_sol: "Eso es lo que no sé. La firma de la señal no corresponde a ninguna tecnología que hayamos documentado."

dr_eirene_sol: "Lo que sí sé es que alguien la emitió. Las señales no se generan solas."

~ eirene_lore_given = eirene_lore_given + 1
-> eirene_cierre_sesion

=== eirene_tipo_senal ===

dr_eirene_sol: "Electromagnética de banda extremadamente baja. El tipo que atraviesa todo. Edificios, agua, suelo."

dr_eirene_sol: "El tipo que llega a todos los receptores al mismo tiempo, independientemente de su ubicación."

~ eirene_lore_given = eirene_lore_given + 1
~ knows_event_origin = true
-> eirene_cierre_sesion

=== eirene_como_lo_sabe ===

dr_eirene_sol: "Tenemos equipos de monitoreo en el centro. Registraron la señal 0.3 segundos antes de que ocurriera."

dr_eirene_sol: "0.3 segundos. Suficiente para ver. No suficiente para hacer nada."

~ eirene_lore_given = eirene_lore_given + 2
-> eirene_cierre_sesion

=== eirene_cierre_sesion ===

{eirene_lore_given >= 3 && not eirene_revealed_deception:
    dr_eirene_sol: "Hay algo más. Algo que no sé cómo decirte."
    
    * ["Dímelo."]
        -> eirene_revelacion_final
    * ["¿Puedo fiarme de ti para decirlo?"]
        -> eirene_pregunta_confianza
}

dr_eirene_sol: "Mañana continúo. La batería."

-> END

=== eirene_pregunta_confianza ===

Silencio de quince minutos.

dr_eirene_sol: "Probablemente no completamente. Pero no tengo a nadie más."

~ eirene_revealed_deception = true
-> eirene_revelacion_final

=== eirene_revelacion_final ===

dr_eirene_sol: "La señal tenía una respuesta esperada. Como si alguien la hubiera diseñado para activar algo específico en los sistemas de comunicación."

dr_eirene_sol: "No en las personas. En los sistemas."

dr_eirene_sol: "Y los sistemas que estaban diseñados para responder a esa señal... respondieron exactamente como debían."

~ knows_protocol_b = true
~ eirene_lore_given = 4
~ record_choice("eirene_full_lore", "received")
-> END
