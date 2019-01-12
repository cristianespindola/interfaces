package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import ui.unq.edu.ar.TraiFlix.Capitulo
import org.uqbar.arena.widgets.tables.Column
import ui.unq.edu.ar.TraiFlix.Material
import ui.unq.edu.ar.applicationModels.ApplicationModelSerie

class VerSerieWindow extends Dialog<ApplicationModelSerie> {
	
	new(WindowOwner owner, ApplicationModelSerie model) {
		super(owner, model)
	}
		
	override protected createFormPanel(Panel mainPanel) {
		
		this.title = "TraiFlix Ver Serie"
		val minWidth = 200
		this.minHeight = 200
		this.minWidth = minWidth
		
		//DATOS DE LA SERIE
		val datosPanel = new Panel(mainPanel)
		datosPanel.layout = new ColumnLayout(2)
		
		new Label(datosPanel) => [
			text = "Código:"
			new Label(datosPanel) => [
				value <=> "serie.codigo"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Título:"
			new Label(datosPanel) => [
				value <=> "serie.titulo"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Creadores:"
			new Label(datosPanel) => [
				value <=> "serie.creadores"
				width = minWidth
				alignLeft
			]
		]
		
		new Label(datosPanel) => [
			text = "Clasificación:"
			new Label(datosPanel) => [
				value <=> "serie.clasificacion"
				width = minWidth
				alignLeft
			]
		]   
		
		new Label(datosPanel) => [
				text = "Categorías:"
				new Label(datosPanel) => [
					value <=> "serie.categoria"
					width = minWidth
					alignLeft
				]
			]
		//
		
		//LABEL SECCION CAPITULOS	
		new Label(datosPanel) => []
		new Label(datosPanel) => []
			
		new Label(datosPanel) => [
			text = "Capítulos de la serie:"
		]
		//
		
		//TABLA DE CAPITULOS
		val tablaPanel = new Panel(mainPanel)
			
		val tablaEpisodios = new Table(tablaPanel, typeof(Capitulo)) => [
			numberVisibleRows = 5
			items <=> "capitulos"
			value <=> "capitulo"
		]
		
		new Column<Capitulo>(tablaEpisodios) => [
			title = "Título"
			bindContentsToProperty("titulo")
			fixedSize = minWidth
			
		]
		
		new Column<Capitulo>(tablaEpisodios) => [
			title = "Duración"
			fixedSize = minWidth
			bindContentsToProperty("duracion")
		]
		
		new Column<Capitulo>(tablaEpisodios) => [
			title = "Número de Capítulo"
			fixedSize = minWidth
			bindContentsToProperty("nroCapitulo")
		]
		
		new Column<Capitulo>(tablaEpisodios) => [
			title = "Número de Temporada"
			bindContentsToProperty("nroTemporada")
			fixedSize = minWidth
		]
		
		new Button(tablaPanel) => [
				caption = "Info capitulo"
				onClick [ | modelObject.setFechaEstrenoParaMostrar()
					        this.openDialog(new VerCapituloWindow(this, modelObject))
				]
		    ]
		//
		
		//TABLA CONTENIDO RELACIONADO	
		new Label(tablaPanel) => []
		new Label(tablaPanel) => []
			
		new Label(tablaPanel) => [
			text = "Contenido relacionado de la serie:"
			alignLeft
		]
		
		val tablaContenidoss = new Table(tablaPanel, typeof(Material)) => [
			numberVisibleRows = 5
			items <=> "contenidoRelacionado"
			value <=> "contenidoRelacionadoSeleccionado"
		]
		
		new Column<Material>(tablaContenidoss) => [
			title = "Título"
			bindContentsToProperty("titulo")
			fixedSize = minWidth
		]
		
		new Column<Material>(tablaContenidoss) => [
			title = "Categoría"
			bindContentsToProperty("categoria")
			fixedSize = minWidth
		]
		
		new Label(tablaPanel) => []
		new Label(tablaPanel) => []
		//
		
		//BOTON SALIR
		val botonesPanel = new Panel(mainPanel)
		
		new Button(botonesPanel) => [
				caption = "Salir"
				onClick [ |this.close ]
		    ]
		//
	 }
	 
	 def openDialog(Dialog<?> dialog) {
		dialog.open
	}
		
}
