package ui.unq.edu.ar.windows

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import ui.unq.edu.ar.TraiFlix.Usuario
import org.uqbar.arena.widgets.tables.Column
import java.time.format.DateTimeFormatter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.VerticalLayout
import ui.unq.edu.ar.applicationModels.ApplicationModelTraiFlix

class VerUsuariosWindow extends Dialog<ApplicationModelTraiFlix> {
	
	new(WindowOwner owner, ApplicationModelTraiFlix model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		title = "TraiFlix - Usuarios"
		new Label(mainPanel) => [ 
			text = "Usuarios"
			alignCenter 
		]
		crearUsuariosTable(mainPanel)
		panelOpciones(mainPanel)
	}
	
	def crearUsuariosTable(Panel panel) {
		var tablaUsers = new Table<Usuario>(panel, Usuario) => [
			bindItemsToProperty("usuarios")
			bindSelectionToProperty("usuario")
		]
		new Column(tablaUsers)=>[
			title = "Nombre de Usuario"
			setFixedSize(130)
			bindContentsToProperty("nombreUsuario")
		]
		new Column(tablaUsers)=>[
			title = "Nombre"
			setFixedSize(130)
			bindContentsToProperty("nombre")
		]
		new Column(tablaUsers)=>[
			title = "Fecha de registro"
			setFixedSize(100)
			bindContentsToProperty("fechaRegistro")
		]
		new Column(tablaUsers)=>[
			title = "Edad"
			setFixedSize(50)
			bindContentsToProperty("edad")
		]
		
	}	
	
	def panelOpciones(Panel panel){
		var panelBotones = new Panel(panel)
		panelBotones.layout = new HorizontalLayout()
		new Button(panelBotones) => [
			caption = "Cerrar"
			onClick[| close ]
		]
		new Button(panelBotones) => [
			caption = "Ver"
			onClick[| verUsuario(modelObject) ]
		]
	}
	
	def verUsuario(ApplicationModelTraiFlix model) {
		new UsuarioWindow(this, model).open()
	}
	
}
