extends RigidBody2D

const TOKEN_ID = "Enemy"
var Health = 5

func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Player":
		lose_health(1)


func _on_body_exited(body: Node) -> void:
	pass # Replace with function body.

func lose_health(damage):
	Health -= Game.ATK_POWER
	$HPCounter.text = str(Health)
	if Health <= 0:
		queue_free()
