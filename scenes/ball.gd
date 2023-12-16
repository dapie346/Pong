extends CharacterBody2D

var speed: int = 300

@onready var initial_pos = position

func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		$AudioStreamPlayer2D.play()
		velocity = velocity.bounce(collision_object.get_normal())
		
func reset():
	position = initial_pos
	visible = true
	initialize_velocity()
	

func initialize_velocity():
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-0.8,0.8][randi() % 2]
