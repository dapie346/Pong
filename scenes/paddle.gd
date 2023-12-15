extends CharacterBody2D

@onready var move_up: String
@onready var move_down: String
@export var player: Globals.Player = Globals.Player.ONE
@export var color: String
@export var speed: int = 500

func _ready():
	match player:
		Globals.Player.ONE:
			move_up = "player_one_up"
			move_down = "player_one_down"
			color = Globals.player_one_color
		Globals.Player.TWO:
			move_up = "player_two_up"
			move_down = "player_two_down"
			color = Globals.player_two_color
	if color == "blue":
		$Red.visible = false
	elif color == "red":
		$Blue.visible = false


func _physics_process(_delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed(move_up):
		velocity = Vector2.UP * speed
	if Input.is_action_pressed(move_down):
		velocity = Vector2.DOWN * speed
	move_and_slide()
