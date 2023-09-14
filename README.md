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

## Example

Let's say we want to enable any object in our game to have pixel-perfect smooth movement. This task usually involves managing a fractional movement speed, adding and subtracting it, etc. It can be a lot of lines of code and muddy up your actual game logic.

We can instead create an Atom like the following (this could go in any script file):

```
function Transform() : Atom() constructor {
    xspeed = 0;
    yspeed = 0;
    xAdjustment = 0;
    yAdjustment = 0;

    function trunc(number) {
        if (number < 0) {
            return ceil(number);
        } else {
            return floor(number);
        }
    }

    function on_step() {
        var _totalXspeed = xspeed + xAdjustment;
        var _totalYspeed = yspeed + yAdjustment;
        var _truncXspeed = trunc(_totalXspeed );
        var _truncYspeed = trunc(_totalYspeed );
        xAdjustment = _totalXspeed- _truncXspeed ;
        yAdjustment = _totalYspeed - _truncYspeed ;
        instance.x += _truncXspeed ;
        instance.y += _truncYspeed ;
    }
}
```

This handles all the logic of pixel-perfect smooth movement, but it needs to be actually running on our objects to be useful. That's where registering it with a Molecule comes in. Any object in your game which inherits `obj_molecule` can now utilize this. In the object's `Create` event, call:

```
transform = add_atom(new Transform());
```

Then any time you would have updated that object's `hspeed` or `vspeed` variable, instead update `transform.xspeed` and `transform.yspeed`. It will "just work", and you can apply this same Atom to any objects you want, whether they are related to each other or not!
