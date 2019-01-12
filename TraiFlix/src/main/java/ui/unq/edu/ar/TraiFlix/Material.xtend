package ui.unq.edu.ar.TraiFlix

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
abstract class Material {
	
	int codigo
	String titulo
	String categoria
	String clasificacion

}