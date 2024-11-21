using Godot;
using System;

public abstract partial class ControlsProvider : Node
{
    public abstract Vector2 Controls { get; }
    public abstract bool WantsToJump { get; }
}
