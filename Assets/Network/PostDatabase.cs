using UnityEngine;
using System.Collections.Generic;

[CreateAssetMenu(fileName = "PostDatabase", menuName = "LHO/PostDatabase")]
public class PostDatabase : ScriptableObject
{
    [Header("Bot posts â€” perturbadores por su normalidad")]
    [TextArea(2,4)] public List botPostTemplates = new()
    {
        "Â¡Buenos dÃ­as! El clima de hoy es perfecto para un paseo.",
        "Recuerda: mantenerse hidratado es importante para tu salud.",
        "Â¿SabÃ­as que el 73% de las personas prefieren el cafÃ© por la maÃ±ana?",
        "Los mejores momentos son los que compartimos con otros. ðŸ˜Š",
    };

    [Header("Human posts â€” crudos, con miedo real")]
    [TextArea(2,4)] public List humanPostTemplates = new()
    {
        "DÃ­a {day} sin ver a nadie. El generador aguantÃ³ esta noche.",
        "Si alguien lee esto... responde por favor.",
        "EncontrÃ© comida en el tercer piso. DejÃ© la mitad para quien venga.",
        "No sÃ© si esto llega a algÃºn sitio real. Necesito saber que no estoy solo.",
        "Hay seÃ±al en el tejado de {city}. Intentad llegar.",
    };

    [Header("Lore posts â€” revelan quÃ© pasÃ³")]
    [TextArea(2,4)] public List loreTemplates = new()
    {
        "Sistema NEXUS v2.1 â€” mantenimiento automÃ¡tico completado.",
        "Alerta: se detectÃ³ actividad de usuario en zona {city}. Registrando.",
        "Protocolo {day}-B iniciado. IndexaciÃ³n de perfiles activos en curso.",
        "Red estable. Usuarios conectados: {count}. Verificados: ???",
    };

    [Header("Word pools")]
    public List adjectives = new() { "silent","dark","lost","broken","last","empty","real","ghost","echo","void" };
    public List nouns      = new() { "signal","human","node","trace","user","mind","wave","link","data","soul" };
    public List cities     = new() { "zona_norte","distrito_7","bloque_sur","sector_9","periferia" };

    [TextArea(1,3)] public List humanBioTemplates = new()
    {
        "Superviviente desde {year}. {city}. Si eres real, escrÃ­beme.",
        "AquÃ­ desde el principio. Buscando seÃ±ales de vida.",
        "No soy un bot. Por favor, tampoco tÃº.",
    };
    [TextArea(1,3)] public List botBioTemplates = new()
    {
        "Apasionado del bienestar y la productividad. ðŸ“ˆ",
        "Compartiendo contenido positivo cada dÃ­a.",
        "Cuenta oficial de informaciÃ³n y actualizaciones.",
    };
}
