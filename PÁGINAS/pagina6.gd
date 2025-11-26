# pagina6.gd
extends Pagina


enum Estado { NORMAL, ZOOM }
var estado_universidade: Estado = Estado.NORMAL
var estado_votacao: Estado = Estado.NORMAL


@onready var img_universidade: TextureRect = $ImgUniversidade
@onready var img_votacao: TextureRect = $ImgVotacao
@onready var player_universidade: AnimatedSprite2D = $ImgUniversidade/PlayerUniversidade
@onready var player_votacao: AnimatedSprite2D = $ImgVotacao/PlayerVotacao
@onready var hotspot_universidade: TextureButton = $HotspotUniversidade
@onready var hotspot_votacao: TextureButton = $HotspotVotacao



func _ready() -> void:
	print("--- PÁGINA 6: DEBUG _READY() ---")
	super._ready() 
	
	if hotspot_universidade.mouse_filter != 0: push_warning("HotspotUniversidade precisa de Mouse Filter = STOP")
	if hotspot_votacao.mouse_filter != 0: push_warning("HotspotVoto precisa de Mouse Filter = STOP")
	if img_universidade.mouse_filter != 1: push_warning("ImgUniversidade precisa de Mouse Filter = IGNORE")
	if img_votacao.mouse_filter != 1: push_warning("ImgVotacao precisa de Mouse Filter = IGNORE")

	player_universidade.hide()
	player_votacao.hide()
	print("--- PÁGINA 6: PRONTA ---")




func _on_hotspot_universidade_gui_input(event: InputEvent) -> void:
	print("Input Recebido: UNIVERSIDADE") 
	
	var zoom_in_detectado = false
	if event is InputEventMagnifyGesture and event.factor > 1.0: zoom_in_detectado = true
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed() and event.ctrl_pressed:
		zoom_in_detectado = true
	
	if estado_universidade == Estado.NORMAL and zoom_in_detectado:
		iniciar_zoom_universidade()

	var zoom_out_detectado = false
	if event is InputEventMagnifyGesture and event.factor < 1.0: zoom_out_detectado = true
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed() and event.ctrl_pressed:
		zoom_out_detectado = true
	
	if estado_universidade == Estado.ZOOM and zoom_out_detectado:
		parar_zoom_universidade()


func _on_hotspot_votacao_gui_input(event: InputEvent) -> void:
	print("Input Recebido: VOTAÇÃO") 
	
	var zoom_in_detectado = false
	if event is InputEventMagnifyGesture and event.factor > 1.0: zoom_in_detectado = true
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed() and event.ctrl_pressed:
		zoom_in_detectado = true
	
	if estado_votacao == Estado.NORMAL and zoom_in_detectado:
		iniciar_zoom_votacao()

	var zoom_out_detectado = false
	if event is InputEventMagnifyGesture and event.factor < 1.0: zoom_out_detectado = true
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed() and event.ctrl_pressed:
		zoom_out_detectado = true
	
	if estado_votacao == Estado.ZOOM and zoom_out_detectado:
		parar_zoom_votacao()




func iniciar_zoom_universidade():
	print("Iniciando Zoom: UNIVERSIDADE") 
	estado_universidade = Estado.ZOOM
	
	
	player_universidade.show()
	player_universidade.speed_scale = 1.0
	player_universidade.frame = 0
	player_universidade.play("zoom_in")

func parar_zoom_universidade():
	print("Parando Zoom: UNIVERSIDADE") 
	estado_universidade = Estado.NORMAL
	
	player_universidade.speed_scale = -1.0
	player_universidade.frame = player_universidade.sprite_frames.get_frame_count("zoom_in") - 1
	player_universidade.play() 

func _on_player_universidade_animation_finished():
	print("Animação UNIVERSIDADE terminada. Animação: %s" % player_universidade.animation) 
	
	if player_universidade.speed_scale > 0:
		if player_universidade.animation == "zoom_in":
			print("...Terminou zoom_in (forward), tocando loop.") 
			player_universidade.play("loop")
	else:
		print("...Terminou zoom_in (backward), escondendo.") 
		player_universidade.hide()
		
		player_universidade.speed_scale = 1.0




func iniciar_zoom_votacao():
	print("Iniciando Zoom: VOTAÇÃO")
	estado_votacao = Estado.ZOOM
	

	player_votacao.show()
	player_votacao.speed_scale = 1.0
	player_votacao.frame = 0
	player_votacao.play("zoom_in")

func parar_zoom_votacao():
	print("Parando Zoom: VOTAÇÃO") 
	estado_votacao = Estado.NORMAL
	
	player_votacao.speed_scale = -1.0
	player_votacao.frame = player_votacao.sprite_frames.get_frame_count("zoom_in") - 1
	player_votacao.play()

func _on_player_votacao_animation_finished():
	print("Animação VOTAÇÃO terminada. Animação: %s" % player_votacao.animation) 

	if player_votacao.speed_scale > 0:
		if player_votacao.animation == "zoom_in":
			print("...Terminou zoom_in (forward), tocando loop.") 
			player_votacao.play("loop")
	else:
		print("...Terminou zoom_in (backward), escondendo.") 
		player_votacao.hide()
		
		player_votacao.speed_scale = 1.0




func _on_botao_anterior_pressed():
	if estado_universidade == Estado.ZOOM:
		parar_zoom_universidade()
	elif estado_votacao == Estado.ZOOM:
		parar_zoom_votacao()
	else:
		super._on_botao_anterior_pressed()

func _on_botao_proxima_pressed():
	super._on_botao_proxima_pressed()

func _on_botao_som_toggled(toggled_on: bool):
	super._on_botao_som_toggled(toggled_on)
