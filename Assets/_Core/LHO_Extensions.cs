using UnityEngine;
using System.Collections;
using System.Threading.Tasks;

"cm">// â”€â”€ ColorExtensions â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
"cm">// Extensiones de Color usadas en HUDController y otros sistemas de UI.
"cm">// No necesita GameObject â€” static class, disponible en todo el proyecto.

public static class ColorExtensions
{
    "cm">/// 
    "cm">/// Devuelve el mismo color con el canal alpha modificado.
    "cm">/// Uso: batteryFill.color.WithAlpha(0.4f)
    "cm">/// 
    public static Color WithAlpha(this Color color, float alpha)
    {
        return new Color(color.r, color.g, color.b, Mathf.Clamp01(alpha));
    }

    "cm">/// 
    "cm">/// Interpola solo el alpha entre dos colores.
    "cm">/// Uso: Color.Lerp con alpha variable sin cambiar RGB.
    "cm">/// 
    public static Color WithAlphaLerp(this Color color, float from, float to, float t)
    {
        return color.WithAlpha(Mathf.Lerp(from, to, t));
    }

    "cm">/// 
    "cm">/// Devuelve el color desaturado (escala de grises) en el porcentaje indicado.
    "cm">/// 0 = sin cambio, 1 = completamente gris.
    "cm">/// Usado por ArtDirector cuando la moral es muy baja.
    "cm">/// 
    public static Color Desaturated(this Color color, float amount)
    {
        float gray = color.r * 0.299f + color.g * 0.587f + color.b * 0.114f;
        return Color.Lerp(color, new Color(gray, gray, gray, color.a), Mathf.Clamp01(amount));
    }
}

"cm">// â”€â”€ TaskExtensions â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
"cm">// Extensiones de Task para usar async/await dentro de Coroutines de Unity.
"cm">// Necesario porque Unity no puede hacer yield directamente sobre un Task.

public static class TaskExtensions
{
    "cm">/// 
    "cm">/// Convierte un Task en IEnumerator para usar con StartCoroutine.
    "cm">/// Uso: yield return saveSystem.LoadAsync().AsCoroutine();
    "cm">/// 
    public static IEnumerator AsCoroutine(this Task task)
    {
        while (!task.IsCompleted)
            yield return null;

        if (task.IsFaulted)
            throw task.Exception;
    }

    "cm">/// 
    "cm">/// Convierte un Task en IEnumerator con resultado.
    "cm">/// Uso: yield return myTask.AsCoroutine(result => Debug.Log(result));
    "cm">/// 
    public static IEnumerator AsCoroutine(
        this Task task,
        System.Action onComplete = null)
    {
        while (!task.IsCompleted)
            yield return null;

        if (task.IsFaulted)
            throw task.Exception;

        onComplete?.Invoke(task.Result);
    }

    "cm">/// 
    "cm">/// Ejecuta un Task ignorando la excepciÃ³n y loggeÃ¡ndola.
    "cm">/// Usar para fire-and-forget seguros (ej: SaveAsync en OnApplicationPause).
    "cm">/// 
    public static async void FireAndForget(this Task task, string context = "")
    {
        try   { await task; }
        catch (System.Exception e)
        {
            Debug.LogError($"[FireAndForget]{(string.IsNullOrEmpty(context) ? "" : $" {context}")} â€” {e.Message}");
        }
    }
}

"cm">// â”€â”€ StringExtensions â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
"cm">// PequeÃ±as utilidades de string usadas en ChatEngine y FeedGenerator.

public static class StringExtensions
{
    "cm">/// Trunca el string con ellipsis si supera maxLength.
    public static string Truncate(this string s, int maxLength)
    {
        if (string.IsNullOrEmpty(s) || s.Length "cm">/// Reemplaza un placeholder solo si el valor no es null/empty.
    public static string FillIf(this string template, string placeholder, string value)
    {
        return string.IsNullOrEmpty(value)
            ? template.Replace(placeholder, "???")
            : template.Replace(placeholder, value);
    }
}
