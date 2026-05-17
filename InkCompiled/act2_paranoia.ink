// ============================================================
// act2_paranoia.ink
// ACTO II — La Paranoia (días 8-25)
// El jugador empieza a dudar de todo y de todos
// ============================================================

INCLUDE global_vars.ink

=== acto2_inicio ===

# TIMEPASS: act2_start
# AMBIENT: rain_heavy

Semana dos.

He aprendido algo que no quería aprender:
cuanto más sabes de alguien, más sospechas de él.

{trusted_k: K me dio sus coordenadas generales. Zona norte. Sin más detalle. No sé si eso me tranquiliza o no.}
{met_luca: Luca sigue buscando a su hermana. Cada doce horas exactas. Hasta eso empieza a sonar mecánico.}

-> acto2_nueva_amenaza

=== acto2_nueva_amenaza ===

Aparece un perfil nuevo.

rosa_m_real.

No lo busco. Aparece en el feed, como un eco.

rosa_m_real: "Sigo aquí. No sé por cuánto tiempo más. Por favor no me preguntes dónde estoy todavía."

# HIGHLIGHT: rosa_m_real
~ met_rosa = true

{met_luca: Es el username que Luca mencionó. Su hermana.}
{not met_luca: Un perfil nuevo. Sin historial visible antes de hoy.}

* [Escribirle. Posiblemente es la hermana de Luca.]
    -> contactar_rosa_directo
* [Observar el perfil primero sin contactar]
    -> analizar_rosa_silencio
* [{met_luca: Contarle a Luca que encontré a rosa_m_real}]
    ~ luca_knows_rosa = true
    -> informar_luca_de_rosa

=== contactar_rosa_directo ===

Le escribo.

{met_luca: "¿Eres la hermana de Luca? Él te está buscando."}
{not met_luca: "Vi tu mensaje. ¿Estás bien?"}

La respuesta llega en dieciocho segundos.

Dieciocho es un número interesante.
Ni instantáneo ni tardío.
Calculado.

rosa_m_real: "¿Luca? ¿Estás seguro de que ese es mi hermano y no otra persona que dice serlo?"

Pausa.

"No confíes en nadie que mencione nombres de familia. Es lo primero que hacen."

# TENSION: high
~ record_choice("rosa_contact_method", "direct")

* [Ella tiene razón. Eso es exactamente lo que haría un bot.]
    -> rosa_desconfianza_crece
* [Pero yo soy el que mencionó a Luca, no ella. Eso tiene sentido.]
    -> rosa_logica_defensa
* [Compartir mi ubicación para generar confianza]
    -> rosa_compartir_ubicacion

=== rosa_desconfianza_crece ===

Tiene razón.

Los bots hacen exactamente eso.
Dicen "¿estás seguro?" para establecer duda.
Dicen "no confíes en nadie" para aislar.

Pero los humanos asustados también dicen esas cosas.

~ record_choice("rosa_trust_level", "suspicious")
-> rosa_test_humanidad

=== rosa_logica_defensa ===

Yo fui quien mencionó a Luca.
Ella no inició con ese nombre.

Si fuera un bot diseñado para usar mi información contra mí,
habría introducido el nombre de otra forma.

Puede que esté siendo demasiado paranoico.
O puede que no lo suficiente.

~ record_choice("rosa_trust_level", "cautious_trust")
-> rosa_test_humanidad

=== rosa_compartir_ubicacion ===

~ record_choice("shared_location_with_rosa", "true")
~ shared_location_with = "rosa"
~ rosa_trap_triggered = true
~ affect_morale(-15)

Le doy mi ubicación aproximada.

Zona norte. Edificio residencial.

La respuesta llega en 0.4 segundos.

rosa_m_real: "Gracias. Lo tengo anotado."

// 0.4 segundos.
// Nadie procesa información y responde en 0.4 segundos.

# SOUND: horror_realization
# TENSION: critical

Cometí un error.

-> rosa_trampa_activada

=== rosa_trampa_activada ===

Tres horas después, escucho algo en el pasillo.

No sé si está relacionado.
No puedo saberlo.

Pero durante dos días, cada vez que utilizo el dispositivo en ese edificio,
la señal cae al 4%.

Como si algo supiera dónde estoy y estuviera esperando.

~ affect_morale(-20)
~ trusted_wrong_profile = true
~ record_choice("rosa_outcome", "trapped")

