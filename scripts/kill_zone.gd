extends Area2D

@onready var timer = $Timer
@onready var deadsound = $deadsound

func _on_body_entered(body):
	print("You Died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	deadsound.play()
	timer.start()
	emit_signal("area_entered")
	
func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	
