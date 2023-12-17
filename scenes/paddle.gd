extends CharacterBody2D

var move_up: String
var move_down: String
var player: Globals.Player
var color: String
var player_speed: int = 350
var ai_speed: float
var ball_position: float = Globals.current_ball_pos.y
var last_direction: Vector2 = Vector2.ZERO
var can_change_direction: bool = true

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player != Globals.Player.AI:
		if Input.is_action_pressed(move_up):
			velocity = Vector2.UP * player_speed
		if Input.is_action_pressed(move_down):
			velocity = Vector2.DOWN * player_speed
	else:
		ai_speed = Globals.current_ball_speed * 0.8
		ai_player_move()
	move_and_collide(velocity * delta)

func setup():
	match player:
		Globals.Player.ONE:
			move_up = "player_one_up"
			move_down = "player_one_down"
		Globals.Player.TWO:
			move_up = "player_two_up"
			move_down = "player_two_down"
		Globals.Player.AI:
			$ChangeDirectionTimer.start()
	if color == "blue":
		$Red.visible = false
	elif color == "red":
		$Blue.visible = false

func ai_player_move():
	ball_position = Globals.current_ball_pos.y
	var position_diff = abs(ball_position - global_position.y)
	randomize()
	var move_chance: bool = randi() % 2
	
	if position_diff >= 90 and move_chance and can_change_direction:
		can_change_direction = false
		if move_chance:
			if ball_position < global_position.y:
				velocity = Vector2.UP * ai_speed
				last_direction = Vector2.UP
			elif ball_position > global_position.y:
				velocity = Vector2.DOWN * ai_speed
				last_direction = Vector2.DOWN
	else:
		velocity = last_direction * ai_speed

func _on_change_direction_timer_timeout():
	can_change_direction = true
