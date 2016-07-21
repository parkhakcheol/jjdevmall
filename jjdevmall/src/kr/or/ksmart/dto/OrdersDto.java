package kr.or.ksmart.dto;

public class OrdersDto {
	private int orders_quantity = 0;
	private double orders_rate = 0;
	private int orders_price = 0;
	
	public int getOrders_quantity() {
		return orders_quantity;
	}
	public void setOrders_quantity(int orders_quantity) {
		System.out.println("OrdersDto.java orders_quantity -> " + orders_quantity);
		this.orders_quantity = orders_quantity;
	}
	public double getOrders_rate() {
		return orders_rate;
	}
	public void setOrders_rate(double orders_rate) {
		System.out.println("OrdersDto.java orders_rate -> " + orders_rate);
		this.orders_rate = orders_rate;
	}
	public int getOrders_price() {
		return orders_price;
	}
	public void setOrders_price(int orders_price) {
		System.out.println("OrdersDto.java orders_price -> " + orders_price);
		this.orders_price = orders_price;
	}
	
	
}
