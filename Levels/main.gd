extends Node2D

@onready var intro: AudioStreamPlayer = $intro
@onready var loop: AudioStreamPlayer = $loop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	intro.play()

func _on_intro_finished() -> void:
	loop.play()
