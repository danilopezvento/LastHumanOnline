using UnityEngine;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

public class SaveSystem : MonoBehaviour
{
    private const string KEY  = "LHO_AES_KEY_32CH"; "cm">// 32 chars exactos
    private string savePath  => Path.Combine(Application.persistentDataPath, "save.lho");

    private SaveData current = new();

    public async Task LoadAsync()
    {
        if (!File.Exists(savePath)) return;
        try
        {
            string encrypted = await File.ReadAllTextAsync(savePath);
            string json      = Decrypt(encrypted);
            current = JsonConvert.DeserializeObject(json) ?? new();
        }
        catch { current = new(); }
    }

    public async void SaveAsync()
    {
        try
        {
            current.timestamp = System.DateTime.UtcNow.ToString("o");
            string json      = JsonConvert.SerializeObject(current, Formatting.None);
            string encrypted = Encrypt(json);
            await File.WriteAllTextAsync(savePath, encrypted);
        }
        catch (System.Exception e) { Debug.LogError($"Save failed: {e.Message}"); }
    }

    public T Get(string key, T fallback = default)
    {
        if (current.data.TryGetValue(key, out var val))
            return JsonConvert.DeserializeObject(val.ToString());
        return fallback;
    }

    public void Set(string key, object value) => current.data[key] = value;

    private string Encrypt(string plain)
    {
        using var aes = Aes.Create();
        aes.Key = Encoding.UTF8.GetBytes(KEY);
        aes.GenerateIV();
        using var enc = aes.CreateEncryptor();
        var bytes  = Encoding.UTF8.GetBytes(plain);
        var result = enc.TransformFinalBlock(bytes, 0, bytes.Length);
        return System.Convert.ToBase64String(aes.IV) + "|" + System.Convert.ToBase64String(result);
    }

    private string Decrypt(string cipher)
    {
        var parts = cipher.Split(''|'');
        using var aes = Aes.Create();
        aes.Key = Encoding.UTF8.GetBytes(KEY);
        aes.IV  = System.Convert.FromBase64String(parts[0]);
        using var dec = aes.CreateDecryptor();
        var bytes  = System.Convert.FromBase64String(parts[1]);
        var result = dec.TransformFinalBlock(bytes, 0, bytes.Length);
        return Encoding.UTF8.GetString(result);
    }
}

[System.Serializable]
public class SaveData
{
    public string timestamp;
    public System.Collections.Generic.Dictionary data = new();
}
