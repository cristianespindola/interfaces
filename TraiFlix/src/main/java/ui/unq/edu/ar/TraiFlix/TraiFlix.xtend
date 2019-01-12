package ui.unq.edu.ar.TraiFlix

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import java.util.List

@Accessors
@Observable
class TraiFlix {
	
	List<Pelicula> peliculas
	List<Serie> series
	List<Usuario> usuarios
	List<String> categorias
	
	new(){
		this.peliculas = new ArrayList
		this.series = new ArrayList
		this.usuarios = new ArrayList
		this.categorias = new ArrayList
	}
	
	def agregarPelicula(Pelicula pelicula) {
		peliculas.add(pelicula)
		agregarCategoria(pelicula.categoria)
	}
	
	def agregarSerie(Serie serie) {
		series.add(serie)
		agregarCategoria(serie.categoria)
	}

	def agregarCategoria(String categoria) {
		if (categoria.contains(',')) {
			(categoria.split(',')).forEach[catg|agregarCategoria(catg)]
		} else {
			if (!(categorias.exists[catg|catg.equals(categoria)])) {
				categorias.add(categoria)
			}
		}
	}
	
	def agregarUsuario(Usuario usuario) {
		usuarios.add(usuario)
	}
	
	def cantidadDePeliculas() {
		return this.peliculas.size
	}
	
	def getContenidoSinTrailer() {
		val contenidosSinTrailer = new ArrayList
		for(pelicula : this.peliculas) {
			if(pelicula.getLinkYT().empty) {
				contenidosSinTrailer.add(pelicula)
			}
		} for(serie : this.series) {
			serie.getCapitulos().forEach[ 
				capitulo | if(capitulo.getLinkYT().empty) { contenidosSinTrailer.add(capitulo) }
			]
		}
		return contenidosSinTrailer
	}
	
	def getContenidosAptosParaEdadDe(Usuario usuario) {
		val edad = usuario.getEdad()
		val contenidosAptos = new ArrayList()
		contenidosAptos.addAll(this.series)
		contenidosAptos.addAll(this.peliculas)
		if(edad < 18) {
			contenidosAptos.removeIf(material | material.getClasificacion().contains("+18"))
		} if(edad < 16) {
			contenidosAptos.removeIf(material | material.getClasificacion().contains("+16"))
		} if(edad < 13) {
			contenidosAptos.removeIf(material | material.getClasificacion().contains("+13"))
		}
		return contenidosAptos
	}
	
	def getContenidoCategoria(String categoria) {
		var contenido = new ArrayList<Material>()
		contenido.addAll(obtenerPeliculasPorCategoria(categoria))
		contenido.addAll(obtenerSeriesPorCategoria(categoria))
		return contenido
	}

	def obtenerPeliculasPorCategoria(String categoria) {				
		val res = this.peliculas.filter[pelicula | pelicula.categoria.contains(categoria)]
		return res
	}
	
	def obtenerSeriesPorCategoria(String categoria) {		
		val res = this.series.filter[serie | serie.categoria.contains(categoria)]
		return res
	}
	
	def getSeriesDeClasificacion(String clasificacion) {
		series.filter[ material | material.clasificacion.contains(clasificacion) ]
	}
	
	def getPeliculasDeClasificacion(String clasificacion) {
		peliculas.filter[ material | material.clasificacion.contains(clasificacion) ]
	}
	
	def obtenerContenidoRelacionado(Material material) {
		val res1 = obtenerPeliculasPorCategoria(material.getCategoria)
		val res2 = obtenerSeriesPorCategoria(material.getCategoria)
		val ArrayList<Material> res = new ArrayList
		res.addAll(res1)
		res.addAll(res2)
		res.remove(material)
		return res
	}
	
	def seriesVistasDeFormaCompletaPor(Usuario usuario) {
		series.filter[ serie | usuario.vioDeFormaCompleta(serie) ]
	}
	
	def buscarUsuario(String usuario) {
		usuarios.findFirst[usuar | usuar.nombre.toLowerCase.contains(usuario.toLowerCase)]
	}
	
	def getCapitulos() {
		series.map[serie | serie.capitulos ].flatten.toList
	}
		
}