extends CanvasLayer

@onready var winning_score: Label = $VBoxContainer/MarginContainer/VSplitContainer/WinningSettings/WinningScore
@onready var lower_score_button: Button = $VBoxContainer/MarginContainer/VSplitContainer/WinningSettings/LowerScore
@onready var higher_score_button: Button = $VBoxContainer/MarginContainer/VSplitContainer/WinningSettings/HigherScore
@onready var color_one: Label = $VBoxContainer/ColorSettings/ColorLabelOne
@onready var color_two: Label = $VBoxContainer/ColorSettings/ColorLabelTwo
@onready var switch_players_button: Button = $VBoxContainer/PlayerSettings/SwitchPlayers
@onready var player_settings: HBoxContainer = $VBoxContainer/PlayerSettings
var player_one_tag: PackedScene = preload("res://scenes/ui/player_one_tag.tscn")
var player_two_tag: PackedScene = preload("res://scenes/ui/player_two_tag.tscn")
var blue: Color = Color("00ffff")
var red: Color = Color("ff0000")


func _ready():
	update_players()
	update_colors()
	update_winning_score()


func _on_switch_players_pressed():
	Globals.players_switched = not Globals.players_switched
	update_players()


func _on_switch_color_pressed():
	Globals.colors_switched = not Globals.colors_switched
	update_colors()
	
func update_colors():
	if not Globals.colors_switched:
		color_one.text = "BLUE"
		color_one.modulate = blue
		color_two.text = "RED"
		color_two.modulate = red
	else:
		color_one.text = "RED"
		color_one.modulate = red
		color_two.text = "BLUE"
		color_two.modulate = blue

func update_players():
	for child in player_settings.get_children():
		if child != switch_players_button:
			child.queue_free()
	var lower_element: Node
	var upper_element: Node
	if Globals.players_switched:
		lower_element = player_one_tag.instantiate()
		upper_element = player_two_tag.instantiate()
	else:
		lower_element = player_two_tag.instantiate()
		upper_element = player_one_tag.instantiate()
		
	var reference_index = switch_players_button.get_index()
	player_settings.add_child(lower_element)
	player_settings.add_child(upper_element)
	player_settings.move_child(upper_element, reference_index + 1)
	player_settings.move_child(lower_element, reference_index)

func update_winning_score():
	winning_score.text = str(Globals.winning_score)

func _on_lower_score_pressed():
	if Globals.winning_score > 1:
		Globals.winning_score -= 1
		update_winning_score()

func _on_higher_score_pressed():
	if Globals.winning_score < 25:
		Globals.winning_score += 1
		update_winning_score()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
