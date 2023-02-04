atoms = {};

/// @function add_atom(atom, [atomName])
/// @param _atom The created Atom to add to this Molecule
/// @param {String} _atom_name A unique name for the atom to be added. If not provided, the atom's class name is used
/// @description Adds an Atom to this Molecule, registering it and starting its step function running
/// @returns The Atom which has been added, so it can be assigned to a convenience variable
function add_atom(_atom, _atom_name = "") {
	if (is_method(_atom.register)) {
		_atom.register(id);
		var _name = instanceof(_atom);
		if (_atom_name != "") {
			_name = _atom_name;
		}
		if (!variable_struct_exists(atoms, _name)) {
			variable_struct_set(atoms, _name, _atom);
		} else {
			throw { 
				errorName: "nonUniqueAtomError", 
				errorMessage: "An Atom with the given name " + _name + " already exists on this Molecule"
			}
		}
		return _atom;
	}
}

/// @function get_atom(_atom_name)
/// @param {String} _atom_name The name of the Atom to get for this Molecule
/// @returns The atom whose name matches that given, or noone if not found
function get_atom(_atom_name) {
	var _result = noone;
	if (variable_struct_exists(atoms, _atom_name)) {
		_result = variable_struct_get(atoms, _atom_name);
	}
	return _result;
}

/// @function atom_foreach(_function)
/// @param _function A function which takes an Atom as an argument
/// @param _args An array of arguments to pass to _function
/// Iterates through all the Atoms on this Molecule and performs _function on them
function atom_foreach(_function, _args = []) {
	var _keys = variable_struct_get_names(atoms);
	for (var i = 0; i < array_length(_keys); i++) {
		var _atom = variable_struct_get(atoms, _keys[i]);
		_function(_atom, _args);
	}
}