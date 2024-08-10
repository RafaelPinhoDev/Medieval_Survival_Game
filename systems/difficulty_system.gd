extends Node

@export var mob_spawner: MobSpawner
@export var initial_spawn_rate: float = 60.0
@export var spawn_rate_per_minute: float = 30.0
@export var wave_duraction: float = 20.0
@export var break_intensity: float = 0.5
var time: float = 0.0
#Onda de dificuldade
func _process(delta: float) -> void:
	#Ignorar game over
	if GameManager.is_game_over: return
	#Incrementar Temporizador
	time += delta
	
	#Dificuldade Linear (Linha Verde)
	var spawn_rate =  initial_spawn_rate + spawn_rate_per_minute * (time / 60.0) 
	#Sistema de Ondas (Linha Rosa)
	var sin_wave = sin((time * TAU) / wave_duraction)  #2Pi = TAU
 	#função que pega o min, max e transforma ela para que saia o resultado q a gente deseja
	var wave_factor = remap(sin_wave, -1.0, 1.0, break_intensity, 1)
	spawn_rate *=wave_factor
	#Aplica dificuldade
	mob_spawner.mobs_per_minute = spawn_rate
	
	
