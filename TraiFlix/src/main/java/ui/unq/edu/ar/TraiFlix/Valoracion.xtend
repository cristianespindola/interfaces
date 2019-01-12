package ui.unq.edu.ar.TraiFlix

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@Accessors
class Valoracion {
	
	List<Integer> valoraciones
	
	new(){
		
		this.valoraciones = new ArrayList<Integer>()
	}
	
 	def agregarValoracion(Integer valoracion){
 		
 		this.valoraciones.add(valoracion)
 	}
 	
 	def tamanioValoraciones() {
 		
 		return this.valoraciones.size;
 	}

 	
	def getRating() {
		if (tamanioValoraciones!=0) {
			var sum = 0
			for (int v : valoraciones) {
				sum += v
			}
			return Math.round(sum / valoraciones.size)
		} else {
			return 0
		}
	}
	

}