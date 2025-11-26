# pagina5.gd
extends Pagina

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var botao_play_pause: TextureButton = $BotaoPlayPause
@onready var botao_som: BaseButton = $BotaoSom 

const TEX_PLAY = preload("res://IMAGENS/Página 5/play.png")
const TEX_PAUSE = preload("res://IMAGENS/Página 5/pause.png")


func _ready() -> void:
	super._ready()
	
	if not narracao_player:
		narracao_player = get_node_or_null("AudioStreamPlayer")
	
	video_player.finished.connect(_on_video_finished)
	
	if video_player.autoplay:
		video_player.autoplay = false
		video_player.play()       
		video_player.paused = true 
	
	_update_button_textures(false)


func _on_botao_play_pause_pressed() -> void:
	
	var video_esta_rodando = video_player.is_playing()
	
	if not video_esta_rodando:
		video_player.play()
		_update_button_textures(true)
		
		if narracao_player: narracao_player.stop()
		
	else:
		video_player.paused = not video_player.paused
		
		if video_player.paused:
			_update_button_textures(false)
			
		
			if narracao_player and botao_som.button_pressed:
				narracao_player.play()
				
		else:
			_update_button_textures(true)
			if narracao_player: narracao_player.stop()



func _on_botao_som_toggled(is_pressionado: bool) -> void:
	
	if not narracao_player: return

	if is_pressionado:
		
		if not video_player.is_playing() or video_player.paused:
			print("Som Ligado: Tocando narração (Vídeo parado)")
			narracao_player.play()
		else:
			print("Som Ligado: Narração mantida em silêncio (Vídeo tocando)")
			
	else:
		
		print("Som Desligado")
		narracao_player.stop()




func _on_video_finished() -> void:
	_update_button_textures(false)
	
	if narracao_player and botao_som.button_pressed: 
		narracao_player.play()

func _update_button_textures(is_playing: bool) -> void:
	if is_playing:
		botao_play_pause.texture_normal = TEX_PAUSE
		botao_play_pause.texture_pressed = TEX_PAUSE
		botao_play_pause.texture_hover = TEX_PAUSE 
	else:
		botao_play_pause.texture_normal = TEX_PLAY
		botao_play_pause.texture_pressed = TEX_PLAY
		botao_play_pause.texture_hover = TEX_PLAY

func _exit_tree() -> void:
	video_player.stop()
	if narracao_player:
		narracao_player.stop()

func _on_botao_proxima_pressed() -> void:
	super._on_botao_proxima_pressed()
	
func _on_botao_anterior_pressed() -> void:
	super._on_botao_anterior_pressed()
