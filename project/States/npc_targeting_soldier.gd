extends NpcTargeting
class_name npc_targeting_soldier

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../GunshotAudioStreamPlayer2D"

@export var animSprite2D: AnimatedSprite2D
@export var shootRestTime: float
@export var gunSounds: Array[AudioStream]

func shoot() -> void:
	if !targeter.targetNode:
		return
	if targeter.targetNode.has_node("HealthSystem"):
		var targetHealthSystem: HealthSystem = targeter.targetNode.get_node("HealthSystem")
		targetHealthSystem.damage(25)
		audio_stream_player_2d.stream = gunSounds.pick_random()
		audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
		audio_stream_player_2d.play()

func _on_shoot_timer_timeout() -> void:
	shoot()
	$ShootTimer.start(shootRestTime)

func enter() -> void:
	animSprite2D.set_frame_and_progress(1, 0)
	$ShootTimer.start(shootRestTime)

func exit() -> void:
	animSprite2D.set_frame_and_progress(0, 0)
	$ShootTimer.stop()
