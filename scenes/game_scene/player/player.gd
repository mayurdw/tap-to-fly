extends CharacterBody2D

@export_category("Stats")
@export var up_velocity : float = -400.0
@export var mass : float = 100.0
@export var air_resistance : float = 20.0
@export var max_falling_speed = 400.0

var jump_allowed : bool = true
@onready var jump_cooldown: Timer = $"Jump Cooldown"

func _physics_process(delta: float) -> void:
	if not velocity.y > max_falling_speed:
		velocity += get_gravity() * delta

	# Handle jump.
	if jump_allowed and Input.is_action_just_pressed("Jump"):
		jump_allowed = false
		jump_cooldown.start()
		velocity.y = up_velocity + mass

	move_and_slide()


func _on_jump_cooldown_timeout() -> void:
	jump_allowed = true
