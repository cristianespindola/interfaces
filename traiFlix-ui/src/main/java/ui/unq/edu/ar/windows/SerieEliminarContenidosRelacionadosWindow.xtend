package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import ui.unq.edu.ar.TraiFlix.Material
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import ui.unq.edu.ar.applicationModels.ApplicationModelSerie

class SerieEliminarContenidosRelacionadosWindow extends Dialog<ApplicationModelSerie> {
	
	new(WindowOwner owner, ApplicationModelSerie model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		this.title = "TraiFlix Eliminar Contenido Relacionado"
		val inputWidth = 200
		this.minHeight = 200
		this.minWidth = inputWidth
		
		//TABLA DE CONTENIDOS
		val tablaPanel = new Panel(mainPanel)
			
		val tablaEpisodios = new Table(tablaPanel, typeof(Material)) => [
			numberVisibleRows = 5
			items <=> "contenidoRelacionado"
			value <=> "contenidoRelacionadoSeleccionado"
		]
		
		new Column<Material>(tablaEpisodios) => [
			title = "Título"
			bindContentsToProperty("titulo")
			fixedSize = inputWidth
		]
		
		new Column<Material>(tablaEpisodios) => [
			title = "Categoría"
			bindContentsToProperty("categoria")
			fixedSize = inputWidth
		]
		//
		
		//BOTONES
		val botonesPanel = new Panel(mainPanel)
		botonesPanel.layout = new HorizontalLayout()
		
		new Button(botonesPanel) => [
				caption = "Eliminar"
				onClick[ | modelObject.eliminarContenidoRelacionado()
					       this.close
				]
		    ]
		   
	    new Button(botonesPanel) => [
				caption = "Cancelar"
				onClick [ | this.close
				]
		    ]
		//
	}
	
}
