extends Node

@onready var tileMapLayer: TileMapLayer = $"World/NavigationRegion2D/TileMapLayer-Environment"
@onready var worldNavigation: NavigationRegion2D = $World/NavigationRegion2D
@export var door_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_doors()

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
