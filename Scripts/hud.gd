extends CanvasLayer

@onready var coin_label: Label = $Label

func _ready():
	GameManager.coins_count_changed.connect(_actualizar_texto)
	
	_actualizar_texto(GameManager.coin_count)
	
func _actualizar_texto(nuevo_valor: int):
	coin_label.text = "Monedas: " + str(nuevo_valor)
