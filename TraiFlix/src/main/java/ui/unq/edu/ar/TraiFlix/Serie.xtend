package ui.unq.edu.ar.TraiFlix

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import org.uqbar.commons.model.annotations.Observable
import java.util.Map
import java.util.HashMap

@Accessors
@Observable
class Serie extends Material{
	
	String creadores
	Map<Integer, List<Capitulo> > temporadas
	List<Pelicula> contenidoRelacionadoPelicula
	List<Serie> contenidoRelacionadoSerie
	String linkPortada
	
	new(){}
	new(int codigo, String titulo, String categorias,  String clasificacion, String creadores){
		this.codigo = codigo
		this.titulo = titulo
		this.categoria = categorias
		this.clasificacion = clasificacion
		this.creadores = creadores
		this.temporadas = new HashMap<Integer, List<Capitulo> >()
		this.contenidoRelacionadoPelicula = new ArrayList<Pelicula>()
		this.contenidoRelacionadoSerie = new ArrayList<Serie>()
	}
	
	def agregarCapitulo(Capitulo capitulo) {
		var temporada = capitulo.getNroTemporada
		if (temporadas.containsKey(temporada) ){
			temporadas.get(temporada).add(capitulo)
		} else{
			var newTemporada = new ArrayList<Capitulo>()
			newTemporada.add( capitulo )
			temporadas.put( temporada, newTemporada )
		}
	}
	
	def getCapitulosTemporada(int nroTemporada) {
		return temporadas.get(nroTemporada)
	}
	
	def getCapitulos() {
		var totalCaps = new ArrayList<Capitulo>()
		for( List<Capitulo> temporada : temporadas.values ){
			totalCaps.addAll( temporada )
		}
		return totalCaps
	}
	
	def getRating() {
		var valoracionesActuales = new Valoracion
		for (Capitulo cap : getCapitulos) {
			if ( cap.getRating()!= 0) {
				valoracionesActuales.agregarValoracion(cap.getRating())
			}
		}
		return valoracionesActuales.getRating()
	}
	
}