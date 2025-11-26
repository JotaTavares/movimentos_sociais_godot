# pagina3.gd
extends Pagina

@export var quadros_animacao: Array[Texture2D]
@export var textos_animacao: Array[String]


@onready var slider: HSlider = $TimelineSlider
@onready var display_imagem: TextureRect = $DisplayImagem
@onready var display_texto: Label = $DisplayTexto
@onready var flash_texture: TextureRect = $FlashTexture


var indice_atual: int = -1



func _ready() -> void:
	super._ready() 

	
	slider.min_value = 0.0
	slider.max_value = 100.0
	slider.value = 0.0 
	
	
	_on_timeline_slider_value_changed(slider.value)



func _on_timeline_slider_value_changed(new_value: float) -> void:
	
	if quadros_animacao.is_empty():
		return

	
	var porcentagem: float = new_value / slider.max_value
	
	
	var novo_indice = int(floor(porcentagem * quadros_animacao.size()))
	
	
	novo_indice = clamp(novo_indice, 0, quadros_animacao.size() - 1)

	
	if novo_indice != indice_atual:
		indice_atual = novo_indice
		do_flash()
		
		
		display_imagem.texture = quadros_animacao[indice_atual]
		
		
		if indice_atual < textos_animacao.size():
			display_texto.text = textos_animacao[indice_atual]
		else:
			display_texto.text = "" # Esconde o texto se não houver um
			
			
func do_flash() -> void:
	
	flash_texture.modulate = Color(1.0, 1.0, 1.0, 1.0) 

	
	var tween = create_tween()

	
	tween.tween_property(flash_texture, "modulate:a", 0.0, 0.3)
	
func _on_botao_proxima_pressed() -> void:
	
	super._on_botao_proxima_pressed()
	
	
func _on_botao_som_toggled(toggled_on: bool) -> void:
	
	super._on_botao_som_toggled(toggled_on)
