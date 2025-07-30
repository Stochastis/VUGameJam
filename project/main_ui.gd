extends Control
class_name MainUI

@onready var decay_meter: ProgressBar = $DecayMeter
@onready var repair_replace_progress_bar: ProgressBar = $RepairReplaceProgressBar
@onready var repair_replace_label: Label = $RepairReplaceProgressBar/RepairReplaceLabel
@onready var score_amount: Label = $ScorePanel/Score/ScoreAmount

@export var repRepProgressBar: ProgressBar
