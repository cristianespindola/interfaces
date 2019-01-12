
package ui.unq.edu.ar.windows

import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import ui.unq.edu.ar.TraiFlix.Material
import ui.unq.edu.ar.TraiFlix.Pelicula
import ui.unq.edu.ar.TraiFlix.Usuario
import org.uqbar.arena.widgets.Button
import ui.unq.edu.ar.applicationModels.ApplicationModelTraiFlix
import ui.unq.edu.ar.applicationModels.LocalDateTransformer

class UsuarioWindow extends Dialog<ApplicationModelTraiFlix> {
	
	new(WindowOwner owner, ApplicationModelTraiFlix model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Ver usuario"
		mainPanel.layout = new VerticalLayout

		panelInfo(mainPanel)		
		tablaAmigos(mainPanel)
		tablaPeliculasVistas(mainPanel)
		tablaContenidoFav(mainPanel)
		new Button(mainPanel)=>[ caption = "Cerrar"
			onClick[| close ]
		]
	}
	
	def panelInfo(Panel panel){
		val panelInfo = new Panel(panel)
		panelInfo.layout = new ColumnLayout(2)
		new Label(panelInfo) => [
			alignRight
			text = "Nombre de usuario: "
			new Label(panelInfo) => [
				bindValueToProperty("usuario.nombreUsuario")
			]
		]
		new Label(panelInfo) => [
			alignRight
			text = "Nombre: "
			new Label(panelInfo) => [
				bindValueToProperty("usuario.nombre")
			]
		]
		new Label(panelInfo) => [
			alignRight
			text = "Fecha de registro: "
			new Label(panelInfo) => [
				bindValueToProperty("usuario.fechaRegistro").transformer = new LocalDateTransformer
			]
		]
		new Label(panelInfo) => [
			alignRight
			text = "Fecha de nacimiento: "
			new Label(panelInfo) => [
				bindValueToProperty("usuario.fechaNacimiento").transformer = new LocalDateTransformer
			]
		]
	}
	
	def tablaAmigos(Panel panel) {
		new Label(panel)=>[ alignLeft 
			text = "Amigos:"
		]
		new Table<Usuario>(panel, Usuario) =>[
			bindItemsToProperty("usuario.amigos")
			numberVisibleRows = 3
			new Column(it)=>[
				title = "Nombre de Usuario"
				bindContentsToProperty("nombreUsuario")
			]
			new Column(it)=>[
				title = "Nombre"
				bindContentsToProperty("nombre")
			]
		]
	}
	
	def tablaPeliculasVistas(Panel panelPeliculas){
		new Label(panelPeliculas)=>[ alignLeft
			text = "Peliculas vistas: "
		]
		new Table<Pelicula>(panelPeliculas, Pelicula) =>[
			numberVisibleRows = 3
			bindItemsToProperty("usuario.peliculasVistas")
			new Column(it)=>[
				title = "Titulo"
				bindContentsToProperty("titulo")
			]
			new Column(it)=>[
				title = "Directores"
				bindContentsToProperty("directores")
			]
		]
	}	
	def tablaContenidoFav(Panel panel){
		new Label(panel)=>[ alignLeft
			text = "Favoritos: "
		]
		new Table<Material>(panel, Material) =>[	
			numberVisibleRows = 3
			bindItemsToProperty("usuario.contenidoFavorito")
			new Column(it)=>[
				title = "Titulo"
				bindContentsToProperty("titulo")
			]
			new Column(it)=>[
				title = "Tipo de contenido"
				bindContentsToProperty("class.simpleName")
			]
		]
	}
}
