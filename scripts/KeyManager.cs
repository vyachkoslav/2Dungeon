using Godot;
using System;
using System.Collections.Generic;

public partial class KeyManager : Node
{
    private List<int> keys = new List<int>();
    public void AddKey(int id)
    {
        if(!keys.Contains(id))
            keys.Add(id);
    }
    public bool HasKeyFor(int doorID)
    {
        return keys.Contains(doorID);
    }
}
