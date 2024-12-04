using Godot;
using System;

public partial class Key : Area2D
{
	[Export] private KeyManager keyManager;
	[Export] private int opensDoorID;

	[Export] private AudioStreamPlayer2D keyPickupSound;
	
	public override void _Ready()
	{
		BodyEntered += OnEntered;
	}

	private void OnEntered(Node2D node)
	{
		if (node is not CharacterBody2D) return;
		keyManager.AddKey(opensDoorID);
		keyPickupSound?.Play();
		Visible = false;
		BodyEntered -= OnEntered;
	}
}
