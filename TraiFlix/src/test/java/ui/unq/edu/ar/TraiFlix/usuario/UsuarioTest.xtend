package ui.unq.edu.ar.TraiFlix.usuario

import static org.junit.Assert.*
import org.junit.Test
import java.util.Date
import ui.unq.edu.ar.TraiFlix.Usuario
import java.time.LocalDate
import ui.unq.edu.ar.TraiFlix.Pelicula
import ui.unq.edu.ar.TraiFlix.Capitulo
import ui.unq.edu.ar.TraiFlix.Serie
import java.util.ArrayList

class UsuarioTest {
	
	@Test
	def unUsuarioTieneUnConjuntoDeAtributos(){
		var dateNow = LocalDate.now()
		var birthday = LocalDate.parse("2000-01-01")
		var usuario = new Usuario(001, "Pepe", "Jose", dateNow, birthday)
		
		assertEquals(001, usuario.getCodigo)
		assertEquals("Pepe", usuario.getNombreUsuario)
		assertEquals("Jose", usuario.getNombre)
		assertEquals(dateNow, usuario.getFechaRegistro)
		assertEquals(birthday, usuario.getFechaNacimiento)
	}
	
	@Test def void testUsuarioConAmigos() {
		
		// Usuario con 0 amigos
		val usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.now())
		assertEquals(usuario.getAmigos.size, 0)
		
		// Usuario con 1 amigo
		val amigo1 = new Usuario()
		usuario.agregarAmigo(amigo1) 
		assertEquals(usuario.getAmigos.size, 1)
		
