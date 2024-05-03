extends Node

@onready var score_label = $"../ScoreLabel"

var score = 0

func _ready():
	score_label.text = "COINS: " + str(score)

func add_point():
	score += 1
	score_label.text = "COINS: " + str(score)
