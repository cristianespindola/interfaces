package ui.unq.edu.ar.TraiFlix

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.Date
import java.util.ArrayList
import java.time.LocalDate
import java.time.temporal.ChronoUnit
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Usuario {
	int codigo
	String nombreUsuario
	String nombre
	LocalDate fechaRegistro 
	LocalDate fechaNacimiento
	List<Usuario> amigos
	List<Pelicula> peliculasVistas
	List<Capitulo> capitulosVistos
	List<Material> contenidoFavorito
	Recomendaciones contenidoSugeridoPorAmigos
	
	
	new(){	}
	
	new(int codigo, String nombreUsuario, String nombre, LocalDate fechaRegistro, LocalDate fechaNacimiento){
		this.codigo = codigo
		this.nombreUsuario = nombreUsuario
		this.nombre = nombre
		this.fechaRegistro = fechaRegistro
		this.fechaNacimiento = fechaNacimiento
		this.amigos = new ArrayList<Usuario>()
		this.peliculasVistas = new ArrayList<Pelicula>()
		this.capitulosVistos = new ArrayList<Capitulo>()
		this.contenidoFavorito = new ArrayList<Material>()
		this.contenidoSugeridoPorAmigos = new Recomendaciones()
	}
	
	
	def valorarPelicula(Pelicula pelicula, Integer cantidadDeEstrellas){		
		pelicula.valoracion.agregarValoracion(cantidadDeEstrellas)
	}
	

	def valorarCapitulo(Capitulo capitulo, Integer cantidadDeEstrellas){
		capitulo.valoraciones.agregarValoracion(cantidadDeEstrellas)
	}
	
	def agregarAmigo(Usuario amigo) {
		amigos.add(amigo)
	}
	
	def getEdad() {
		return ChronoUnit.YEARS.between( 
		    this.fechaNacimiento, 
		    LocalDate.now())
	}
	
	def agregarPeliculaVista(Pelicula pelicula) {
		this.peliculasVistas.add(pelicula)
	}
	
	def agregarCapituloVisto(Capitulo capitulo) {
		this.capitulosVistos.add(capitulo)
	}
	
	def vioDeFormaCompleta(Serie serie) {
		var capitulosDeSerie = serie.getCapitulos
		if( capitulosDeSerie.isEmpty ){
			return false // porque no tiene ni un capitulo
		}
		return capitulosVistos.containsAll( capitulosDeSerie )	
	}
	
	def sugerirContenido(Material material, Usuario usuario) {
		if(usuario.getAmigos().contains(this)) {
			usuario.getContenidoSugeridoPorAmigos().recomendar(material)
	    }
	}
	
	def agregarAFavoritos(Material material) {
		contenidoFavorito.add(material)
	}
	
	def quitarDeFavoritos(Material material) {
		contenidoFavorito.remove(material)
	}
	
}	
