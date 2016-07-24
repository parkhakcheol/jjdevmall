package kr.or.ksmart.dto;

//상품테이블 객체입니다.
public class ItemDto {
	private int itme_no = 0;
	private String item_name = null;
	private int item_price = 0;
	private double item_rate = 0;
	
	
	public int getItme_no() {
		return itme_no;
	}
	public void setItme_no(int itme_no) {
		System.out.println("ItemDto.java itme_no : " + itme_no);
		this.itme_no = itme_no;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		System.out.println("ItemDto.java item_name : " + item_name);
		this.item_name = item_name;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		System.out.println("ItemDto.java item_price : " + item_price);
		this.item_price = item_price;
	}
	public double getItem_rate() {
		return item_rate;
	}
	public void setItem_rate(double item_rate) {
		System.out.println("ItemDto.java item_rate : " + item_rate);
		this.item_rate = item_rate;
	}
	
	
	
}
