using Godot;

public partial class PlayerMovement : Node
{
	private static readonly StringName ForwardAction = "forward";
	private static readonly StringName BackAction = "back";
	private static readonly StringName JumpAction = "jump";
	
	[Export] private CharacterBody2D playerBody;
	[Export] private float maxSpeed;
	[Export] private float acceleration;
	[Export] private float jumpStrength;

	private int xControl;

    public override void _PhysicsProcess(double delta)
    {
		Vector2 velocity = playerBody.Velocity;
		if(xControl == 0)
			velocity.X = Mathf.MoveToward(velocity.X, 0, acceleration * (float)delta);
		else
			velocity.X = Mathf.Clamp(velocity.X + (float)(acceleration * delta * xControl), -maxSpeed, maxSpeed);

		if(playerBody.IsOnFloor() && Input.IsActionJustPressed(JumpAction))
		{
			velocity.Y = -jumpStrength;
		}

	    velocity += playerBody.GetGravity() * (float)delta;
		playerBody.Velocity = velocity;
    }

	public override void _UnhandledInput(InputEvent @event)
	{
	    if (@event.IsActionPressed(ForwardAction))
		{
			xControl = 1;
		}
		else if (@event.IsActionPressed(BackAction))
		{
			xControl = -1;
		}
		else if (xControl == 1 && @event.IsActionReleased(ForwardAction))
		{
			xControl = 0;
		}
		else if (xControl == -1 && @event.IsActionReleased(BackAction))
		{
			xControl = 0;
		}
	}
}
