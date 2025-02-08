extends Node2D

@onready var limely = get_node("Limely")

func _ready() -> void:
	get_node("GameOver").hide()
	get_tree().paused = false
	load_data()

func _process(_delta: float) -> void:
	bars()

func load_data() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var stats = json.data
		
		limely.load_stats(stats)

func bars() -> void:
	var weakness_bar = get_node("MainScreen/MarginContainer/VBoxContainer/Slides/Weakness")
	var sadness_bar = get_node("MainScreen/MarginContainer/VBoxContainer/Slides/Sadness")
	var anger_bar = get_node("MainScreen/MarginContainer/VBoxContainer/Slides/Anger")
	
	weakness_bar.value = 100 - limely.weakness
	sadness_bar.value = 100 - limely.sadness
	anger_bar.value = 100 - limely.anger

func game_over() -> void:
	delete_data()
	get_node("GameOver").show()

func save_data()  -> void:
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var stats = limely.save()
	var json_string = JSON.stringify(stats)
	
	save_file.store_line(json_string)

func delete_data()  -> void:
	get_tree().paused = true
	
	limely.weakness = 0
	limely.sadness = 0
	limely.anger = 0
	
	save_data()
