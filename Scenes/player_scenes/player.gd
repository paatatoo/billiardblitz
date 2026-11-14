extends RigidBody2D

const TOKEN_ID = "Player"
var slowed = false

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Engine.time_scale = 0.2
		Game.player_state = "focus"
	if Game.player_state == "focus" and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Engine.time_scale = 1
		linear_velocity = position - Game.focus_point
		linear_velocity *= Game.SPEED
		if slowed:
			linear_velocity *= 0.4
		Game.player_state = "idle"
	queue_redraw()

func _draw():
	if Game.player_state == "focus":
		var start_point = Vector2(0, 0)
		var end_point = to_local(get_global_mouse_position())
		var size_limit = (end_point - start_point).limit_length(Game.RANGE)
		end_point = start_point + size_limit
		draw_line(start_point, end_point, Color(Color.WHITE, 0.8), 28)
		Game.focus_point = to_global(end_point)
		
