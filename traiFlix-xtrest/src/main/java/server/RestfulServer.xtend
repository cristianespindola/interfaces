package server

import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import ui.unq.edu.ar.TraiFlix.TraiFlix
import java.util.ArrayList
import ui.unq.edu.ar.TraiFlix.Serie
import ui.unq.edu.ar.TraiFlix.Pelicula
import java.util.Collections

/**
 * Servidor RESTful implementado con XtRest.
 */
@Controller
class RestfulServer {

	extension JSONUtils = new JSONUtils
	TraiFlix traiFlix
	AppController appController

	new(TraiFlix traiFlix) {
		this.traiFlix = traiFlix
		this.appController = new AppController()
	}
    		
    // retorna las categorias		
	@Get("/categories")
	def getCategories() {
		response.contentType = ContentType.APPLICATION_JSON
		var res = this.traiFlix.categorias		
		Collections.sort(res, String.CASE_INSENSITIVE_ORDER)
		return ok(res.toJson)
	}
	
	 // Retorne el listado de los contenidos que tengan la categoría recibida.
	 @Get("/content/:category")
	 def getContenidoDeCategoria() {
	 		response.contentType = ContentType.APPLICATION_JSON
	 		var contenidos = new ArrayList
	 		var categoria = category.toLowerCase.substring(0,3)
			
			for(Pelicula p : this.traiFlix.peliculas) {
				if(p.categoria.toLowerCase.contains(categoria)) {
					contenidos.add(new SimplePelicula(p))
				}
			}
			for(Serie s : this.traiFlix.series) {
				if(s.categoria.toLowerCase.contains(categoria)) {
					contenidos.add(new SimpleSerie(s))
				}
			}

			return ok(contenidos.toJson)
	 }
	
	//indica si el usuario es valido
	@Post("/auth")
	// Body [ { "username" : "nombreUsuario"}]
	def validarUsuario(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
 		val nombreUsuario = body.getPropertyValue("username") 
		val usuario = AppController.buscarUsuario(this.traiFlix, nombreUsuario);
		if(usuario === null){
			return badRequest(this.appController.argsAJson("status, error, message, Usuario Invalido")) 
		}else{
			return ok('{ "status": "ok",
			"message": "¡Listo!" }')
			}
	}
   	
	// Retorna el contenido favorito de un usuario.
	@Get("/:username/favs")
	def getContenidoFavoritoDeUsuario() {
		response.contentType = ContentType.APPLICATION_JSON
		val usuario = AppController.buscarUsuario(this.traiFlix, username)
		if(usuario === null){
			return badRequest(this.appController.argsAJson("status, error, message, Usuario Invalido")) 
		}else{
			return ok(this.appController.getContenidoFavoritoDeUsuarioParaMostrar(usuario))
		}
	}
	
	// Retorna el contenido recomendado de un usuario.
	@Get("/:username/recommended")
	def getContenidoRecomendadoDeUsuario() {
		response.contentType = ContentType.APPLICATION_JSON
		val usuario = AppController.buscarUsuario(this.traiFlix, username)
		if(usuario === null){
			return badRequest(this.appController.argsAJson("status, error, message, Usuario Invalido")) 
		}else{
			return ok(this.appController.getContenidoRecomendadoDeUsuarioParaMostrar(usuario))
		}
	}
	
	// Retorna el contenido mas recomendado de un usuario.
	@Get("/:username/mostrecommended")
	def getContenidoMasRecomendadoDeUsuario() {
		response.contentType = ContentType.APPLICATION_JSON
		val usuario = AppController.buscarUsuario(this.traiFlix, username)
		if(usuario === null){
			return badRequest(this.appController.argsAJson("status, error, message, Usuario Invalido")) 
		}else{
			return ok(this.appController.getContenidoMasRecomendadoDeUsuarioParaMostrar(usuario))
		}
	}
	
