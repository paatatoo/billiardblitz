extends RigidBody2D

@export var Player : RigidBody2D

const TOKEN_ID = "Enemy"
var Health = 5

var shards = preload("res://Scenes/hazard_scenes/glass_shards.tscn")
var direction = 0
var state = "normal"

@onready var shardstimer: Timer = $shardstimer
@onready var move_timer: Timer = $move_timer

func _ready():
	shardstimer.wait_time = randi_range(3, 5)
	shardstimer.start()
	
	move_timer.wait_time = randi_range(2, 4)
	move_timer.start()

func _process(delta: float) -> void:
	
	if state == "move":		
		look_at_player()
			
		var delta_x = cos(deg_to_rad(direction))
		var delta_y = sin(deg_to_rad(direction))
		
		position.x += delta_x * 50 * delta
		position.y += delta_y * 50 * delta

func look_at_player():
	direction = atan2((position.y - Player.position.y), (position.x - Player.position.x))
	direction = 180 + round((direction * 180/PI))

func _on_body_entered(body: Node) -> void:
	if body.TOKEN_ID == "Player" :
		print(body.linear_velocity.length())
	if body.TOKEN_ID == "Player" and body.linear_velocity.length() > 200:
		lose_health(1)
		state = "normal"
		$hit.play()
		Game.hit_stop(0.1)


func _on_body_exited(body: Node) -> void:
	pass # Replace with function body.

func lose_health(damage):
	Health -= Game.ATK_POWER
	$HPCounter.text = str(Health)
	if Health <= 0:
		queue_free()

func _on_shardstimer_timeout() -> void:
	var new_shards = shards.instantiate()
	new_shards.position = position
	$"..".add_child(new_shards)

func _on_move_timer_timeout() -> void:
	state = "move"
