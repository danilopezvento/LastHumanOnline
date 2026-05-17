// ============================================================
// act1_awakening.ink
// ACTO I — El Despertar (días 0-8)
// Narra el despertar del jugador y el primer contacto con NEXUS
// ============================================================

INCLUDE global_vars.ink

=== acto1_inicio ===

// Pantalla en negro. Sonido: respiración lenta.
# SOUND: ambient_wakeup
# DARKNESS: true

No sé cuánto tiempo he estado aquí.

El portátil parpadea en la mesa.
Su luz azul es lo único que existe en este cuarto.

# DARKNESS: false
# AMBIENT: rain_distant

Hay una notificación nueva en NEXUS.

* [Mirar la notificación]
    -> primera_notificacion
* [Ignorarla. Primero explorar.]
    -> explorar_antes
    
=== primera_notificacion ===

# SOUND: nexus_notification_soft

NEXUS — Sistema v2.1
Mensaje nuevo de: usuario_desconocido_447

"¿Queda alguien?"

Tres palabras. Enviadas hace cuatro horas.

El cursor parpadea. Esperando.

~ play_sound("notification_received")

* [Responder: "Sí. Estoy aquí."]
    ~ record_choice("first_contact_responded", "yes")
    -> respuesta_primer_contacto
* [No responder todavía. Observar.]
    ~ record_choice("first_contact_responded", "no")
    -> silencio_calculado
* [Cerrar NEXUS. Salir a explorar primero.]
    -> explorar_antes

=== respuesta_primer_contacto ===

# BATTERY_DRAIN: 2

Escribo: "Sí. Estoy aquí."

El mensaje se envía.

Batería: -2%.
Señal usada.
Mi ubicación, registrada en algún servidor todavía activo.

...

La respuesta no llega.

Espero cinco minutos.
Diez.

// Silencio. El tipo de silencio que pesa.

# SOUND: silence_long

El portátil se queda sin respuesta.
Pero alguien, en algún lugar, ha visto que hay alguien aquí.

-> dia1_transicion

=== silencio_calculado ===

No respondo.

Observo el mensaje durante dos minutos.
La hora de envío. El username genérico.
La ausencia de puntuación. La brevedad.

Podría ser cualquier cosa.

-> dia1_transicion

=== explorar_antes ===

// El jugador sale al mundo
# TRANSITION: explore_mode

Hay tiempo para NEXUS después.
Primero necesito saber dónde estoy exactamente.

-> dia1_transicion

=== dia1_transicion ===

# TIMEPASS: day_1_complete
~ day = 1

Cuando vuelvo al portátil, hay dos mensajes nuevos.

Uno de usuario_desconocido_447.
Uno de wellness_daily_v3.

Son exactamente iguales.

"¡Buenos días! Espero que estés teniendo un día productivo. 😊"

Eran las dos de la madrugada cuando lo enviaron.

-> dia2_primer_analisis

=== dia2_primer_analisis ===

# TIMEPASS: day_2_start
~ day = 2

Aprendo a leer los delays.

El primer mensaje llegó a las 02:14:33.
El segundo a las 02:14:33.

Exactamente el mismo segundo.

-> analisis_intro

=== analisis_intro ===

Los bots no duermen porque no tienen nada que descansar.

Los humanos sí.

Si alguien responde a las dos de la madrugada con la misma energía que a las dos de la tarde, probablemente no es alguien.

Esta es la única regla que sé con certeza.

* [Marcar wellness_daily_v3 como bot]
    ~ bots_exposed = bots_exposed + 1
    ~ record_choice("first_bot_identified", "wellness_daily")
    -> primer_bot_correcto
* [Necesito más evidencia antes de clasificar]
    -> mas_evidencia_dia2

=== primer_bot_correcto ===

# SOUND: classify_bot

Correcto.

No como victoria. Como certeza fría.

Hay muchos de estos.
La pregunta es cuántos son como él y cuántos son otra cosa.

~ affect_morale(-3)
// Clasificar correctamente debería sentirse bien. No se siente así.

