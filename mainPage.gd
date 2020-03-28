extends Node

export (NodePath) var questionbankpath

onready var questionbanknode = get_node(questionbankpath)

var answer
var questionnode
var changeH  = 20
var changeM  = 50
var changeF  = 50

func update_resource_ui():
	$ResourcesPanel/HealthResourceBar/Label.text = "health: " + str(changeH)
	$ResourcesPanel/HealthResourceBar/ProgressBar.value = changeH
	$ResourcesPanel/MoneyResourceBar/Label.text = "money: " + str(changeM)
	$ResourcesPanel/MoneyResourceBar/ProgressBar.value = changeM
	$ResourcesPanel/SanityResourceBar/Label.text = "sanity: " + str(changeF)
	$ResourcesPanel/SanityResourceBar/ProgressBar.value = changeF

func _ready():
	update_resource_ui()
	randomize();
	print(randi()%5)
	setQuestion()
	
func setQuestion():
	questionnode=questionbanknode.get_child(randi()%5)
	var questiontext = questionnode.fact
	print(questiontext)
	$QuestionPanel/Label.text = questiontext
	answer = questionnode.answer
	
func updateStats(decision):
	if decision == true:
		changeH += questionnode.healthyes
		changeM += questionnode.moneyyes
		changeF += questionnode.foodyes
	
	if decision == false:
		changeH += questionnode.healthno
		changeM += questionnode.moneyno
		changeF += questionnode.foodno
	
	update_resource_ui()

func _on_Button_pressed():
	updateStats(false)
	if answer == true :
		print("you are correct!\n")

	else:
		print("you are wrong\n")
	setQuestion()


func _on_Button2_pressed():
	updateStats(true)
	if answer == false :
		print("you are correct!\n")
	else:
		print("you are wrong\n")
	
	setQuestion()
