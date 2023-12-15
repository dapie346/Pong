extends Node2D

var count: int
@onready var player_one_score: int = 0
@onready var player_two_score: int = 0
@onready var counting_text: Label = $UI/Counting
@onready var scoring_text: Label = $UI/Score
@onready var winner_text: Label = $UI/WinningMenu/WinnerDisplay
@onready var winning_menu: VBoxContainer = $UI/WinningMenu

func _ready():
	winning_menu.visible = false
	start_new_round()

func _on_scoring_zone_one_body_entered(_body):
	player_one_score +=1
	point_scored()


func _on_scoring_zone_two_body_entered(_body):
	player_two_score +=1
	point_scored()

func point_scored():
	var current_winning_score = max(player_one_score, player_two_score)
	if current_winning_score < Globals.winning_score:
		start_new_round()
	else:
		show_winner(current_winning_score)
	
func show_winner(current_winning_score: int) -> void:
	update_scoring_text()
	var winning_color: String
	if current_winning_score == player_one_score:
		winning_color = Globals.player_one_color
	else:
		winning_color = Globals.player_two_color
	winner_text.text = winning_color.to_upper() + " WINS!"
	winning_menu.visible = true
	
func start_new_round():
	count = 3
	$CountingTimer.start()
	update_scoring_text()
	update_counting_text()
	

func update_scoring_text():
	scoring_text.text = str(player_two_score) + " : " + str(player_one_score)
	
func _on_counting_timer_timeout():
	count -= 1
	update_counting_text()

func update_counting_text():
	counting_text.visible = true
	if count > 0:
		counting_text.text = str(count)
	elif count == 0:
		counting_text.text = "GO!"
	else:
		counting_text.visible = false
		$CountingTimer.stop()
		$Ball.reset()


func _on_menu_button_pressed():
	pass # Replace with function body.


func _on_replay_button_pressed():
	get_tree().reload_current_scene()
