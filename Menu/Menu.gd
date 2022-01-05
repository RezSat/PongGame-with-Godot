extends Node

var highscore = "user://highscore.save"

func load_score(score_file):
	var score
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		score = f.get_var()
		f.close()
	else:
		score = 0
	return score

func _process(delta):
	var High_score = load_score(highscore)
	if High_score == null:
		High_score == "0"
	$"highscore".text = str(High_score)


func _on_Button_pressed():
	get_tree().change_scene("res://Level/Level.tscn")
