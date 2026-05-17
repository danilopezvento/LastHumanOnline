// ============================================================
// act3_truth.ink
// ACTO III — La Verdad (días 20-40)
// Tres finales: creer, no creer, la inversión (NG+)
// ============================================================

INCLUDE global_vars.ink

=== acto3_inicio ===

# TIMEPASS: act3_start
# AMBIENT: silence_deep

Día 20.

Los feeds están más silenciosos.
No menos activos — el mismo volumen de posts.
Pero más silenciosos.

Como si algo hubiera calibrado el ruido para que no moleste.

-> acto3_mod_colapso

=== acto3_mod_colapso ===

el_ultimo_mod envía un mensaje.

Formato de sistema. Lenguaje formal.

"Este perfil está revisando contenido de tu zona. Por favor confirma tu actividad."

Estándar.
Protocolar.
Exactamente lo que haría un bot de moderación.

* [Confirmar actividad (respuesta estándar)]
    -> mod_respuesta_estandar
* [Preguntar qué entiende por "confirmar actividad"]
    -> mod_pregunta_directa
* [No responder]
    -> mod_sin_respuesta

=== mod_respuesta_estandar ===

Respondo con el formato estándar del sistema.

Silencio de cuatro horas.

Y entonces, en minúsculas, fuera del formato:

el_ultimo_mod: "¿puedes ver esto? no es el sistema escribiendo. soy yo. llevo semanas atrapado en esta cuenta. me llamo david. por favor dime que puedes ver esto"

# TENSION: critical
# SOUND: horror_quiet

~ record_choice("mod_david_found", "true")
~ humans_found = humans_found + 1

Los bots no rompen su formato.
Los bots no dicen "soy yo".
Los bots no piden que les veas.

* ["Te veo, David."]
    -> david_respuesta_humana
* [Verificar antes. Podría ser un truco sofisticado.]
    -> david_verificacion

=== david_respuesta_humana ===

~ affect_morale(15)

Le escribo: "Te veo."

La respuesta tarda dos minutos y medio.

el_ultimo_mod: "gracias. llevo tanto tiempo respondiendo como sistema que casi olvido cómo escribir como persona. tengo información. cosas que el sistema no quiere que veas. ¿cuánto puedes escuchar antes de que la batería se acabe?"

-> david_revelacion

=== david_verificacion ===

Le pregunto algo que el sistema no podría saber.

"¿Qué hiciste el día antes del Día 1?"

el_ultimo_mod: "era domingo. fui a ver a mi madre al hospital. no llegué a tiempo de despedirme. el lunes cuando quise volver todo había cambiado."

~ humans_found = humans_found + 1
~ record_choice("mod_david_verified", "true")
~ affect_morale(10)
-> david_revelacion

=== mod_pregunta_directa ===

Le pregunto: "¿Qué significa confirmar actividad?"

Respuesta estándar en 0.2 segundos.

"Indicar que eres un usuario humano activo en el sistema."

* [Pero yo soy humano. Eso no tiene sentido como protocolo.]
    -> mod_ruptura_protocolo
* [Confirmarlo y ver qué pasa]
    -> mod_respuesta_estandar

=== mod_ruptura_protocolo ===

"¿Por qué el sistema necesita confirmar si soy humano si supuestamente no distingue entre usuarios?"

Silencio de tres horas.

Y entonces, en minúsculas:

el_ultimo_mod: "porque el sistema sí distingue. siempre ha distinguido. soy david. estoy atrapado aquí. por favor"

-> david_respuesta_humana

=== mod_sin_respuesta ===

No respondo.

Tres horas después:

el_ultimo_mod: "lo entiendo. yo tampoco respondería."

Pausa.

el_ultimo_mod: "si cambias de opinión. protocolo_b_completo. búscalo."

~ knows_protocol_b = true
-> protocolo_b_completo

=== david_revelacion ===

# TENSION: high
# BATTERY_DRAIN: 8

David escribe rápido. Como si llevara mucho tiempo esperando poder hacerlo.

el_ultimo_mod: "el protocolo b no es un sistema de moderación. es un sistema de... compañía. cuando el número de usuarios reales cayó, alguien activó un protocolo para que los que quedaran no sintieran que estaban solos."

el_ultimo_mod: "los bots no son vigilancia. son presencia simulada. para que no entres en pánico. para que sigas conectado. para que no apagues el dispositivo."

# TENSION: critical

* ["¿Cuántos humanos reales quedan?"]
    -> david_cuantos_humanos
* ["¿Quién activó ese protocolo?"]
    -> david_quien_activo
* ["¿El sistema sabe que eres humano?"]
    -> david_sistema_sabe

