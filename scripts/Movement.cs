using System;
using Godot;

public partial class Movement : Node
{
	[Export] private CharacterBody2D body;
	[Export] private ControlsProvider controls;
	[Export] private float maxSpeed;
	[Export] private float acceleration;
	[Export] private float jumpStrength;
	[Export] private bool turnOffDirectionSwitchInertia;

	private float xControl => controls.Controls.X;

	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = body.Velocity;
		if(xControl == 0)
			velocity.X = Mathf.MoveToward(velocity.X, 0, acceleration * (float)delta);
		else
		{
			if (turnOffDirectionSwitchInertia && Math.Sign(velocity.X) != Math.Sign(xControl))
				velocity.X = 0;
			velocity.X = Mathf.Clamp(velocity.X + (float)(acceleration * delta * xControl), -maxSpeed, maxSpeed);
		}

		if(body.IsOnFloor() && controls.WantsToJump)
		{
			velocity.Y = -jumpStrength;
		}

		velocity += body.GetGravity() * (float)delta;
		body.Velocity = velocity;
	}
}
