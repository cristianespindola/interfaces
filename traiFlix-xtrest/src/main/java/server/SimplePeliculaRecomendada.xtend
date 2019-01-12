package server

import java.time.LocalDate
import ui.unq.edu.ar.TraiFlix.Pelicula
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SimplePeliculaRecomendada extends SimpleContenido{
	int id 
	String type
	String titulo
	String fechaEstreno
	
	new(Pelicula pelicula) {
		this.id = pelicula.codigo
		this.type = "movie"
		this.titulo = pelicula.titulo
		this.fechaEstreno = pelicula.fechaDeEstreno.toString
	}
	
}