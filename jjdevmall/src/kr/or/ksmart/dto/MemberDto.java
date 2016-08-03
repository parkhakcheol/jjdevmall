package kr.or.ksmart.dto;

//member table ∞¥√º¿‘¥œ¥Ÿ.
public class MemberDto {
	private int member_no = 0;
	private String member_id = null;
	private String member_pw = null;
	private String member_name = null;
	private String member_gender = null;
	private int member_age = 0;
	private String member_address = null;
	
		
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		System.out.println("MemberDto.java member_no : "+ member_no);
		this.member_no = member_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		System.out.println("MemberDto.java member_id : "+ member_id);
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		System.out.println("MemberDto.java member_pw : " + member_pw);
		this.member_pw = member_pw;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		System.out.println("MemberDto.java member_name : " + member_name);
		this.member_name = member_name;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		System.out.println("MemberDto.java member_gender : " + member_gender);
		this.member_gender = member_gender;
	}
	public int getMember_age() {
		return member_age;
	}
	public void setMember_age(int member_age) {
		System.out.println("MemberDto.java member_age : " + member_age);
		this.member_age = member_age;
	}
	public String getMember_address() {
		return member_address;
	}
	public void setMember_address(String member_address) {
		System.out.println("MemberDto.java member_address : " + member_address);
		this.member_address = member_address;
	}
	
	
	
}
