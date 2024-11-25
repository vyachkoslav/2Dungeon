class_name DamageReceiveArea extends Area2D

@export var body: Node
@export var thisAttacker: DamageArea
@export var health: int

signal died
signal health_changed(oldHP: int, newHP: int)

func _area_entered(node: Node2D):
	if(node is DamageArea && node != thisAttacker):
		var old = health
		health -= (node as DamageArea).damage
		if(health <= 0):
			area_entered.disconnect(_area_entered)
			died.emit()
			body.call_deferred("queue_free")
		else:
			health_changed.emit(old, health)

func _ready() -> void:
	area_entered.connect(_area_entered)
