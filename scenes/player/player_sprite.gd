class_name PlayerSprite extends AnimatedSprite2D

var character: CharacterBody2D
@onready var hat_sprite: Sprite2D = $HatSprite2D

const _ANIMATION_BY_STATE_NAME: Dictionary = {
	"IdleMovementState": "idle",
	"WalkMovementState": "walk",
	"JumpMovementState": "jump",
	"FallMovementState": "fall",
}

func _ready() -> void:
	await owner.ready
	character = owner as Character
	assert(character != null)

func _process(_delta: float) -> void:
	if character.velocity.x != 0:
		flip_h = character.velocity.x < 0
		hat_sprite.flip_h = flip_h

func _on_movement_state_changed(_previous_state: State, current_state: State) -> void:
	play(_ANIMATION_BY_STATE_NAME[current_state.name])

func update_hat_position() -> void:
	# some frames of some animations have a lower head, so the hat must follow
	var hat_needs_offset = animation == "fall" or (animation == "walk" and frame % 2 == 0)
	hat_sprite.offset = Vector2(0, 1 if hat_needs_offset else 0)
