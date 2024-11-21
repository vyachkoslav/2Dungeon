using Godot;
using System;

public partial class WaypointedAIControlsProvider : ControlsProvider
{
    public override Vector2 Controls => direction;
    public override bool WantsToJump => false;

	[Export] private Node2D body;
	[Export] private Godot.Collections.Array<Node2D> waypoints;
	[Export] private bool alignWithX;
	[Export] private bool alignWithY;

	private int currentWaypoint = 0;
	private Vector2 direction;
	private Node2D currentWaypointNode => waypoints[currentWaypoint];

    public override void _Ready()
    {
        CalculateDirection();
    }

    public override void _Process(double delta)
	{
		bool xAligned = alignWithX && Mathf.Sign(currentWaypointNode.GlobalPosition.X - body.GlobalPosition.X) != Mathf.Sign(direction.X);
		bool yAligned = alignWithY && Mathf.Sign(currentWaypointNode.GlobalPosition.Y - body.GlobalPosition.Y) != Mathf.Sign(direction.Y);
		
		if(xAligned == alignWithX && yAligned == alignWithY)
		{
			currentWaypoint = (currentWaypoint + 1) % waypoints.Count;
			CalculateDirection();
		}
	}

	private void CalculateDirection()
	{
		if(alignWithX == false && alignWithY == false)
		{
			direction = Vector2.Zero;
			return;
		}

		direction = currentWaypointNode.GlobalPosition - body.GlobalPosition;
		if(alignWithX != alignWithY)
		{
			if(alignWithX)
			{
				direction.Y = 0;
				direction.X = Mathf.Sign(direction.X);
			}
			else
			{
				direction.X = 0;
				direction.Y = Mathf.Sign(direction.Y);
			}
		}
		else
			direction = direction.Normalized();
	}
}
