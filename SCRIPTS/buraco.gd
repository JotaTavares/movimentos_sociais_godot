extends Area2D


func desaparecer():
	
	var tween = create_tween()
	
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.3)
	
	await tween.finished
	queue_free() 
