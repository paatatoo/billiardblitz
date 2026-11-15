extends Node

func play_sound(sound):
	if sound == "Hit":
		$hit.play()
	if sound == "Die":
		$die.play()
