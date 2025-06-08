class_name HurtBox extends Area2D

var character: Character

func _ready() -> void:
	await owner.ready
	character = owner as Character
	assert(character != null)

 
func _on_area_entered(area: Area2D) -> void:
	if character.is_ancestor_of(area):
		return # don't hit yourself

	var knockback_direction = area.global_position.direction_to(character.global_position)
	character.velocity = knockback_direction * character.knockback_velocity_pixels_per_second


func _on_area_exited(_area: Area2D) -> void:
	pass
