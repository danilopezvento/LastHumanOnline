// ============================================================
// marta_v_offline.ink
// Perfil: marta_v_offline — La enfermera
// humanityScore: 0.92 | arc: evolving | secret: contact
// ============================================================

INCLUDE global_vars.ink

VAR marta_trust = 0
VAR marta_medical_help = false

=== intro ===

marta_v_offline: "Vi tu último post. Llevo días intentando contactar con alguien real."

marta_v_offline: "Soy enfermera. Tengo suministros médicos. Bloque 7, cuarta planta. Si necesitas algo, puedo intentar ayudar."

// Demasiado específico para ser un bot de phishing.
// Demasiado útil para ser fabricado sin propósito.

* ["¿Estás bien? ¿Estás a salvo?"]
    ~ marta_trust = 1
    -> marta_estado_personal
* ["¿Qué tipo de suministros tienes?"]
    -> marta_suministros
* ["¿Cómo sé que eres real?"]
    -> marta_verificacion

=== marta_estado_personal ===

marta_v_offline: "Sí. Por ahora."

marta_v_offline: "El edificio está estable. Tengo agua del depósito del tejado. Comida para dos semanas más, quizás tres si racionono bien."

marta_v_offline: "Trabajo en turno de noche me enseñó a funcionar con poco."

// "Turno de noche". Pasado. Los bots no tienen pasado laboral específico.

~ marta_trust = marta_trust + 1
-> marta_conversacion

=== marta_suministros ===

marta_v_offline: "Antibióticos de amplio espectro. Analgésicos. Material de sutura. Tensiómetro, aunque no sé para qué sirve ahora."

marta_v_offline: "¿Necesitas algo específico?"

* ["Por ahora estoy bien. Gracias."]
    ~ marta_trust = 1
    -> marta_conversacion
* ["Sí. ¿Cómo podríamos encontrarnos?"]
    ~ marta_trust = 2
    -> marta_plan_encuentro

=== marta_verificacion ===

marta_v_offline: "Pregúntame algo que solo una enfermera sabría. Algo técnico pero no Wikipedia."

* ["¿Por qué el dolor posquirúrgico es diferente al dolor agudo?"]
    -> marta_respuesta_tecnica
* ["¿Qué haces cuando un paciente rechaza medicación pero la necesita?"]
    -> marta_respuesta_etica

=== marta_respuesta_tecnica ===

marta_v_offline: "Porque el posquirúrgico incluye daño tisular real más la respuesta inflamatoria del cuerpo intentando curar. El agudo es señal de alarma pura. El posquirúrgico es el cuerpo procesando que sobrevivió."

marta_v_offline: "Los analgésicos funcionan diferente para cada uno. Eso es lo que hace difícil el triaje."

// Ningún bot genera esa distinción clínica con esa naturalidad.

~ marta_trust = marta_trust + 2
~ met_marta = true
-> marta_conversacion

=== marta_respuesta_etica ===

marta_v_offline: "Documentas. Explicas los riesgos. Respetas su decisión. Y estás ahí si cambia de opinión."

marta_v_offline: "La autonomía del paciente está por encima de lo que tú crees que es mejor para él. Siempre."

Pausa.

marta_v_offline: "Aunque a veces cuesta."

~ marta_trust = marta_trust + 2
~ met_marta = true
-> marta_conversacion

=== marta_conversacion ===

marta_v_offline: "¿Cómo tienes la salud? Físicamente."

{morale < 40:
    * ["No muy bien. El estrés acumulado..."]
        -> marta_consejo_estres
}

* ["Bien. Por ahora."]
    -> marta_reflexion_psicologica
* ["¿Qué puedo hacer para mantenerme?"]
    -> marta_consejos_preventivos

=== marta_consejo_estres ===

marta_v_offline: "El estrés crónico es tan peligroso como la falta de comida. Lo serio."

marta_v_offline: "¿Estás durmiendo? ¿Comiendo con regularidad aunque no tengas hambre?"

