package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.bindings.DateTransformer
import ui.unq.edu.ar.applicationModels.ApplicationModelSerie

class VerCapituloWindow extends Dialog<ApplicationModelSerie> {
	
	new(WindowOwner owner, ApplicationModelSerie model){
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel){
		
		this.title = "TraiFlix Informacion del capitulo"
		val minWidth = 300
		this.minHeight = 300
		this.minWidth = minWidth
		
		// Datos del capitulo
		val datosPanel = new Panel(mainPanel)
		datosPanel.layout = new ColumnLayout(2)
		
		new Label(datosPanel) => [
			text = "Codigo:"
			new Label(datosPanel) => [
				value <=> "capitulo.codigo"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Titulo:"
			new Label(datosPanel) => [
				value <=> "capitulo.titulo"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Nro de temporada:"
			new Label(datosPanel) => [
				value <=> "capitulo.nroTemporada"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Nro de capitulo:"
			new Label(datosPanel) => [
				value <=> "capitulo.nroCapitulo"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Fecha De Estreno (dd/mm/yyyy):"
			new Label(datosPanel ) => [
				(value <=> "capitulo.fechaEstreno").transformer = new DateTransformer
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Duracion:"
			new Label(datosPanel) => [
				value <=> "capitulo.duracion"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Directores:"
			new Label(datosPanel) => [
				value <=> "capitulo.directores"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Actores principales:"
			new Label(datosPanel) => [
				value <=> "capitulo.actoresPrincipales"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Titulo:"
			new Label(datosPanel) => [
				value <=> "capitulo.titulo"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Link YouTube:"
			new Label(datosPanel) => [
				value <=> "capitulo.linkYT"
				width = minWidth
				alignLeft
			]
		]
		
		//BOTON SALIR
		val botonSalir = new Panel(mainPanel)
		
		new Button(botonSalir) => [
				caption = "Salir"
				onClick [ |this.close ]
		    ]
		
		
		
		
	}
}
