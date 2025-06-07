class_name Character extends CharacterBody2D

@export var friction_pixels_per_second: float = Globals.TILE_SIZE_PIXELS * 2
@export var acceleration_pixels_per_second_squared: float = pow(Globals.TILE_SIZE_PIXELS * 10, 2)
@export var velocity_pixels_per_second: float = Globals.TILE_SIZE_PIXELS * 8
@export var jump_height_pixels: float = Globals.TILE_SIZE_PIXELS * 2.2
@export var jump_duration_seconds: float = 0.34

@onready var gravity_pixels_per_second_squared: float = 2 * jump_height_pixels / pow(jump_duration_seconds, 2)
@onready var jump_velocity_pixels_per_second: float = sqrt(2 * gravity_pixels_per_second_squared * jump_height_pixels)

func default_physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_friction()
	move_horizontally(delta)
	clamp_velocity()
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity_pixels_per_second_squared * delta

func apply_friction() -> void:
	velocity.x = move_toward(velocity.x, 0, friction_pixels_per_second)

func move_horizontally(delta: float) -> void:
	var input_direction = Input.get_axis("left", "right")
	if input_direction:
		velocity.x = move_toward(
			velocity.x,
			input_direction * velocity_pixels_per_second,
			acceleration_pixels_per_second_squared * delta
		)

func clamp_velocity() -> void:
	var max_velocity := Globals.MAX_VELOCITY_PIXELS_PER_SECOND
	if velocity.length() > max_velocity:
		velocity = velocity.normalized() * max_velocity
