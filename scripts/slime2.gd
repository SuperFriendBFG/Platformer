extends CharacterBody2D

@export_group("Locomotion")

@export var speed = 60
@export var fspeed = 140

var directionx = 1

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_down = $RayCastDown
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physic_process(delta):
	if ray_cast_right.is_colliding():
		directionx = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		directionx = 1
		animated_sprite.flip_h = false		
	position.x += directionx * speed * delta
	
	if not ray_cast_down.is_colliding():
		position.y += fspeed * delta
	
