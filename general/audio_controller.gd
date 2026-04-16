extends Node

@onready var music_winter: AudioStreamPlayer = $"music winter"


func play_music():
	music_winter.play()
