package server

import ui.unq.edu.ar.TraiFlix.Serie
import ui.unq.edu.ar.TraiFlix.Material
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@Accessors
class SimpleSerie extends Material {
	
	int id
	String type
    String titulo
    String categoria
    String clasificacion
    String creadores
    int temporadas
    int rating
    List<SimpleContenido> contenidoRelacionado
    List<SimpleCapitulo> capitulos
    String portada
        
	new() {}
	
	new(Serie serie) {
		this.id = serie.codigo
		this.type = "serie"
		this.titulo = serie.titulo
		this.categoria = serie.categoria
		this.clasificacion = serie.clasificacion
		this.creadores = serie.creadores
		this.temporadas = serie.temporadas.size
		this.rating = serie.rating
		this.contenidoRelacionado = AppController.contenidoRelacionaSimple(serie)
		this.capitulos = new ArrayList
		this.portada = serie.linkPortada
	}
	
}