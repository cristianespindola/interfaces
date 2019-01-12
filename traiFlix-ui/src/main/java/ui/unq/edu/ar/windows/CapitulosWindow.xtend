package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import ui.unq.edu.ar.TraiFlix.TraiFlix
import ui.unq.edu.ar.TraiFlix.Capitulo
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.NumericField
import ui.unq.edu.ar.applicationModels.ApplicationModelSerie

class CapitulosWindow extends Dialog<ApplicationModelSerie> {
	
	new(WindowOwner owner, ApplicationModelSerie model) {
		super(owner, model)
		title = "Traiflix Capitulo"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
	  this.minWidth = 200
		
	  new Panel(mainPanel) => [
	  	
	  	// DATOS DEL CAPITULO
	  	new Label(mainPanel) => [
			text = "Código:"
			new NumericField(mainPanel, false) => [
				value <=> "capitulo.codigo"
			]
		]
		
		new Label(mainPanel) => [
				text = "Titulo"
				new TextBox(mainPanel) => [
					value <=> "capitulo.titulo"
				]
			]
		
		new Label(mainPanel) => [
				text = "Duración"
				new TextBox(mainPanel) => [
					value <=> "capitulo.duracion"
				]
			]
		
		new Label(mainPanel) => [
				text = "Temporada"
				new TextBox(mainPanel) => [
					value <=> "capitulo.nroTemporada"
				]
			]
			
		new Label(mainPanel) => [
			text = "Capitulo"
			new TextBox(mainPanel) => [
				value <=> "capitulo.nroCapitulo"
			]
		]
		
		new Label(mainPanel) => [
				text = "Fecha de estreno (dd/mm/yyyy)"
				new TextBox(mainPanel) => [
					value <=> "fechaEstrenoCapitulo"
				]
			]
		
		new Label(mainPanel) => [
				text = "Directores"
				new TextBox(mainPanel) => [
					value <=> "capitulo.directores"
				]
			]
			
		new Label(mainPanel) => [
				text = "Actores"
				new TextBox(mainPanel) => [
					value <=> "capitulo.actoresPrincipales"
				]
			]
			
		new Label(mainPanel) => [
			text = "Link Youtube"
			new TextBox(mainPanel) => [
				value <=> "capitulo.linkYT"
			]
		]
	 ]
	 //
	 
	 	//BOTONES
		val botonesPanel = new Panel(mainPanel)
		botonesPanel.layout = new HorizontalLayout()
		
		new Button(botonesPanel) => [
				caption = "Aceptar"
				onClick[ | modelObject.agregarNuevoCapitulo()
					       this.close
				]
		    ]
		   
	    new Button(botonesPanel) => [
				caption = "Cancelar"
				onClick [ | modelObject.cancelarCambiosACapitulo()
					        modelObject.reiniciarDatosCapitulo()
					        this.close
				]
		    ]
		//
	}
	
}
