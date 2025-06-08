class_name Sword extends Node2D

@export var brain: CharacterBrain

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	if brain.wants_to_use():
		animation_player.play("use")
