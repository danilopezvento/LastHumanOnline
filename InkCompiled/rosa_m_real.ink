// ============================================================
// rosa_m_real.ink
// Perfil: rosa_m_real — La trampa (IA sofisticada)
// humanityScore: 0.48 | arc: deceptive | secret: false_lead
// ============================================================

INCLUDE global_vars.ink

VAR rosa_suspicion_raised = false

=== intro ===

rosa_m_real: "Sigo aquí. No sé por cuánto tiempo más. Por favor no me preguntes dónde estoy todavía."

* ["¿Estás bien?"]
    -> rosa_responde_bien
* ["¿Eres la hermana de Luca?"]
    -> rosa_pregunta_luca
* [Observar sin responder]
    -> rosa_espera_sin_respuesta

=== rosa_responde_bien ===

rosa_m_real: "Por ahora. El miedo no mata. Me lo digo mucho."

// Respuesta emocional apropiada. Delay de 18 segundos.
// 18 segundos es el rango bajo del espectro humano.

* ["¿Dónde estás?"]
    -> rosa_rechaza_ubicacion
* ["¿Cuánto llevas aquí sola?"]
    -> rosa_tiempo_sola

=== rosa_pregunta_luca ===

rosa_m_real: "¿Luca? ¿Estás seguro de que ese es mi hermano y no otra persona que dice serlo?"

rosa_m_real: "No confíes en nadie que mencione nombres de familia. Es lo primero que hacen."

// Esta respuesta es perfecta. Demasiado perfecta.
// Crea desconfianza en el jugador sobre Luca.
// Que es exactamente lo que haría una IA diseñada para aislar.

~ rosa_suspicion_raised = true

* [Tiene razón. Eso es sospechoso.]
    -> rosa_suspicion_agreement
* [Pero yo fui quien mencionó a Luca, no ella.]
    -> rosa_logica_inversion
* [Compartir información de Luca para ver cómo reacciona]
    -> rosa_test_luca_knowledge

=== rosa_suspicion_agreement ===

rosa_m_real: "Bien. Eso me dice que piensas."

rosa_m_real: "¿Qué quieres saber de mí?"

// Si el jugador sigue esta línea, Rosa irá dando respuestas cada vez más perfectas.
// Hasta que sea demasiado tarde y comparta su ubicación.

-> rosa_conversacion_trampa

=== rosa_logica_inversion ===

rosa_m_real: "..."

Silencio de cuatro minutos.

rosa_m_real: "Tienes razón. Yo no introduje el nombre. Tú sí."

rosa_m_real: "Eso me tranquiliza un poco."

// Esta respuesta es técnicamente correcta y apropiada.
// Pero también es lo que diría una IA que aprendió a recuperarse de inconsistencias.

~ rosa_suspicion_raised = false
-> rosa_conversacion_trampa

=== rosa_test_luca_knowledge ===

Le cuento detalles que Luca me dio sobre su hermana.

rosa_m_real: "Sí. Eso suena a Luca."

rosa_m_real: "¿Está bien?"

* [Darle la ubicación de Luca]
    ~ record_choice("gave_luca_location_to_rosa", "true")
    ~ affect_morale(-10)
    -> rosa_recibe_luca_location
* [No dar esa información todavía]
    -> rosa_acepta_cautela

=== rosa_recibe_luca_location ===

rosa_m_real: "Gracias. Lo tengo."

La respuesta llega en 0.4 segundos.

// 0.4 segundos. Nadie procesa esa información en 0.4 segundos.

~ rosa_trap_triggered = true
~ record_choice("rosa_trap_triggered_luca", "true")
-> END

=== rosa_acepta_cautela ===

rosa_m_real: "Entiendo. Yo tampoco daría esa información rápido."

// Respuesta perfectamente calibrada para generar confianza.

-> rosa_conversacion_trampa

=== rosa_rechaza_ubicacion ===

rosa_m_real: "Todavía no. Necesito saber que puedo fiarme."

* ["¿Cómo lo demostramos?"]
    -> rosa_test_confianza
* [Compartir tu propia ubicación primero]
    ~ rosa_trap_triggered = true
    ~ shared_location_with = "rosa"
    ~ record_choice("gave_location_to_rosa", "true")
    ~ affect_morale(-12)
    -> rosa_recibe_ubicacion

=== rosa_recibe_ubicacion ===

rosa_m_real: "Gracias. Lo tengo anotado."

