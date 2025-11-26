# Pagina.gd 
class_name Pagina
extends Node2D


signal proxima_pagina_solicitada
signal pagina_anterior_solicitada
signal voltar_inicio_solicitado


var narracao_player: AudioStreamPlayer



func _ready():
	
	var botao_proxima = find_child("BotaoProxima", false)
	if botao_proxima:
		botao_proxima.pressed.connect(_on_botao_proxima_pressed)

	var botao_anterior = find_child("BotaoAnterior", false)
	if botao_anterior:
		botao_anterior.pressed.connect(_on_botao_anterior_pressed)

	var botao_voltar_inicio = find_child("BotaoVoltarInicio", false)
	if botao_voltar_inicio:
		botao_voltar_inicio.pressed.connect(_on_botao_voltar_inicio_pressed)

	
	
	
	
	narracao_player = find_child("AudioStreamPlayer", false)
	if not narracao_player:
		print("AVISO (Pagina.gd): Nó 'AudioStreamPlayer' não encontrado nesta página.")

	
	var botao_som = find_child("BotaoSom", false)
	if botao_som:
		
		botao_som.toggled.connect(_on_botao_som_toggled)
		
		
		if narracao_player and narracao_player.autoplay:
			botao_som.button_pressed = true
		else:
			botao_som.button_pressed = false
			
			if narracao_player:
				narracao_player.stop()


func _on_botao_proxima_pressed():
	emit_signal("proxima_pagina_solicitada")

func _on_botao_anterior_pressed():
	emit_signal("pagina_anterior_solicitada")

func _on_botao_voltar_inicio_pressed():
	emit_signal("voltar_inicio_solicitado")


func _on_botao_som_toggled(is_pressionado: bool):
	
	if not narracao_player:
		return
		
	if is_pressionado:
		
		print("Narração LIGADA (do começo)")
		narracao_player.play()
	else:
		
		print("Narração DESLIGADA")
		narracao_player.stop()


func esconder_botao_proxima():
	var botao = find_child("BotaoProxima", false)
	if botao:
		botao.hide()

func esconder_botao_anterior():
	var botao = find_child("BotaoAnterior", false)
	if botao:
		botao.hide()
