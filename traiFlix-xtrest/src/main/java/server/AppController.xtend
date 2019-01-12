package server

import java.text.SimpleDateFormat
import java.util.List
import java.util.ArrayList
import java.util.Date
import java.util.HashMap
import java.util.Map
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import ui.unq.edu.ar.TraiFlix.Capitulo
import ui.unq.edu.ar.TraiFlix.Material
import ui.unq.edu.ar.TraiFlix.Pelicula
import ui.unq.edu.ar.TraiFlix.Serie
import ui.unq.edu.ar.TraiFlix.TraiFlix
import ui.unq.edu.ar.TraiFlix.Usuario

@Controller
class AppController {
	
	extension JSONUtils = new JSONUtils
	
	new() {}
	
	// Recibe una lista con pares de strings clave y valor delimitados por ", " y retorna un JSON.  
	def argsAJson(String args) {
		var pares = args.split(", ")
		var Map<String, String> mr = new HashMap
		var i = 0
		var limit = pares.size
		while(i < limit) {
			mr.put(pares.get(i), pares.get(i+1))
			i += 2
		}
		return mr.toJson
	}
	
	// Retorna un error tipo json con un mensaje
	def getErrorJson(String message) {
		 argsAJson("status, error, message, "+message)
	}
	
	// Retorna el contenido favorito (sólo series o películas) en formato JSON.
	def getContenidoFavoritoDeUsuarioParaMostrar(Usuario usuario) {
		return agregarSimpleMaterialALista(usuario.contenidoFavorito).toJson
	}
		
	def getInformacionPeliculaIdconUsuario(Pelicula pelicula, Usuario usuario) {
		var usuarioConPeliculaParaVer = new SimpleUsuarioPelicula(pelicula, usuario)
		return usuarioConPeliculaParaVer.toJson
	}
	
	def getInformacionSerieIdConUsuario(Serie serie, Usuario usuario){
		var usuarioConSerieParaVer = new SimpleUsuarioSerie(serie, usuario)
		return usuarioConSerieParaVer.toJson
	}
	
	def static getTextoError() {
		return "Hubo un error en la consulta realizada."
	}
	
	def static contenidoRelacionaSimple(Material material) {
		var lisContenidoRelacionado = new ArrayList<SimpleContenido>()
		if(material.class.name == Pelicula.name) {
			for(contenidoPelicula : (material as Pelicula).contenidoRelacionadoPelicula){
				var contenidoActual = new SimplePeliculaRecomendada(contenidoPelicula)
				lisContenidoRelacionado.add(contenidoActual)
			}
			for(contenidoSerie : (material as Pelicula).contenidoRelacionadoSerie){
				var contenidoActual = new SimpleSerieRecomendada(contenidoSerie)
				lisContenidoRelacionado.add(contenidoActual)
			}
		} else {
			for(contenidoPelicula : (material as Serie).contenidoRelacionadoPelicula){
				var contenidoActual = new SimplePeliculaRecomendada(contenidoPelicula)
				lisContenidoRelacionado.add(contenidoActual)
			}
			for(contenidoSerie : (material as Serie).contenidoRelacionadoSerie){
				var contenidoActual = new SimpleSerieRecomendada(contenidoSerie)
				lisContenidoRelacionado.add(contenidoActual)
			}
		}
		return lisContenidoRelacionado
	}	
	
	def validar(String valor, java.util.List<String> valoresAceptados) {
		// si un valor no se encuentra en la lista de valores aceptados, excepcion
		if( ! valoresAceptados.contains(valor) ){
			throw new Exception(valor+" no es valido")
		}
		valor
	}
	
	// Establece si un usuario tiene vista una pelicula o serie
	def marcarVistoAUnContenido( Usuario u, Material m){
		if( m.class.equals( typeof(Pelicula)) ){
			u.agregarPeliculaVista(m as Pelicula)			
		}else{
			var serie = m as Serie
			serie.capitulos.forEach[cap | u.agregarCapituloVisto(cap)]
		}
	}
	def marcarNoVistoAUnContenido( Usuario u, Material m){
		if( m.class.equals( typeof(Pelicula)) ){
			val pelicula = m as Pelicula
			u.peliculasVistas = u.peliculasVistas.filter[ peli | peli.codigo != pelicula.codigo ].toList
		}else{
			var serie = m as Serie
			serie.capitulos.forEach[cap | 
				u.capitulosVistos = u.capitulosVistos.filter[ capVisto | capVisto.codigo != cap.codigo ].toList
			]
		}
	}
	
