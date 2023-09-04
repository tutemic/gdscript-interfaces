# Adding support for interfaces in GDScript

This script is designed to add the functionality to implement make-shift interfaces to your GDScript Godot project until an official solution is made available.

An explanation of why to use interfaces, and how this script was generally created, Tutemic livestreamed it on YouTube here: [Tutemic YouTube tutorial](https://www.youtube.com/watch?v=pBs6c902P0Q)

If you found this useful, feel free to support Tutemic on YouTube: [Tutemic on YouTube](https://www.youtube.com/@tutemic) by subscribing!

## How to use

### Installing the interfaces script
Copy this interface.gd script somewhere in your Godot project folder. Within your Godot project within the Godot editor, make this script an autoload script, with the recommended node name Interface.

### Defining custom interfaces
To define a custom interface, create a sub-class, as shown in the example below:

  class ExampleInterface:
    var example_property
    
    signal example_signal
    
    func example_method():
      pass

### Implementing your custom interfaces
To implement a custom interface you defined above, type the following
in any class script (using the example name above):

  var implements = Interface.ExampleInterface

### Checking if a node implements a custom interface you created
To check if a node implements a custom interface you defined above,
you may type something like the following anywhere in your codebase:

  if Interface.node_implements_interface(myNode, Interface.ExampleInterface):
    ...
