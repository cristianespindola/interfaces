package ui.unq.edu.ar.TraiFlix

import static org.junit.Assert.*
import org.junit.Test
import java.util.Date
import java.time.LocalDate

class TraiFlixTest {
	
	@Test def void testLitadoDePeliculas() {
		
		// Lista sin peliculas
		val traiFlix = new TraiFlix()
		assertEquals(traiFlix.getPeliculas.size, 0)
		
		// Lista con 1 pelicula
		val pelicula1 = new Pelicula()
		pelicula1.categoria = "catg"
		traiFlix.agregarPelicula(pelicula1)
		assertEquals(traiFlix.getPeliculas.size, 1)
		
		// Lista con 3 peliculas
		val pelicula2 = new Pelicula() pelicula2.categoria = "catg"
		val pelicula3 = new Pelicula() pelicula3.categoria = "catg"
		traiFlix.agregarPelicula(pelicula2)
		traiFlix.agregarPelicula(pelicula3)
		assertEquals(traiFlix.getPeliculas.size, 3)
	}
	
	@Test def void testLitadoDeSeries() {
		
		// Lista sin series
		val traiFlix = new TraiFlix()
		assertEquals(traiFlix.getSeries.size, 0)
		
		// Lista con 1 serie
		val serie1 = new Serie() serie1.categoria = "catg"
		traiFlix.agregarSerie(serie1) 
		assertEquals(traiFlix.getSeries.size, 1)
		
		// Lista con 3 series
		val serie2 = new Serie() serie2.categoria = "catg"
		val serie3 = new Serie() serie3.categoria = "catg"
		traiFlix.agregarSerie(serie2)
		traiFlix.agregarSerie(serie3)
		assertEquals(traiFlix.getSeries.size, 3)
	}
	
	@Test def void testLitadoDeUsuarios() {
		
		// Lista sin usuarios
		val traiFlix = new TraiFlix()
		assertEquals(traiFlix.getPeliculas.size, 0)
		
		// Lista con 1 usuario
		val usuario1 = new Usuario()
		traiFlix.agregarUsuario(usuario1) 
		assertEquals(traiFlix.getUsuarios.size, 1)
		
		// Lista con 3 Usuarios
		val usuario2 = new Usuario()
		val usuario3 = new Usuario()
		traiFlix.agregarUsuario(usuario2)
		traiFlix.agregarUsuario(usuario3)
		assertEquals(traiFlix.getUsuarios.size, 3)
	}
	
	@Test def void testListadoDeCapitulos(){
		
		val traiFlix = new TraiFlix()
		
		assertEquals( 0, traiFlix.capitulos.size ) // sin capitulos
		
		var serie = new Serie(0, "title", "catgs",  "clasif", "crs")
		var capituloS1 = new Capitulo(1, "title", 1, 1, new Date(), 90, "dir", "acts", "")
		serie.agregarCapitulo(capituloS1)
		
		var serie2 = new Serie(0, "title", "catgs",  "clasif", "crs")
		var capituloS2 = new Capitulo(1, "title", 1, 1, new Date(), 90, "dir", "acts", "")
		serie2.agregarCapitulo(capituloS2)
		
		traiFlix.agregarSerie(serie)
		traiFlix.agregarSerie(serie2)
		assertEquals( 2, traiFlix.capitulos.size ) // con dos capitulos
	}
	
	@Test
	def void seObtieneContenidoSinTrailer() {
		val traiFlix = new TraiFlix()
		
		var pelicula1 = new Pelicula() pelicula1.categoria = "catg"
		pelicula1.setLinkYT("")
		var pelicula2 = new Pelicula() pelicula2.categoria = "catg"
		pelicula2.setLinkYT("http://unLinkNoVacioDePelicula")	
		traiFlix.agregarPelicula(pelicula1)
		traiFlix.agregarPelicula(pelicula2)
		
		var serie = new Serie(0, "title", "catgs",  "clasif", "crs")
		var capituloT1 = new Capitulo(1, "title", 1, 1, new Date(), 90, "dir", "acts", "")
		capituloT1.setLinkYT("")
		var capituloT2 = new Capitulo(1, "title", 2, 1, new Date(), 90, "dir", "acts", "")
		capituloT1.setNroTemporada(1)
		capituloT2.setLinkYT("http://unLinkNoVacioDeCapitulo")
		capituloT2.setNroTemporada(2)
		serie.agregarCapitulo(capituloT1)
		serie.agregarCapitulo(capituloT2)		
		traiFlix.agregarSerie(serie)
		
		var contenidosSinTrailer = traiFlix.getContenidoSinTrailer()	      
		var pel1 = contenidosSinTrailer.get(0) as Pelicula
		var ep1 = contenidosSinTrailer.get(1) as Capitulo
		
		assertEquals(contenidosSinTrailer.size, 2)
		assertTrue(pel1.getLinkYT().empty)            
		assertTrue(ep1.getLinkYT().empty)     
	}
	
