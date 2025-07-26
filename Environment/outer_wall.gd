extends Node2D
class_name OuterWall

const FLOORTILESOURCEID: int = 2
const FLOORTILEATLASCOORDS: Vector2i = Vector2i(0, 0)

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		var envTileMapLayer: TileMapLayer = get_node("/root/Main/World/WorldNavRegion/TileMapLayer-Environment")
		var mapLocalPos: Vector2 = envTileMapLayer.to_local(global_position)
		var cellCoords: Vector2i = envTileMapLayer.local_to_map(mapLocalPos)
		envTileMapLayer.set_cell(cellCoords, FLOORTILESOURCEID, FLOORTILEATLASCOORDS)
		queue_free()

func makeBreakable() -> void:
	$AnimatedSprite2D.set_frame_and_progress(1, 0)
	add_to_group("Breakable")

func interact() -> void:
	makeBreakable()