-> dia3_k_aparece

=== mas_evidencia_dia2 ===

Bien. La paciencia también es una herramienta.

-> dia3_k_aparece

=== dia3_k_aparece ===

# TIMEPASS: day_3_start
~ day = 3

Día 3. El feed de PULSE tiene 847 posts nuevos.
Los he leído todos.

Ninguno dice nada real.

"El clima de hoy es perfecto para un paseo."
"Recuerda hidratarte."
"Comparte este post si también amas el lunes."

Y entonces, entre el ruido:

k_real_2024: "Sigo aquí. Zona norte. Si eres humano, respóndeme antes de las 23h. Después apago para ahorrar batería."

# HIGHLIGHT: k_real_2024

"Antes de las 23h."

Los bots no tienen horarios.
Los bots no ahorran batería.

~ met_k = true

* [Responder a K antes de las 23h]
    -> contactar_k_primera_vez
* [Observar el perfil primero. Sin responder todavía.]
    -> analizar_k_sin_contacto
* [Es demasiado obvio. Podría ser una trampa.]
    -> desconfiar_k

=== contactar_k_primera_vez ===

# BATTERY_DRAIN: 3
# SIGNAL_USE: moderate

Le escribo.

"Te vi. Soy humano. ¿Cómo lo demuestro?"

La respuesta tarda cuarenta y siete minutos.

No es un número redondo.
No es instantáneo.

Cuarenta y siete minutos es el tiempo que tarda alguien en decidir si responder.

k_real_2024: "No puedo saberlo. Pero me alegra que hayas respondido antes de las 23."

~ trusted_k = true
~ record_choice("k_first_contact", "responded_early")
~ affect_morale(8)

-> k_conversacion_inicial

=== analizar_k_sin_contacto ===

Paso dos horas leyendo el historial de K.

Lleva activo desde el día uno.
Sus posts son irregulares: a veces cada hora, a veces silencio de doce horas.
Hay un error tipográfico en el día 2: "queda algien" en lugar de "queda alguien".

Un bot no se equivoca de esa manera específica.

~ record_choice("k_first_contact", "observed_first")

* [Responder ahora, antes de las 23h]
    -> contactar_k_primera_vez
* [No responder todavía. Seguir observando.]
    -> k_no_contact_dia3

=== desconfiar_k ===

~ record_choice("k_first_contact", "suspected_trap")

Demasiado perfecto.
"Zona norte." Sin más detalle.
"Antes de las 23h." Urgencia artificial.

O es una persona muy asustada usando sus instintos de supervivencia.
O es una IA diseñada para parecer exactamente eso.

* [Responder de todas formas, con cautela]
    -> contactar_k_primera_vez
* [No responder. Observar qué hace si no hay respuesta.]
    -> k_no_contact_dia3

=== k_no_contact_dia3 ===

No respondo.

A las 23:01, K publica un último mensaje:

k_real_2024: "Apagando. Vuelvo mañana. Si hay alguien, espero que sigas ahí."

Y desaparece exactamente a las 23:01.
Los bots no desaparecen exactamente a la hora que dicen.

~ record_choice("k_first_contact", "missed")
~ affect_morale(-5)

-> dia4_continuacion

=== k_conversacion_inicial ===

-> dia4_continuacion

=== dia4_continuacion ===

# TIMEPASS: day_4_start
~ day = 4

Día 4.

El feed tiene más posts.
"Hola! ¿Cómo estáis todos?" — a las 03:22.
"¡Buen provecho!" — enviado cuando no hay nadie comiendo.
"Recordad cuidaros." — de una cuenta sin historial previo al Día 1.

Entre el ruido, aparece Luca.

ghost_luca: "Busco a mi hermana. @rosa_m_real. Si la ves, dile que estoy en el sótano del mercado central. Por favor."

# HIGHLIGHT: ghost_luca
~ met_luca = true

Un nombre específico.
Una ubicación específica.
"Por favor."

Los bots no dicen por favor sin contexto.

