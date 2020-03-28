extends Node

export (NodePath) var questionbankpath
onready var questionbanknode = get_node(questionbankpath)
var answer
var questionnode
var changeH  = 5
var changeM  = 5
var changeF  = 5


func _ready():
	$health.text="health"+str(changeH)
	$food.text="food"+str(changeF)
	$money.text="money"+str(changeM)
	
	randomize();
	print(randi()%5)
	setQuestion()
	
	
func setQuestion():
	questionnode=questionbanknode.get_child(randi()%5)
	var questiontext = questionnode.fact
	print(questiontext)
	$Panel/Label.text=questiontext
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
			
	$health.text="health"+str(changeH)
	$food.text="food"+str(changeF)
	$money.text="money"+str(changeM)	
	


func _on_Button_pressed():
	updateStats(false)
	if answer == true :
		print("you are correct!\n")

	else:
		print("you are wrong\n")	
		
	setQuestion();	


func _on_Button2_pressed():
	updateStats(true)
	if answer == false :
		print("you are correct!\n")
	else:
		print("you are wrong\n")
	
	setQuestion();
	

		
		
		
		
		
