extends Path

class_name Dolly

export (NodePath) var camera_path
export (NodePath) var target_path

export (bool)    var look_at_target          = false
export (bool)    var frozen                  = false
export (float)   var interpolation_speed     = 0.0
export (Vector3) var camera_position_offset  = Vector3.ZERO
export (Vector3) var camera_rotation_degrees = Vector3.ZERO

onready var follow : Spatial = PathFollow.new()
onready var target : Spatial = get_node_or_null(target_path)

var camera : Spatial


func _ready() -> void:
	# Configures the PathFollow node
	add_child(follow)
	follow.global_transform = global_transform
	follow.rotation_mode = PathFollow.ROTATION_ORIENTED
	follow.unit_offset = 0
	camera = get_node_or_null(camera_path)
	# Creates a default camera if none is given
	if !camera:
		camera = Camera.new()
		camera.current = true
		add_child(camera)
	# Sets the camera's starting position
	camera.global_transform = follow.global_transform
	camera.translate(camera_position_offset)
	camera.rotation_degrees += camera_rotation_degrees
	return

func _process(delta) -> void:
	if !target:
		print("DollyCam has no target")
		return
	if frozen:
		return
	# Sets the PathFollow's position to the position in the curve closest
	# To the target's position
	follow.offset = curve.get_closest_offset(target.global_transform.origin)
	var follow_original = follow.transform
	follow.translate(camera_position_offset)
	follow.rotation_degrees += camera_rotation_degrees
	# Makes it slowly interpolate if the interpolation speed is different than 0
	# Or move instantly if it is equal to 0
	var t = 1 if interpolation_speed == 0 else interpolation_speed * delta
	camera.global_transform = camera.global_transform.interpolate_with(follow.global_transform,t)
	if look_at_target:
		camera.look_at(target.global_transform.origin,Vector3.UP)
	follow.transform = follow_original
	return

func get_forward() -> Vector3:
	return follow.global_transform.basis.z

func get_follow_rotation() -> Vector3:
	return follow.rotation

func freeze() -> void:
	frozen = true
	return

func unfreeze() -> void:
	frozen = false
	return

func switch_frozen() -> bool:
	frozen = !frozen
	return frozen

func get_frozen() -> bool:
	return frozen

func rotate_camera_axis_deg(axis : Vector3, angle : float) -> void:
	camera_rotation_degrees += axis*angle
	return

func rotate_camera_axis_rad(axis : Vector3, angle : float) -> void:
	camera_rotation_degrees += axis*rad2deg(angle)
	return

func translate_camera(offset : Vector3) -> void:
	camera_position_offset += offset
	return

func set_camera_position_offset(offset : Vector3) -> void:
	camera_position_offset = offset
	return

func get_camera_position_offset() -> Vector3:
	return camera_position_offset

func set_interpolation_speed(amount : float) -> void:
	interpolation_speed = amount
	return

func get_interpolation_speed() -> float:
	return interpolation_speed

func set_look_at_target(value : bool) -> void:
	look_at_target = value
	return

func get_look_at_target() -> bool:
	return look_at_target
