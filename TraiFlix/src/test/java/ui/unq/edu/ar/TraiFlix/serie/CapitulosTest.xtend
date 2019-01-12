package ui.unq.edu.ar.TraiFlix.serie

import org.junit.Test
import ui.unq.edu.ar.TraiFlix.Capitulo

import static org.junit.Assert.*
import java.util.Date
import ui.unq.edu.ar.TraiFlix.Usuario

class CapitulosTest {
	
	@Test
	def unCapituloTieneCiertasPropiedades() {
		
		var trailer = "http://youtube/dsfsdfsdfasfas"
		var actoresPrincipales = "Mike Tyson, Jake Hill"
		var fecha = new Date();
		
		var capitulo = new Capitulo( 123, "Los Simpson", 10, 5, 
		fecha, 30, "James Cameron", actoresPrincipales, trailer
		)
		assertEquals(capitulo.codigo, 123)
		assertEquals(capitulo.titulo, "Los Simpson")
		assertEquals(capitulo.nroTemporada, 10)
		assertEquals(capitulo.nroCapitulo, 5)
		assertEquals(capitulo.fechaEstreno, fecha )
		assertEquals(capitulo.duracion, 30)
		assertEquals(capitulo.directores, "James Cameron")
		assertEquals(capitulo.actoresPrincipales, actoresPrincipales)
		assertEquals(capitulo.getLinkYT, trailer)
	}
	
	@Test
	def unCapituloTieneCiertoRatingSegunValoraciones() {
		var capTst = new Capitulo(1, "title", 1, 1, new Date(), 90, "dir", "acts", "YTube")
		var user = new Usuario()
		
		user.valorarCapitulo( capTst, 5 )
		assertTrue(capTst.getRating == 5)
		
		user.valorarCapitulo( capTst, 4 )
		assertTrue( capTst.getRating == 4 )
	}
}