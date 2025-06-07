class_name PlayerSprite
extends AnimatedSprite2D

@export var body: CharacterBody2D

func _process(_delta: float) -> void:
	if body.velocity.x != 0:
		flip_h = body.velocity.x < 0

func _on_movement_state_changed(_previous_state: State, current_state: State) -> void:
	match current_state.name:
		"IdleMovementState": play("idle")
		"WalkMovementState": play("walk")
		"JumpMovementState": play("jump")
		"FallMovementState": play("fall")