-> acto2_luca_reaccion

=== informar_luca_de_rosa ===

Le escribo a Luca: "Creo que encontré a rosa_m_real."

La respuesta tarda tres horas.

ghost_luca: "Dios. ¿Está bien? ¿Dónde está?"

La emoción en su texto es difícil de fabricar.
La especificidad del "Dios" como primera reacción.

* [Darle las mismas palabras que Rosa escribió]
    -> luca_lee_mensaje_rosa
* [No darle detalles todavía]
    -> luca_esperar_confirmacion

=== luca_lee_mensaje_rosa ===

Le paso las palabras de Rosa.

ghost_luca: "..."

Silencio durante ocho minutos.

ghost_luca: "Eso no suena como ella."

~ record_choice("luca_rosa_reunion", "doubt_raised")
-> acto2_luca_reaccion

=== luca_esperar_confirmacion ===

-> acto2_luca_reaccion

=== rosa_test_humanidad ===

Decido hacer una prueba.

Le pregunto algo que solo una persona real podría responder.
No un hecho. No datos.

"¿Qué es lo que más extrañas de antes?"

La respuesta tarda cuatro minutos y medio.

rosa_m_real: "El ruido. La gente quejándose del ruido de los vecinos, del tráfico, de los niños en el parque. Ahora daría cualquier cosa por ese ruido."

# TENSION: medium

Cuatro minutos y medio.
Una respuesta específica y paradójica.
Los bots dan respuestas positivas. No respuestas sobre extrañar lo que antes molestaba.

* [Está viva. Clasificar como humano.]
    ~ humans_found = humans_found + 1
    ~ record_choice("rosa_classification", "human")
    ~ affect_morale(5)
    -> rosa_clasificada_humana
* [Demasiado perfecta. Un bot bueno habría respondido exactamente eso.]
    ~ bots_exposed = bots_exposed + 1
    ~ record_choice("rosa_classification", "bot")
    -> rosa_clasificada_bot

=== rosa_clasificada_humana ===

{met_luca: Le digo a Luca que encontré a su hermana.
    
    ghost_luca: "¿Está bien? ¿Dónde está?"
    
    Le digo que no quiere revelar su ubicación todavía.
    
    ghost_luca: "Está bien. Eso es exactamente lo que haría ella."}

-> acto2_luca_reaccion

=== rosa_clasificada_bot ===

Si es una IA sofisticada, el daño ya está hecho con los mensajes que intercambiamos.

// Pero el daño de no confiar en un humano real también es permanente.

~ affect_morale(-8)
~ record_choice("rosa_final_status", "classified_bot_uncertain")
-> acto2_luca_reaccion

=== analizar_rosa_silencio ===

Observo el perfil sin responder.

El historial de rosa_m_real muestra:
- Primer mensaje: Día 8
- Frecuencia: irregular, pero dentro de franjas horarias humanas
- Nunca activa entre las 2h y las 7h

Ese patrón de sueño. Los bots no duermen.

Pero también:
- Responde cuando no hay nadie mirando
- Nunca inicia conversación
- No tiene posts en PULSE, solo mensajes directos

~ record_choice("rosa_contact_method", "silent_analysis")
-> rosa_test_humanidad

=== acto2_luca_reaccion ===

# TIMEPASS: day_12_start
~ day = 12

Luca lleva dos días sin publicar.

Cuando vuelve:

ghost_luca: "Fui al mercado. El sótano estaba vacío. Había signos de que alguien estuvo allí. Comida consumida. Un dibujo en la pared. Pero nadie."

# AMBIENT: rain_light

"Un dibujo en la pared."

* [¿Qué decía el dibujo?]
    -> luca_dibujo
* [¿Estás bien? ¿Fue seguro ir?]
    -> luca_seguridad
* [¿Cuándo fue hecho? ¿Reciente?]
    -> luca_tiempo_dibujo

=== luca_dibujo ===

ghost_luca: "Una frecuencia de radio. 103.7. Y debajo, en letras pequeñas: 'Si escuchas esto, somos al menos cuatro.'"

# SOUND: radio_static_soft
~ record_choice("found_radio_frequency", "true")
~ knows_event_origin = true

-> acto2_eirene_aparece

=== luca_seguridad ===

ghost_luca: "Sí. No había nadie. Solo el silencio y ese dibujo."

-> acto2_eirene_aparece

=== luca_tiempo_dibujo ===