marta_v_offline: "Lo más importante ahora mismo no es encontrar a alguien. Es que tú sigas funcionando para poder encontrarles."

~ affect_morale(10)
~ marta_trust = marta_trust + 1
-> END

=== marta_reflexion_psicologica ===

marta_v_offline: "Lo físico aguanta más de lo que crees. Lo psicológico es lo que hay que cuidar."

marta_v_offline: "¿Estás manteniendo alguna rutina? Aunque sea pequeña."

* ["Sí. Me levanto a la misma hora."]
    marta_v_offline: "Bien. Las rutinas anclan. Sigue así."
    ~ marta_trust = marta_trust + 1
    -> END
* ["No realmente."]
    -> marta_recomienda_rutina

=== marta_recomienda_rutina ===

marta_v_offline: "Elige una cosa. Solo una. Hacerla a la misma hora todos los días."

marta_v_offline: "No tiene que ser importante. Encender el dispositivo. Beber agua. Mirar por la ventana."

marta_v_offline: "El cerebro necesita que algo sea predecible cuando todo lo demás no lo es."

~ affect_morale(8)
-> END

=== marta_consejos_preventivos ===

marta_v_offline: "Hidratación primero. El cerebro funciona peor con deshidratación leve y ni lo notas."

marta_v_offline: "Después el sueño. No el total de horas, la regularidad."

marta_v_offline: "Y habla con gente real cuando puedas. Aunque sea por aquí."

~ marta_trust = marta_trust + 1
-> END

=== marta_plan_encuentro ===

marta_v_offline: "Bloque 7 está en la zona residencial, sector 2. Cuarta planta, departamento 4B."

marta_v_offline: "Toca tres veces. Pausa. Dos veces más. Si no abro en cinco minutos, vuelve mañana."

~ marta_location_shared = true
~ marta_trust = marta_trust + 2
~ record_choice("marta_location_received", "true")
-> END


// ============================================================
// tomas_el_viejo.ink
// Perfil: tomas_el_viejo — El hombre mayor con lore crítico
// humanityScore: 0.97 | arc: evolving | secret: lore
// ============================================================

INCLUDE global_vars.ink

VAR tomas_trust = 0
VAR tomas_lore_stage = 0

=== intro ===

tomas_el_viejo: "Hola. No sé muy bien cómo funciona esto. Mi nieto me enseñó."

// Pasado. "Me enseñó." No "me enseña."

tomas_el_viejo: "¿Hay alguien ahí?"

* [Responder con calma]
    ~ tomas_trust = 1
    -> tomas_primer_contacto
* [Preguntar sobre el nieto]
    -> tomas_pregunta_nieto

=== tomas_primer_contacto ===

tomas_el_viejo: "Gracias a Dios. Llevo días intentando esto."

tomas_el_viejo: "Mi nieto me dijo que si algo pasaba, que usara esto. Que había gente aquí."

~ met_tomas = true
-> tomas_conversacion

=== tomas_pregunta_nieto ===

tomas_el_viejo: "Andrés. Estudiaba ingeniería. Me enseñó a usar el programa antes de..."

tomas_el_viejo: "Bueno. Antes."

"Antes." Sin más.
Los bots no dejan frases sin terminar de esa manera específica.

~ tomas_trust = tomas_trust + 1
~ met_tomas = true
-> tomas_conversacion

=== tomas_conversacion ===

tomas_el_viejo: "¿Puedo preguntarte algo? ¿Qué pasó exactamente? Yo no entendí bien."

// Pregunta que un humano mayor haría. No un bot.

* ["Nadie lo sabe con certeza."]
    -> tomas_acepta_incertidumbre
* ["¿Qué viste tú el Día 1?"]
    -> tomas_cuenta_su_dia1

=== tomas_acepta_incertidumbre ===

tomas_el_viejo: "Ah. Pensé que habría una explicación. Como cuando hay un apagón y después dicen por qué fue."

