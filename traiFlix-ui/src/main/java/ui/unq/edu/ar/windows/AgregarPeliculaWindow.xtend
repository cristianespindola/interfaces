package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.layout.HorizontalLayout
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.List
import ui.unq.edu.ar.applicationModels.ApplicationModelPelicula
import ui.unq.edu.ar.applicationModels.LocalDateFilter
import ui.unq.edu.ar.applicationModels.LocalDateTransformer

class AgregarPeliculaWindow extends Dialog<ApplicationModelPelicula>{
	
	new(WindowOwner owner, ApplicationModelPelicula model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		this.title = "TraiFlix Agregar Nueva Pelicula"
		crearPanelVertical(mainPanel)
		crearPanelHorizontal(mainPanel)
	}
	
	def crearPanelVertical(Panel panel) {
		new Panel(panel)
		panel.layout = new ColumnLayout(2)
					
		new Label(panel) => [
			text = "Codigo:"
			new TextBox(panel) => [
				value <=> "pelicula.codigo"
				width = 200
			]
		]
			
			
		new Label(panel) => [
			text = "Titulo:"
			new TextBox(panel) => [
				value <=> "pelicula.titulo"
				width = 200
			]
		]
		
		new Label(panel) => [
			text = "Categorias:"
			new TextBox(panel) => [
				value <=> "pelicula.categoria"
				width = 200
			]
		]
		
		new Label(panel) => [
			text = "Clasificación:"
			new List(panel) => [             
	                     items <=> "clasificaciones"    
	                     value <=> "pelicula.clasificacion"
	              ]
		]

		new Label(panel) => [
			text = "Fecha De Estreno (dd/mm/yyyy):"
			new TextBox(panel) => [
				withFilter(new LocalDateFilter)
				(value <=> "pelicula.fechaDeEstreno").transformer = new LocalDateTransformer
				width = 200
			]
		]
		
		new Label(panel) => [
			text = "Duracion:"
			new TextBox(panel) => [
				value <=> "pelicula.duracion"
				width = 200
			]
		]
		
		new Label(panel) => [
			text = "Directores:"
			new TextBox(panel) => [
				value <=> "pelicula.directores"
				width = 200
			]
		]

		new Label(panel) => [
			text = "Actores Principales::"
			new TextBox(panel) => [
				value <=> "pelicula.actores"
				width = 200
			]
		]

		new Label(panel) => [
			text = "Link Youtube:"
			new TextBox(panel) => [
				value <=> "pelicula.linkYT"
				width = 200
			]
		]		
	}
			
	def crearPanelHorizontal(Panel panel) {
		val botonesPanel = new Panel(panel)
		botonesPanel.layout = new HorizontalLayout()
		
		new Button(botonesPanel) => [
				caption = "Aceptar"
				onClick[ | 					
					modelObject.agregarPelicula()
					this.accept()		
				]
			]
		
		new Button(botonesPanel) => [
				caption = "Cancelar"
				onClick[ | this.close]
			]
	}	
}
