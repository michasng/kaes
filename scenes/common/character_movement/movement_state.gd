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
	if Input.is_action_pressed("jump"):
		return jump_state
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return walk_state
	return idle_state
	
