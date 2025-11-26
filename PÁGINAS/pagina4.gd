# pagina4.gd
extends Pagina


@onready var grupo_mst: RigidBody2D = $GrupoMST
@onready var fundo_produtivo: TextureRect = $FundoProdutivo
@onready var gatilho_terreno: Area2D = $GatilhoTerreno


const IMPULSE_FORCE = 980.0 
var terreno_ocupado: bool = false



func _ready() -> void:
	
	super._ready() 
	
	
	fundo_produtivo.modulate.a = 0.0
	
	gatilho_terreno.body_entered.connect(_on_gatilho_terreno_body_entered)
	
	
	print("--- PÁGINA 4 PRONTA ---")



func _physics_process(delta: float) -> void:
	
	if terreno_ocupado:
	
		grupo_mst.linear_velocity = grupo_mst.linear_velocity.lerp(Vector2.ZERO, delta * 5.0)
		return

	var input_vector = Vector2.ZERO

	
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	
	if input_vector == Vector2.ZERO:
		
		if OS.has_feature("mobile"):
			var accel = Input.get_accelerometer()
			input_vector.x = accel.x
			input_vector.y = -accel.y
	
	
	if input_vector != Vector2.ZERO:
		
		grupo_mst.apply_central_impulse(input_vector.normalized() * IMPULSE_FORCE * delta)
		
	
	grupo_mst.sleeping = false



func _on_gatilho_terreno_body_entered(body: Node2D) -> void:
	
	if body == grupo_mst and not terreno_ocupado:
		
		print("TERRENO OCUPADO! Iniciando transformação...")
		
		terreno_ocupado = true
		gatilho_terreno.monitoring = false
		grupo_mst.hide()
		
		
		PhysicsServer2D.area_set_param(
			get_viewport().find_world_2d().space,
			PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR,
			Vector2.ZERO
		)
		
		
		var tween = create_tween()
		tween.tween_property(fundo_produtivo, "modulate:a", 1.0, 2.0)

func _on_botao_anterior_pressed() -> void:
	super._on_botao_anterior_pressed()

func _on_botao_proxima_pressed() -> void:
	super._on_botao_proxima_pressed()

func _on_botao_som_toggled(toggled_on: bool) -> void:
	super._on_botao_som_toggled(toggled_on)
