package server

import ui.unq.edu.ar.TraiFlix.Serie
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SimpleSerieRecomendada extends SimpleContenido {
	int id
	String type
    String titulo
    
	new() {}
	
	new(Serie serie) {
		this.id = serie.codigo
		this.type = "serie"
		this.titulo = serie.titulo
	}
	
}