extends RigidBody2D

@export var Player : RigidBody2D
const TOKEN_ID = "Enemy"
var state = "idle"
var direction = 0
var Health = 3

func look_at_player():
	direction = atan2((position.y - Player.position.y), (position.x - Player.position.x))
	direction = 180 + round((direction * 180/PI))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == "wind":
		var delta_x = cos(deg_to_rad(direction))
		var delta_y = sin(deg_to_rad(direction))

		position.x -= delta_x * 70 * delta
		position.y -= delta_y * 70 * delta
		
func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Player" and state != "ram" and body.linear_velocity.length() > 200:
		$hit.play()
		lose_health(1)
		Game.hit_stop(0.1)
		
	if state == "ram" and body.TOKEN_ID == "Player":
		$AnimationPlayer.play("RESET")
		$RushTimer.stop()
		state = "idle"
		Game.lose_health(30)
		$IdleTimer.start()
		

func _on_body_exited(body: Node) -> void:
	pass # Replace with function body.

func lose_health(damage):
	Health -= Game.ATK_POWER
	$HPCounter.text = str(Health)
	if Health <= 0:
		queue_free()


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("flicker")
	state = "wind"
	look_at_player()
	$WindTimer.start()


func _on_ram_timer_timeout() -> void:
	look_at_player()
	var delta_x = cos(deg_to_rad(direction))
	var delta_y = sin(deg_to_rad(direction))
	linear_velocity = Vector2(delta_x * 600, delta_y * 600)
	$RushTimer.start()
	state = "ram"


func _on_rush_timer_timeout() -> void:
	$AnimationPlayer.play("RESET")
	state = "idle"
	$IdleTimer.start()
