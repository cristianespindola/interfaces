package ui.unq.edu.ar.TraiFlix

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.Date
import java.util.List
import java.util.ArrayList
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import java.time.LocalDate

@Accessors
@Observable
class Pelicula extends Material{
	
	LocalDate fechaDeEstreno
	int duracion
	String directores
	String actores
	Valoracion valoracion
	String linkYT
	String linkPortada
	List<Pelicula> contenidoRelacionadoPelicula
	List<Serie> contenidoRelacionadoSerie
    
	new() {}
	new(int codigo, String titulo, String categoria, String clasificacion,
		LocalDate fechaDeEstreno, int duracion, String directores, String actores,
		String linkYT) {
			this.codigo = codigo
			this.titulo = titulo
			this.categoria = categoria
			this.clasificacion = clasificacion
			this.fechaDeEstreno = fechaDeEstreno
			this.duracion = duracion
			this.directores = directores
			this.actores = actores
			this.linkYT = linkYT
			this.valoracion = new Valoracion()
			this.contenidoRelacionadoPelicula = new ArrayList<Pelicula>()
			this.contenidoRelacionadoSerie = new ArrayList<Serie>()
		}
		
	def getRating() {
		return this.valoracion.getRating
	}
	
}