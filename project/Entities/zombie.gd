extends CharacterBody2D
class_name Zombie

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var target = null
@onready var stateMachine: StateMachine = $StateMachine
@onready var hurt_audio_stream_player_2d: AudioStreamPlayer2D = $HurtAudioStreamPlayer2D
@onready var reactor_nav_agent: NavigationAgent2D = $ReactorNavAgent
@onready var targeter: Targeter = $Targeter

@export var cooldown: = 1.0
@export var zombieSounds: Array[AudioStream]
@export var zombieSoundMinGap: int = 3
@export var zombieSoundMaxGap: int = 240

var can_attack = true
var funnelNode: Node2D

func _ready() -> void:
	$ZombieSoundTimer.start(randi_range(zombieSoundMinGap, zombieSoundMaxGap))

func _process(_delta: float) -> void:
	#TODO: Fix this temporary code
	if stateMachine.current_state is NpcIdle and ($Observer.observationArea != $Focus_Area or $Focus_Area/CollisionShape2D.disabled):
		$Focus_Area/CollisionShape2D.disabled = false
		$Observer.observationArea = $Focus_Area
	
	queue_redraw()

func _on_health_system_health_changed() -> void:
	hurt_audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	hurt_audio_stream_player_2d.play()
	if $HealthSystem.currHealth <= 0:
		queue_free()

func _on_zombie_sound_timer_timeout() -> void:
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player_2d.stream = zombieSounds.pick_random()
	audio_stream_player_2d.play()
	$ZombieSoundTimer.start(randi_range(zombieSoundMinGap, zombieSoundMaxGap))

func _draw() -> void:
	if stateMachine.current_state is ZombieToReactor:
		draw_circle(global_position, 16, Color.PURPLE, false, 4)
