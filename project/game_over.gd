extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var score_amount: Label = $Control/GameOver/YourFinalScore/ScoreAmount

func _ready() -> void:
	ScoreKeeper.finalScore = ScoreKeeper.score
	score_amount.text = str(ScoreKeeper.finalScore)
	ScoreKeeper.score = 0
	
	audio_stream_player.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player.play()