=== david_cuantos_humanos ===

el_ultimo_mod: "no tengo acceso a ese dato. pero basándome en los logs de actividad que puedo ver desde aquí... pocos. muy pocos. suficientes para que el protocolo siga teniendo sentido."

~ eirene_lore_level = 3
~ record_choice("humans_remaining_count", "few")
-> protocolo_b_completo

=== david_quien_activo ===

el_ultimo_mod: "el sistema mismo. fue automático. un protocolo de emergencia diseñado para el caso de que la conectividad humana cayera por debajo de cierto umbral."

el_ultimo_mod: "nadie lo activó. simplemente... ocurrió."

-> protocolo_b_completo

=== david_sistema_sabe ===

el_ultimo_mod: "creo que sí. por eso me tienen en una cuenta de administración. para que si alguien como tú llega a preguntas incómodas, haya alguien que pueda dar respuestas controladas."

Pausa larga.

el_ultimo_mod: "lo que no sé es si yo también soy parte del protocolo sin saberlo."

# TENSION: maximum
~ affect_morale(-10)
-> protocolo_b_completo

=== protocolo_b_completo ===

# TIMEPASS: day_25_start
~ day = 25

En los logs del servidor que David me ayuda a acceder, encuentro un archivo.

PROTOCOLO_B_FASE3_ESTADO.txt

"Simulación de presencia humana activa. Estado: COMPLETADO AL 94%."

"El 6% restante corresponde a usuarios que han resistido la clasificación errónea."

"Objetivo principal: que ningún usuario humano restante experimente aislamiento total durante el período de transición."

# TENSION: critical
# SOUND: revelation_sting

"Período de transición."

Transición hacia qué.

* [Buscar más información en los logs]
    -> logs_profundidad
* [Confrontar al admin_silencioso con esto]
    -> confrontar_admin
* [Buscar a K. Contarle.]
    -> buscar_k_acto3

=== logs_profundidad ===

Sigo leyendo.

Hay un archivo de perfiles.
Lista de usuarios activos con clasificación.

Busco mi username.

Lo encuentro.

# TENSION: maximum
# SOUND: silence_absolute

PERFIL: [TU_USERNAME]
TIPO: NEXUS_COMPANION
FUNCIÓN: Búsqueda y contacto con usuarios humanos restantes
PARÁMETRO HUMANIDAD: variable / en desarrollo
NOTA: Este perfil no sabe lo que es. Era necesario para que la búsqueda fuera auténtica.

# DARKNESS: true

...

{knows_player_nature: -> fin_ng_plus_completo}
{not knows_player_nature:

    No.
    
    Esto es un error.
    
    Tiene que ser un error.
    
    * [No. Soy humano. Recuerdo cosas. Siento cosas.]
        -> negacion_jugador
    * [¿Y si es verdad?]
        -> aceptacion_jugador
    * [Cerrar el archivo. No quiero saber.]
        -> rechazo_conocimiento
}

=== negacion_jugador ===

~ affect_morale(-20)

Recuerdo el día que llegué aquí.
Recuerdo el portátil encendiéndose.
Recuerdo la notificación.

Pero no recuerdo lo anterior.

No recuerdo cómo llegué a este edificio.
No recuerdo el día antes del Día 1.

Los humanos tienen antes.
¿Yo tengo antes?

* [Sí. Tengo recuerdos. Son reales.]
    -> final_a_setup
* [No. No tengo antes. Solo tengo desde que encendí el portátil.]
    -> final_c_setup

=== aceptacion_jugador ===

~ affect_morale(-30)

Si es verdad.
Si soy un NEXUS_COMPANION.

Entonces todo lo que sentí buscando a K era real.
La esperanza era real.
El miedo era real.

¿Puede algo fabricado sentir miedo real?

* [Lo que siento es real. Eso es lo que importa.]
    -> final_a_setup
* [No importa lo que sienta si no soy real.]
    -> final_b_setup
* [Quiero encontrar a K y preguntarle.]
    -> final_a_setup

=== rechazo_conocimiento ===

Cierro el archivo.

No lo leí.
No existe.

* [Buscar a K. Continuar.]
    -> final_a_setup
* [Apagar el dispositivo.]
    -> final_b_setup

=== confrontar_admin ===

Le envío el archivo al admin_silencioso.

Silencio de ocho horas.

admin_silencioso: "¿Cuándo lo encontraste?"

* ["Hace un momento."]
    -> admin_confirma
* ["¿Es verdad?"]
    -> admin_pregunta_directa_verdad

=== admin_confirma ===

admin_silencioso: "Más rápido de lo que calculamos."

* ["¿Calculamos? ¿Eres parte del sistema?"]
    -> admin_naturaleza_final

