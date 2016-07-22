package kr.or.ksmart.dto;

public class MemberAndAddressDto {
	private int address_no = 0;
	private int member_no = 0;
	private String member_address = null;
	private String member_name = null;
	private String member_id = null;
	
	
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		System.out.println("AddressDto.java member_id : member_id");
		this.member_id = member_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		System.out.println("AddressDto.java member_name : member_name");
		this.member_name = member_name;
	}
	public int getAddress_no() {
		return address_no;
	}
	public void setAddress_no(int address_no) {
		System.out.println("AddressDto.java address_no : address_no");
		this.address_no = address_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		System.out.println("AddressDto.java member_no : member_no");
		this.member_no = member_no;
	}
	public String getMember_address() {
		return member_address;
	}
	public void setMember_address(String member_address) {
		System.out.println("AddressDto.java member_address : member_address");
		this.member_address = member_address;
	}
	
	
}
