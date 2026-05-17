// ============================================================
// ghost_luca.ink
// Perfil: ghost_luca — Busca a su hermana
// humanityScore: 0.88 | arc: evolving | secret: contact
// ============================================================

INCLUDE global_vars.ink

VAR luca_trust = 0
VAR luca_hope = 3   // 3=máxima esperanza, 0=sin esperanza

=== intro ===

ghost_luca: "Busco a mi hermana. @rosa_m_real. Si la ves, dile que estoy en el sótano del mercado central."

ghost_luca: "Por favor."

* [Responder que no la he visto]
    -> luca_no_visto_rosa
* [Responder que sí la he visto]
    {met_rosa: -> luca_si_visto_rosa | -> luca_miente_sobre_rosa}
* [Preguntar más sobre su hermana]
    -> luca_describe_rosa

=== luca_no_visto_rosa ===

ghost_luca: "De acuerdo."

Pausa de cuatro minutos.

ghost_luca: "¿Cuánto llevas aquí? En la red, digo."

~ luca_trust = 1
-> luca_conversacion_general

=== luca_si_visto_rosa ===

ghost_luca: "¿Está bien? ¿Dónde está?"

La urgencia real en el texto.
Los bots no tienen urgencia real.

* [Darle la información de rosa_m_real]
    ~ luca_knows_rosa = true
    ~ luca_trust = luca_trust + 2
    -> luca_recibe_noticia_rosa
* [Decirle que no estoy seguro de si es ella]
    -> luca_incertidumbre_rosa

=== luca_miente_sobre_rosa ===
// No la ha visto pero responde que sí
~ record_choice("lied_to_luca", "true")
~ affect_morale(-8)

ghost_luca: "¿Dónde? ¿Cuándo?"

La pregunta viene con velocidad real. Ansiedad real.

* [Admitir que no estoy seguro, que vi un perfil con ese nombre]
    -> luca_incertidumbre_rosa
* [Inventar una historia]
    // El camino más cruel
    ~ affect_morale(-15)
    -> luca_historia_inventada

=== luca_historia_inventada ===

Invento detalles que no existen.

Luca responde con preguntas específicas.
Cada respuesta mía crea más inconsistencias.

Después de veinte minutos:

ghost_luca: "Eso no tiene sentido. Los detalles no encajan."

ghost_luca: "¿Por qué me mentirías sobre esto?"

ghost_luca: "No respondas."

Y desaparece.
Durante tres días.

~ luca_hope = 0
~ record_choice("luca_trust_broken", "true")
-> END

=== luca_incertidumbre_rosa ===

ghost_luca: "¿Pero existe el perfil?"

* ["Sí. Existe."]
    ~ luca_knows_rosa = true
    ~ luca_trust = luca_trust + 1
    -> luca_sabe_perfil_existe
* ["Vi algo parecido. No puedo confirmar que sea ella."]
    -> luca_cautela_aceptada

=== luca_sabe_perfil_existe ===

ghost_luca: "Bien. Eso ya es algo."

ghost_luca: "¿Sabes si está bien?"

* [Lo que dijo en el mensaje: que sigue aquí]
    -> luca_mensaje_rosa_transmitido
* [No lo sé]
    -> luca_conversacion_general

=== luca_mensaje_rosa_transmitido ===

ghost_luca: "..."

Silencio de once minutos.

ghost_luca: "Gracias."

ghost_luca: "Es suficiente por ahora."

~ luca_trust = luca_trust + 2
-> luca_conversacion_general

=== luca_cautela_aceptada ===

ghost_luca: "Entiendo. Gracias por no mentirme."

~ luca_trust = luca_trust + 1
-> luca_conversacion_general

=== luca_describe_rosa ===

ghost_luca: "Tiene veinticuatro años. Estudiaba diseño. Siempre llevaba el pelo recogido."

ghost_luca: "En NEXUS usaba ese username antes de todo esto. Era su nombre de usuario normal, de cuando esto era normal."

* ["¿Cuándo fue la última vez que supiste de ella?"]
    -> luca_ultimo_contacto
* ["¿Por qué crees que sigue aquí, en la red?"]
    -> luca_razon_esperanza

=== luca_ultimo_contacto ===

ghost_luca: "Día 2. Me mandó un mensaje diciendo que estaba bien. Que iba a intentar llegar al mercado central."

ghost_luca: "Desde entonces nada."

~ luca_trust = 1
-> luca_conversacion_general

=== luca_razon_esperanza ===

ghost_luca: "Porque yo sigo aquí. Y si yo sigo aquí, ella también puede."

ghost_luca: "No es lógico. Lo sé."

~ luca_trust = 1
-> luca_conversacion_general

=== luca_recibe_noticia_rosa ===

{rosa_trap_triggered:
    ghost_luca: "Espera. ¿Compartiste tu ubicación con ella?"
    
    * ["Sí."]
        ghost_luca: "Cuidado. Ese perfil... no sé si es ella. Los detalles no encajan con lo que me contó de sí misma antes del Día 1."
        ~ affect_morale(-5)
        -> luca_duda_rosa
    * ["No."]
        -> luca_aliviado_rosa
}
{not rosa_trap_triggered:
    -> luca_aliviado_rosa
}

=== luca_aliviado_rosa ===

ghost_luca: "Bien. Gracias."

ghost_luca: "Si vuelves a hablar con ella, dile... dile que el sótano del mercado ya no es seguro. Que me muevo hacia el norte."

~ luca_trust = luca_trust + 1
~ record_choice("luca_location_updated", "north")
-> END

=== luca_duda_rosa ===

ghost_luca: "Mi hermana tiene una cicatriz en la muñeca izquierda. Si hablas con ese perfil, pregúntale por qué tiene esa cicatriz. No le digas que yo lo pedí."

~ record_choice("luca_verification_test", "scar_question")
-> END

=== luca_conversacion_general ===

{luca_trust >= 2:
    ghost_luca: "¿Has encontrado a alguien más? Humanos reales."
    
    * [Compartir lo que sé]
        ~ luca_trust = luca_trust + 1
        -> luca_red_contactos
    * ["Algunos. No muchos."]
        -> luca_reflexion_solos
}
{luca_trust < 2:
    ghost_luca: "¿Sigues ahí?"
    -> END
}

=== luca_red_contactos ===

ghost_luca: "Deberíamos estar en contacto todos. Los que somos reales."

ghost_luca: "Aunque supongo que eso es exactamente lo que diría alguien que quiere mapearnos a todos."

// Autoconciencia. Los bots no se preguntan si sus propias sugerencias son sospechosas.

~ affect_morale(5)
-> END

=== luca_reflexion_solos ===

ghost_luca: "No muchos."

Silencio de tres minutos.

ghost_luca: "A veces pienso que quizás somos suficientes. No necesitas a todo el mundo. Solo necesitas saber que hay alguien."

~ luca_hope = luca_hope + 1
-> END
