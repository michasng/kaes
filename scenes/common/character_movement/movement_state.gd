class_name MovementState extends State # abstract class

var character: Character

@onready var idle_state = $"../IdleMovementState"
@onready var walk_state = $"../WalkMovementState"
@onready var jump_state = $"../JumpMovementState"
@onready var fall_state = $"../FallMovementState"

func _ready() -> void:
	await owner.ready
	character = owner as Character
	assert(character != null)

func get_next_state() -> State:
	if character.is_on_floor():
		return get_next_floor_state()
	return fall_state

func get_next_floor_state() -> State:
	if character.brain.wants_to_jump():
		return jump_state
	if character.brain.wants_to_move_left() or character.brain.wants_to_move_right():
		return walk_state
	return idle_state
	
