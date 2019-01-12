package ui.unq.edu.ar.traiFlix_ui

import ui.unq.edu.ar.TraiFlix.TraiFlix
import ui.unq.edu.ar.TraiFlix.Usuario
import java.util.Date
import java.time.LocalDate
import ui.unq.edu.ar.TraiFlix.Pelicula
import java.text.SimpleDateFormat
import ui.unq.edu.ar.TraiFlix.Capitulo
import ui.unq.edu.ar.TraiFlix.Serie
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class TraiFlixFactory {
	
	TraiFlix traiFlix
	
	new() { this.traiFlix = this.nuevoTraiFlix() }
	
	def nuevoTraiFlix() {
		var traiFlix = new TraiFlix()
		this.agregarUsuarios(traiFlix)
		this.agregarPeliculas(traiFlix)
		this.agregarSeries(traiFlix)
		return traiFlix
	}
	
	def agregarSeries(TraiFlix flix) {
		var trailer1 = "https://www.youtube.com/watch?v=giYeaKsXnsI"
		var trailer2 = "https://www.youtube.com/watch?v=0hIbFFwTKdE"
		var actoresPrincipales1 = "Emilia Clarke, Peter Dinklage, Kit Harington"
		var sDate1="30/09/2017"
        var date1 = new SimpleDateFormat("dd/MM/yyyy").parse(sDate1)
        var sDate2="03/02/2018"
        var date2 = new SimpleDateFormat("dd/MM/yyyy").parse(sDate1)
		
		var capitulo1 = new Capitulo(5000, "The Rains of Castamere", 1, 1, 
		date1, 30, "David Nutter", actoresPrincipales1, trailer1)
		
		var capitulo2 = new Capitulo(5001, "Battle of the Bastards", 2, 1, 
		date2, 33, "David Nutter", actoresPrincipales1, trailer2)
		
		var serie1 = new Serie(2000, "Game of Thrones", "Acción", "+18",
			"David Benioff, D.B. Weiss")
			
		serie1.agregarCapitulo(capitulo1)
		serie1.agregarCapitulo(capitulo2)
			
		var trailer3 = "https://www.youtube.com/watch?v=f5av6OqFwz0"
		var actoresPrincipales2 = "Gustaf Skarsgård, Katheryn Winnick, Alexander Ludwig"
		var sDate3 = "30/05/2014"
        var date3 = new SimpleDateFormat("dd/MM/yyyy").parse(sDate1)
        
        var capitulo3 = new Capitulo(5002, "The Last Ship", 1, 1, 
		date3, 36, "Jeff Woolnough", actoresPrincipales2, trailer3)
		
		var serie2 = new Serie(2001, "Vikings", "Aventura", "+18",
			"Michael Hirst")
		
		serie2.agregarCapitulo(capitulo3)
		
		flix.agregarSerie(serie1)
		flix.agregarSerie(serie2)	
	}
	
	def agregarPeliculas(TraiFlix flix) {
		var pelicula1 = new Pelicula(1000, "A Clockwork Orange", "Drama", "+18", LocalDate.now(), 124, 
		                         "Stanley Kubrick", "Malcolm McDowell, Patrick Magee, Michael Bates", 
		                         "https://www.youtube.com/watch?v=SPRzm8ibDQ8")
		                         
		var pelicula2 = new Pelicula(1001, "Jurassic Park", "Ciencia Ficción", "ATP", LocalDate.now(), 140, 
		                         "Steven Spielberg", "Sam Neill, Laura Dern, Jeff Goldblum, Richard Attenborough", 
		                         "https://www.youtube.com/watch?v=lc0UehYemQA")
		
		var pelicula3 = new Pelicula(1002, "Jurassic Word", "Ciencia Ficción", "ATP", LocalDate.now(), 124, 
		                         "Colin Trevorrow", "Chris Pratt, Bryce Dallas Howard, Nick Robinson, Vincent D’Onofrio", 
		                         "https://www.youtube.com/watch?v=RFinNxS5KN4")
		                         
		flix.agregarPelicula(pelicula1)
		flix.agregarPelicula(pelicula2)
		flix.agregarPelicula(pelicula3)
	}
	
	def agregarUsuarios(TraiFlix flix) {
		var usuario1 = new Usuario(1, "al84", "Antonio Lamas", LocalDate.now(), LocalDate.parse("2000-01-01"))
		var usuario2 = new Usuario(2, "lb2003", "Lorenzo Banderas", LocalDate.now(), LocalDate.parse("2000-06-08"))
		
		flix.agregarUsuario(usuario1)
		flix.agregarUsuario(usuario2)
	}
	
	
	
}