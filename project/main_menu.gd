extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tutorial_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
