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
