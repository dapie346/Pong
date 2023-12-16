extends Node2D

var count: int
@onready var paddle_one_score: int = 0
@onready var paddle_two_score: int = 0
@onready var paddle_one: CharacterBody2D = $PaddleOne
@onready var paddle_two: CharacterBody2D = $PaddleTwo
@onready var counting_text: Label = $UI/Counting
@onready var scoring_text: Label = $UI/Score
@onready var header: Label = $UI/PauseMenu/MessageDisplay
@onready var pause_menu: VBoxContainer = $UI/PauseMenu
@onready var back_button: Button = $UI/PauseMenu/MarginContainer/BackButton

func _ready():
	paddle_one.player = Globals.paddle_one_player
	paddle_one.color = Globals.paddle_one_color
	paddle_one.setup()
	paddle_two.player = Globals.paddle_two_player
	paddle_two.color = Globals.paddle_two_color
	paddle_two.setup()
	start_new_round()

func _unhandled_input(event):
	if event.is_action_pressed("ui_back") and !event.is_echo():
		if get_tree().paused:
			pause_menu_off()
		else:
			pause_menu_on()

func pause_menu_on():
	get_tree().paused = true
	pause_menu.show()
	back_button.show()
	header.text = "PAUSED"

func pause_menu_off():
	get_tree().paused = false
	pause_menu.hide()
	back_button.hide()

func _on_scoring_zone_one_body_entered(_body):
	paddle_one_score +=1
	point_scored()


func _on_scoring_zone_two_body_entered(_body):
	paddle_two_score +=1
	point_scored()

func point_scored():
	var current_winning_score = max(paddle_one_score, paddle_two_score)
	if current_winning_score < Globals.winning_score:
		start_new_round()
	else:
		show_winner(current_winning_score)
	
func show_winner(current_winning_score: int) -> void:
	update_scoring_text()
	var winning_color: String
	if current_winning_score == paddle_one_score:
		winning_color = Globals.player_one_color
	else:
		winning_color = Globals.player_two_color
	header.text = winning_color.to_upper() + " WINS!"
	pause_menu.show()
	
func start_new_round():
	count = 3
	$CountingTimer.start()
	update_scoring_text()
	update_counting_text()
	

func update_scoring_text():
	scoring_text.text = str(paddle_two_score) + " : " + str(paddle_one_score)
	
func _on_counting_timer_timeout():
	count -= 1
	update_counting_text()

func update_counting_text():
	counting_text.show()
	if count > 0:
		counting_text.text = str(count)
	elif count == 0:
		counting_text.text = "GO!"
	else:
		counting_text.hide()
		$CountingTimer.stop()
		$Ball.reset()


func _on_menu_button_pressed():
	pause_menu_off()
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")


func _on_replay_button_pressed():
	pause_menu_off()
	get_tree().reload_current_scene()


func _on_back_button_pressed():
	pause_menu_off()
