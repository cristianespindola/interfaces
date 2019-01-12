package ui.unq.edu.ar.applicationModels

import java.util.ArrayList
import java.util.HashMap
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ui.unq.edu.ar.TraiFlix.Capitulo
import ui.unq.edu.ar.TraiFlix.Serie
import ui.unq.edu.ar.TraiFlix.Material
import ui.unq.edu.ar.TraiFlix.Pelicula
import ui.unq.edu.ar.applicationModels.ApplicationModel

@Accessors
@Observable
class ApplicationModelSerie {
	
	List<String> clasificaciones
	List<Capitulo> capitulos
	List<Material> contenidoRelacionado
	Material contenidoRelacionadoSeleccionado
	Serie serie
	Serie serieEstadoOriginal
	Capitulo capitulo
	Capitulo capituloEstadoOriginal
	String fechaEstrenoCapitulo
	ApplicationModelTraiFlix traiFlixModelo
	
	// Constructor a usar al borrar/modificar una serie.
	new(Serie serie, ApplicationModelTraiFlix traiFlixModelo) {
		this.clasificaciones = ApplicationModel.clasificacionesActuales
		this.traiFlixModelo = traiFlixModelo
		this.serie = serie
		this.serieEstadoOriginal = ApplicationModel.clonarSerie(serie)
		this.capitulos = serie.capitulos
	}
	
	// Constructor a usar al agregar nueva serie.
	new(ApplicationModelTraiFlix traiFlix) {
		this.clasificaciones = ApplicationModel.clasificacionesActuales
		this.traiFlixModelo = traiFlix
		this.serie = new Serie()
		this.serie.temporadas = new HashMap<Integer, List<Capitulo> >()
		this.serie.contenidoRelacionadoPelicula = new ArrayList<Pelicula>()
		this.serie.contenidoRelacionadoSerie = new ArrayList<Serie>()
		this.capitulo = new Capitulo()
		this.fechaEstrenoCapitulo = ""
		this.capitulos = new ArrayList
	}
	
	// Guarda en un colaborador una copia del capítulo seleccionado para poder revertir los cambios.
	def guardarCapituloEstadoOriginal() {
		this.capituloEstadoOriginal = ApplicationModel.clonarCapitulo(this.capitulo)
	}
	
	// Guarda en un colaborador el contenido relacionado disponible en el sistema para la serie.
	def guardarContenidoRelacionado() {
		var copiaSeries = new ArrayList(this.traiFlixModelo.series)
		copiaSeries.removeIf(serie | serie.getCategoria != this.serie.getCategoria )
		copiaSeries.removeIf(serie | serie.getCodigo == this.serie.getCodigo )
		for(Serie s: this.serie.getContenidoRelacionadoSerie) {
			copiaSeries.removeIf(serie | serie.getCodigo == s.getCodigo)
		}
		var copiaPeliculas = new ArrayList(this.traiFlixModelo.peliculas)
		copiaPeliculas.removeIf(peli | peli.getCategoria != this.serie.getCategoria )
		for(Pelicula p: this.serie.getContenidoRelacionadoPelicula) {
			copiaPeliculas.removeIf(peli | peli.getCodigo == p.getCodigo)
		}
		this.contenidoRelacionado = new ArrayList
		this.contenidoRelacionado.addAll(copiaSeries)
		this.contenidoRelacionado.addAll(copiaPeliculas)
	}
	
	// Guarda en un colaborador el contenido que ya tiene relacionado la serie.
	def guardarContenidoRelacionadoParaMostrar() {
		this.contenidoRelacionado = new ArrayList
		this.contenidoRelacionado.addAll(this.serie.getContenidoRelacionadoSerie)
		this.contenidoRelacionado.addAll(this.serie.getContenidoRelacionadoPelicula)
	}
	