	@Test
	def void unMenorDe13AniosNoObtieneContenidoParaMayoresYUnMayorSi() {
		val traiFlix = new TraiFlix()
		
		var usuarioMenor = new Usuario()
		usuarioMenor.setFechaNacimiento(LocalDate.now())
		
		var usuarioMayor = new Usuario()
		usuarioMayor.setFechaNacimiento(LocalDate.parse("2000-01-01"))
		
		var pelicula1 = new Pelicula() pelicula1.categoria = "catg"
		pelicula1.setClasificacion("+18")
		traiFlix.agregarPelicula(pelicula1)
		
		var serie1 = new Serie() serie1.categoria = "catg"
		serie1.setClasificacion("APT")
		traiFlix.agregarSerie(serie1)
		
		assertEquals(traiFlix.getContenidosAptosParaEdadDe(usuarioMenor).size, 1)
		assertEquals(traiFlix.getContenidosAptosParaEdadDe(usuarioMenor).get(0).getClasificacion(), "APT")
		assertEquals(traiFlix.getContenidosAptosParaEdadDe(usuarioMayor).size, 2)
		assertEquals(traiFlix.getContenidosAptosParaEdadDe(usuarioMayor).get(0).getClasificacion(), "APT")
		assertEquals(traiFlix.getContenidosAptosParaEdadDe(usuarioMayor).get(1).getClasificacion(), "+18")
	}
	
	@Test
	def void puedenObtenersePeliculasYSeriesSegunCategoria(){
		var traiflix = new TraiFlix()
		var peliComedia = new Pelicula() peliComedia.setCategoria("Estreno,Comedia")
		var serieComedia = new Serie() serieComedia.setCategoria("Comedia,Scyfy")
		var peli2 = new Pelicula() peli2.setCategoria("Terror,Scify")

		traiflix.agregarPelicula(peliComedia)
		traiflix.agregarPelicula(peli2)
		traiflix.agregarSerie(serieComedia)
		
		assertTrue( traiflix.getContenidoCategoria("Comedia").contains(peliComedia) )
		assertTrue( traiflix.getContenidoCategoria("Comedia").contains(serieComedia) )
		assertEquals( 2, traiflix.getContenidoCategoria("Comedia").size )
	}
	
	@Test
	def void testObtenerPeliculasPorCategoria() {
		
		var traiFlix = new TraiFlix();
		
		val pelicula1 = new Pelicula();
		pelicula1.categoria = "accion";
		val pelicula2 = new Pelicula();
		pelicula2.categoria = "terror"
		val pelicula3 = new Pelicula();
		pelicula3.categoria = "drama";
		val pelicula4 = new Pelicula();
		pelicula4.categoria = "terror"
		
		traiFlix.agregarPelicula(pelicula1);
		traiFlix.agregarPelicula(pelicula2);
		traiFlix.agregarPelicula(pelicula3);
		traiFlix.agregarPelicula(pelicula4)
		assertEquals(traiFlix.cantidadDePeliculas, 4);
		
		val peliculasPorCategoria = traiFlix.obtenerPeliculasPorCategoria("terror")
		assertEquals(peliculasPorCategoria.size, 2)

	}
	
	@Test
	def void testObtenerPeliculasPorClasificacion() {
		var traiFlix = new TraiFlix();
		
		val pelicula1 = new Pelicula() pelicula1.categoria = "catg"
		pelicula1.clasificacion = "ATP"
		val pelicula2 = new Pelicula() pelicula2.categoria = "catg"
		pelicula2.clasificacion = "+18"
		val pelicula3 = new Pelicula() pelicula3.categoria = "catg"
		pelicula3.clasificacion = "+18"
		
		traiFlix.agregarPelicula(pelicula1)
		traiFlix.agregarPelicula(pelicula2)
		traiFlix.agregarPelicula(pelicula3)
		
		assertEquals(traiFlix.getPeliculasDeClasificacion("ATP").size, 1)
		assertEquals(traiFlix.getPeliculasDeClasificacion("+18").size, 2)
	}
	
