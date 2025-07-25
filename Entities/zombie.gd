extends CharacterBody2D

@export var move_speed: float = 20
@export var max_health: int = 100
@export var cooldown: = 1.0
@export var ROTATIONSPEED: float = 1
@export var targeter: Targeter

@onready var target = null
@onready var current_health: int = max_health
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D

var can_attack = true
