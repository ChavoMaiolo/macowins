
object gestionVentas {
	var ventas = []
	var property descuentoPromocion=0
	method agregarVenta(venta) {
		ventas.push(venta);
	}
	method calcularVentas(dia){
		return ventas.filter({venta => venta.fecha() == dia}).sum({venta => venta.calcularTotal()})
	}
}
class Venta{
	var prendas = []
	const property fecha
	const medioPago
	method agregarPrenda(prenda){
		prendas.push(prenda);
	}
	method calcularTotal(){
		return medioPago.total(prendas)
	}
	
}
class MedioPago{
	method total(prendas){
		return prendas.sum({prenda => prenda.calcularPrecio()})
	}
}
class Cuotas inherits MedioPago{
	const cantCuotas
	const coeficiente
	override method total(prendas){
		const recargo = prendas.sum({prenda => prenda.calcularPrecio()*0.01})+ cantCuotas*coeficiente
		return prendas.sum({prenda => prenda.calcularPrecio()})+ recargo
	}
}

class Prenda{
	const precio;
	const estado;
	const property tipo;
	method calcularPrecio(){
		var precioFinal;
		if(estado=="Nuevo"){
			precioFinal=precio
		}else if(estado=="Promocion"){
			precioFinal=precio - gestionVentas.descuentoPromocion();
		}else if(estado=="Liquidacion"){
			precioFinal=precio*0.5
		}
		return precioFinal
	}
}