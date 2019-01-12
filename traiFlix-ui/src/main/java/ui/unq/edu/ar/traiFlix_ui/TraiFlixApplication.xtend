package ui.unq.edu.ar.traiFlix_ui

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import ui.unq.edu.ar.applicationModels.ApplicationModelTraiFlix
import ui.unq.edu.ar.windows.TraiFlixWindow

/**
 * Correr esta clase con el siguiente argument
 * 
 * -Djava.system.class.loader=org.uqbar.apo.APOClassLoader
 */
public class TraiFlixApplication extends Application {

	override protected Window<?> createMainWindow() {
		var model = new ApplicationModelTraiFlix()
		return new TraiFlixWindow(this, model);
	}
	
	def static void main(String[] args) {
		new TraiFlixApplication().start
	}
	
}
	