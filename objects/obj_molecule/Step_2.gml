atom_foreach(function (_atom) {
	if (_atom.enabled) {
		_atom.on_end_step();
	}
});