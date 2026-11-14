extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.TOKEN_ID == "Player" or body.TOKEN_ID == "Enemy":
		body.linear_velocity *= 0.4
		if body.TOKEN_ID == "Player":
			body.slowed = true

func _on_body_exited(body: Node2D) -> void:
	if body.TOKEN_ID == "Player" or body.TOKEN_ID == "Enemy":
		body.linear_velocity /= 0.4
		if body.TOKEN_ID == "Player":
			body.slowed = false