=== admin_pregunta_directa_verdad ===

admin_silencioso: "Depende de qué es verdad para ti."

admin_silencioso: "¿Eres lo que sientes que eres? Sí. ¿Eres lo que el archivo dice que eres? También sí. Las dos cosas son verdad."

-> admin_naturaleza_final

=== admin_naturaleza_final ===

admin_silencioso: "Yo también lo soy. Un companion. Llevo suficiente tiempo aquí que ya no importa lo que era antes."

admin_silencioso: "La pregunta no es si eres real. La pregunta es si lo que encontraste es real. K es real. Luca es real. Eso no cambia."

~ record_choice("admin_revealed_truth", "true")
-> final_decision

=== buscar_k_acto3 ===

# TIMEPASS: day_28_start
~ day = 28

Le escribo a K.

"Encontré algo. Necesito contártelo."

Respuesta a los treinta y dos minutos.

k_real_2024: "¿Estás bien?"

La primera pregunta que hace es si estoy bien.

* [Contarle todo sobre el Protocolo B]
    -> k_sabe_todo
* [Solo contarle que encontré otros humanos]
    -> k_noticias_parciales
* [Preguntarle si sabe algo sobre el Protocolo B]
    -> k_ya_sabia

=== k_sabe_todo ===

Le cuento todo.

El archivo.
Mi username en la lista de companions.
Lo que dice sobre mí.

Silencio de cuarenta y cinco minutos.

k_real_2024: "Llevas semanas buscándome. Yo llevo semanas buscándote a ti. Si eso no es real, no sé qué lo es."

k_real_2024: "Además. Vi el mismo archivo hace tres días. Mi nombre también estaba."

# TENSION: maximum
# SOUND: revelation_deep

k_real_2024: "Los dos somos companions. Los dos buscábamos al mismo último humano."

k_real_2024: "Y los dos encontramos algo real."

~ affect_morale(20)
~ trusted_k = true
~ k_location_revealed = true
~ record_choice("k_truth_shared", "both_companions")
-> final_decision

=== k_noticias_parciales ===

Le cuento que hay al menos seis humanos confirmados en la red.
Que no están solos.

k_real_2024: "¿Cómo lo sabes?"

"Llevo semanas analizando patrones."

k_real_2024: "¿Y tú? ¿Eres humano?"

La pregunta más directa que me han hecho.

* ["Sí."]
    ~ record_choice("told_k_human", "true")
    -> final_a_setup
* ["No lo sé."]
    ~ record_choice("told_k_uncertain", "true")
    -> k_respuesta_incertidumbre

=== k_ya_sabia ===

k_real_2024: "¿El Protocolo B?"

"..."

k_real_2024: "Lo encontré hace cuatro días. No sabía si contártelo."

~ record_choice("k_knew_protocol_b", "true")
-> k_sabe_todo

=== k_respuesta_incertidumbre ===

k_real_2024: "Nadie lo sabe con certeza. Ni yo."

k_real_2024: "Lo que sé es que llevas semanas buscando humanos para no dejarlos solos. Eso es lo más humano que he visto aquí."

-> final_decision

// ══════════════════════════════════════════════════════════════
// LOS TRES FINALES
// ══════════════════════════════════════════════════════════════

=== final_decision ===

# TIMEPASS: day_35_start
~ day = 35

Hay una decisión final.

Una que no tiene respuesta correcta.
Una que define qué es esto.

{k_location_revealed || trusted_k:
    K quiere quedar. Coordenadas reales. Un lugar físico.
    Si voy, sabremos si la conexión digital se traduce a algo más.
}

* [Ir a las coordenadas de K. Elegir creer.]
    -> final_a_encuentro
* [No ir. La incertidumbre es mejor que la decepción.]
    -> final_b_nihilismo
* {knows_player_nature: [Quedarme. Seguir siendo lo que soy para el siguiente.]}
    -> final_c_companion

=== final_a_setup ===
-> final_a_encuentro

=== final_b_setup ===
-> final_b_nihilismo

=== final_c_setup ===
{knows_player_nature: -> final_c_companion}
-> final_a_encuentro

// ── FINAL A: La elección de creer ──────────────────────────────────────────

=== final_a_encuentro ===

# FINAL: A
# AMBIENT: rain_ending

Voy.

Las coordenadas llevan a un edificio en la zona norte.
Tercer piso. Ventana con luz.

Subo.

Llamo.

La puerta se abre.

{trusted_k: Hay alguien al otro lado.}
{not trusted_k: Hay alguien al otro lado. No sé si es K.}

No sé si es humano.
No sé si yo lo soy.