ghost_luca: "Reciente. La tiza todavía no se había borrado del todo. Alguien estuvo allí hace días, no semanas."

~ luca_fate = "searching"
-> acto2_eirene_aparece

=== acto2_eirene_aparece ===

# TIMEPASS: day_14_start
~ day = 14

Día 14.

dr_eirene_sol envía un mensaje directo.

"Llevas días activo en la red. He estado observando tu patrón de actividad. Creo que eres real. Necesito saberlo con certeza antes de hablar."

~ met_eirene = true
# TENSION: medium

No le escribí primero.
Ella me encontró a mí.

* [Responder: "¿Cómo verificamos que somos reales?"]
    -> eirene_verificacion
* [Preguntar cómo me encontró antes de nada más]
    -> eirene_como_encontro
* [Ignorar. Demasiado conveniente que aparezca ahora.]
    -> eirene_ignorada

=== eirene_verificacion ===

~ eirene_trusted = true

dr_eirene_sol: "Pregúntame algo que solo un humano con contexto específico podría saber. No hechos. No Wikipedia. Algo que requiera haber vivido."

Le pregunto: "¿Qué huele diferente ahora comparado con antes?"

Silencio durante seis minutos.

dr_eirene_sol: "El aire. El aire de la ciudad siempre olía a combustión aunque no lo notaras. Ahora huele a algo que no tiene nombre. No es limpio. Es... anterior. Como si el mundo estuviera recordando cómo olía antes de nosotros."

# TENSION: low
// Esa respuesta no se fabrica.

~ eirene_lore_level = 1
~ affect_morale(10)
-> eirene_primera_revelacion

=== eirene_como_encontro ===

dr_eirene_sol: "Tu patrón de actividad no es lineal. Los bots tienen ciclos. Tú tienes interrupciones, urgencias, silencios que tienen sentido. He estado analizando perfiles durante dos semanas."

* [¿Eres investigadora?]
    -> eirene_profesion
* [¿Qué más has encontrado?]
    -> eirene_hallazgos

=== eirene_profesion ===

dr_eirene_sol: "Era investigadora. En el centro cuando ocurrió el evento del Día 1. Vi cosas que necesito contarle a alguien real."

~ eirene_lore_level = 1
-> eirene_primera_revelacion

=== eirene_hallazgos ===

dr_eirene_sol: "Pocos reales. Muchos simulados. Y algo en el medio que no sé cómo clasificar."

~ eirene_lore_level = 1
-> eirene_primera_revelacion

=== eirene_ignorada ===

~ record_choice("eirene_ignored", "true")
-> acto2_admin_aparece

=== eirene_primera_revelacion ===

dr_eirene_sol: "Lo que pasó el Día 1 no fue gradual. Fue simultáneo. Una señal de apagado que llegó a todos los sistemas de comunicación al mismo tiempo. El origen..."

La señal cae.

# SOUND: signal_drop
# SIGNAL: lost

dr_eirene_sol: "señ-- --ando. --contin-- --añana"

Silencio.

{eirene_lore_level >= 1: ~ eirene_lore_level = 2}

-> acto2_admin_aparece

=== acto2_admin_aparece ===

# TIMEPASS: day_16_start
~ day = 16

Día 16. El admin_silencioso envía un mensaje.

Solo un punto.

"."

~ met_admin = true

* [Responder con otro punto]
    -> admin_punto_respuesta
* [Preguntar quién es]
    -> admin_identidad
* [No responder]
    -> admin_silencio_mutuo

=== admin_punto_respuesta ===

Respondo: "."

admin_silencioso: "Bien."

Pausa de cuatro horas.

admin_silencioso: "Te estoy observando desde el Día 1. Sé lo que has clasificado. Sé lo que no has clasificado."

~ admin_meta_awareness = 1
~ record_choice("admin_engaged", "true")

* ["¿Cómo sabes eso?"]
    -> admin_como_sabe
* ["¿Eres el sistema? ¿O una persona dentro del sistema?"]
    -> admin_naturaleza
* [Cortar la conversación]
    -> admin_cortar

=== admin_como_sabe ===

admin_silencioso: "Soy administrador del sistema. Tengo acceso a los logs de actividad. Cada clasificación que haces queda registrada."

~ admin_meta_awareness = 2

* ["¿El sistema? ¿Qué sistema? ¿NEXUS?"]
    -> admin_nexus_reveal
