class_name Sword extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("use"):
		animation_player.play("use")
