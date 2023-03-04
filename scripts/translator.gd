extends Node

var currentLanguage = "en"
var availableLanguages = [
	"en"
]
var langFiles = {}

func _ready():
	for lang in availableLanguages:
		var f = FileAccess.open("res://Translations/" + lang + ".json", FileAccess.READ)
		var json = JSON.new()
		json.parse(f.get_as_text())
		langFiles[lang] = json.data
