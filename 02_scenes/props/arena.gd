extends Node3D

@onready var arena_area = $Geo_Arena/ArenaArea

func _on_arena_area_body_exited(body):
	if body.is_in_group("player"):
		print("GAME OVER")
	else:
		if body.is_in_group("enemies"):
			print(str(body) + " was deleted")
			body.queue_free()
