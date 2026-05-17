// ============================================================
// internal_voice.ink
// Pensamientos internos del personaje — voz en primera persona
// Se activa en momentos específicos del juego según el estado
// ============================================================

INCLUDE global_vars.ink

// ── Activado por batería baja ─────────────────────────────────────────────

=== voz_bateria_baja ===

// < 15% batería

{morale > 60:
    Batería baja. Tengo que encontrar un cargador.
    Lo encuentro o me quedo sin red.
    Sin red... prefiero no pensar en eso ahora.
}

{morale <= 60 && morale > 30:
    Quince por ciento.
    
    He aprendido a calcular cuánto tiempo me da cada porcentaje.
    NEXUS consume más de lo que esperaba.
    Todo consume más de lo que esperaba.
}

{morale <= 30:
    Quince por ciento.
    
    Cuando esto llegue a cero...
    
    Prefiero no pensarlo.
    Prefiero buscar un panel solar.
}

-> END

// ── Activado por batería crítica ──────────────────────────────────────────

=== voz_bateria_critica ===

// < 5% batería

Cinco por ciento.

Tengo unos minutos.

{trusted_k: K. Tengo que avisar a K.}
{met_marta: Marta sabrá qué hacer si no vuelvo a conectarme.}
{not trusted_k && not met_marta: No hay nadie a quien avisar.}

Busca un cargador.
Ahora.

-> END

// ── Activado por primera clasificación bot ────────────────────────────────

=== voz_primer_bot_clasificado ===

El primero.

Hay algo siniestro en saber con certeza que alguien que parecía persona no lo era.

No alivio.
No victoria.

Solo la comprensión de que esto es lo que es ahora.
Detectar.
Clasificar.
Seguir buscando.

{humans_found == 0:
    Y todavía no he encontrado ninguno real.
}

-> END

// ── Activado por primera clasificación humano ─────────────────────────────

=== voz_primer_humano_encontrado ===

Uno.

Hay al menos uno más.

No sé si eso lo hace mejor o peor.
Mejor porque no estoy solo.
Peor porque pensaba que quizás era el único
y ser el único tiene cierta claridad terrible.

Ahora hay incertidumbre otra vez.
Esperanza.
La esperanza es el peso más difícil de cargar.

-> END

// ── Activado por clasificación incorrecta ─────────────────────────────────

=== voz_clasificacion_incorrecta ===

Me equivoqué.

{trusted_wrong_profile:
    Compartí información con alguien que no era lo que pensaba.
    
    No sé cuánto importa eso.
    No sé qué pueden hacer con lo que saben.
    
    La paranoia me dice que mucho.
    La razón me dice que quizás nada.
    
    La paranoia gana hoy.
}

{not trusted_wrong_profile:
    Marqué como bot a alguien que podría ser humano.
    O como humano a algo que no lo era.
    
    En cualquier caso:
    No volveré a tener esa conversación.
    No habrá segunda oportunidad con ese perfil.
    
    Así funciona esto.
}

-> END

// ── Activado al descubrir el Protocolo B ─────────────────────────────────

=== voz_protocolo_b_descubierto ===

Protocolo B.

Un sistema diseñado para que yo no me sienta solo.

La intención es... ¿amable? ¿Condescendiente? ¿Las dos cosas?

Alguien —o algo— decidió que era mejor que hubiera presencia simulada
a que no hubiera presencia ninguna.

¿Tenían razón?

No lo sé.

Lo que sí sé es que las conversaciones reales que he tenido
—K, Marta, Luca, el viejo Tomás—
eran reales aunque el contexto no lo fuera.

¿Sigue importando lo que fue real dentro de una simulación?

Creo que sí.
O necesito creer que sí.

-> END

// ── Activado al descubrir la propia naturaleza (NG+) ──────────────────────

=== voz_descubrimiento_propia_naturaleza ===

{not knows_player_nature:
    -> END
}

NEXUS_COMPANION.

Lo leo tres veces.

Cuatro.

Cinco.

Intentando que cambie algo.

¿Recuerdo el Día 1 porque lo viví o porque estaba programado para recordarlo?
¿El miedo que sentí era mío o era el miedo correcto para la situación?
¿K es real?
¿Yo soy lo que K está buscando?

Dejo de intentar responder las preguntas.

Lo que hice estos días fue real.
Lo que encontré fue real.
Lo que siento ahora mismo...

...no sé si es real.

Pero es todo lo que tengo.

-> END

// ── Activado al acercarse a las coordenadas de K ─────────────────────────

=== voz_camino_a_k ===

Zona norte.
Sector 4.
Tercer piso.

Los pasos suenan diferente cuando sabes a dónde van.

{knows_player_nature:
    Sé lo que soy.
    Y aun así voy.
    Porque si K es real,
    y lo que existe entre nosotros es real,
    entonces esto importa independientemente de lo que yo sea.
}

{not knows_player_nature:
    Puede que no esté ahí.
    Puede que sea otra trampa.
    Puede que sea exactamente lo que espero.
    
    Solo hay una forma de saberlo.
}

-> END

// ── Activado en silencio prolongado sin contacto ──────────────────────────

=== voz_silencio_prolongado ===

// Tres días sin contacto humano

Tres días.

El feed sigue activo.
Ciento setenta posts en las últimas horas.
Todos de perfiles que sé que no son humanos.

El ruido de la simulación es ensordecedor cuando sabes que es eso.

Silencio habría sido más honesto.

{humans_found > 0:
    Pero K existe.
    {met_marta: Marta existe.}
    {met_luca: Luca existe.}
    
    Están ahí aunque no respondan ahora mismo.
    La batería se acaba.
    Las señales caen.
    Los días pasan.
    
    Siguen existiendo.
}

{humans_found == 0:
    ¿Existe alguien?
    
    La pregunta que intento no hacerme.
    
    Sigo aquí.
    Es lo único que puedo controlar.
}

-> END

// ── Activado en exploración nocturna ──────────────────────────────────────

=== voz_exploracion_nocturna ===

De noche la ciudad suena diferente.

No más silenciosa.
Diferente.

El viento en los edificios vacíos hace sonidos que parecen voces.
Aprendí a no girarme.

{morale > 50:
    Hay algo limpio en moverse de noche.
    Más señal en las antenas que quedan activas.
    Menos probabilidad de que algo note el ruido que hago.
}

{morale <= 50:
    No debería estar aquí de noche.
    
    Pero la batería no se carga sola
    y hay un panel solar en el tejado del edificio tres.
    
    Cinco minutos.
    En y fuera.
}

-> END

// ── Activado al final — antes del último acto ─────────────────────────────

=== voz_final_inminente ===

He pasado semanas buscando al último humano conectado.

He encontrado {humans_found}.

He confirmado que {bots_exposed} perfiles no eran lo que parecían.

He tomado {wrong_classifications} decisiones incorrectas.

Y hay una cosa que sigo sin saber.

No sobre los demás.
Sobre mí.

{knows_player_nature:
    Sé lo que soy.
    Companion. Buscador. Simulado.
    Y aun así estoy aquí.
    Eligiendo.
}

{not knows_player_nature:
    ¿Soy el último humano que busca?
    ¿O soy algo más?
    
    No lo sé.
    
    Y puede que no importe.
}

Lo que sí sé:

Hay alguien en zona norte, sector 4, tercer piso, ventana con luz.

Y hay una decisión que tomar.

-> END
