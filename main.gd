extends Node
class_name Main

@export var door_scene: PackedScene
@export var maxStructIntegrity: int

@onready var tileMapLayer: TileMapLayer = $"World/WorldNavRegion/TileMapLayer-Environment"
@onready var worldNavigation: NavigationRegion2D = $World/WorldNavRegion

var currStructIntegrity: int : set = _on_set_curr_struct_integrity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_doors()
	currStructIntegrity = maxStructIntegrity

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
	$World/GUICanvasLayer/MainUI/DecayMeter.value = newValue
	
	if currStructIntegrity <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
