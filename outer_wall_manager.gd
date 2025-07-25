extends Node

@export var tileMapLayer: TileMapLayer
@export var breakableOuterWallScene: PackedScene

func _ready() -> void:
	pass
	#spawn_doors()

func spawn_doors():
	for cell_pos: Vector2i in tileMapLayer.get_used_cells():
			var tile_data: TileData = tileMapLayer.get_cell_tile_data(cell_pos)
			
			#print(tile_data.name)
			
			if tile_data.get_custom_data("is_door"):
				continue
			
			
			# Convert cell coordinates to world position
			var local_pos = tileMapLayer.map_to_local(cell_pos)
			
			# Read and apply custom data
			if tile_data.has_custom_data("north_south"):
				pass
			if tile_data.has_custom_data("open"):
				pass
			
			tileMapLayer.set_cell(cell_pos, -1)
