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
