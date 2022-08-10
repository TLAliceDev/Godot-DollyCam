extends MeshInstance

onready var dolly = get_parent().get_node("Dolly")

func _process(delta):
	global_translate(dolly.get_forward()*delta*2)
