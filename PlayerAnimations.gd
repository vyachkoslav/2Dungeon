extends CharacterBody2D

func _jumpanimation() -> void:
	$AnimatedSprite2D.play("jump")
	$AnimatedSprite2D.play("jump_loop")
	
	
func _fallanimation() -> void:
	$AnimatedSprite2D.play("fall")
	$AnimatedSprite2D.play("fall_loop")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if velocity.x > 0:
		$AnimatedSprite2D.scale.x = 1
		$AnimatedSprite2D.play("run")
	elif velocity.x < 0:
		$AnimatedSprite2D.scale.x = -1
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
		
	if velocity.y < 0 and !is_on_floor():
		_jumpanimation()
	elif velocity.y > 0 and !is_on_floor():
		_fallanimation()
