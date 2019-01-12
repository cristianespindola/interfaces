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
import org.uqbar.arena.widgets.tables.Table
import ui.unq.edu.ar.TraiFlix.Capitulo
import org.uqbar.arena.widgets.tables.Column
import ui.unq.edu.ar.applicationModels.ApplicationModelSerie

class ModificarSerieWindow extends Dialog<ApplicationModelSerie> {
	
	new(WindowOwner owner, ApplicationModelSerie model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		this.title = "Editar serie"
		val inputWidth = 150
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
		
		new Label(datosPanel) => []	
		new Label(datosPanel) => []	
		
		new Label(datosPanel) => [
			text = "Capítulos de la serie:"
		]
		//
		
		//TABLA DE CAPITULOS
		val tablaPanel = new Panel(mainPanel)
		tablaPanel.layout = new HorizontalLayout()
			
		val tablaEpisodios = new Table(tablaPanel, typeof(Capitulo)) => [
			numberVisibleRows = 5
			items <=> "capitulos"
			value <=> "capitulo"
		]
		
		new Column<Capitulo>(tablaEpisodios) => [
			title = "Título"
			bindContentsToProperty("titulo")
			fixedSize = inputWidth
		]
		
		new Column<Capitulo>(tablaEpisodios) => [
			title = "Duración"
			fixedSize = inputWidth
			bindContentsToProperty("duracion")
		]
		
		new Column<Capitulo>(tablaEpisodios) => [
			title = "Número de Capítulo"
			fixedSize = inputWidth
			bindContentsToProperty("nroCapitulo")
		]
		
		new Column<Capitulo>(tablaEpisodios) => [
			title = "Número de Temporada"
			bindContentsToProperty("nroTemporada")
			fixedSize = inputWidth
		]
		//
		
		//BOTONES DE ACCIONES SOBRE CAPÍTULOS 
		val tablaPanelBotones = new Panel(tablaPanel)
		
		new Button(tablaPanelBotones) => [
				caption = "Agregar Nuevo Capítulo"
				onClick [ | modelObject.reiniciarDatosCapitulo()
					        this.openDialog(new CapitulosWindow(this, modelObject))
				]
		    ]
			
		new Button(tablaPanelBotones) => [
				caption = "Modificar Capítulo"
				onClick [ | modelObject.setFechaEstrenoParaMostrar()
					        modelObject.guardarCapituloEstadoOriginal()
					        this.openDialog(new CapitulosWindow(this, modelObject))
				]
		    ]
		    
		new Button(tablaPanelBotones) => [
				caption = "Eliminar Capítulo"
				onClick [ | modelObject.eliminarCapitulo()
				]
		    ] 
		//
		
		//BOTONES CONTENIDO RELACIONADO
		val botonesCRPanel = new Panel(mainPanel)
		
		new Label(botonesCRPanel) => []
		
		new Button(botonesCRPanel) => [
				caption = "Agregar Contenido Relacionado a la Serie"
				onClick [ | modelObject.guardarContenidoRelacionado()
					        this.openDialog(new SerieContenidosRelacionadosWindow(this, modelObject))
				]
		    ]
		    
		new Button(botonesCRPanel) => [
				caption = "Eliminar Contenido Relacionado de la Serie"
				onClick [ | modelObject.guardarContenidoRelacionadoParaMostrar()
					        this.openDialog(new SerieEliminarContenidosRelacionadosWindow(this, modelObject))
				]
		    ]
		    
		new Label(botonesCRPanel) => []
		new Label(botonesCRPanel) => []
		//
		
		//BOTONES
		val botonesPanel = new Panel(mainPanel)
		botonesPanel.layout = new HorizontalLayout()
		
		new Button(botonesPanel) => [
				caption = "Aceptar"
				onClick[ | this.close ]
		    ]
		   
	    new Button(botonesPanel) => [
				caption = "Cancelar"
				onClick [ | modelObject.cancelarCambiosASerie()
					        this.close
				]
		    ]
		//
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
}
