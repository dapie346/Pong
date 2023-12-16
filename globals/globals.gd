extends Node

enum Player {
	ONE,
	TWO,
	AI
}

var paddle_one_color: String = "blue"
var paddle_two_color: String = "red"
var paddle_one_player: Player = Player.ONE
var paddle_two_player: Player = Player.TWO
var players_switched: bool = false:
	set(value):
		players_switched = value
		if players_switched:
			paddle_one_player = Player.TWO
			paddle_two_player = Player.ONE
		else:
			paddle_one_player = Player.ONE
			paddle_two_player = Player.TWO
var colors_switched: bool = false:
	set(value):
		colors_switched = value
		if colors_switched:
			paddle_one_color = "red"
			paddle_two_color = "blue"
		else:
			paddle_one_color = "blue"
			paddle_two_color = "red"
var winning_score: int = 5
