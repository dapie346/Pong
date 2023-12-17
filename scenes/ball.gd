extends CharacterBody2D

var initial_speed: float = 300
var max_speed: float = 1000
var speed: float

@onready var initial_pos = global_position
@onready var speed_increase_timer = $SpeedIncreaseTimer

func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	Globals.current_ball_pos = global_position
	if collision_object:
		if not $CollisionSound.playing:
			$CollisionSound.play()
		velocity = velocity.bounce(collision_object.get_normal())
		ensure_valid_x_velocity()
		ensure_valid_y_velocity()
		
func reset():
	global_position = initial_pos
	speed = initial_speed
	visible = true
	initialize_velocity()
	

func initialize_velocity():
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = randf_range(-0.7, 0.7)

func ensure_valid_y_velocity():
	while abs(velocity.y) < 0.2:
		velocity.y += sign(velocity.y) * 0.2 if velocity.y != 0 else 0.2
	while abs(velocity.y) > 0.7:
		velocity.y -= sign(velocity.y) * 0.2

func ensure_valid_x_velocity():
	while abs(velocity.x) < 1:
		velocity.x += sign(velocity.x) * 0.2 if velocity.x != 0 else 0.1

func _on_speed_increase_timer_timeout():
	if speed > 0 and speed < max_speed:
		speed += speed * 0.005
		Globals.current_ball_speed = speed
		var new_wait_time = (speed / 200.0) ** 2
		speed_increase_timer.set_wait_time(new_wait_time)
		speed_increase_timer.start()
