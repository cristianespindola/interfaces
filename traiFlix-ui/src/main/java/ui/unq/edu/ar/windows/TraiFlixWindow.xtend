package ui.unq.edu.ar.windows

import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import ui.unq.edu.ar.TraiFlix.Pelicula
import ui.unq.edu.ar.TraiFlix.Serie
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import ui.unq.edu.ar.applicationModels.ApplicationModelTraiFlix
import ui.unq.edu.ar.applicationModels.ApplicationModelSerie
import ui.unq.edu.ar.applicationModels.ApplicationModelPelicula

class TraiFlixWindow extends SimpleWindow<ApplicationModelTraiFlix> {
	
	new(WindowOwner parent, ApplicationModelTraiFlix model) { 
		super(parent, model)
	}
	
	override protected void createMainTemplate(Panel mainPanel) {
		this.setTitle("Bienvenido a TraiFlix!")
		
		//Titulo
		new Label(mainPanel) => [
			text = "TraiFlix"
			alignCenter
			fontSize = 17
		]
		
		//contenido
		var panelPelisYSeries = new Panel(mainPanel)
		panelPelisYSeries.layout = new HorizontalLayout
		
		createPanelPeliculas(panelPelisYSeries)
		createPanelSeries(panelPelisYSeries)
		createPanelUsuarios(mainPanel)

	}
	
	def createPanelUsuarios(Panel panel) {
		var panelUsers = new Panel(panel)
		panelUsers.layout = new HorizontalLayout
		new Button(panelUsers) =>[ caption = "Ver usuarios"
			onClick[| verUsuarios()]
		]
	}

	// peliculas
	def createPanelPeliculas(Panel panel) {
		var panelPeliculas = new Panel(panel)
		panelPeliculas.layout = new VerticalLayout()
		
		new Label(panelPeliculas) => [ // Titulo
			text = "Películas"
			alignCenter
		]
		new Label(panelPeliculas) => [ 
			alignLeft
			text = "Buscar película por titulo"
		]
		new TextBox(panelPeliculas) => [
			width = 90
			value <=> "filtroPelicula"
		]
		createBusquedaPeliculas(panelPeliculas)
	}
	
	// panel opciones a realizar
	def createOpcionesPeliculas(Panel panel){
		var panelOpciones = new Panel(panel)
		panelOpciones.layout = new VerticalLayout
		
		new Button(panelOpciones) => [
			caption = "Nueva pelicula"
			onClick[| agregarPelicula(modelObject) ]
		]
		new Button(panelOpciones) => [
			caption = "Ver pelicula"
			onClick[| verPelicula(modelObject.peliculaSeleccionada, modelObject)]
		]
		new Button(panelOpciones) => [
			caption = "Modificar"
			onClick[| modificarPelicula(modelObject.peliculaSeleccionada, modelObject)]
		]
		new Button(panelOpciones) => [
			caption = "Borrar"
			onClick[| borrarPelicula(modelObject.peliculaSeleccionada, modelObject)]
		]
	}
		
	// panel vista previa y busqueda peliculas
	def createBusquedaPeliculas(Panel panel) {
		var panelBusquedaPeliculas = new Panel(panel)
		panelBusquedaPeliculas.layout = new HorizontalLayout
		panelVistaPeliculas(panelBusquedaPeliculas)
		createOpcionesPeliculas(panelBusquedaPeliculas)
	}
	
	// vista previa peliculas
	def panelVistaPeliculas(Panel panel){
		var panelVista = new Panel(panel)
		panel.layout = new HorizontalLayout
		new List<Pelicula>(panelVista) => [ 
			height = 100
			(items <=> "peliculas").adapter = new PropertyAdapter(Pelicula, "titulo")
			value <=> "peliculaSeleccionada"
		]
	}
	
	def createPanelSeries(Panel panel) {
		var panelSeries = new Panel(panel)
		panelSeries.layout = new VerticalLayout()
		new Label(panelSeries) => [
			text = "Series"
			alignCenter
		]
		new Label(panelSeries) => [ 
			alignLeft
			text = "Buscar una serie por titulo"
		]
		new TextBox(panelSeries) => [
			width = 100
			value <=> "filtroSerie"
		]
		panelBusquedaSeries(panelSeries)
	}
	
	
	// series
	
