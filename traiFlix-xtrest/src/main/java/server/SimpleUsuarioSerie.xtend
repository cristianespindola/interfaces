package server

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import ui.unq.edu.ar.TraiFlix.Capitulo
import ui.unq.edu.ar.TraiFlix.Serie
import ui.unq.edu.ar.TraiFlix.Usuario
import java.util.ArrayList

@Accessors
class SimpleUsuarioSerie {
	
	int id
	String titulo
	String categoria
	String clasificacion
	String creadores
	List<SimpleContenido> contenidoRelacionado
	List<SimpleCapitulo> capitulos
	int recomendaciones
	String nombreUsuario
	String nombre
	String link
	int rating
	
	def changeCapitulosASimpleCapitulos(List<Capitulo> capitulos){
		var chapters = new ArrayList
		for(Capitulo c : capitulos){
			chapters.add(new SimpleCapitulo(c))
		}
	  return chapters
	}
	
	
	new(){}
	
	new(Serie serie, Usuario usuario){
		this.id = serie.codigo
		this.titulo = serie.titulo
		this.categoria = serie.categoria
		this.clasificacion = serie.clasificacion
		this.contenidoRelacionado = this.contenidoRelacionadoSimple(serie)
		this.capitulos = this.changeCapitulosASimpleCapitulos(serie.capitulos)
		this.recomendaciones = usuario.contenidoSugeridoPorAmigos.recomendaciones.size
		this.creadores = serie.creadores
		this.link = serie.capitulos.get(0).linkYT
		this.rating = serie.rating
		this.nombreUsuario = usuario.nombreUsuario
		this.nombre = usuario.nombre
	}
	
	def contenidoRelacionadoSimple(Serie serie){
		var listaContenidoRelacionado = new ArrayList<SimpleContenido>()
		for(contenidoPelicula: serie.contenidoRelacionadoPelicula){
			var contenidoActual = new SimplePeliculaRecomendada(contenidoPelicula)
			listaContenidoRelacionado.add(contenidoActual) 
		}
		for(contenidoSerie : serie.contenidoRelacionadoSerie){
			var contenidoActual = new SimpleSerieRecomendada(contenidoSerie)
			listaContenidoRelacionado.add(contenidoActual)
		}
		return listaContenidoRelacionado
	}
	
	
}