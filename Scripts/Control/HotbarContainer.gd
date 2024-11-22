extends GridContainer


@onready var hotbarPanel:Hotbar_Panel = $HotbarPanel
@onready var hotbarPanel2:Hotbar_Panel = $HotbarPanel2
@onready var hotbarPanel3:Hotbar_Panel = $HotbarPanel3
@onready var hotbarPanel4:Hotbar_Panel = $HotbarPanel4
@onready var hotbarPanel5:Hotbar_Panel = $HotbarPanel5
@onready var hotbarPanel6:Hotbar_Panel = $HotbarPanel6
@onready var hotbarPanel7:Hotbar_Panel = $HotbarPanel7
@onready var hotbarPanel8:Hotbar_Panel = $HotbarPanel8
@onready var hotbarPanel9:Hotbar_Panel = $HotbarPanel9
@onready var hotbarPanel10:Hotbar_Panel = $HotbarPanel10
@onready var panels = [hotbarPanel, hotbarPanel2, hotbarPanel3, hotbarPanel4, hotbarPanel5, 
hotbarPanel6, hotbarPanel7, hotbarPanel8, hotbarPanel9, hotbarPanel10]

@onready var selected_panel_index = 1
@onready var selected_panel = hotbarPanel

signal hotbar_panel_selected
func set_panel(panel:Hotbar_Panel, index:int):
	selected_panel = panel
	selected_panel_index = index
	emit_signal("hotbar_panel_selected", index)

# Called when the node enters the scene tree for the first time.
func _ready():
	select_panel_by_panel(selected_panel)

func _input(event):
	if event.is_action_pressed("scroll_down"):
		scroll_right()
	elif event.is_action_pressed("scroll_up"):
		scroll_left()
	elif event.is_action_pressed("item_1"):
		select_panel_by_index(0)
	elif event.is_action_pressed("item_2"):
		select_panel_by_index(1)
	elif event.is_action_pressed("item_3"):
		select_panel_by_index(2)
	elif event.is_action_pressed("item_4"):
		select_panel_by_index(3)
	elif event.is_action_pressed("item_5"):
		select_panel_by_index(4)
	elif event.is_action_pressed("item_6"):
		select_panel_by_index(5)
	elif event.is_action_pressed("item_7"):
		select_panel_by_index(6)
	elif event.is_action_pressed("item_8"):
		select_panel_by_index(7)
	elif event.is_action_pressed("item_9"):
		select_panel_by_index(8)
	elif event.is_action_pressed("item_10"):
		select_panel_by_index(9)
	
func scroll_right():
	selected_panel_index += 1
	if selected_panel_index > 9:
		selected_panel_index = 0
	
	select_panel_by_index(selected_panel_index)

func scroll_left():
	selected_panel_index -= 1
	if selected_panel_index < 0:
		selected_panel_index = 9
	
	select_panel_by_index(selected_panel_index)

func select_panel_by_index(index:int):
	var i = 0
	for panel in panels:
		if i == index:
			panel.set_selected(true)
			set_panel(panel, i)
		else:
			panel.set_selected(false)
		
		i += 1

func select_panel_by_panel(select_panel:Hotbar_Panel):
	var i = 0
	for panel in panels:
		if select_panel == panel:
			panel.set_selected(true)
			set_panel(select_panel, i)
		else:
			panel.set_selected(false)
		
		i += 1

func update_hotbarPanels(inventory:Dictionary):
	var i = 0
	for panel in panels:
#		get the item
		var item = inventory[i]
#		find the texture
		var texture
		if item == null:
			texture = null
		else:
			texture = item.hotbarTexture
			#texture = item.instance().hotbarTexture_get()
			
#		set the texture
#		panel.sprite.set_texture(texture)
		panel.change_sprite_texture(texture)
		
#		increment to next inventory item
		i += 1
