class_name StateMachine extends Node

@export var initial_state: State

var _current_state: State = null
var _previous_state: State = null

signal state_changed(previous_state: State, current_state: State)

func _ready() -> void:
	await owner.ready # ensure all nodes in the scene are ready when the state is entered
	_set_state(initial_state)

func _physics_process(delta: float) -> void:
	if _current_state == null:
		return

	# Mind the order for responsiveness: Transition first, then handle physics.
	_set_state(_current_state.get_next_state())
	_current_state.handle_physics_process(delta)

func _set_state(next_state: State):
	if _current_state == next_state:
		return

	_previous_state = _current_state
	_current_state = next_state
	
	if _previous_state != null:
		_previous_state.exit_state(_current_state)

	if _current_state != null:
		_current_state.enter_state(_previous_state)
	
	state_changed.emit(_previous_state, _current_state)
