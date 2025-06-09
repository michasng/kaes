class_name CharacterSprite extends AnimatedSprite2D

var character: CharacterBody2D

@onready var children: Array[Node] = self.find_children("*", "Node2D", false)

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
	_on_character_flipped(character.view_direction)


func _on_character_flipped(view_direction: Vector2i) -> void:
	# inverting scale.x flips dependent sprites too (as opposed to setting flip_h)
	scale = Vector2(view_direction.x, 1)


func _on_movement_state_changed(_previous_state: State, current_state: State) -> void:
	play(_ANIMATION_BY_STATE_NAME[current_state.name])


# some frames of some animations have a lower head and hand, so dependent sprites must follow
func update_offsets() -> void:
	var offset_needed = animation == "fall" or (animation == "walk" and frame % 2 == 0)
	for child: Node2D in children:
		child.position = Vector2(0, 1 if offset_needed else 0)
