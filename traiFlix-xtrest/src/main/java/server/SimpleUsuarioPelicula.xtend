package server

import ui.unq.edu.ar.TraiFlix.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.util.List
import ui.unq.edu.ar.TraiFlix.Pelicula
import ui.unq.edu.ar.TraiFlix.Recomendaciones
import java.util.ArrayList

@Accessors
class SimpleUsuarioPelicula {
	
	int id
	String titulo
	String categoria 
	String clasificacion
	String fechaDeEstreno
	int duracion
	String directores
	String actores
	String link
	int ranking
	List<SimpleContenido> contenidoRelacionado
	
	String nombreUsuario
	String nombre
	Boolean visto
	int recomendaciones
	
	new(){}
	
	new(Pelicula pelicula, Usuario usuario){
		this.id = pelicula.codigo
		this.titulo = pelicula.titulo
		this.categoria = pelicula.categoria
		this.clasificacion = pelicula.clasificacion
		this.fechaDeEstreno = pelicula.fechaDeEstreno.toString
		this.duracion = pelicula.duracion
		this.directores = pelicula.directores
		this.actores = pelicula.actores
		this.link = pelicula.linkYT
		this.ranking = pelicula.rating
		this.contenidoRelacionado = AppController.contenidoRelacionaSimple(pelicula)
		this.nombreUsuario = usuario.nombreUsuario
		this.nombre = usuario.nombre
		this.visto = vioPelicula(usuario, pelicula)
		this.recomendaciones = usuario.contenidoSugeridoPorAmigos.recomendaciones.size	
	}
			
	def nombreUsuarioDeAmigos(Usuario usuario) {
		var resAmigos = new ArrayList<String>()
		for(amigo : usuario.amigos){
			resAmigos.add(amigo.nombreUsuario)
		}
		return resAmigos
	}
	
	def vioPelicula(Usuario usuario, Pelicula pelicula) {
		usuario.peliculasVistas.contains(pelicula)
	}
	
}