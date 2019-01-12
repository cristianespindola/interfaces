package ui.unq.edu.ar.TraiFlix

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.Date
import java.time.LocalDate

@Accessors
@Observable
class Capitulo extends Material {

	int nroTemporada
	int nroCapitulo
	Date fechaEstreno
	int duracion //en minutos
	String directores
	String actoresPrincipales
	Valoracion valoraciones
	String linkYT
	
	new(){
		
	}
	new(int cod, String titulo, int nroTemp, int nroCap, Date fechaEstr, 
		int dur, String directores, String actoresPrnc, String trailerYT ) {
			this.codigo = cod
			this.titulo = titulo
			this.nroTemporada = nroTemp
			this.nroCapitulo = nroCap
			this.fechaEstreno = fechaEstr
			this.duracion = dur
			this.directores = directores
			this.actoresPrincipales = actoresPrnc
			this.linkYT = trailerYT
			this.valoraciones = new Valoracion();
	}
	
	def getRating() {
		return this.valoraciones.getRating
	}

}