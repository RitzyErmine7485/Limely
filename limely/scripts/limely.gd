extends Node2D

@onready var sprite: Sprite2D = $Sprite

@export var weakness: int
@export var sadness: int
@export var anger: int

func _process(_delta: float) -> void:
	check_state()

func _on_timer_timeout() -> void:
	if weakness < 100 && sadness < 100 && anger < 100:
		gameplay()

func check_state() -> void:
	if weakness < 0: weakness = 0
	if sadness < 0: sadness = 0
	if anger < 0: anger = 0
	
	if weakness < 50 && sadness < 50 && anger < 50:
		sprite.texture = load("res://assets/limely_base.png")
		
	if weakness >= 50:
		sprite.texture = load("res://assets/limely_smol.png")
	if sadness >= 50:
		sprite.texture = load("res://assets/limely_sad.png")
	if anger >= 50:
		sprite.texture = load("res://assets/limely_angy.png")
		
	if weakness >= 100:
		sprite.texture = load("res://assets/limely_melted.png")
	if sadness >= 100:
		sprite.texture = load("res://assets/limely_depressed.png")
	if anger >= 100:
		sprite.texture = load("res://assets/limely_furious.png")
	
	if weakness >= 100 || sadness >= 100 || anger >= 100:
		get_parent().game_over()

func gameplay() -> void:
	var stat = randi_range(0, 2)
	
	match stat:
		0:
			weakness += randi_range(0,10)
		1:
			sadness += randi_range(0,10)
		2:
			anger += randi_range(0,10)

func save() -> Dictionary:
	var stats_dict= {"weakness" : weakness, "sadness" : sadness, "anger" : anger}
	return stats_dict

func load_stats(stats) -> void:
	weakness = stats["weakness"]
	sadness = stats["sadness"]
	anger = stats["anger"]
