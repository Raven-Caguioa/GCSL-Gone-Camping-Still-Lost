extends Node2D

var coins = 10
var score = 0

func _process(delta: float) -> void:
	$"GUI/CoinValue".text = str(coins)
	$GUI/ScoreValue.text = str(score)