	// Recomienda un contenido a un usuario.
	// Body [{"userfrom" : "nombreUserFrom", "userto" : "nombreUserTo"}]
	@Post("/recommend/:type/:id")
	def generarRecomendacionDeUnUsuarioAOtro(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			val nombreUserFrom = body.getPropertyValue("userfrom")
			val nombreUserTo = body.getPropertyValue("userto")
			val codigo = new Integer(id)
			var userFrom = AppController.buscarUsuario(this.traiFlix, nombreUserFrom)
			var userTo = AppController.buscarUsuario(this.traiFlix, nombreUserTo)
			var nombreContenido = ""
			
			if(type.equals("serie")) {
				userFrom.sugerirContenido(this.traiFlix.series.findFirst[serie | serie.codigo == codigo], userTo)
				nombreContenido = this.traiFlix.series.findFirst[serie | serie.codigo == codigo].titulo
			} else {
				userFrom.sugerirContenido(this.traiFlix.peliculas.findFirst[pelicula | pelicula.codigo == id], userTo)
				nombreContenido = this.traiFlix.peliculas.findFirst[pelicula | pelicula.codigo == codigo].titulo
			}
			
			var msgResultado = "%s le recomendo %s a %s"
			msgResultado = String.format(msgResultado, userFrom.nombre, nombreContenido, userTo.nombre)
			return ok(this.appController.argsAJson("status, ok, message, " + msgResultado))
			} catch (Exception exception) {
			return badRequest(this.appController.argsAJson("status, error, message, " + AppController.textoError))
		    }  
	}
	
	//Dado un usuario ya vlaido, retorna la informacion de la pelicula dada si esta
	@Get("/:username/movie/:id")
	def getMovie() {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			val codigoId = new Integer(id)
			val usuario = AppController.buscarUsuario(this.traiFlix, username)
			var pelicula = this.traiFlix.peliculas.findFirst[pelicula | pelicula.codigo == codigoId]
			pelicula.contenidoRelacionadoPelicula = appController.peliculaRelacionadas(traiFlix, pelicula)
			pelicula.contenidoRelacionadoSerie = appController.serieRelacionadas(traiFlix, pelicula)
			return ok(this.appController.getInformacionPeliculaIdconUsuario(pelicula ,usuario))
			} catch (Exception exception) {
			return badRequest(appController.getErrorJson("No se encontro la pelicula"))
		}		
	}
	
	// Dado el nombre de un usuario, establezca si marco como favorito o no a un deter contenido segun id dado
	// Body: { "value": "valorBooleano" }
	@Put("/:username/fav/:type/:id")
	def asignarFavoritos(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		try {

			var usuario = AppController.buscarUsuario(traiFlix,username)
			var tipoDeContenido = appController.validar(type, #["movie","serie"])
			var contenido = appController.buscarContenidoSegunTipoeId(traiFlix,tipoDeContenido, Integer.parseInt(id))
			var esFavorito = appController.validar(body.getPropertyValue("value"), #["true", "false"]).equals("true")
			var asignacion = ""
			if ( esFavorito ){
				usuario.agregarAFavoritos( contenido )
				asignacion = "agrego a favoritos"
			}else{
				usuario.quitarDeFavoritos( contenido )
				asignacion = "saco de sus favoritos"
			}
			var msg = "El usuario %s %s a %s"
			msg = String.format(msg, usuario.nombre, asignacion, contenido.titulo )
			return ok( appController.argsAJson( "status, ok, message, "+msg ) )
			
		} catch (Exception e) {
			return  badRequest(appController.getErrorJson(e.message))
		}
	}
	
	// Retorna lista de peliculas vists por el usuario
	@Get("/:username/watched/movies")
	def getContenidoVisto() {
		var usuario = AppController.buscarUsuario(traiFlix, username)
		if(usuario == null){
			return badRequest(this.appController.argsAJson("status, error, message, Usuario Invalido")) 
		}else{
			return ok( usuario.peliculasVistas.map[p | new SimplePelicula(p)].toJson)
		}
	}
	
	// Dado un username y un id de un contenido tipo movie o serie, se establece como visto segun un valor booleano 
	@Put("/:username/watched/:type/:id")
	// Body: { "value": "valorBooleano"}
	def marcarVisto(@Body String body){
		response.contentType = ContentType.APPLICATION_JSON
		try{

			var usuario = AppController.buscarUsuario(traiFlix,username)
			var tipoDeContenido = appController.validar(type, #["movie","serie"])
			var contenido = appController.buscarContenidoSegunTipoeId(traiFlix,tipoDeContenido, Integer.parseInt(id))
			var visto = appController.validar(body.getPropertyValue("value"), #["true", "false"]).equals("true")			
			var asignacion = ""
			if ( visto ){
				appController. marcarVistoAUnContenido(usuario, contenido)
				asignacion = "agrego a su contenido visto"
			}else{
				appController. marcarNoVistoAUnContenido(usuario, contenido)
				asignacion = "elimino de su contenido visto"
			}
			var msg = "El usuario %s %s a %s"
			msg = String.format(msg, usuario.nombre, asignacion, contenido.titulo )
			return ok( appController.argsAJson( "status, ok, message, "+msg ) )
		}catch (Exception e){
			return badRequest("")	
		}
	}
	

	@Put("/:username/rating/:type/:id")
	// Body: { "stars": cantidadDeEstrellas }
	def calificarContenido(@Body String body){
		response.contentType = ContentType.APPLICATION_JSON
		try{			
			var usuario = AppController.buscarUsuario(this.traiFlix, username)
			var tipoDeContenido = appController.validar(type, #["movie", "chapter"])
			var contenido = appController.buscarContenidoSegunTipoeId(traiFlix,tipoDeContenido, Integer.parseInt(id))
			var rating = Integer.parseInt( appController.validar(body.getPropertyValue("stars"), #["1", "2", "3", "4", "5"]) )
			
			appController.corresponderCalificacion(usuario, rating, type, contenido )
			
			var msg = "El usuario %s califico con %s estrellas a %s"
			msg = String.format(msg, usuario.nombre, rating, contenido.titulo)
			return ok(appController.argsAJson("status, ok, message, "+msg))
		} catch (Exception e){
			return  badRequest(appController.getErrorJson(e.message))
		}
	}

	// Busca un contenido en el sistema con un nombre similar al recibido.
	// Body [{"pattern" : "textoABuscar"}]
	@Post("/search")
	def buscarContenidos(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			val textoABuscar = body.getPropertyValue("pattern").toLowerCase
			var contenidos = new ArrayList
			
			for(Pelicula p : this.traiFlix.peliculas) {
				if(p.titulo.toLowerCase.contains(textoABuscar)) {
					contenidos.add(new SimplePelicula(p))
				}
			}
			for(Serie s : this.traiFlix.series) {
				if(s.titulo.toLowerCase.contains(textoABuscar)) {
					contenidos.add(new SimpleSerie(s))
				}
			}

			return ok(contenidos.toJson)
			} catch (Exception exception) {
			return badRequest(this.appController.argsAJson("status, error, message, " + AppController.textoError))
		}
	}	
	
	// Dado un usuario valido, retorna la informacion de la serie dada si está
	@Get("/:username/serie/:id")
	def getSerie(){
		response.contentType = ContentType.APPLICATION_JSON
		try{
			val codigoId = new Integer(id)
			val usuario = AppController.buscarUsuario(this.traiFlix, username)
			var serie = this.traiFlix.series.findFirst[serie | serie.codigo == codigoId]
			serie.contenidoRelacionadoPelicula = appController.peliculaRelacionadasASerie(traiFlix, serie)
			serie.contenidoRelacionadoSerie = appController.serieRelacionadasASerie(traiFlix, serie)
			return ok(this.appController.getInformacionSerieIdConUsuario(serie, usuario))
			} catch (Exception exception){
			return badRequest(appController.getErrorJson("No se encontro la serie"))
		}
	}
	
	//Dado un usuario y un contenido, retorna si el usuario lo ha visto.
	@Get("/:username/vio/:type/:id")
	def vioContenido() {
		response.contentType = ContentType.APPLICATION_JSON
				response.contentType = ContentType.APPLICATION_JSON
		try{
			val codigoId = new Integer(id)
			val usuario = AppController.buscarUsuario(this.traiFlix, username)
			var visto = false
			if(type.equals("movie")) {
				visto = !usuario.peliculasVistas.filter[peli | peli.codigo == codigoId].empty
			} else {
				visto = !this.traiFlix.seriesVistasDeFormaCompletaPor(usuario).filter[serie | serie.codigo == codigoId].empty
			}
			return ok(this.appController.argsAJson("visto, " + visto.toString()))
		} catch (Exception exception) {
			return badRequest(this.appController.argsAJson("status, error, message, " + AppController.textoError))
		}
	}
	
	// Retorna el nombre de los amigos de un usuario.
	@Get("/:username/amigos")
	def getAmigosDeUsuario() {
		response.contentType = ContentType.APPLICATION_JSON
		val usuario = AppController.buscarUsuario(this.traiFlix, username)
		if(usuario===null){
			return badRequest(this.appController.argsAJson("status, error, message, Usuario Invalido")) 
		}
		return ok(this.appController.getAmigosDeUsuarioParaMostrar(usuario))
	}

	// Retornando las peliculas
	@Get("/content/movies")
	def getPeliculas(){
		response.contentType = ContentType.APPLICATION_JSON
		val resp = new ArrayList
		this.traiFlix.peliculas.forEach[p|resp.add(new SimplePelicula(p))]
		return ok(resp.toJson)
	}
	
	// Retornando las series
	@Get("/content/series")
	def getSeries(){
		response.contentType = ContentType.APPLICATION_JSON
		val resp = new ArrayList
		this.traiFlix.series.forEach[s|resp.add(new SimpleSerie(s))]
		return ok(resp.toJson)
	}
}