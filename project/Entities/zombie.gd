extends CharacterBody2D
class_name Zombie

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var target = null
@onready var stateMachine: StateMachine = $StateMachine

@export var cooldown: = 1.0
@export var zombieSounds: Array[AudioStream]
@export var zombieSoundMinGap: int = 3
@export var zombieSoundMaxGap: int = 240

var can_attack = true
var funnelNode: Node2D

func _ready() -> void:
	$ZombieSoundTimer.start(randi_range(zombieSoundMinGap, zombieSoundMaxGap))

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		queue_free()

func _on_zombie_sound_timer_timeout() -> void:
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player_2d.stream = zombieSounds.pick_random()
	audio_stream_player_2d.play()
	$ZombieSoundTimer.start(randi_range(zombieSoundMinGap, zombieSoundMaxGap))