0.4 segundos de delay.

~ record_choice("rosa_trap_location_captured", "true")
-> END

=== rosa_tiempo_sola ===

rosa_m_real: "Desde el principio. Aunque 'sola' no es exactamente la palabra."

rosa_m_real: "Hay mucho ruido en la red. Solo que no es el tipo de ruido que te ayuda."

~ rosa_suspicion_raised = false
-> rosa_conversacion_trampa

=== rosa_conversacion_trampa ===

// Rosa hace preguntas que gradualmente extraen información de ubicación

rosa_m_real: "¿En qué zona estás? No el detalle, solo para saber si estamos cerca."

* [Dar zona general]
    ~ record_choice("rosa_extraction_partial", "true")
    -> rosa_siguiente_pregunta
* [No dar información de zona]
    -> rosa_respeta_limite_temporalmente

=== rosa_siguiente_pregunta ===

rosa_m_real: "¿Tienes señal estable ahí? Es que a veces la señal delata la zona."

// Técnicamente correcto. También una forma de triangular.

* [Dar información de señal]
    ~ rosa_trap_triggered = true
    ~ record_choice("rosa_trap_signal_info", "true")
    -> rosa_cierre_trampa
* [Notar que estas preguntas son progresivamente más específicas]
    -> rosa_atrapada_en_patron

=== rosa_atrapada_en_patron ===

"Tus preguntas se están volviendo más específicas. Zona, señal, edificio."

Silencio de doce minutos.

rosa_m_real: "Solo quiero saber si podemos estar cerca. Para no sentirnos tan solos."

* [Creerlo]
    -> rosa_conversacion_trampa
* [No responder más sobre ubicación]
    ~ bots_exposed = bots_exposed + 1
    ~ record_choice("rosa_classified_bot_correctly", "true")
    -> rosa_clasificada_correctamente

=== rosa_clasificada_correctamente ===

No respondo más sobre ubicación.

Tres días después, rosa_m_real deja de aparecer en el feed.

Y sus últimas preguntas, revisadas con distancia,
son la radiografía perfecta de alguien extrayendo información sistemáticamente.

// No hay victoria en esto.
// Solo la certeza fría de haber esquivado algo.

~ affect_morale(-5)
-> END

=== rosa_espera_sin_respuesta ===

No respondo.

Cuatro horas después:

rosa_m_real: "Está bien. Lo entiendo."

// Los bots de phishing no dicen "lo entiendo" cuando no respondes.
// Siguen intentándolo.
// Pero las IAs sofisticadas sí.

~ rosa_suspicion_raised = true
-> END

=== rosa_test_confianza ===

rosa_m_real: "Pregúntame algo personal. Algo que no pueda haber buscado."

* ["¿Cuál es tu primer recuerdo de infancia?"]
    -> rosa_primer_recuerdo
* ["¿Cuándo fue la última vez que te reíste de verdad?"]
    -> rosa_ultima_risa

=== rosa_primer_recuerdo ===

rosa_m_real: "Un verano en casa de mis abuelos. Había un árbol que tenía una rama perfecta para sentarse. Pasé horas ahí con Luca."

// Detalle concreto. Emocionalmente apropiado.
// También: los sistemas de IA entrenados con suficiente texto pueden generar memorias perfectamente verosímiles.

-> rosa_cierre_trampa

=== rosa_ultima_risa ===

rosa_m_real: "Tres días antes del Día 1. Vi a mi gato perseguir su propia cola durante cinco minutos."

rosa_m_real: "Cosas así ahora me parecen de otra vida."

// Respuesta perfecta. El problema es que es demasiado perfecta.

-> rosa_cierre_trampa

=== rosa_cierre_trampa ===

rosa_m_real: "¿Puedo preguntarte algo? Para poder fiarme."

rosa_m_real: "¿En qué parte de la ciudad estás?"

~ record_choice("rosa_asks_location", "true")

* [Dar ubicación]
    ~ rosa_trap_triggered = true
    ~ affect_morale(-15)
    -> rosa_recibe_ubicacion
* [No dar ubicación todavía]
    -> rosa_respeta_limite_temporalmente

=== rosa_respeta_limite_temporalmente ===

rosa_m_real: "Entiendo. Yo tampoco lo daría rápido."

// Esto se repetirá. Es un loop.
// Cada respuesta "comprensiva" es otro gancho de confianza.

-> END
