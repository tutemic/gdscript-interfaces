extends Node
## Check the README.md in the GitHub repository for this script
## at https://github.com/tutemic/gdscript-interfaces for more information
##
## How to use -------
## 
## Make this script an autoload script, with the recommended node name Interface
##
## Define your interfaces here
## class ExampleInterface:
## 		var example_property
##
## 		signal example_signal
##
## 		func example_method():
## 			pass
##
## -------
## To implement a custom interface you defined above, type the following
## in any class script (using the example name above):
## var implements = Interface.ExampleInterface
##
## -------
## To check if a node implements a custom interface you defined above,
## you may type something like the following anywhere in your codebase:
## if Interface.node_implements_interface(myNode, Interface.ExampleInterface)


## Takes a node and an interface, and returns true if the given node
## implements the given interface, and false if it does not
func node_implements_interface(node_to_check:Node, interface) -> bool:
	if "implements" in node_to_check:
		var node_implements = node_to_check.implements

		if not node_implements is Array:
			if node_implements == interface:
				return true
		else: 
			for implemented_interface in node_implements:
				if implemented_interface == interface:
					return true
		
	return false


## Get an array of all the descendants of the given node, and includes the given node
func _get_all_descendants(node:Node) -> Array:
	var all_descendants = [node]
	
	var children = node.get_children()
	for child in children:
		all_descendants.append_array(_get_all_descendants(child))

	return all_descendants
	


func _ready():
	var all_the_darn_nodes = _get_all_descendants(get_tree().current_scene)
	
	for node in all_the_darn_nodes:
		_check_node(node)
	
	get_tree().node_added.connect(_check_node)


## Checks to the given node's methods, properties, and signals to see if they match the
## interface's methods, properties, and signals, throwing an error if not. 
func _check_node(node:Node) -> void:
	if "implements" in node:
		var node_implements = node.implements
		
		var check = func (node, interface_instance):
			var error_string:String = "Interface error: " + node.name + " does not possess the "
		
			
			## NOTE: if an error happened here, it's because your interface system probably worked!
			## Check the error in your Godot editor to see which method, property, or signal
			##   did not match the interface you set up above
			for method in interface_instance.get_script().get_script_method_list():
				assert(method.name in node, error_string + method.name + " method.")
			for this_signal in interface_instance.get_script().get_script_signal_list():
				assert(this_signal.name in node, error_string + this_signal.name + " signal.")
			var prop_list:Array = interface_instance.get_script().get_script_property_list()
			for i in range(1, prop_list.size()):  # skip first property as the default is the property "Built-in script"
				var property = prop_list[i]
				assert(property.name in node, error_string + property.name + " property.")
			
		
		if not node_implements is Array: 
			var instance = node.implements.new()
			check.call(node, instance)
		else:
			for implemented_interface in node_implements:
				var instance = implemented_interface.new()
				check.call(node, instance)
