extends RigidBody2D

@export var Player : RigidBody2D
const TOKEN_ID = "Enemy"
var state = "idle"
var Health = 3

func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Player":
		lose_health(1)
	if state == "ram":
		state = "idle"

func _on_body_exited(body: Node) -> void:
	pass # Replace with function body.

func lose_health(damage):
	Health -= Game.ATK_POWER
	$HPCounter.text = str(Health)
	if Health <= 0:
		queue_free()


func _on_timer_timeout() -> void:
	state = "wind"
	$RamTimer.start()


func _on_ram_timer_timeout() -> void:
	$AnimationPlayer.play("flicker")
	
	state = "ram"
