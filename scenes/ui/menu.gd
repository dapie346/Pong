extends CanvasLayer

@onready var main_menu: VBoxContainer = $MainMenu
@onready var game_mode_menu: VSplitContainer = $GameModeMenu


func _ready():
	UISounds.play_music()
	for button in get_tree().get_nodes_in_group("buttons"):
		UISounds.connect_hover_sound(button)
		UISounds.connect_click_sound(button)

func _on_new_game_pressed():
	main_menu.hide()
	game_mode_menu.show()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/options_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_one_player_pressed():
	if Globals.players_switched:
		Globals.paddle_one_player = Globals.Player.AI
	else:
		Globals.paddle_two_player = Globals.Player.AI
	start_game()


func _on_two_players_pressed():
	if Globals.players_switched:
		Globals.paddle_one_player = Globals.Player.TWO
	else:
		Globals.paddle_two_player = Globals.Player.TWO
	start_game()


func _on_back_button_pressed():
	main_menu.show()
	game_mode_menu.hide()


func start_game():
	UISounds.stop_music()
	get_tree().change_scene_to_file("res://scenes/level.tscn")
