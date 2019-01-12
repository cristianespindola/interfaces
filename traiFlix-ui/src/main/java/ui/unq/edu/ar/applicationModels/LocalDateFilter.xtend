package ui.unq.edu.ar.applicationModels

import org.uqbar.arena.filters.TextFilter
import org.uqbar.arena.widgets.TextInputEvent
import java.util.ArrayList

class LocalDateFilter implements TextFilter	{
	
	override accept(TextInputEvent event) {
		val expected = new ArrayList(#["\\d", "\\d?", "/", "\\d", "\\d?", "/", "\\d{0,4}"])
		val regex = expected.reverse.fold("")[result, element| '''(«element»«result»)?''']
		println(regex)
		event.potentialTextResult.matches(regex)
	}	
}
