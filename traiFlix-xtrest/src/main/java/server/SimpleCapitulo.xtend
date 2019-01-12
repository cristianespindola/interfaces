package server

import ui.unq.edu.ar.TraiFlix.Capitulo
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date

@Accessors
class SimpleCapitulo {
	
	int id
	String type
	int nroTemporada
	int nroCapitulo
	String fechaDeEstreno
	int duracion
	String directores
	String actoresPrincipales
	String linkYT 
	int rating
	String titulo
	
	new(){}
	
	new(Capitulo capitulo){
		this.id = capitulo.codigo
		this.type = "Capitulo"
	    this.nroTemporada = capitulo.nroTemporada
		this.nroCapitulo = capitulo.nroCapitulo
		this.fechaDeEstreno = AppController.formatearFechaEstrenoParaMostrar(capitulo.fechaEstreno)
		this.duracion = capitulo.duracion
		this.directores = capitulo.directores
		this.actoresPrincipales = capitulo.actoresPrincipales
		this.linkYT = capitulo.linkYT
		this.rating = capitulo.rating
		this.titulo = capitulo.titulo
	}
		
}