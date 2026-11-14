extends CanvasLayer


func _process(delta: float) -> void:
	$HPBar.value = Game.HEALTH
	$STAMINABar.value = Game.STAMINA