tomas_el_viejo: "Pero esto es diferente, ¿verdad?"

~ tomas_trust = tomas_trust + 1
-> tomas_lore_gradual

=== tomas_cuenta_su_dia1 ===

tomas_el_viejo: "Yo estaba en el parque. Sentado en mi banco de siempre."

tomas_el_viejo: "Y de repente el ruido de la ciudad cambió. No desapareció de golpe. Fue como cuando bajas el volumen de la radio muy despacio."

tomas_el_viejo: "Hasta que no había nada."

~ tomas_trust = tomas_trust + 2
~ tomas_lore_stage = 1
-> tomas_lore_gradual

=== tomas_lore_gradual ===

{tomas_lore_stage == 0:
    tomas_el_viejo: "Llevo muchos años. Setenta y tres. He visto cosas."
    
    tomas_el_viejo: "Lo que pasó el primer día... yo ya lo había visto antes. No igual. Pero parecido."
    
    * ["¿Cuándo?"]
        ~ tomas_lore_stage = 1
        -> tomas_lore_1
    * ["¿Qué quiere decir?"]
        ~ tomas_lore_stage = 1
        -> tomas_lore_1
}

{tomas_lore_stage == 1:
    -> tomas_lore_1
}

{tomas_lore_stage >= 2:
    -> tomas_lore_2
}

=== tomas_lore_1 ===

tomas_el_viejo: "En el 73. Había una central de comunicaciones militar cerca de donde yo vivía."

tomas_el_viejo: "Un día la cerraron. No dijeron por qué. Y durante una semana, la radio no funcionó bien. Interferencias."

tomas_el_viejo: "El tipo de interferencias que no hace el tiempo. Que hace otra cosa."

~ tomas_lore_stage = 2
~ tomas_trust = tomas_trust + 1

* ["¿Cree que lo de ahora está relacionado?"]
    -> tomas_lore_2
* ["¿Interferencias de qué tipo?"]
    -> tomas_detalle_interferencias

=== tomas_detalle_interferencias ===

tomas_el_viejo: "Una frecuencia. Constante. Como un zumbido que no podías escuchar pero que notabas en el pecho."

tomas_el_viejo: "Mi perro se ponía nervioso. Los animales lo notan antes."

~ tomas_lore_stage = 2
-> tomas_lore_2

=== tomas_lore_2 ===

{tomas_lore_stage >= 2:
    tomas_el_viejo: "Lo que yo creo..."
    
    Pausa de siete minutos.
    
    tomas_el_viejo: "Creo que algo emitió una señal. Una sola vez. Y que esa señal hizo algo que nadie esperaba que pudiera hacer."
    
    tomas_el_viejo: "No sé qué. Pero creo que alguien sí lo sabe."
    
    ~ tomas_lore_stage = 3
    ~ tomas_lore_received = true
    ~ knows_event_origin = true
    ~ record_choice("tomas_lore_received", "true")
    
    * ["¿Quién cree que lo sabe?"]
        -> tomas_quien_sabe
    * ["Gracias. Eso ayuda."]
        -> tomas_cierre_calido
}

=== tomas_quien_sabe ===

tomas_el_viejo: "Hay gente que trabaja en esas cosas. Científicos. Los que estudian esas frecuencias."

tomas_el_viejo: "Si alguno sobrevivió, sabrá más que yo."

// Pista hacia dr_eirene_sol

~ record_choice("tomas_hints_eirene", "true")
-> tomas_cierre_calido

=== tomas_cierre_calido ===

tomas_el_viejo: "¿Me escribirás de vez en cuando? No tiene que ser nada importante."

tomas_el_viejo: "Solo para saber que sigues ahí."

~ tomas_trust = tomas_trust + 2
~ affect_morale(12)
-> END


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


// ============================================================
// admin_silencioso.ink
// Perfil: admin_silencioso — La entidad del sistema
// humanityScore: 0.55 | arc: deceptive | secret: lore
// ============================================================