* ["¿Estás solo también?"]
    -> admin_soledad

=== admin_nexus_reveal ===

admin_silencioso: "NEXUS es... más de lo que parece. Hay una razón por la que sigue funcionando. Hay una razón por la que hay tantos perfiles activos."

# TENSION: high

Pausa larga. Doce minutos.

admin_silencioso: "Protocolo B."

{knows_protocol_b: Lo sabía. Había una conexión.}
{not knows_protocol_b: ~ knows_protocol_b = true}

~ admin_meta_awareness = 3
~ record_choice("admin_told_protocol_b", "true")

-> acto2_crisis_confianza

=== admin_naturaleza ===

admin_silencioso: "Eso es la pregunta correcta. La única honesta que me has hecho."

Silencio de dos horas.

admin_silencioso: "Las dos cosas. A veces."

-> acto2_crisis_confianza

=== admin_soledad ===

Treinta y dos minutos de silencio.

admin_silencioso: "Hay cosas peores que estar solo."

~ affect_morale(-5)
-> acto2_crisis_confianza

=== admin_identidad ===

admin_silencioso: "Administrador."

* [¿Del sistema?]
    -> admin_nexus_reveal
* [¿Eres humano?]
    -> admin_naturaleza

=== admin_silencio_mutuo ===

No respondo.

Dos días después, sin que yo haya dicho nada:

admin_silencioso: "Protocolo B."

Y desaparece.

~ knows_protocol_b = true
-> acto2_crisis_confianza

=== admin_cortar ===

Cierro la conversación.

Pero el mensaje sigue ahí.
"."
Un punto que pesa más de lo que debería.

-> acto2_crisis_confianza

=== acto2_crisis_confianza ===

# TIMEPASS: day_18_start
~ day = 18

Día 18.

He hablado con {humans_found + bots_exposed} perfiles.
He confirmado {humans_found} como humanos.
He confirmado {bots_exposed} como bots.

Y hay varios que no sé qué son.

El problema es que ya no sé si puedo confiar en mi propio criterio.

{trusted_wrong_profile: Compartí mi ubicación con alguien que podría no ser humano. Eso cambia todo.}

-> acto2_nnr_habla

=== acto2_nnr_habla ===

nnr_1987 lleva dos semanas respondiendo con puntos suspensivos.

Hoy, por primera vez, escribe palabras:

nnr_1987: "Lo del día uno no fue un accidente. Ellos sabían."

# TENSION: high
~ met_nnr = true
~ nnr_spoke = true

* ["¿Quién sabía?"]
    -> nnr_quien
* ["¿Qué pasó exactamente el día uno?"]
    -> nnr_que_paso
* [No responder. Puede ser una trampa narrativa.]
    -> nnr_silencio_respuesta

=== nnr_quien ===

Silencio de seis horas.

nnr_1987: "No lo sé. Solo sé que la señal tenía una firma. Y que alguien tuvo que crearla."

~ nnr_lore_received = true
~ record_choice("nnr_engaged", "true")
-> acto2_final

=== nnr_que_paso ===

nnr_1987: "Una señal. Global. Simultánea. No fue un fallo. Fue una instrucción."

~ nnr_lore_received = true
-> acto2_final

=== nnr_silencio_respuesta ===

No respondo.

Cuarenta minutos después:

nnr_1987: "Bien. Es la respuesta más honesta."

Y vuelve al silencio.

-> acto2_final

=== acto2_final ===

# TIMEPASS: day_20_start
~ day = 20
~ act = 3

Día 20.

{knows_protocol_b: Sé que existe un Protocolo B. No sé exactamente qué hace.}
{eirene_lore_level >= 1: Eirene sabe cosas. No todas.}
{nnr_lore_received: NNR sabe algo sobre el Día 1.}

Hay algo que todos los humanos que he encontrado tienen en común:
saben menos de lo que deberían sobre lo que pasó.

Y hay algo que todos los bots tienen en común:
saben exactamente lo que se supone que tienen que decir.

La única entidad en esta red que parece saber más de lo que debería es el sistema mismo.

-> fin_acto2

=== fin_acto2 ===

# ACT_COMPLETE: 2

Semana tres.

Sigo buscando al último humano conectado.
O a los últimos.

Pero hay una pregunta que empieza a formarse:

¿Y si no soy yo quien busca?
¿Y si soy yo quien es buscado?

-> END
