package ui.unq.edu.ar.windows

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.List
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.NumericField
import ui.unq.edu.ar.applicationModels.ApplicationModelSerie

class AgregarSerieWindow extends Dialog<ApplicationModelSerie> {
	
	new(WindowOwner owner, ApplicationModelSerie model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		this.title = "TraiFlix Agregar Nueva Serie"
		val inputWidth = 100
		this.minHeight = 200
		this.minWidth = inputWidth
		
		//DATOS DE LA SERIE
		val datosPanel = new Panel(mainPanel)
		datosPanel.layout = new ColumnLayout(2)
		
		
		new Label(datosPanel) => [
			text = "Código:"
			new NumericField(datosPanel, false) => [
				value <=> "serie.codigo"
				width = inputWidth
			]
		]
		
		new Label(datosPanel) => [
			text = "Título:"
			new TextBox(datosPanel) => [
				value <=> "serie.titulo"
				width = inputWidth
			]
		]
		
		new Label(datosPanel) => [
			text = "Creadores:"
			new TextBox(datosPanel) => [
				value <=> "serie.creadores"
				width = inputWidth
			]
		]
		
		new Label(datosPanel) => [
			text = "Clasificación:"
			new List(datosPanel) => [             
	                     items <=> "clasificaciones"    
	                     value <=> "serie.clasificacion"
	                     width = inputWidth
	              ] 
		]   
		
		new Label(datosPanel) => [
				text = "Categorías:"
				new TextBox(datosPanel) => [
					value <=> "serie.categoria"
					width = inputWidth
				]
			]
			
		new Button(datosPanel) => [
				caption = "Agregar Capítulo"
				onClick [ | this.openDialog(new CapitulosWindow(this, modelObject)) ]
		    ]	
		
		new Label(datosPanel) => []
		new Label(datosPanel) => []	
		//
		
		//BOTONES
		val botonesPanel = new Panel(mainPanel)
		botonesPanel.layout = new HorizontalLayout()
		
		new Button(botonesPanel) => [
				caption = "Aceptar"
				onClick[ | modelObject.agregarNuevaSerie()
					       this.close
				]
		    ]
		   
	    new Button(botonesPanel) => [
				caption = "Cancelar"
				onClick [ | this.close ]
		    ]
		//
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
}
