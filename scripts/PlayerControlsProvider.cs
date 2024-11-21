using Godot;
using System;

public partial class PlayerControlsProvider : ControlsProvider
{
	private static readonly StringName ForwardAction = "forward";
	private static readonly StringName BackAction = "back";
	private static readonly StringName JumpAction = "jump";

	private Vector2 controls;
	public override Vector2 Controls => controls;
	
    public override bool WantsToJump { 
		get {
			return Input.IsActionJustPressed(JumpAction);
		}
	}

	public override void _UnhandledInput(InputEvent @event)
	{
		if (@event.IsActionPressed(ForwardAction))
		{
			controls.X = 1;
		}
		else if (@event.IsActionPressed(BackAction))
		{
			controls.X = -1;
		}
		else if (controls.X == 1 && @event.IsActionReleased(ForwardAction))
		{
			controls.X = 0;
		}
		else if (controls.X == -1 && @event.IsActionReleased(BackAction))
		{
			controls.X = 0;
		}
	}
}
