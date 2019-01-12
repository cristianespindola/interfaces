package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.tables.Table
import ui.unq.edu.ar.TraiFlix.Material
import org.uqbar.arena.widgets.tables.Column
import ui.unq.edu.ar.applicationModels.ApplicationModelPelicula
import ui.unq.edu.ar.applicationModels.LocalDateTransformer

class PeliculasWindow extends Dialog<ApplicationModelPelicula>{
	
	new(WindowOwner owner, ApplicationModelPelicula model) {
		super(owner, model)
		title = "Información De: " + modelObject.pelicula.titulo + ""
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "TraiFlix Información de Pelicula"
		val minWidth = 200
		this.minHeight = 200
		this.minWidth = minWidth
		
		val panel = new Panel(mainPanel)
		panel.layout = new ColumnLayout(2)
		
		new Label(panel ) => [
			text = "Codigo:"
			new Label(panel ) => [
				value <=> "pelicula.codigo"
				width = minWidth
				alignLeft
			]
		]
			
			
		new Label(panel ) => [
			text = "Titulo:"
			new Label(panel ) => [
				value <=> "pelicula.titulo"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel ) => [
			text = "Categorias:"
			new Label(panel ) => [
				value <=> "pelicula.categoria"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel ) => [
			text = "Clasificación:"
			new Label(panel ) => [
				value <=> "pelicula.clasificacion"
				width = minWidth
				alignLeft
			]
		]

		new Label(panel ) => [
			text = "Fecha De Estreno (dd/mm/yyyy):"
			new Label(panel ) => [
				(value <=> "pelicula.fechaDeEstreno").transformer = new LocalDateTransformer
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel ) => [
			text = "Duracion:"
			new Label(panel ) => [
				value <=> "pelicula.duracion"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel ) => [
			text = "Directores:"
			new Label(panel ) => [
				value <=> "pelicula.directores"
				width = minWidth
				alignLeft
			]
		]

		new Label(panel ) => [
			text = "Actores Principales::"
			new Label(panel ) => [
				value <=> "pelicula.actores"
				width = minWidth
				alignLeft
			]
		]

		new Label(panel ) => [
			text = "Link Youtube:"
			new Label(panel ) => [
				value <=> "pelicula.linkYT"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(panel) => []
		new Label(panel) => []
			
		new Label(panel) => [
			text = "Contenido Relacionado:"
		]
		val tablaPanel = new Panel(mainPanel)
			
		val tableContenidoRelacionado = new Table(tablaPanel, Material) => [
			numberVisibleRows = 5
			items <=> "contenidoRelacionado"
		]
		
		new Column<Material>(tableContenidoRelacionado) => [
			title = "Título"
			bindContentsToProperty("titulo")
			fixedSize = minWidth
		]
		
		new Column<Material>(tableContenidoRelacionado) => [
			title = "Clasificacion"
			fixedSize = minWidth
			bindContentsToProperty("clasificacion")
		]
		
		new Column<Material>(tableContenidoRelacionado) => [
			title = "Categoria"
			fixedSize = minWidth
			bindContentsToProperty("categoria")
		]
			
		val botonesPanel = new Panel(mainPanel)
		
		new Button(botonesPanel) => [
				caption = "Salir"
				onClick [ |this.close ]
		    ]					
	}
}
