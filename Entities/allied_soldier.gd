extends CharacterBody2D

const SPEED = 300.0

func _process(delta: float) -> void:
	var overlappingAreas: Array[Area2D] = $ObservationArea.get_overlapping_areas()
	var zombies: Array[Area2D] = overlappingAreas.filter(func(area): return area.name == "Zombie")
	# TODO: Finish this method so that the allied soldier turns and points at the closest zombie
