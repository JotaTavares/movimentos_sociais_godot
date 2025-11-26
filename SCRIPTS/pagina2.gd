# pagina2.gd
extends Pagina

@export var total_de_pessoas: int = 0
var pessoas_na_praca: int = 0


@onready var container_slots: Node2D = $PracaCentral/SlotsPessoas

func _on_praca_central_body_entered(body):
	
	
	if body is PessoaArrastavel:
		
		
		if not body.has_meta("foi_contado"):
			
			
			body.set_meta("foi_contado", true) 
			pessoas_na_praca += 1
			print("Uma pessoa chegou! Total: %d/%d" % [pessoas_na_praca, total_de_pessoas])
			
			
			
			
			var slot_index = pessoas_na_praca - 1 
			if slot_index < container_slots.get_child_count(): 
				var target_slot = container_slots.get_child(slot_index) 
				
				
				body.travar_no_slot(target_slot.global_position)
				
				_animar_pessoa_chegando(body)
			
			
			if pessoas_na_praca >= total_de_pessoas:
				print("Todas as pessoas se reuniram!")
				_iniciar_animacao_final()

func _iniciar_animacao_final():
	var rolo_compressor = $RoloCompressor
	if rolo_compressor:
		rolo_compressor.show()
		var pos_final = Vector2(1000, rolo_compressor.position.y)
		var tween = create_tween()
		tween.tween_property(rolo_compressor, "position", pos_final, 6.0)

func _on_rolo_compressor_area_entered(area):
	if area.has_method("desaparecer"):
		area.desaparecer()
		
		
func _animar_pessoa_chegando(pessoa: PessoaArrastavel):
	
	var pos_final = pessoa.global_position
	
	var pos_pulo = pos_final - Vector2(0, 50)
	
	
	var tween = create_tween()
	
	
	tween.set_loops()

	
	tween.tween_property(pessoa, "global_position", pos_pulo, 0.3).set_ease(Tween.EASE_OUT)
	
	
	tween.tween_property(pessoa, "global_position", pos_final, 0.3).set_ease(Tween.EASE_IN)
	
	
	tween.tween_interval(1.0)
