class_name Character extends CharacterBody2D

@export var acceleration_seconds: float = 0.1 # time to reach velocity_pixels_per_second
@export var velocity_pixels_per_second: float = Globals.TILE_SIZE_PIXELS * 10
@export var friction_deceleration_seconds: float = 0.1 # time from velocity_pixels_per_second back to 0
@export var jump_height_pixels: float = Globals.TILE_SIZE_PIXELS * 4.2
@export var jump_apex_time_seconds: float = 0.4
@export var view_direction: Vector2i = Vector2i.RIGHT
@export var knockback_velocity_pixels_per_second: float = Globals.TILE_SIZE_PIXELS * 100

@onready var friction_pixels_per_second_squared: float = velocity_pixels_per_second / friction_deceleration_seconds
@onready var acceleration_pixels_per_second_squared: float = (velocity_pixels_per_second / acceleration_seconds) + friction_pixels_per_second_squared
@onready var gravity_pixels_per_second_squared: float = 2 * jump_height_pixels / pow(jump_apex_time_seconds, 2)
@onready var jump_velocity_pixels_per_second: float = sqrt(2 * gravity_pixels_per_second_squared * jump_height_pixels)

@onready var brain: CharacterBrain = self.find_children("*", "CharacterBrain")[0]

signal flipped(view_direction: Vector2i)


func _physics_process(_delta: float) -> void:
	var intended_movement_axis = brain.get_movement_axis()
	if intended_movement_axis != 0:
		var new_view_direction = Vector2i(sign(intended_movement_axis), 0)
		if new_view_direction != view_direction:
			view_direction = new_view_direction
			flipped.emit(view_direction)


func default_physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_friction(delta)
	move_horizontally(delta)
	clamp_velocity()
	move_and_slide()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity_pixels_per_second_squared * delta


func apply_friction(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0, friction_pixels_per_second_squared * delta)


func move_horizontally(delta: float) -> void:
	var input_direction = brain.get_movement_axis()
	brain.wants_to_move_left()
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
