using Godot;
using System.Linq;

public partial class WaypointedAIControlsProvider : ControlsProvider
{
    public override Vector2 Controls => direction;
    public override bool WantsToJump => false;

	[Export] private Node2D body;
	[Export] private Node waypointsParent;
	[Export] private bool alignWithX;
	[Export] private bool alignWithY;

	private Node2D[] waypoints;
	private int currentWaypoint;
	private Vector2 direction;
	private Node2D currentWaypointNode => waypoints[currentWaypoint];

    public override void _Ready()
    {
	    waypoints = waypointsParent.GetChildren().Select((x) => x as Node2D).ToArray();
        CalculateDirection();
    }

    public override void _Process(double delta)
	{
		bool xAligned = alignWithX && Mathf.Sign(currentWaypointNode.GlobalPosition.X - body.GlobalPosition.X) != Mathf.Sign(direction.X);
		bool yAligned = alignWithY && Mathf.Sign(currentWaypointNode.GlobalPosition.Y - body.GlobalPosition.Y) != Mathf.Sign(direction.Y);
		
		if(xAligned == alignWithX && yAligned == alignWithY)
		{
			currentWaypoint = (currentWaypoint + 1) % waypoints.Length;
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
