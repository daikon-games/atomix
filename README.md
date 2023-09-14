# Atomix
Atomix is a simple framework for GameMaker that allows you to code in a new way. By utilizing Atomix you'll be able to re-use code/functionality easily across multiple objects in an intuitive way.

## Concepts
Atomix introduces two concepts. The first is an `Atom`. Atoms are GML classes that encapsulate certain properties and behaviors. The second is a `Molecule`. Molecules are the new parent object for all your GameMaker objects. Molecules can have zero or more Atoms attached to them, which will imbue the object with all the properties and behaviors of that Atom.

## Molecules
Setting `obj_molecule` as the parent object to any GameMaker object will allow you to add Atoms to it.

Molecules have the following built-in functions:

### add_atom(_atom, _atom_name = "")
Adds an Atom to this Molecule, registering it and starting its events running.
The `_atom` parameter is an instantiated Atom (created using `new`).
The `_atom_name` parameter is optional, if not provided it will default to the Atom's constructor name.

### get_atom(_atom_name)
Finds a registered Atom of this Molecule with a given name.
The `_atom_name` parameter is the name of the Atom to find.

### atoms_foreach(_function, _args = [])
Iterates through all registered Atoms on this Molecule and performs `_function` on them.
The parameter `_function` is a function which takes an Atom instance and an array as its arguments.
The parameter `_args` is an array of arguments to optionally pass to `_function`.

## Atoms
Atoms are the actual reusable code components. You can create Atoms by inheriting from the `Atom` constructor.
It is intended that Atoms will override one or more of the following built-in methods of `Atom`, each of which are no-ops by default.

Registering an Atom onto a Molecule will give the Atom a reference to that Molecule instance, in the `instance` variable.

Atoms also have a `enabled` variable, which if set to `false` will prevent execution of the following methods (besides `on_register`)

### on_register()
This function is executed when an Atom is registered using `obj_molecule.add_atom`.

### on_begin_step()
This function is executed on the parent Molecule's `Begin Step` event.

### on_step()
This function is executed on the parent Molecule's `Step` event.

### on_end_step()
This function is executed on the parent Molecule's `End Step` event.

### on_draw_begin()
This function is executed on the parent Molecule's `Draw Begin` event.

### on_draw()
This function is executed on the parent Molecule's `Draw` event.

### on_draw_end()
This function is executed on the parent Molecule's `Draw End` event.
