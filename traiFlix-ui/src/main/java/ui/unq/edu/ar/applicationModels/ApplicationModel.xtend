package ui.unq.edu.ar.applicationModels

import java.text.SimpleDateFormat
import java.util.ArrayList
import ui.unq.edu.ar.TraiFlix.Capitulo
import ui.unq.edu.ar.TraiFlix.Serie
import java.util.Date

class ApplicationModel {
	
	// Retorna una nueva instancia de Serie que es una copia de la recibida como parámetro.
	def static clonarSerie(Serie serie) {
		var clon = new Serie(serie.codigo, serie.titulo, serie.categoria, serie.clasificacion, serie.creadores)
		for(Capitulo c : serie.getCapitulos()) {
			clon.agregarCapitulo(clonarCapitulo(c))
		}
		clon.contenidoRelacionadoPelicula.addAll(serie.contenidoRelacionadoPelicula)
		clon.contenidoRelacionadoSerie.addAll(serie.contenidoRelacionadoSerie)
		return clon
	}
	
	// Retorna una nueva instancia de Capitulo que es una copia de la recibida como parámetro.
	def static clonarCapitulo(Capitulo c) {
		var clon = new Capitulo(c.codigo, c.titulo, c.nroTemporada, c.nroCapitulo, c.fechaEstreno,
			                    c.duracion, c.directores, c.actoresPrincipales, c.linkYT)
	    return clon
	}
	
	// Retorna todas las clasificaciones usadas en el modelo.
	def static clasificacionesActuales() {
		var clasificaciones = new ArrayList
		clasificaciones.add("ATP")
		clasificaciones.add("+13")
		clasificaciones.add("+16")
		clasificaciones.add("+18")
		return clasificaciones
	}
	
	// Retorna un Date parseando el string de fecha en formato dd/mm/yyyy ingresado en la ventana CapitulosWindow.
	def static strToDate(String str) {
		var date = new SimpleDateFormat("dd/MM/yyyy").parse(str)
		return date
	}
	
	// Retorna un String a partir de la la fecha recibida en formato dd/mm/yyyy.
	def static formatearFechaEstrenoParaMostrar(Date fecha) {
		var formatoFecha = new SimpleDateFormat("dd/MM/yyyy")
		return formatoFecha.format(fecha)
	}
}
