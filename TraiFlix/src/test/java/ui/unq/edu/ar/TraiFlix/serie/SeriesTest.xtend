package ui.unq.edu.ar.TraiFlix.serie

import static org.junit.Assert.*
import org.junit.Test
import ui.unq.edu.ar.TraiFlix.Serie
import ui.unq.edu.ar.TraiFlix.Capitulo
import ui.unq.edu.ar.TraiFlix.Usuario
import java.util.Date
import org.junit.Before

class SeriesTest {

	Serie serie
	
	@Before
	def void setUp(){
		serie = new Serie(0, "title", "catgs",  "clasif", "crs")		
	}

	@Test
	def unaSerieTieneUnaCantidadDeAtributos(){
		
		assertEquals( 0, serie.codigo )
		assertEquals( "title", serie.titulo )
		assertEquals( "catgs", serie.categoria)
		assertEquals( "clasif", serie.clasificacion )
		assertEquals( "crs", serie.creadores )
	}
	
	@Test
	def unaSerieTieneUnaCantidadDeCapitulos() {
		assertEquals(0, serie.getCapitulos.size)
	}
	
	@Test
	def SePuedeObtenerLosCapitulosDeXTemporada(){

		var capitulo = new Capitulo(1, "title", 1, 1, new Date(), 90, "dir", "acts", "YTube")
		serie.agregarCapitulo( capitulo )
		
		assertEquals(1, serie.getCapitulos.size)
		
		var capitulosDeTemp1 = serie.getCapitulosTemporada(1)
		assertTrue( capitulosDeTemp1.contains(capitulo) )
	}
	
	@Test
	def SeObtieneLaCantidadDeTemporadasQueTieneUnaSerie() {
		// sin temporadas
		assertEquals( 0, serie.temporadas.size )
		
		var capituloT1 = new Capitulo(1, "title", 1, 1, new Date(), 90, "dir", "acts", "YTube")		
		var capituloT2 = new Capitulo(12, "title2", 2, 1, new Date(), 90, "dir", "acts", "YTube")
		
		serie.agregarCapitulo(capituloT1)
		serie.agregarCapitulo(capituloT2)
		
		assertEquals( 2, serie.temporadas.size )
	}
	
	@Test
	def SeObtieneRatingDeUnaSerieSegunValoracionesDeSusCapitulos(){

		var cap1 = new Capitulo(123, "c1", 1, 1, new Date, 52, "dir", "acts", "yt")
		var cap2 = new Capitulo(124, "c2", 1, 2, new Date, 52, "dir", "acts", "yt")
		
		serie.agregarCapitulo(cap1)
		serie.agregarCapitulo(cap2)
		// ningun capitulo esta valorado
		assertEquals( 0, serie.getRating )
		
		var usr = new Usuario
		usr.valorarCapitulo(cap1, 5)
		usr.valorarCapitulo(cap2, 1)
		assertEquals(3, serie.getRating)
	}
}
