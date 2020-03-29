extends Node

export (NodePath) var questionbankpath
export (NodePath) var sfxbankpath

onready var questionbanknode = get_node(questionbankpath)
onready var sfxnode = get_node(sfxbankpath)

var answer
var questionnode
var changeH  = 20
var changeM  = 50
var changeS  = 50

func update_resource_ui():
	$ResourcesPanel/HealthResourceBar/Label.text = "health: " + str(changeH)
	$ResourcesPanel/HealthResourceBar/ProgressBar.value = changeH
	$ResourcesPanel/MoneyResourceBar/Label.text = "money: " + str(changeM)
	$ResourcesPanel/MoneyResourceBar/ProgressBar.value = changeM
	$ResourcesPanel/SanityResourceBar/Label.text = "sanity: " + str(changeS)
	$ResourcesPanel/SanityResourceBar/ProgressBar.value = changeS

func _ready():
	update_resource_ui()
	randomize();
	print(randi()%5)
	setQuestion()
	$Message/personSprite.texture=load("res://doorMan.png")


func setSprite(a):
	if a.person==1:
		$Message/personSprite.texture=load("res://doorMan.png")
		$Message/name.text=a.profession
	if a.person==2:
		$Message/personSprite.texture=load("res://kid.png")	
	if a.person==3:
		$Message/personSprite.texture=load("res://wife.png")
	if a.person==4:
		$Message/personSprite.texture=load("res://window.png")
		
		
	
func setQuestion():
	questionnode=questionbanknode.get_child(randi()%6)
	var questiontext = questionnode.fact
	setSprite(questionnode)
	print(questiontext)
	$QuestionPanel/Label.text = questiontext
	answer = questionnode.answer
	
func updateStats(decision):
	if decision == true:
		changeH += questionnode.healthyes
		changeM += questionnode.moneyyes
		changeS += questionnode.sanityyes
		$info/Label.text = questionnode.popupyes
	
	if decision == false:
		changeH += questionnode.healthno
		changeM += questionnode.moneyno
		changeS += questionnode.sanityno
		$info/Label.text = questionnode.popupno
	
	update_resource_ui()

func _on_Button_pressed():
	sfxnode.get_child(7).play();
	
	updateStats(false)

	setQuestion()


func _on_Button2_pressed():
	sfxnode.get_child(6).play();
	
	updateStats(true)

	setQuestion()


func _on_ok_pressed():
	$info.hide()
