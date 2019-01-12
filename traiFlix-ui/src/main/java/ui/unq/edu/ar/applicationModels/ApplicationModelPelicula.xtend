package ui.unq.edu.ar.applicationModels

import java.util.List
import ui.unq.edu.ar.TraiFlix.Material
import ui.unq.edu.ar.TraiFlix.Pelicula
import java.util.ArrayList
import ui.unq.edu.ar.TraiFlix.Serie
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.text.SimpleDateFormat

@Accessors
@Observable
class ApplicationModelPelicula {
	List<String> clasificaciones
	List<Material> contenidoRelacionado
	Material contenidoRelacionadoSeleccionado
	Pelicula pelicula
	Pelicula peliculaEstadoOriginal
	String fechaDeEstreno
	ApplicationModelTraiFlix traiFlix
		
	new(ApplicationModelTraiFlix traiFlix) {
		this.clasificaciones = this.clasificacionesActuales
		this.pelicula = new Pelicula()
		this.pelicula.contenidoRelacionadoPelicula = new ArrayList<Pelicula>()
		this.pelicula.contenidoRelacionadoSerie = new ArrayList<Serie>()
		this.fechaDeEstreno = ""
		this.traiFlix = traiFlix
		contenidoRelacionado = new ArrayList<Material>()
		}
	
	new(Pelicula pelicula, ApplicationModelTraiFlix traiFlix) {
		this.clasificaciones = this.clasificacionesActuales
		this.pelicula = pelicula
		this.peliculaEstadoOriginal = this.clonarPelicula(pelicula)
		this.traiFlix = traiFlix
		contenidoRelacionado = new ArrayList<Material>()
	}
	
	def clonarPelicula(Pelicula pelicula) {
		var clon = new Pelicula(pelicula.codigo, pelicula.titulo, pelicula.categoria, pelicula.clasificacion, pelicula.fechaDeEstreno, pelicula.duracion, pelicula.directores, pelicula.actores, pelicula.linkYT)
		clon.contenidoRelacionadoPelicula = pelicula.contenidoRelacionadoPelicula
		clon.contenidoRelacionadoSerie = pelicula.contenidoRelacionadoSerie
		return clon
	}
	
	def clasificacionesActuales() {
		var clasificaciones = new ArrayList
		clasificaciones.add("ATP")
		clasificaciones.add("+13")
		clasificaciones.add("+16")
		clasificaciones.add("+18")
		return clasificaciones	
	}
	
	def borrarPelicula() {
		var copiaPeliculas = new ArrayList(this.traiFlix.peliculas)
		copiaPeliculas.remove(this.pelicula)
		traiFlix.actualizarPeliculas(copiaPeliculas)
		for(Pelicula p : this.traiFlix.peliculas) {
			p.contenidoRelacionadoPelicula.removeIf(serie | serie.getCodigo == this.pelicula.getCodigo)
		}
		for(Serie s : this.traiFlix.series) {
			s.getContenidoRelacionadoPelicula.removeIf(serie | serie.getCodigo() == this.pelicula.getCodigo())
		}
	}
	
	def agregarPelicula() {
		var newPeliculas = new ArrayList(this.traiFlix.peliculas)
		newPeliculas.add(this.pelicula)
		this.traiFlix.actualizarPeliculas( newPeliculas)
	}
	
	def setFechaEstrenoParaMostrar() {
		var formatoFecha = new SimpleDateFormat("dd/MM/yyyy")
		this.fechaDeEstreno = formatoFecha.format(this.pelicula.fechaDeEstreno)
	}
	
	def guardarPeliculaEstadoOriginal() {
		this.peliculaEstadoOriginal = this.clonarPelicula(this.pelicula)
	}
	
	def guardarContenidoRelacionado() {
		var copiaSeries = new ArrayList(this.traiFlix.series)
		copiaSeries.removeIf(serie | serie.getCategoria != this.pelicula.getCategoria )
		
		var copiaPeliculas = new ArrayList(this.traiFlix.peliculas)
		copiaPeliculas.removeIf(peli | peli.getCategoria != this.pelicula.getCategoria )
				
		copiaPeliculas.removeIf(peli | peli.getCodigo == this.pelicula.getCodigo)
		copiaSeries.removeIf(serie | serie.getCodigo == this.pelicula.getCodigo)
		
		this.contenidoRelacionado = new ArrayList
		this.contenidoRelacionado.addAll(copiaSeries)
		this.contenidoRelacionado.addAll(copiaPeliculas)
	}
	
	def agregarContenidoRelacionado() {
		if (this.contenidoRelacionadoSeleccionado.getClass().name == Pelicula.name) {
			this.pelicula.getContenidoRelacionadoPelicula.add(this.contenidoRelacionadoSeleccionado as Pelicula)
		} else {
			this.pelicula.getContenidoRelacionadoSerie.add(this.contenidoRelacionadoSeleccionado as Serie)
		}
		guardarContenidoRelacionado
	}
	
	def guardarContenidoRelacionadoParaMostrar() {
		this.contenidoRelacionado = new ArrayList
		this.contenidoRelacionado.addAll(this.pelicula.getContenidoRelacionadoSerie)
		this.contenidoRelacionado.addAll(this.pelicula.getContenidoRelacionadoPelicula)
	}
	
	def eliminarContenidoRelacionado() {
		if(this.contenidoRelacionadoSeleccionado.getClass().name == Pelicula.name) {
			this.pelicula.getContenidoRelacionadoPelicula.remove(this.contenidoRelacionadoSeleccionado as Pelicula)
		} else {
			this.pelicula.getContenidoRelacionadoSerie.remove(this.contenidoRelacionadoSeleccionado as Serie)
		}
		guardarContenidoRelacionado
	}
		
}
