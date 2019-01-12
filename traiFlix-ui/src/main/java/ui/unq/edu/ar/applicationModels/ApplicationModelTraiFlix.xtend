package ui.unq.edu.ar.applicationModels

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ui.unq.edu.ar.TraiFlix.Pelicula
import ui.unq.edu.ar.TraiFlix.Serie
import ui.unq.edu.ar.TraiFlix.TraiFlix
import ui.unq.edu.ar.TraiFlix.Usuario
import ui.unq.edu.ar.TraiFlix.Capitulo

@Accessors
@Observable
class ApplicationModelTraiFlix {
	
	TraiFlix modelo
	List<Pelicula> peliculas
	List<Serie> series
	List<Usuario> usuarios
	Pelicula peliculaSeleccionada
	Serie serieSeleccionada
	Capitulo capituloSeleccionado
	String filtroPelicula
	String filtroSerie
	Usuario usuario
	
	new(){
		modelo = new ui.unq.edu.ar.traiFlix_ui.TraiFlixFactory().nuevoTraiFlix
		peliculas = modelo.peliculas
		series = modelo.series
		usuarios = modelo.usuarios
		serieSeleccionada = modelo.series.get(0) // ?
		peliculaSeleccionada = modelo.peliculas.get(0)
		capituloSeleccionado = (modelo.series.get(0)).capitulos.get(0)
		filtroPelicula = ""
		filtroSerie = ""
		usuario = modelo.usuarios.get(0)
	}
	
	def void setFiltroPelicula(String filtro) {
		filtroPelicula = filtro.toLowerCase
		buscarPeliculas()
	}
	
	def void setFiltroSerie(String filtro) {
		filtroSerie = filtro.toLowerCase
		buscarSeries()
	}
	
	def buscarPeliculas() {
		this.peliculas = modelo.peliculas
		.filter[it.titulo.toLowerCase.contains(filtroPelicula)].toList
	}
	
	def buscarSeries() {
		this.series = modelo.series
		.filter[it.titulo.toLowerCase.contains(filtroSerie)].toList
	}
	
	def actualizarSeries(List<Serie> series) {
		modelo.setSeries = series
		buscarSeries()
	}
	def actualizarPeliculas(List<Pelicula> peliculas) {
		modelo.setPeliculas = peliculas
		buscarPeliculas()
	}
	
}
