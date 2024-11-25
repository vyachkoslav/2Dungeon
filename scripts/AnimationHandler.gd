class_name AnimationHandler extends Node

@export var animatedSprite: AnimatedSprite2D
@export var body: CharacterBody2D

func jump_animation() -> void:
	animatedSprite.play("jump")
	animatedSprite.play("jump_loop")
	
	
func fall_animation() -> void:
	animatedSprite.play("fall")
	animatedSprite.play("fall_loop")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	body.move_and_slide()
	
	if body.velocity.x > 0:
		animatedSprite.scale.x = 1
		animatedSprite.play("run")
	elif body.velocity.x < 0:
		animatedSprite.scale.x = -1
		animatedSprite.play("run")
	else:
		animatedSprite.play("idle")
		
	if body.velocity.y < 0 and !body.is_on_floor():
		jump_animation()
	elif body.velocity.y > 0 and !body.is_on_floor():
		fall_animation()
