# pessoa_arrastavel.gd
extends CharacterBody2D

class_name PessoaArrastavel

@export var textura_da_pessoa: Texture2D
@onready var sprite_visual = $Sprite2D

var is_dragging = false
var is_draggable: bool = true 

func _ready():
	if textura_da_pessoa:
		sprite_visual.texture = textura_da_pessoa

func _on_input_event(viewport, event, shape_idx):
	
	if not is_draggable:
		is_dragging = false
		return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = event.is_pressed()
			
func _process(delta):
	
	if is_dragging and is_draggable: 
		global_position = get_global_mouse_position()


func travar_no_slot(nova_posicao: Vector2):
	
	is_draggable = false
	is_dragging = false
	
	
	get_node("CollisionShape2D").disabled = true
	
	
	global_position = nova_posicao
