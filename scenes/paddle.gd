extends CharacterBody2D

var move_up: String
var move_down: String
var player: Globals.Player
var color: String
var speed: int = 500


func _physics_process(_delta):
	velocity = Vector2.ZERO
	if player != Globals.Player.AI:
		if Input.is_action_pressed(move_up):
			velocity = Vector2.UP * speed
		if Input.is_action_pressed(move_down):
			velocity = Vector2.DOWN * speed
	else:
		pass
	move_and_slide()

func setup():
	match player:
		Globals.Player.ONE:
			move_up = "player_one_up"
			move_down = "player_one_down"
		Globals.Player.TWO:
			move_up = "player_two_up"
			move_down = "player_two_down"
	if color == "blue":
		$Red.visible = false
	elif color == "red":
		$Blue.visible = false
