# pagina7.gd
extends Pagina

@onready var imagem_parada: TextureRect = $ImagemParada
@onready var alvo_respeito: Area2D = $AlvoRespeito
@onready var container_bolas: Node2D = $ContainerBolas
@onready var fogos_cauda: GPUParticles2D = $Fogos


var lista_bolas: Array[Area2D] = []
var toques_ativos = {}
var bolas_dentro_do_alvo: int = 0
var vitoria: bool = false


func _ready() -> void:
	super._ready() 
	

	imagem_parada.modulate.a = 0.0
	

	if fogos_cauda:
		fogos_cauda.emitting = false
	

	if container_bolas:
		for bola in container_bolas.get_children():
			if bola is Area2D:
				lista_bolas.append(bola)
				bola.hide()
				bola.global_position = Vector2(-1000, -1000)
	

	if alvo_respeito:
		if not alvo_respeito.area_entered.is_connected(_on_bola_entrou_no_alvo):
			alvo_respeito.area_entered.connect(_on_bola_entrou_no_alvo)
		if not alvo_respeito.area_exited.is_connected(_on_bola_saiu_do_alvo):
			alvo_respeito.area_exited.connect(_on_bola_saiu_do_alvo)
	
	print("Página 7 Pronta.")


func _input(event: InputEvent) -> void:
	if vitoria: return

	if event is InputEventScreenTouch:
		if event.pressed:
			_atribuir_bola_ao_dedo(event.index, event.position)
		else:
			_liberar_bola_do_dedo(event.index)
			
	elif event is InputEventScreenDrag:
		_mover_bola(event.index, event.position)




func _atribuir_bola_ao_dedo(dedo_index: int, posicao: Vector2):
	for bola in lista_bolas:
		if not bola.visible: 
			toques_ativos[dedo_index] = bola
			bola.global_position = posicao
			bola.show()
			return 

func _liberar_bola_do_dedo(dedo_index: int):
	if toques_ativos.has(dedo_index):
		var bola = toques_ativos[dedo_index]
		bola.hide()
		bola.global_position = Vector2(-1000, -1000) 
		toques_ativos.erase(dedo_index)

func _mover_bola(dedo_index: int, nova_posicao: Vector2):
	if toques_ativos.has(dedo_index):
		var bola = toques_ativos[dedo_index]
		bola.global_position = nova_posicao




func _on_bola_entrou_no_alvo(area_da_bola: Area2D):
	if area_da_bola in lista_bolas:
		bolas_dentro_do_alvo += 1
		print("Bola entrou! Total: ", bolas_dentro_do_alvo)
		
		if bolas_dentro_do_alvo >= 6:
			_ganhar_jogo()

func _on_bola_saiu_do_alvo(area_da_bola: Area2D):
	if area_da_bola in lista_bolas:
		bolas_dentro_do_alvo -= 1
		if bolas_dentro_do_alvo < 0: bolas_dentro_do_alvo = 0

func _ganhar_jogo():
	if vitoria: return
	vitoria = true
	print("VITÓRIA! A PARADA VAI COMEÇAR!")
	
	if container_bolas: container_bolas.hide()
	if has_node("LabelRespeito"): $LabelRespeito.hide()
	
	
	if fogos_cauda:
		fogos_cauda.emitting = true 
	
	var tween = create_tween()
	tween.tween_property(imagem_parada, "modulate:a", 1.0, 2.0)
