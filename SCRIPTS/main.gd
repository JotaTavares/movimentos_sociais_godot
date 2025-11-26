# main.gd
extends Node

@export var paginas: Array[PackedScene]

var pagina_atual_index = 0
var pagina_atual_instancia = null

func _ready():
	if not paginas.is_empty():
		carregar_pagina(pagina_atual_index)
	else:
		print("Nenhuma página foi configurada no Inspetor do nó Main!")

func carregar_pagina(index: int):
	if pagina_atual_instancia:
		pagina_atual_instancia.queue_free()

	pagina_atual_instancia = paginas[index].instantiate()
	
	
	pagina_atual_instancia.proxima_pagina_solicitada.connect(proxima_pagina)
	pagina_atual_instancia.pagina_anterior_solicitada.connect(pagina_anterior)
	pagina_atual_instancia.voltar_inicio_solicitado.connect(voltar_ao_inicio) 

	add_child(pagina_atual_instancia)

	if index == 0:
		pagina_atual_instancia.esconder_botao_anterior()
	
	if index == paginas.size() - 1:
		pagina_atual_instancia.esconder_botao_proxima()

func proxima_pagina():
	if pagina_atual_index < paginas.size() - 1:
		pagina_atual_index += 1
		carregar_pagina(pagina_atual_index)

func pagina_anterior():
	if pagina_atual_index > 0:
		pagina_atual_index -= 1
		carregar_pagina(pagina_atual_index)


func voltar_ao_inicio():

	pagina_atual_index = 0
	carregar_pagina(pagina_atual_index)