	def panelBusquedaSeries(Panel panel){
		var panelBusquedaSeries = new Panel(panel)
		panelBusquedaSeries.layout = new HorizontalLayout
		
		panelVistaSeries(panelBusquedaSeries)
		createOpcionesSeries(panelBusquedaSeries)
	}
	
	def panelVistaSeries(Panel panel){
		var panelVista = new Panel(panel)
		panel.layout = new HorizontalLayout
		new List<Serie>(panelVista) => [
			height = 100
			value <=> "serieSeleccionada"
			(items <=> "series").adapter = new PropertyAdapter(Serie, "titulo")
		]
	}

	def createOpcionesSeries(Panel panel){
		var panelOpciones = new Panel(panel)
			
		new Button(panelOpciones) => [
			caption = "Nueva serie"
			onClick[| agregarSerie(modelObject)]
		]
		new Button(panelOpciones) => [
			caption = "Ver serie"
			onClick[| verSerie(modelObject) ]
		]
		new Button(panelOpciones) => [
			caption = "Modificar"
			onClick[| modificarSerie(modelObject) ]
		]
		new Button(panelOpciones) => [
			caption = "Borrar"
			onClick[| borrarSerie(modelObject) ]
		]
	}
	

	override protected addActions(Panel actionsPanel) {}
	
	override protected createFormPanel(Panel mainPanel) {}
		
	def agregarSerie(ApplicationModelTraiFlix traiFlix){
		try {
			val nuevaSerieDialog = new AgregarSerieWindow(this, new ApplicationModelSerie(traiFlix))
			this.openDialog(nuevaSerieDialog)
		} catch (Exception e) {
		}
	}
	
	def verSerie(ApplicationModelTraiFlix traiFlix) {
		try {
			var appModelSerie = new ApplicationModelSerie(modelObject.serieSeleccionada, traiFlix)
			appModelSerie.guardarContenidoRelacionadoParaMostrar()
		    this.openDialog(new VerSerieWindow(this, appModelSerie))
		} catch(Exception e){}
	}
	
	def modificarSerie(ApplicationModelTraiFlix traiFlix) {
		try {
		    this.openDialog(new ModificarSerieWindow(this, new ApplicationModelSerie(modelObject.serieSeleccionada, traiFlix)))
		} catch(Exception e){}
	}
	
	def buscarSerie() {
		modelObject.buscarSeries
	}
	
	def borrarSerie(ApplicationModelTraiFlix traiFlix) {
		this.openDialog(new BorrarSerieWindow(this, new ApplicationModelSerie(modelObject.serieSeleccionada, traiFlix)))
	}
	
	// Peliculas
	
	def agregarPelicula(ApplicationModelTraiFlix traiFlix) {
		try {
			this.openDialog(new AgregarPeliculaWindow(this, new ApplicationModelPelicula(traiFlix)))
		} catch (Exception e) {}
	}
	
	def modificarPelicula(Pelicula pelicula, ApplicationModelTraiFlix traiFlix) {		
		try{		
			var newAppModelPelicula = new ApplicationModelPelicula(modelObject.peliculaSeleccionada, traiFlix)
			newAppModelPelicula.guardarContenidoRelacionadoParaMostrar()
			this.openDialog(new ModificarPeliculaWindow(this, newAppModelPelicula))
		}catch( Exception e){}
	}
		
	def buscarPelicula() {
		modelObject.buscarPeliculas
	}
		
	def verPelicula(Pelicula pelicula, ApplicationModelTraiFlix traiFlix){
		try{
			var newAppModelPelicula = new ApplicationModelPelicula(modelObject.peliculaSeleccionada, traiFlix)
			newAppModelPelicula.guardarContenidoRelacionadoParaMostrar()
			this.openDialog(new PeliculasWindow(this, newAppModelPelicula))
		}catch( Exception e){}
	}
	
	def borrarPelicula(Pelicula pelicula, ApplicationModelTraiFlix traiFlix) {
		try{
		this.openDialog(new BorrarPeliculaWindow(this, new ApplicationModelPelicula(pelicula, traiFlix)))
		
		}catch( Exception e){}
	}
	
	def verUsuarios() {
		try{
			this.openDialog(new VerUsuariosWindow(this, modelObject))
		}catch(Exception e){ throw e }
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
}
