package ui.unq.edu.ar.TraiFlix

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Recomendacion {
	
	Material material
	int cantidad
	
	new() {}
	
	new(Material material) {
		this.material = material
		this.cantidad = 0
	} 
}