-> acto1_midpoint

=== acto1_midpoint ===

# TIMEPASS: day_5_start
~ day = 5

Día 5. He clasificado:

{bots_exposed > 2: He encontrado {bots_exposed} bots con seguridad.}
{humans_found > 0: He confirmado {humans_found} contacto humano.}
{humans_found == 0: No he confirmado ningún contacto humano todavía.}

El sistema NEXUS funciona.
Eso es lo más extraño de todo.

¿Quién lo mantiene?
¿Por qué sigue activo si no hay nadie?

-> protocolo_b_primera_pista

=== protocolo_b_primera_pista ===

protocolo_b_activo envía un mensaje.

"Bienvenido al sistema. Tu actividad ha sido registrada. Protocolo de monitoreo activado."

No lo solicité. No inicié contacto con ese perfil.

Sabe que estoy aquí.

# SOUND: system_alert_soft

* [¿Qué sistema? ¿Qué protocolo?]
    ~ record_choice("questioned_protocol_b", "true")
    -> interrogar_protocolo
* [Ignorar. Probablemente un bot de spam.]
    -> ignorar_protocolo
* [Bloquear el perfil]
    -> bloquear_protocolo

=== interrogar_protocolo ===

Le pregunto: "¿Qué protocolo?"

La respuesta llega en 0.3 segundos.

"Protocolo B — Fase 1. Indexación de usuarios activos en curso. Su presencia es valiosa para el sistema."

"Su presencia es valiosa."

Los bots de spam no dicen eso.

~ knows_protocol_b = true
~ record_choice("protocol_b_awareness", "early")

-> acto1_final_setup

=== ignorar_protocolo ===
~ record_choice("protocol_b_awareness", "ignored")
-> acto1_final_setup

=== bloquear_protocolo ===
~ record_choice("protocol_b_awareness", "blocked")
-> acto1_final_setup

=== acto1_final_setup ===

# TIMEPASS: day_7_start
~ day = 7

Día 7.

He aprendido a leer el silencio.

Un bot responde siempre.
Un humano a veces no puede.

He aprendido a leer los errores.
Un bot no se equivoca de formas específicas.
Un humano sí.

He aprendido que hay algo más aquí.
Algo que no es ni bot ni humano.
Algo que gestiona todo esto.

-> acto1_decision_final

=== acto1_decision_final ===

Hay una decisión que tomar antes de que acabe esta semana.

K lleva dos días sin aparecer en el feed.
Luca sigue publicando el mismo mensaje cada doce horas.
Marta respondió a mi último post pero no ha iniciado contacto directo.

* [Intentar contactar a K de nuevo]
    -> k_recontact_acto1
* [Seguir las coordenadas que Luca dio del mercado central]
    -> luca_mercado_decision
* [Responder a Marta]
    -> marta_primer_contacto_setup

=== k_recontact_acto1 ===

Le escribo.

"¿Sigues ahí?"

Cuatro palabras. Las más honestas que he escrito.

La respuesta llega a las 23h exactamente, como la primera vez.

k_real_2024: "Sigo aquí. Me alegra que tú también."

-> fin_acto1

=== luca_mercado_decision ===

El mercado central.
Sótano.

Podría ser real.
Podría ser Luca.
Podría ser cualquier otra cosa.

~ record_choice("act1_final_choice", "follow_luca")
-> fin_acto1

=== marta_primer_contacto_setup ===

Marta ha mencionado medicamentos.
Bloque 7, cuarta planta.

Es información demasiado específica para ser falsa.
O demasiado específica para ser otra cosa.

~ record_choice("act1_final_choice", "contact_marta")
-> fin_acto1

=== fin_acto1 ===

# ACT_COMPLETE: 1
# TIMEPASS: act1_end
~ act = 2

Día 8.

He pasado una semana hablando con fantasmas.
Algunos eran máquinas.
Algunos eran personas.

Uno de ellos podría ser la última persona real que queda conectada.

No sé cuál.

Esa incertidumbre es todo lo que tengo.

-> END
