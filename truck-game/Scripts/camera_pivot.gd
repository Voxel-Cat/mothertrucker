extends Node3D

func _input(event):
	#region Camera Movement
	if Input.is_action_pressed("Camera Move") and event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * PlayerSettings.cameraMovementFactor
		rotation_degrees.x -= event.relative.y*PlayerSettings.cameraMovementFactor
		rotation_degrees.x = clampf(rotation_degrees.x,-75,75)
	#endregion