		// Usuario con 3 amigos
		val amigo2 = new Usuario()
		val amigo3 = new Usuario()
		usuario.agregarAmigo(amigo2)
		usuario.agregarAmigo(amigo3)
		assertEquals(usuario.getAmigos.size, 3)
	}
	
	@Test
	def void seRecuperaEdad() {
		val usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.parse("2000-01-01"))
		val edad = 18
		assertEquals(usuario.getEdad(), edad)
	}
	
	@Test
	def void unUsuarioPuedeObtenerLasPeliculasVistas(){
		var usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.parse("2000-01-01"))

		assertTrue( usuario.getPeliculasVistas.isEmpty )
		
		var peli = new Pelicula(123, "titl", "catgs", "clfs", LocalDate.now() ,90, "dirs", "acts","yt")		
		usuario.agregarPeliculaVista(peli)
		assertTrue( usuario.getPeliculasVistas.contains(peli) )
		assertEquals( 1, usuario.getPeliculasVistas.size )
	}
	
	@Test
	def void unUsuarioPuedeObtenerLosCapitulosVistos(){
		var usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.parse("2000-01-01"))
		var serie = new Serie(0, "title", "catgs",  "clasif", "crs")
		var cap = new Capitulo(1, "title", 1, 1, new Date(), 90, "dir", "acts", "YTube")
		serie.agregarCapitulo(cap)
		
		usuario.agregarCapituloVisto(cap)
		assertTrue( usuario.getCapitulosVistos.contains(cap) )
		assertEquals( 1, usuario.getCapitulosVistos.size )
		
	}
	
	@Test
	def void unUsuarioNoVioDeFormaCompletaUnaSerieQueNoTieneCapitulos(){
		var usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.parse("2000-01-01"))
		var serie1 = new Serie(111, "The Simpson", "Comedia",  "ATP", "Matt G")
		
		assertFalse( usuario.vioDeFormaCompleta(serie1) )
	}
	
	@Test
	def void unUsuarioPuedeSaberQueSeriesVioDeFormaCompleta(){
		var usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.parse("2000-01-01"))
		var serie1 = new Serie(111, "The Simpson", "Comedia",  "ATP", "Matt G")
		var capSerie1 = new Capitulo(1, "Dia de Bart", 1, 1, new Date(), 90, "dir", "acts", "YTube")
		serie1.agregarCapitulo(capSerie1)
		
		var serie2 = new Serie(111, "Futurama", "Comedia",  "ATP", "Matt G")
		var cap1serie2 = new Capitulo(1, "Dia de Fry", 1, 1, new Date(), 90, "dir", "acts", "YTube")
		var cap2serie2 = new Capitulo(1, "Dia de Leela", 1, 2, new Date(), 90, "dir", "acts", "YTube")
		serie2.agregarCapitulo(cap1serie2)
		serie2.agregarCapitulo(cap2serie2)
		
		usuario.agregarCapituloVisto(capSerie1) // serie1 completa
		assertTrue( usuario.vioDeFormaCompleta(serie1) )
		
		usuario.agregarCapituloVisto(cap1serie2) // serie 2 incompleta
		assertFalse( usuario.vioDeFormaCompleta( serie2 ) )
	}
	@Test
	def void dadoUnUsuarioSeObtieneElContenidoQLeRecomendaronAmigos() {
		val peli = new Pelicula(123, "titl", "catgs", "clfs", LocalDate.now() ,90, "dirs", "acts","yt")
		var usuario1 = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.now())
		val amigo1 = new Usuario()
		usuario1.agregarAmigo(amigo1) 
		val usuario2 = new Usuario()
		amigo1.sugerirContenido(peli, usuario1)
		usuario2.sugerirContenido(peli, usuario1)
		assertEquals(1, usuario1.contenidoSugeridoPorAmigos.getMaterialRecomendado().size)
		assertEquals(1, usuario1.contenidoSugeridoPorAmigos.masRecomendadas().size)
	}
	
	@Test
	def void dadoUnUsuarioSeObtieneLos5ContenidosQMasLeRecomendaronAmigos() {
		val peli = new Pelicula(123, "titl", "catgs", "clfs", LocalDate.now() ,90, "dirs", "acts","yt")
		val peli1 = new Pelicula(125, "titl", "catgs", "clfs", LocalDate.now() ,90, "dirs", "acts","yt")
		val peli2 = new Pelicula(126, "titl", "catgs", "clfs", LocalDate.now() ,90, "dirs", "acts","yt")
		val peli3 = new Pelicula(127, "titl", "catgs", "clfs", LocalDate.now() ,90, "dirs", "acts","yt")
		val peli4 = new Pelicula(128, "titl", "catgs", "clfs", LocalDate.now() ,90, "dirs", "acts","yt")
		val peli5 = new Pelicula(129, "titl", "catgs", "clfs", LocalDate.now() ,90, "dirs", "acts","yt")
		var usuario1 = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.now())
		val amigo1 = new Usuario()
		usuario1.agregarAmigo(amigo1) 
		val usuario2 = new Usuario()
		amigo1.sugerirContenido(peli, usuario1)
		amigo1.sugerirContenido(peli, usuario1)
		amigo1.sugerirContenido(peli1, usuario1)
		usuario2.sugerirContenido(peli, usuario1)
		amigo1.sugerirContenido(peli2, usuario1)
		amigo1.sugerirContenido(peli2, usuario1)
		amigo1.sugerirContenido(peli2, usuario1)
		amigo1.sugerirContenido(peli3, usuario1)
		amigo1.sugerirContenido(peli3, usuario1)
		amigo1.sugerirContenido(peli4, usuario1)
		amigo1.sugerirContenido(peli4, usuario1)
		amigo1.sugerirContenido(peli5, usuario1)
		amigo1.sugerirContenido(peli5, usuario1)
		
		val masRecomendadas = usuario1.contenidoSugeridoPorAmigos.masRecomendadas()
		
		assertEquals(5, masRecomendadas.size)
		assertEquals(126, masRecomendadas.get(0).getCodigo())
		assertEquals(123, masRecomendadas.get(1).getCodigo())
		assertEquals(127, masRecomendadas.get(2).getCodigo())
		assertEquals(128, masRecomendadas.get(3).getCodigo())
		assertEquals(129, masRecomendadas.get(4).getCodigo())
		assertFalse(masRecomendadas.contains(peli1))
	}
	
	@Test
	def dadoUnUsuarioUnaSerieYUnaTemporadaSePuedeSaberCuantosCapitulosVio() {
		val usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.parse("2000-01-01"))
		
		var serie2 = new Serie(111, "Futurama", "Comedia",  "ATP", "Matt G")
		var cap1serie2 = new Capitulo(1, "Dia de Fry", 1, 1, new Date(), 90, "dir", "acts", "YTube")
		var cap2serie2 = new Capitulo(2, "Dia de Leela", 1, 2, new Date(), 90, "dir", "acts", "YTube")
		serie2.agregarCapitulo(cap1serie2)
		serie2.agregarCapitulo(cap2serie2)
		
		usuario.agregarCapituloVisto(cap1serie2)
		
		var capitulosTemporada1 = new ArrayList(serie2.getCapitulosTemporada(1))
		capitulosTemporada1.removeIf(capitulo | usuario.capitulosVistos.contains(capitulo))
		
		var capitulosVistosDeLaTemporada1 = capitulosTemporada1.size
		
		assertEquals(1, capitulosVistosDeLaTemporada1)
		assertEquals(2, serie2.getCapitulosTemporada(1).size)
	}
	
	@Test
	def unUsuarioPuedeAgregarOSacarDeFavoritosAlgunMaterial(){
		val usuario = new Usuario(001, "Pepe", "Jose", LocalDate.now(), LocalDate.parse("2000-01-01"))
		var serie1 = new Serie(111, "The Simpson", "Comedia",  "ATP", "Matt G")
		
		assertTrue(usuario.contenidoFavorito.isEmpty) //sin contenido
		
		usuario.agregarAFavoritos(serie1)
		assertTrue(usuario.contenidoFavorito.contains(serie1)) //lo incluye
		
		usuario.quitarDeFavoritos(serie1)
		assertTrue(usuario.contenidoFavorito.isEmpty) //sin contenido otra vez
	}
}