	//Retorna series relacionadas a una pelicula
	def serieRelacionadas(TraiFlix traiFlix, Pelicula pelicula) {
		var series = new ArrayList(traiFlix.series)
		val categs = pelicula.getCategoria.split(",")
		series.removeIf(p | !(new ArrayList(p.getCategoria.split(",")).removeAll(categs)))	
		return series
	}
	//Retorna peliculas relacionadas a una pelicula
	def peliculaRelacionadas(TraiFlix traiFlix, Pelicula pelicula) {
		var peliculas = new ArrayList(traiFlix.peliculas)
		val categs = pelicula.getCategoria.split(",")
		peliculas.removeIf(p | !(new ArrayList(p.getCategoria.split(",")).removeAll(categs)))		
		peliculas.removeIf(peli | peli.getCodigo == pelicula.getCodigo)
		return peliculas
	}
	
	//Retorna series relacionadas a una serie
	def serieRelacionadasASerie(TraiFlix traiFlix, Serie serie) {
		var series = new ArrayList(traiFlix.series)
		val categs = serie.getCategoria.split(",")
		series.removeIf(p | !(new ArrayList(p.getCategoria.split(",")).removeAll(categs)))
		series.removeIf(s | s.getCodigo == serie.getCodigo)
		return series
	}
	
	//Retorna peliculas relacionadas a una serie
	def peliculaRelacionadasASerie(TraiFlix traiFlix, Serie serie) {
		var peliculas = new ArrayList(traiFlix.peliculas)
		val categs = serie.getCategoria.split(",")
		peliculas.removeIf(p | !(new ArrayList(p.getCategoria.split(",")).removeAll(categs)))
		return peliculas
	}
	
	// Realiza la calificacion de un usuario a una pelicula o capitulo	
	def corresponderCalificacion(Usuario u, int cantidadDeEstrellas, String tipoContenido, Material material){
		if(tipoContenido.equals("movie")){
			var pelicula = material as Pelicula
			u.valorarPelicula(pelicula, cantidadDeEstrellas)
		}else{
			var capitulo = material as Capitulo
			u.valorarCapitulo(capitulo, cantidadDeEstrellas)
		}
	}	
	
	// Retorna un material segun su tipo y codigo	
	def buscarContenidoSegunTipoeId( TraiFlix traiFlix, String tipoContenido, int idContenido) {
		switch( tipoContenido.toLowerCase ){
			case 'movie':
				return traiFlix.peliculas.findFirst[ p | p.getCodigo == idContenido]
			case 'serie':
				return traiFlix.series.findFirst[ s | s.getCodigo == idContenido]
			case 'chapter':
				return traiFlix.capitulos.findFirst[ cap | cap.getCodigo == idContenido]
			default :
				throw new Exception("Id:"+ idContenido+" no existente")
		}
	}
	
	//Busca un usuario en Traiflix dado, segun Usuario.nombreUsuario
	def static buscarUsuario(TraiFlix traiFlix, String usuario) {
		traiFlix.usuarios.findFirst[usuar | usuar.nombreUsuario.toLowerCase.contains(usuario.toLowerCase)]
	}
	
	// Retorna un String a partir de la la fecha recibida en formato dd/mm/yyyy.
	def static formatearFechaEstrenoParaMostrar(Date fecha) {
		var formatoFecha = new SimpleDateFormat("dd/MM/yyyy")
		return formatoFecha.format(fecha)
	}
	
	def getAmigosDeUsuarioParaMostrar(ui.unq.edu.ar.TraiFlix.Usuario usuario) {
		var res = new ArrayList
		for(Usuario us : usuario.amigos) {
			res.add(us.nombreUsuario)
		}
		return res.toJson
	}
	
	// Retorna el contenido recomendado (sólo series o películas) en formato JSON.
	def getContenidoRecomendadoDeUsuarioParaMostrar(Usuario usuario) {
		var recomendados = usuario.contenidoSugeridoPorAmigos.getMaterialRecomendado; 
		return agregarSimpleMaterialALista(recomendados).toJson
	}
	
	// Retorna el contenido mas recomendado (maximo 5) en formato JSON.
	def getContenidoMasRecomendadoDeUsuarioParaMostrar(Usuario usuario) {
		var masRecomendados = usuario.contenidoSugeridoPorAmigos.masRecomendadas;
		return agregarSimpleMaterialALista(masRecomendados).toJson
	}
	
	// Retorna una lista de SimpleSeries y SimplePeliculas
	// param listToMap: List de Peliculas y Series
	protected def agregarSimpleMaterialALista(List<Material> listToMap) {
		var resultList = newArrayList
		for( Material m : listToMap) {
			if(m.getClass.equals(Serie)) {
				var s = new SimpleSerie(m as Serie)
				resultList.add(s)
			} else {
				resultList.add(new SimplePelicula(m as Pelicula))
			}	
		}
		return resultList
	}

}