package kr.or.ksmart.dto;

//orders table °´Ã¼ÀÔ´Ï´Ù.
public class OrdersDto {
	private int orders_no = 0;
	private int item_no = 0;
	private int member_no = 0;
	private int orders_quantity = 0;
	private String orders_date = null;	
	private double orders_rate = 0;
	private int orders_price = 0;
	private String orders_state = null;
	
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
	public int getOrders_no() {
		return orders_no;
	}
	public void setOrders_no(int orders_no) {
		System.out.println("OrdersDto.java orders_no -> " + orders_no);
		this.orders_no = orders_no;
	}
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		System.out.println("OrdersDto.java item_no -> " + item_no);
		this.item_no = item_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		System.out.println("OrdersDto.java member_no -> " + member_no);
		this.member_no = member_no;
	}
	public String getOrders_date() {
		return orders_date;
	}
	public void setOrders_date(String orders_date) {
		System.out.println("OrdersDto.java orders_date -> " + orders_date);
		this.orders_date = orders_date;
	}
	public String getOrders_state() {
		return orders_state;
	}
	public void setOrders_state(String orders_state) {
		System.out.println("OrdersDto.java orders_state -> " + orders_state);
		this.orders_state = orders_state;
	}
	
	
	
}
