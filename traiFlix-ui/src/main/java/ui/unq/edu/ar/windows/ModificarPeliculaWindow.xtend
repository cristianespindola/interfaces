package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.tables.Table
import ui.unq.edu.ar.TraiFlix.Material
import org.uqbar.arena.widgets.tables.Column
import ui.unq.edu.ar.applicationModels.ApplicationModelPelicula
import ui.unq.edu.ar.applicationModels.LocalDateFilter
import ui.unq.edu.ar.applicationModels.LocalDateTransformer

class ModificarPeliculaWindow extends Dialog<ApplicationModelPelicula>{
	
	new(WindowOwner owner, ApplicationModelPelicula model) {
		super(owner, model)
		title = "Modificar: " + modelObject.pelicula.titulo + ""
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "TraiFlix Modificar Pelicula"
		val minWidth = 200
		this.minHeight = 200
		this.minWidth = minWidth
		
		val panel = new Panel(mainPanel)
		panel.layout = new ColumnLayout(2)
		
		new Label(panel ) => [
			text = "Codigo:"
			new TextBox(panel ) => [
				value <=> "pelicula.codigo"
				width = minWidth
				alignLeft
			]
		]
			
			
		new Label(panel ) => [
			text = "Titulo:"
			new TextBox(panel ) => [
				value <=> "pelicula.titulo"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel ) => [
			text = "Categorias:"
			new TextBox(panel ) => [
				value <=> "pelicula.categoria"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel) => [
			text = "Clasificación:"
			new List(panel) => [
				items <=> "clasificaciones"
				value <=> "pelicula.clasificacion"
			]
		]

		new Label(panel ) => [
			text = "Fecha De Estreno (dd/mm/yyyy):"
			new TextBox(panel ) => [
				withFilter(new LocalDateFilter)
				(value <=> "pelicula.fechaDeEstreno").transformer = new LocalDateTransformer
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel ) => [
			text = "Duracion:"
			new TextBox(panel ) => [
				value <=> "pelicula.duracion"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel ) => [
			text = "Directores:"
			new TextBox(panel ) => [
				value <=> "pelicula.directores"
				width = minWidth
				alignLeft
			]
		]

		new Label(panel ) => [
			text = "Actores Principales::"
			new TextBox(panel ) => [
				value <=> "pelicula.actores"
				width = minWidth
				alignLeft
			]
		]

		new Label(panel ) => [
			text = "Link Youtube:"
			new TextBox(panel ) => [
				value <=> "pelicula.linkYT"
				width = minWidth
				alignLeft
			]
		]
	
		new Button(mainPanel) => [
			caption = "Agregar Contenido Relacionado"
			onClick [|
				modelObject.guardarContenidoRelacionado()
				this.openDialog(new PeliculaAgregarContenidosRelacionadosWindow(this, modelObject))
			]
		]
		
		new Button(mainPanel) => [
			caption = "Eliminar Contenido Relacionado"
			onClick [|
				modelObject.guardarContenidoRelacionado()
				this.openDialog(new PeliculaEliminarContenidosRelacionadosWindow(this, modelObject))
			]
		]
		    
		crearPanelHorizontal(mainPanel)
	}
				
	def crearPanelHorizontal(Panel panel) {
		val botonesPanel = new Panel(panel)
		botonesPanel.layout = new HorizontalLayout()
		
		new Button(botonesPanel) => [
				caption = "Aceptar"
				onClick[ | this.close]
			]
		
		new Button(botonesPanel) => [
				caption = "Cancelar"
				onClick[ | this.close]
			]
	}	
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
}
