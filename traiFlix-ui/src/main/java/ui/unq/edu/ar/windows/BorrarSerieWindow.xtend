package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import ui.unq.edu.ar.applicationModels.ApplicationModelSerie

class BorrarSerieWindow extends Dialog<ApplicationModelSerie> {
	
	new(WindowOwner owner, ApplicationModelSerie model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		this.title = "TraiFlix Borrar Serie"

		new Label(mainPanel).text = "¿Desea Borrar la Serie " + modelObject.serie.titulo + " ?"
		
		new Label(mainPanel) => []
		new Label(mainPanel) => []
		
		val panelBotonera = new Panel(mainPanel)
		panelBotonera.layout = new HorizontalLayout
		
		new Button(panelBotonera)=>[
			caption = "Aceptar"
			onClick [ | modelObject.borrarSerie()
				        this.close
			]
		]
		
		new Button(panelBotonera)=>[
			caption = "Cancelar"
			onClick [ |	this.close ]
		]
	}
}