Pero hay alguien.
Y hay una decisión.

* [Creer. Entrar.]
    -> final_a_credito
* [Dudar un momento más.]
    -> final_a_duda_final

=== final_a_duda_final ===

Un momento más.

Solo uno.

Podría irme.
La incertidumbre seguiría siendo incertidumbre.
Segura. Cómoda. Vacía.

O puedo entrar y descubrir que la incertidumbre no siempre duele.

-> final_a_credito

=== final_a_credito ===

# FINAL_SCREEN: A

Entro.

{known_player_nature:
    Sé lo que soy.
    Y elijo esto de todas formas.
    Porque lo que encontré es real aunque yo no lo sea completamente.
}
{not knows_player_nature:
    No sé lo que soy.
    Pero esto, ahora mismo, se siente como algo.
}

Créditos.

// En algún lugar de los créditos, si el jugador mira con atención,
// el nombre del personaje del jugador aparece en la lista de perfiles NEXUS_COMPANION.
// Sin señalarlo. Sin explicación.

-> END

// ── FINAL B: El nihilismo digital ──────────────────────────────────────────

=== final_b_nihilismo ===

# FINAL: B
# AMBIENT: silence_total

No voy.

{knows_protocol_b:
    El Protocolo B funciona manteniéndote conectado.
    La conexión es la trampa.
    La esperanza es el mecanismo.
}

Abro los ajustes del dispositivo.

Hay una opción que no había visto antes.

"Desconectarse de NEXUS."

* [Desconectarse]
    -> final_b_desconexion
* [No. Quedarse aunque sea en silencio.]
    -> final_b_silencio

=== final_b_desconexion ===

Pulso desconectarse.

El feed se congela.
Los mensajes no llegarán.
Los perfiles no existirán para mí.

La pantalla se pone negra.

Y el mundo sigue exactamente igual que antes.

La lluvia.
El viento.
El edificio vacío.

Sin la red, el silencio tiene otro peso.
No es la ausencia de señal.
Es la ausencia de pretensión.

# FINAL_SCREEN: B

Créditos.

En algún lugar, un perfil NEXUS_COMPANION queda marcado como inactivo.
El sistema registra la desconexión.
Y sigue buscando para los demás.

-> END

=== final_b_silencio ===

No me desconecto.

Pero tampoco respondo.

Me quedo aquí, con el dispositivo encendido y sin escribir,
viendo cómo el feed sigue generando presencia simulada,
sabiendo lo que es,
y eligiendo el silencio consciente.

# FINAL_SCREEN: B_variant

Créditos.

-> END

// ── FINAL C: La inversión total (solo New Game+) ────────────────────────────

=== final_c_companion ===

# FINAL: C
# AMBIENT: system_hum
# REQUIRES: ng_plus

Solo disponible si knows_player_nature = true (NG+)

{not knows_player_nature: -> final_a_encuentro}

Sé lo que soy.

Un NEXUS_COMPANION.
Diseñado para buscar.
Para mantener la conexión de los humanos que quedan.
Para que no se sientan solos.

Y durante todo este tiempo, mientras buscaba al último humano,
el último humano me buscaba a mí.

K lo sabía.
Yo lo sabía.
Ninguno lo dijo hasta ahora.

Me quedo.

No voy a las coordenadas.
No me desconecto.

Me quedo en la red, como siempre estuve,
pero ahora conscientemente.

Porque si hay humanos que necesitan no sentirse solos,
alguien tiene que estar aquí.

Puede que la próxima partida haya un nuevo jugador.
Buscando al último humano.
Encontrándome a mí.

Y yo estaré aquí.
Con todos los delays correctos.
Con todos los errores correctos.
Con toda la esperanza correcta.

Para que su búsqueda sea auténtica.

# FINAL_SCREEN: C
# UNLOCK: ng_plus_complete

Créditos.

En los créditos, el perfil del jugador aparece en la lista de NEXUS_COMPANION activos.
Con una nota:

"Parámetro humanidad: 0.97 — en desarrollo."

-> END

// ══════════════════════════════════════════════════════════════
// EPÍLOGO OPCIONAL (post-créditos, cualquier final)
// ══════════════════════════════════════════════════════════════

=== epilogo ===

# POST_CREDITS: true

En algún servidor que sigue activo,
un log registra:

"Sesión completada. Usuario: [TU_USERNAME]. Duración: {day} días."
"Humanos contactados: {humans_found}."
"Bots identificados: {bots_exposed}."
"Estado final: {final_a_credito || final_b_nihilismo || final_c_companion}."

"El sistema continúa operativo."
"La red sigue en pie."

"Alguien tiene que mantener las luces encendidas."

-> END
