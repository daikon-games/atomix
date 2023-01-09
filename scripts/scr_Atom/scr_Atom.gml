/// @function Atom()
/// All Atoms should inherit from this class. All functions inside 
/// can be overridden aside from register.
function Atom() constructor {
    instance = noone;
	enabled = true;
    
	function on_register() {
		// to be overridden by children
		// executed after the Atom is registered
	}
	
    function on_step() {
        // to be overridden by children
		// executed on Molecule's Step event
    }
	
	function on_draw_begin() {
		// to be overridden by children
		// executed on Molecule's Draw Begin event
	}
	
	function on_draw() {
		// to be overridden by children
		// executed on Molecule's Draw event
	}
	
	function on_draw_end() {
		// to be overridden by children
		// executed on Molecule's Draw End event
	}
    
    /// @function start(inst_id)
	/// @param _inst_id the ID of the Molecule instance this Atom is a part of
    /// To be called automatically by a Molecule's addAtom function
    function register(_inst_id) {
		instance = _inst_id;
		on_register();
    }
}