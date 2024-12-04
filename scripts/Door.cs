using Godot;
using System;

public partial class Door : Area2D
{
	[Export] private KeyManager keyManager;
	[Export] private int doorID;
	[Export] private PhysicsBody2D doorPhysicsBody;
	[Export] private Node2D openedDoor;
	[Export] private Node2D closedDoor;
	
	[Export] private AudioStreamPlayer2D openedDoorSound;
	
	public override void _Ready()
	{
		BodyEntered += OnEntered;
	}

	private void OnEntered(Node2D node)
	{
		if (node is not CharacterBody2D) return;
		if (keyManager.HasKeyFor(doorID))
		{
			OpenDoor(node);
			BodyEntered -= OnEntered;
		}
	}

	private void OpenDoor(Node playerNode)
	{
		doorPhysicsBody.Visible = false;
		openedDoor.Visible = true;
		closedDoor.Visible = false;
		doorPhysicsBody.AddCollisionExceptionWith(playerNode);
		openedDoorSound?.Play();
	}
}
