extends CharacterBody3D

var maxSpeed:float = 5

func moveCamera():
	$"../CameraPivot".reparent($".")
	$CameraPivot.position = Vector3(0,1,0)

func _physics_process(delta):
	#region Gravity
	if(is_on_floor()):
		velocity.y = 0
	else:
		velocity.y -= 15*delta
	#endregion
	#region Movement
	var speedBeforeNormalize:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("Forward") and not Input.is_action_pressed("Backward"):
		speedBeforeNormalize.y = maxSpeed
	elif not Input.is_action_pressed("Forward") and Input.is_action_pressed("Backward"):
		speedBeforeNormalize.y = -maxSpeed
	else:
		speedBeforeNormalize.y = 0
	if Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		speedBeforeNormalize.x = -maxSpeed
	elif not Input.is_action_pressed("Right") and Input.is_action_pressed("Left"):
		speedBeforeNormalize.x = maxSpeed
	else:
		speedBeforeNormalize.x = 0
	if speedBeforeNormalize:
		var finalVelo = speedBeforeNormalize.normalized().rotated(-$CameraPivot.rotation.y+PI)*maxSpeed
		if abs(angle_difference(-finalVelo.angle()+PI/2,$MeshInstance3D.rotation.y)) > 0.5:
			$MeshInstance3D.rotation.y += signf(angle_difference(-finalVelo.angle()+PI/2,$MeshInstance3D.rotation.y+PI))/5
		else:
			$MeshInstance3D.rotation.y = -finalVelo.angle()+1.57
		velocity = Vector3(finalVelo.x,velocity.y,finalVelo.y)
	else:
		velocity.x = 0
		velocity.z = 0
	
	#endregion
	#region Jumping
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = 9
	#endregion
	move_and_slide()
