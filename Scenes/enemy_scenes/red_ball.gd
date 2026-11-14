extends RigidBody2D

@export var Player : RigidBody2D
const TOKEN_ID = "Enemy"
var state = "idle"
var direction = 0
var Health = 3

func _ready() -> void:
	look_at_player()

func look_at_player():
	direction = atan2((position.y - Player.position.y), (position.x - Player.position.x))
	direction = 180 + round((direction * 180/PI))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var delta_x = cos(deg_to_rad(direction))
	var delta_y = sin(deg_to_rad(direction))

	position.x += delta_x * 50 * delta
	position.y += delta_y * 50 * delta

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
