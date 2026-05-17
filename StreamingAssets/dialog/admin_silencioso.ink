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
