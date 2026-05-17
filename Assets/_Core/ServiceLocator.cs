using System;
using System.Collections.Generic;

public static class ServiceLocator
{
    private static readonly Dictionary services = new();

    public static void Register(T service) where T : class
        => services[typeof(T)] = service;

    public static T Get() where T : class
    {
        if (services.TryGetValue(typeof(T), out var s)) return (T)s;
        throw new InvalidOperationException($"Service {typeof(T).Name} not registered");
    }

    public static bool TryGet(out T service) where T : class
    {
        if (services.TryGetValue(typeof(T), out var s)) { service = (T)s; return true; }
        service = null; return false;
    }

    public static void Clear() => services.Clear();
}

"cm">// Uso:
"cm">// ServiceLocator.Register(rm);
"cm">// var rm = ServiceLocator.Get();
