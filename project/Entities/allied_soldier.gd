extends CharacterBody2D
class_name AlliedSoldier

@onready var hurt_audio_stream_player_2d: AudioStreamPlayer2D = $HurtAudioStreamPlayer2D
@onready var observation_area: Area2D = $ObservationArea
@onready var talking_audio_stream_player_2d: AudioStreamPlayer2D = $TalkingAudioStreamPlayer2D

@export var move_speed: float = 20

func _on_health_system_health_changed() -> void:
	hurt_audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	hurt_audio_stream_player_2d.play()
	if $HealthSystem.currHealth <= 0:
		queue_free()