	// Agrega una nueva serie al sistema.
	def agregarNuevaSerie() { 
		var copiaSeries = new ArrayList(this.traiFlixModelo.series)
		copiaSeries.add(this.serie)
		traiFlixModelo.actualizarSeries(copiaSeries)
	}
	
	// Elimina la serie seleccionada del sistema.
	def borrarSerie() {
		var copiaSeries = new ArrayList(this.traiFlixModelo.series)
		copiaSeries.remove(this.serie)
		for(Serie s : copiaSeries) {
			s.getContenidoRelacionadoSerie().removeIf(serie | serie.getCodigo() == this.serie.getCodigo())
		}
		for(Pelicula p : this.traiFlixModelo.peliculas) {
			p.getContenidoRelacionadoSerie().removeIf(serie | serie.getCodigo() == this.serie.getCodigo())
		}
		traiFlixModelo.actualizarSeries(copiaSeries)
    }
	
	// Agrega un nuevo capítulo a la serie y reinicia las instancias guardadas en el AppModelSerie del capítulo
	// en caso de que se sigan agregando capítulos.
	def agregarNuevoCapitulo() {
		this.eliminarCapitulo()
		this.capitulo.fechaEstreno = ApplicationModel.strToDate(this.fechaEstrenoCapitulo)
		this.serie.agregarCapitulo(this.capitulo)
		reiniciarDatosCapitulo()
	}
	
	def reiniciarDatosCapitulo() {
		this.capitulos = this.serie.capitulos
		this.capitulo = new Capitulo()
		this.fechaEstrenoCapitulo = ""
		this.capituloEstadoOriginal = null
	}
	
	//
	
	// Agrega a la serie el contenido relacionado (de la misma categoría) disponible en ese momento.
	def agregarContenidoRelacionado() {
		if(this.contenidoRelacionadoSeleccionado.getClass().name == Pelicula.name) {
			this.serie.getContenidoRelacionadoPelicula.add(this.contenidoRelacionadoSeleccionado as Pelicula)
		} else {
			this.serie.getContenidoRelacionadoSerie.add(this.contenidoRelacionadoSeleccionado as Serie)
		}
	}
	
	// Elimina de la serie que se está modificando el contenido seleccionado.
	def eliminarContenidoRelacionado() {
		if(this.contenidoRelacionadoSeleccionado.getClass().name == Pelicula.name) {
			this.serie.getContenidoRelacionadoPelicula.remove(this.contenidoRelacionadoSeleccionado as Pelicula)
		} else {
			this.serie.getContenidoRelacionadoSerie.remove(this.contenidoRelacionadoSeleccionado as Serie)
		}
	}
	
	// Elimina del sistema la serie modificada y agrega la copia de la original.
	def cancelarCambiosASerie() {
		var copiaSeries = new ArrayList(this.traiFlixModelo.series)
		copiaSeries.remove(this.serie)
		copiaSeries.add(this.serieEstadoOriginal)
		this.traiFlixModelo.series = copiaSeries
	}
	
	// Elimina de la serie el episodio modificado y agrega la copia del original.
	def cancelarCambiosACapitulo() {
		if(this.capituloEstadoOriginal !== null) {
			this.eliminarCapitulo()
			this.serie.agregarCapitulo(this.capituloEstadoOriginal)
		}
	}
	
	// Elimina el episodio seleccionado de la serie que se está editando.
	def eliminarCapitulo() {
		val capitulos = this.serie.getCapitulos()
		this.serie.temporadas = new HashMap<Integer, List<Capitulo> >()
		for(Capitulo c : capitulos) {
			if(c != this.capitulo) {
				this.serie.agregarCapitulo(c)
			}
		}
		this.capitulos = serie.capitulos
		
	}
	
	// Guarda en un colaborador la fecha de estreno del episodio en formato dd/mm/yyyy.
	def setFechaEstrenoParaMostrar() {
		this.fechaEstrenoCapitulo = ApplicationModel.formatearFechaEstrenoParaMostrar(this.capitulo.getFechaEstreno)
	}
}
