using Godot;
using System;

public partial class Key : Area2D
{
	[Export] private KeyManager keyManager;
	[Export] private int opensDoorID;
	
	public override void _Ready()
	{
		BodyEntered += OnEntered;
	}

	private void OnEntered(Node2D node)
	{
		if (node is not CharacterBody2D) return;
		keyManager.AddKey(opensDoorID);
		Visible = false;
		BodyEntered -= OnEntered;
	}
}
