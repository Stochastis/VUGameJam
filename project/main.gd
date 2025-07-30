extends Node
class_name Main

@onready var soldier_talk_timer: Timer = $SoldierTalkTimer
@onready var allied_soldiers: Node = $World/AlliedSoldiers
@onready var tileMapLayer: TileMapLayer = $"World/WorldNavRegion/TileMapLayer-Environment"
@onready var worldNavigation: NavigationRegion2D = $World/WorldNavRegion
@onready var engineer: CharacterBody2D = $World/Engineer
@onready var music_audio_stream_player: AudioStreamPlayer = $MusicAudioStreamPlayer
@onready var main_ui: MainUI = $World/GUICanvasLayer/MainUI

@export var door_scene: PackedScene
@export var maxStructIntegrity: int
@export var soldierTalkingLines: Array[AudioStream]
@export var minSoldierTalkGap: int
@export var maxSoldierTalkGap: int
@export var distanceToTalk: float = 32
@export var musicFiles: Array[AudioStream]
@export var minMusicGap: int = 5
@export var maxMusicGap: int = 60
@export var musicVolume: float = -18

var alliedSoldiers: Array[Node]
var currStructIntegrity: int : set = _on_set_curr_struct_integrity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_doors()
	currStructIntegrity = maxStructIntegrity
	soldier_talk_timer.start(randi_range(minSoldierTalkGap, maxSoldierTalkGap))
	alliedSoldiers = allied_soldiers.get_children()
	
	music_audio_stream_player.volume_db = musicVolume
	music_audio_stream_player.stream = musicFiles.pick_random()
	music_audio_stream_player.play()

func spawn_doors():
	for cell_pos in tileMapLayer.get_used_cells():
		var tile_data = tileMapLayer.get_cell_tile_data(cell_pos)
		if tile_data == null:
			continue
		
		# Only process tiles marked as door
		if not tile_data.get_custom_data("is_door"):
			continue
		
		var door: Door = door_scene.instantiate()
		
		# Convert cell coordinates to world position
		var local_pos = tileMapLayer.map_to_local(cell_pos)
		door.global_position = tileMapLayer.to_global(local_pos)
		
		# Read and apply custom data
		if tile_data.has_custom_data("north_south"):
			door.northSouth = tile_data.get_custom_data("north_south")
			if door.northSouth:
				door.eastWestNavRegion.enabled = false
			else:
				door.northSouthNavRegion.enabled = false
		if tile_data.has_custom_data("open"):
			door.open = tile_data.get_custom_data("open")
		
		worldNavigation.add_child(door)
		tileMapLayer.set_cell(cell_pos, -1)

func _on_set_curr_struct_integrity(integrity: int):
	currStructIntegrity = integrity
	var newValue: float = ((float(maxStructIntegrity - currStructIntegrity)) / float(maxStructIntegrity)) * 100.0
	main_ui.decay_meter.value = newValue
	
	if currStructIntegrity <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")

func _on_soldier_talk_timer_timeout() -> void:
	var soldier: AlliedSoldier = alliedSoldiers.pick_random()
	if soldier.global_position.distance_to(engineer.global_position) < distanceToTalk:
		soldier.talking_audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
		soldier.talking_audio_stream_player_2d.stream = soldierTalkingLines.pick_random()
		soldier.talking_audio_stream_player_2d.play()

func _on_music_audio_stream_player_finished() -> void:
	await get_tree().create_timer(randi_range(minMusicGap, maxMusicGap)).timeout
	music_audio_stream_player.stream = musicFiles.pick_random()
	music_audio_stream_player.play()

func _on_score_timer_timeout() -> void:
	ScoreKeeper.score += 1
	main_ui.score_amount.text = str(ScoreKeeper.score)
	
