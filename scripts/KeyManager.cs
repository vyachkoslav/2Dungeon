using Godot;
using System;
using System.Collections.Generic;

[GlobalClass]
public partial class KeyManager : Node
{
    [Signal]
    public delegate void NewKeyEventHandler(int id);
    
    private List<int> keys = new List<int>();
    public void AddKey(int id)
    {
        if (!keys.Contains(id))
        {
            keys.Add(id);
            EmitSignal(SignalName.NewKey, id);
        }
    }
    public bool HasKeyFor(int doorID)
    {
        return keys.Contains(doorID);
    }
}