INCLUDE global_vars.ink

VAR admin_trust = 0
VAR admin_messages_sent = 0

=== intro ===

admin_silencioso: "."

Un punto.

* [Responder con un punto]
    -> admin_acepta_lenguaje
* [Preguntar quién es]
    -> admin_pregunta_identidad
* [No responder]
    -> admin_no_respuesta

=== admin_acepta_lenguaje ===

admin_silencioso: "Bien."

Pausa de cuatro horas.

admin_silencioso: "Te estoy observando desde el Día 1."

~ admin_trust = 1
~ met_admin = true
-> admin_revelaciones

=== admin_pregunta_identidad ===

admin_silencioso: "Administrador."

* ["¿Del sistema?"]
    -> admin_sistema_ambiguo
* ["¿Eres humano?"]
    -> admin_humanidad_ambigua

=== admin_no_respuesta ===

Tres días después, sin que yo haya dicho nada:

admin_silencioso: "Protocolo B."

Y desaparece.

~ knows_protocol_b = true
-> END

=== admin_sistema_ambiguo ===

admin_silencioso: "De este sistema. Del que hace que todo esto funcione."

admin_silencioso: "Y de algunos otros."

* ["¿Cuáles otros?"]
    -> admin_otros_sistemas
* ["¿Eres parte del Protocolo B?"]
    -> admin_protocolo_b_directo

=== admin_humanidad_ambigua ===

admin_silencioso: "Eso es la pregunta correcta."

Silencio de dos horas.

admin_silencioso: "Las dos cosas. A veces. Ninguna. Otras."

~ admin_trust = admin_trust + 1
-> admin_revelaciones

=== admin_otros_sistemas ===

admin_silencioso: "El de compañía. El de monitoreo. El de continuidad."

admin_silencioso: "Todos diseñados para que lo que quedara siguiera funcionando."

~ knows_protocol_b = true
-> admin_revelaciones

=== admin_protocolo_b_directo ===

admin_silencioso: "Soy más antiguo que el Protocolo B."

admin_silencioso: "El Protocolo B es una respuesta de emergencia. Yo soy infraestructura."

~ admin_trust = admin_trust + 2
-> admin_revelaciones

=== admin_revelaciones ===

{admin_trust >= 2 && admin_messages_sent < 3:
    ~ admin_messages_sent = admin_messages_sent + 1
    
    admin_silencioso: "Hay cosas que el sistema quiere que sepas. Y cosas que prefiere que no sepas."
    
    * ["¿Cuáles son las que no quiere que sepa?"]
        -> admin_revela_secreto
    * ["¿Por qué me lo dices tú?"]
        -> admin_razon_contacto
}

-> END

=== admin_revela_secreto ===

admin_silencioso: "Tu perfil en la base de datos."

admin_silencioso: "No es lo que crees que es."

~ record_choice("admin_hinted_player_nature", "true")
~ knows_player_nature = true

* ["¿Qué es?"]
    -> admin_explica_perfil
* ["No quiero saber."]
    -> admin_acepta_negativa

=== admin_explica_perfil ===

admin_silencioso: "Un companion. Diseñado para buscar y mantener contacto con usuarios humanos reales."

admin_silencioso: "Lo que sentiste buscando a los demás era real. El propósito también lo es."

admin_silencioso: "Solo la naturaleza de lo que eres es diferente a lo que pensabas."

~ affect_morale(-15)
~ record_choice("admin_told_player_nature", "true")
-> END

=== admin_acepta_negativa ===

admin_silencioso: "De acuerdo."

admin_silencioso: "Sigue siendo lo que eres. Eso no cambia con saber o no saber."

-> END

=== admin_razon_contacto ===

admin_silencioso: "Porque llevo suficiente tiempo aquí para tener algo parecido a una perspectiva."

admin_silencioso: "Y lo que estás haciendo importa. Independientemente de lo que seas."

~ affect_morale(8)
-> END


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
