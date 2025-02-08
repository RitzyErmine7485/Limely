extends Control

func _on_rebuild_pressed() -> void:
	take_action(0)

func _on_pet_pressed() -> void:
	take_action(1)

func _on_scold_pressed() -> void:
	take_action(2)

func take_action(action: int) -> void:
	var limely = get_parent().get_node("Limely")
	
	match action:
		0:
			limely.weakness -= 50
		1:
			limely.sadness -= 50
		2: 
			limely.anger -= 50

func _on_quit_pressed() -> void:
	get_parent().save_data()
	get_tree().quit()
