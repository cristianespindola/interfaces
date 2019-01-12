package server

import ui.unq.edu.ar.TraiFlix.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.util.List
import ui.unq.edu.ar.TraiFlix.Pelicula
import ui.unq.edu.ar.TraiFlix.Recomendaciones
import java.util.ArrayList

@Accessors
class SimplePelicula {
	
	int id
	String type
	String titulo
	String categoria 
	String clasificacion
	String fechaDeEstreno
	int duracion
	String directores
	String actores
	String link
	String portada
	int ranking
	List<SimpleContenido> contenidoRelacionado
	
	new(){}
	
	new(Pelicula pelicula) {
		this.id = pelicula.codigo
		this.type = "movie"
		this.titulo = pelicula.titulo
		this.categoria = pelicula.categoria
		this.clasificacion = pelicula.clasificacion
		this.fechaDeEstreno = pelicula.fechaDeEstreno.toString
		this.duracion = pelicula.duracion
		this.directores = pelicula.directores
		this.actores = pelicula.actores
		this.link = pelicula.linkYT
		this.portada = pelicula.linkPortada
		this.ranking = pelicula.rating
		this.contenidoRelacionado = AppController.contenidoRelacionaSimple(pelicula)
	}
}
