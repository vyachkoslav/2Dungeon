extends CharacterBody2D

#Animations

func jump_animation() -> void:
	$AnimatedSprite2D.play("jump")
	$AnimatedSprite2D.play("jump_loop")
	
	
func fall_animation() -> void:
	$AnimatedSprite2D.play("fall")
	$AnimatedSprite2D.play("fall_loop")
	

func _process(_delta: float) -> void:
	move_and_slide()
	
	if velocity.x > 0:
		$AnimatedSprite2D.scale.x = 1
		$AnimatedSprite2D.play("run")
	elif velocity.x < 0:
		$AnimatedSprite2D.scale.x = -1
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
		
	if velocity.y < 0 and !is_on_floor():
		jump_animation()
	elif velocity.y > 0 and !is_on_floor():
		fall_animation()
		
