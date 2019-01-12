package ui.unq.edu.ar.Pelicula

import static org.junit.Assert.*
import org.junit.Test
import ui.unq.edu.ar.TraiFlix.Pelicula
import org.junit.Before
import ui.unq.edu.ar.TraiFlix.Usuario
import java.time.LocalDate
import java.util.ArrayList

class PeliculaTest {
	
	Pelicula pelicula1;
	LocalDate date1;
	
	@Before
	def void setUp() {
		date1 = LocalDate.now()
		pelicula1 = new Pelicula(0, "tstPel", "Categ", "Clas", date1, 5, 
		                         "Dirs", "Acts", "YT")
	}
	
	@Test def void deUnaNuevaPeliculaSePuedeConsultarSusAtributos() {
		assertEquals(0, pelicula1.getCodigo())
		assertEquals("tstPel", pelicula1.getTitulo())
		assertEquals("Categ", pelicula1.getCategoria())
		assertEquals("Clas", pelicula1.getClasificacion())
		assertEquals(date1, pelicula1.getFechaDeEstreno())
		assertEquals(5, pelicula1.getDuracion())		
		assertEquals("Dirs", pelicula1.getDirectores())
		assertEquals("Acts", pelicula1.getActores())
		assertEquals("YT", pelicula1.getLinkYT())
	}
	
	@Test
	def unaPeliculaTieneCiertoRatingSegunValoracionesRecibidas() {
		var user = new Usuario()
		
		user.valorarPelicula(pelicula1, 5)
		assertTrue(pelicula1.getRating == 5)
		
		user.valorarPelicula(pelicula1, 4)
		assertTrue(pelicula1.getRating == 4 )
	}
	
	@Test
	def unaPeliculaTieneContenidoRelacionadoSiSeLeAsigna(){
		
		assertTrue( pelicula1.contenidoRelacionadoPelicula.isEmpty )
		
		var contenido = new ArrayList
		contenido.add(new Pelicula(2, "tstPel", "Categ", "Clas", date1, 5, "Dirs", "Acts", "YT"))
		pelicula1.setContenidoRelacionadoPelicula( contenido )
		assertTrue(1 == pelicula1.contenidoRelacionadoPelicula.size)
	}
}