	@Test
	def void testObtenerSeriesPorClasificacion() {
		var traiFlix = new TraiFlix();
		
		var serie1 = new Serie() serie1.categoria = "catg"
		serie1.setClasificacion("APT") 
		var serie2 = new Serie() serie2.categoria = "catg"
		serie2.setClasificacion("+13")
		var serie3 = new Serie() serie3.categoria = "catg"
		serie3.setClasificacion("+13")
		traiFlix.agregarSerie(serie1)
		traiFlix.agregarSerie(serie2)
		traiFlix.agregarSerie(serie3)
		
		assertEquals(traiFlix.getSeriesDeClasificacion("APT").size, 1)
		assertEquals(traiFlix.getSeriesDeClasificacion("+18").size, 0)
		assertEquals(traiFlix.getSeriesDeClasificacion("+13").size, 2)
	}
	
	@Test
	def void testDadoUnaPeliculaObtenerSuRecomendacion() {
		var traiFlix = new TraiFlix();
		
		val pelicula1 = new Pelicula()
		pelicula1.categoria = "accion"
		val pelicula2 = new Pelicula()
		pelicula2.categoria = "terror"
		val pelicula3 = new Pelicula()
		pelicula3.categoria = "drama"
		val pelicula4 = new Pelicula()
		pelicula4.categoria = "terror"
		val pelicula5 = new Pelicula()
		pelicula5.categoria = "accion"
		
		traiFlix.agregarPelicula(pelicula1)
		traiFlix.agregarPelicula(pelicula2)
		traiFlix.agregarPelicula(pelicula3)
		traiFlix.agregarPelicula(pelicula4)
		traiFlix.agregarPelicula(pelicula5)
		
		val contenidoRelacionado = traiFlix.obtenerContenidoRelacionado(pelicula1)
		
		assertEquals(contenidoRelacionado.size, 1)
	}
	
	@Test
	def void testDadoUnaSerieObtenerSuRecomendacion() {
		var traiFlix = new TraiFlix();
		
		val serie1 = new Serie()
		serie1.categoria = "accion"
		val serie2 = new Serie()
		serie2.categoria = "terror"
		val serie3 = new Serie()
		serie3.categoria = "drama"
		val serie4 = new Serie()
		serie4.categoria = "terror"
		val serie5 = new Serie()
		serie5.categoria = "accion"
		
		traiFlix.agregarSerie(serie1)
		traiFlix.agregarSerie(serie2)
		traiFlix.agregarSerie(serie3)
		traiFlix.agregarSerie(serie4)
		traiFlix.agregarSerie(serie5)
		
		val contenidoRelacionado = traiFlix.obtenerContenidoRelacionado(serie2)
		
		assertEquals(contenidoRelacionado.size, 1)
		
		val pelicula1 = new Pelicula()
		pelicula1.categoria = "accion"
		val pelicula2 = new Pelicula()
		pelicula2.categoria = "terror"
		val pelicula3 = new Pelicula()
		pelicula3.categoria = "drama"
		val pelicula4 = new Pelicula()
		pelicula4.categoria = "terror"
		val pelicula5 = new Pelicula()
		pelicula5.categoria = "accion"
		
		traiFlix.agregarPelicula(pelicula1)
		traiFlix.agregarPelicula(pelicula2)
		traiFlix.agregarPelicula(pelicula3)
		traiFlix.agregarPelicula(pelicula4)
		traiFlix.agregarPelicula(pelicula5)
		
		val contenidoRelacionado2 = traiFlix.obtenerContenidoRelacionado(serie2)
		
		assertEquals(contenidoRelacionado2.size, 3)
	}
	
	@Test
	def void testObtenerSeriesQueUnUsuarioVioDeFormaCompleta(){
		var usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.parse("2000-01-01") )
		var serie1 = new Serie(111, "The Simpson", "Comedia",  "ATP", "Matt G")
		var capSerie1 = new Capitulo(1, "Dia de Bart", 1, 1, new Date(), 90, "dir", "acts", "YTube")
		serie1.agregarCapitulo(capSerie1)
		
		var traiflix = new TraiFlix()
		traiflix.agregarSerie(serie1)
		
		assertTrue( traiflix.seriesVistasDeFormaCompletaPor( usuario ).isEmpty )
		
		usuario.agregarCapituloVisto(capSerie1)
		assertEquals( 1, traiflix.seriesVistasDeFormaCompletaPor( usuario ).size )
	}
}
