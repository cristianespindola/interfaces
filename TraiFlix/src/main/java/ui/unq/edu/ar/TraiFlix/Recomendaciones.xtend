package ui.unq.edu.ar.TraiFlix

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import org.uqbar.commons.model.annotations.Observable
import java.util.Collections

@Accessors
@Observable
class Recomendaciones {
	
	List<Recomendacion> recomendaciones
	
	new() {
		this.recomendaciones = new ArrayList()
	}
	
	def yaRecomendado(Material material) {
		var res = false
		for(Recomendacion r : this.recomendaciones) {
			if(r.getMaterial().getCodigo() == material.getCodigo()) {
				res = true
			}
		}
		return res
	}
	
	def getRecomendacionDe(Material material) {
		var res = new Recomendacion(material)
		for(Recomendacion r : this.recomendaciones) {
			if(r.getMaterial() == material) {
				res = r
			}
		}
		return res 
	}
	
	def recomendar(Material material) {
		if(!this.yaRecomendado(material)) {
			this.recomendaciones.add(new Recomendacion(material))
		} 
		this.getRecomendacionDe(material).setCantidad(this.getRecomendacionDe(material).getCantidad() + 1)
	}
	
	def masRecomendadas() {
		var recomendadas = this.recomendaciones
		var List<Material> res = new ArrayList()
		Collections.sort(recomendadas, [ r1, r2 | r2.cantidad - r1.cantidad ])
		for(Recomendacion r : recomendadas) {
			res.add(r.getMaterial())
		}
		if(recomendadas.size > 5) {
			res = res.subList(0,5)
		}
		return res
	}
	
	def masRecomendada(List<Recomendacion> recomendaciones) {
		var max = 0
		var res = new Recomendacion()
		for(Recomendacion r : recomendaciones) {
			if(r.getCantidad() > max) {
				res = r
				max = r.getCantidad()
			}
		}
		return res
	}
	
	def getMaterialRecomendado() {
		var res = new ArrayList()
		for(Recomendacion r : this.recomendaciones) {
			res.add(r.getMaterial())
		}
		return res
	}
	
}