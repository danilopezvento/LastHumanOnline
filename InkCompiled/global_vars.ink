// ============================================================
// global_vars.ink
// Variables globales compartidas por todos los archivos .ink
// Incluir en cada archivo con: INCLUDE global_vars.ink
// ============================================================

// ── Estado narrativo ────────────────────────────────────────
VAR act = 1                     // Acto actual (1-3)
VAR day = 0                     // Días desde el inicio
VAR morale = 100                // Moral del jugador (0-100)
VAR humans_found = 0            // Humanos confirmados
VAR bots_exposed = 0            // Bots correctamente identificados
VAR wrong_classifications = 0   // Clasificaciones incorrectas

// ── Flags de relaciones ─────────────────────────────────────
VAR met_k = false
VAR trusted_k = false
VAR betrayed_k = false
VAR k_location_revealed = false

VAR met_luca = false
VAR luca_knows_rosa = false
VAR luca_fate = ""              // "found" | "lost" | "unknown"

VAR met_marta = false
VAR marta_location_shared = false
VAR received_marta_supplies = false

VAR met_tomas = false
VAR tomas_lore_received = false

VAR met_eirene = false
VAR eirene_trusted = false
VAR eirene_lore_level = 0      // 0-3: cuánto ha revelado

VAR met_rosa = false
VAR rosa_trap_triggered = false
VAR rosa_true_nature_known = false

VAR met_admin = false
VAR admin_meta_awareness = 0   // 0-3: cuánto sabe el admin de ti

VAR met_nnr = false
VAR nnr_spoke = false
VAR nnr_lore_received = false

// ── Flags de lore ───────────────────────────────────────────
VAR knows_protocol_b = false
VAR knows_event_origin = false
VAR knows_player_nature = false  // Solo NG+

// ── Inventario de decisiones clave ──────────────────────────
VAR shared_location_with = ""    // Con quién compartiste tu ubicación
VAR refused_location_count = 0
VAR trusted_wrong_profile = false

// ── Funciones externas (implementadas en Unity) ─────────────
EXTERNAL affect_morale(delta)
EXTERNAL record_choice(key, value)
EXTERNAL get_memory(key)
EXTERNAL play_sound(event_name)
EXTERNAL set_signal_quality(quality)   // "good" | "poor" | "lost"
