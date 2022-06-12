"""
path.gd should be set as an autoload named "PATH".
It holds references to important nodes so other scripts can easily access them.
When one of these nodes is loaded, it should register itself with this script.
For example, when a new screen loads, that screen should update current_screen.
"""
extends Node


onready var main := $"../Main"
var current_screen: Node


