package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.VerticalLayout
import ui.unq.edu.ar.applicationModels.ApplicationModelPelicula

class BorrarPeliculaWindow extends Dialog<ApplicationModelPelicula>{
	
	new(WindowOwner owner, ApplicationModelPelicula model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		this.title = "TraiFlix Borrar Pelicula"
		new Panel(mainPanel)
		mainPanel.layout = new VerticalLayout()
		new Label(mainPanel).text = "¿Desea Borrar La Pelicula " + modelObject.pelicula.titulo + " ?"
		
		crearPanelHorizontal(mainPanel)
	}
	
	def crearPanelHorizontal(Panel panel) {
		val panelBotonera = new Panel (panel)
		panelBotonera.layout = new HorizontalLayout
		
		new Button(panelBotonera)=>[
			caption = "Aceptar"
			onClick [ | aceptar()]
		]
		
		new Button(panelBotonera)=>[
			caption = "Cancelar"
			onClick [ |	this.close]
		]
	}

	def aceptar() {
		modelObject.borrarPelicula()
		this.close
	}
	
}
