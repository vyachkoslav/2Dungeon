extends CharacterBody2D
@export var hearts: Array[Node]

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


#Health System

var lives = 3

func decrease_health():
	lives -= 1
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	$AnimatedSprite2D.play("hurt")
	if lives == 0:
		get_tree().reload_current_scene()
