package runnable

import org.uqbar.xtrest.api.XTRest
import server.RestfulServer

class App {
	
	def static void main(String[] args) {
		val traiFlix = new TraiFlixFactory().traiFlix
        XTRest.startInstance(9000, new RestfulServer(traiFlix))
    }
}