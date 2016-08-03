<%@ page contentType = "text/html; charset=UTF-8" pageEncoding = "UTF-8"%>
<%@ page import="org.apache.commons.mail.HtmlEmail;" %>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Calendar, java.util.Date, java.text.DecimalFormat" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="currentUrl"	value="${requestScope['struts.request_uri']}?${pageContext.request.queryString}" scope="request" />
<c:url var="loginUrl" value="/login/loginForm.action">
  <c:param name="url">${currentUrl}</c:param>
</c:url>

<jsp:useBean id="stl"      cl0ass="goodit.common.dao.DBUtil"      scope="page"/>
<jsp:useBean id="str_util" class="goodit.common.util.StringUtil" scope="page"/>



<%
request.setCharacterEncoding("UTF-8");



int[] date_data_array = new int[32];        //  휴무일을 배열에 넣음
int[] reservation_data_array = new int[35]; // 예약만료 숙박일 계산을 위해 3을 더 넣었음
int[][] time_data_array = new int[32][4];


Calendar now_cal = Calendar.getInstance();

int i = 0;


int toYear = 0;
int toMonth = 0;
int toDay = 0;

int date_year_prve = 0;
int date_month_prve = 0;
int date_year_next = 0;
int date_month_next = 0;

String rq_cmsid = "";
String rq_method = "";
String rq_arg = "";

String rq_yy_str = "";
String rq_mm_str = "";
String rq_dd_str = "";

String sql = "";
String calday_str = "";
String req_str = "";

ArrayList<String> ddate_std_array=null;  //휴무일을 저장하는 컬렉션
ddate_std_array=new ArrayList<String>();

ArrayList<String> reservation_end_array = new ArrayList<String>(); //상품이 모두 예약된 날을 저장하는 컬렉션
String classFinish="";

String classFinishtext="";
int daycount=0;
String rq_std_reserve_date = "";
String rq_end_reserve_date = "";
String rq_rin_night="1";
String rq_rin_date="";

String rq_default_date_check="";

// Calendar 초기화
Calendar today    = Calendar.getInstance();
Calendar firstday = Calendar.getInstance();
Calendar lastday  = Calendar.getInstance();
Calendar lastmonth = Calendar.getInstance();
Calendar calday   = Calendar.getInstance();



// defualt 날짜
Calendar default_date  = Calendar.getInstance();
default_date.set(now_cal.DATE, now_cal.get(default_date.DATE)+14);

//금액 형식
DecimalFormat df = new DecimalFormat("#,##0");

// 날짜 형식
SimpleDateFormat sdf = new SimpleDateFormat();
sdf.applyPattern("yyyy-MM-dd");

rq_cmsid  = str_util.getArgsCheck(request.getParameter("cmsid"));
rq_method = str_util.getArgsCheck(request.getParameter("method"));
rq_arg    = str_util.getArgsCheck(request.getParameter("arg"));

rq_yy_str = str_util.getArgsCheck(request.getParameter("y"));
rq_mm_str = str_util.getArgsCheck(request.getParameter("m"));
rq_dd_str = str_util.getArgsCheck(request.getParameter("d"));
rq_rin_date = str_util.getArgsCheck(request.getParameter("rin_date"));
rq_rin_night = str_util.getArgsCheck(request.getParameter("rin_night"));
rq_default_date_check = str_util.getArgsCheck(request.getParameter("default_date_check"));
//out.println(rq_rin_night);
//out.println(rq_rin_date);

if(rq_cmsid == null || rq_cmsid.equals("")) { rq_cmsid = ""; }
if(rq_method == null || rq_method.equals("")) { rq_method = ""; }
if(rq_arg == null || rq_arg.equals("")) { rq_arg = ""; }

if(rq_yy_str == null || rq_yy_str.equals("")) { rq_yy_str = ""; }
if(rq_mm_str == null || rq_mm_str.equals("")) { rq_mm_str = ""; }
if(rq_dd_str == null || rq_dd_str.equals("")) { rq_dd_str = ""; }
if(rq_dd_str == null || rq_dd_str.equals("")) { rq_dd_str = ""; }
if(rq_rin_date == null || rq_rin_date.equals("")) { rq_rin_date = sdf.format(default_date.getTime()); }
if(rq_rin_night == null || rq_rin_night.equals("")) { rq_rin_night = "1"; }
if(rq_default_date_check == null || rq_default_date_check.equals("")) { rq_default_date_check = "1"; }




req_str = "program.action?cmsid=" + rq_cmsid;

// -----------------------------------------------------------------------------
// 콘텐츠ID 확인
// -----------------------------------------------------------------------------
if(rq_cmsid == null || rq_cmsid.equals(""))
{
 	if(stl!=null) 
 	{ 
	   stl.close(); 
	   stl = null;
	 }
	 
 	out.println("<script type='text/javascript'>");
  out.println("//<![CDATA[");
  
  out.println("  alert('정보가 없습니다.');");
  out.println("  history.back();");
  
  out.println("//]]>");
  out.println("</script>");
  
	 return;
}
// -----------------------------------------------------------------------------



//------------ DB 데이터 변수 -----------------
   int seqid=0;
   int aclass=0;
   String aname="";
			int aprice1=0;
			int aprice2=0;
			int aprice3=0;
			int aprice4=0;
   int astate=0;


 //----------------------------------------------

//------------------ 변환 변수 ----------------

	String[] aclass_array = {"숙박(본관)", "숙박(돔형)", "낚시"};
	
	//String[] dstate_array = {"사용", "미사용"};

//-------------------------------------------




// 년/월/일 문자형을 숫자형으로 변환
if(rq_yy_str == null || rq_yy_str.equals(""))
{
  toYear = today.get(Calendar.YEAR);
}
else
{
  try{ toYear = Integer.parseInt(rq_yy_str); }catch(Exception ex){ }
}

if(rq_mm_str == null || rq_mm_str.equals(""))
{
  toMonth = today.get(Calendar.MONTH);                                     // 월은 0부터 시작
}
else
{
  try{ toMonth = Integer.parseInt(rq_mm_str) - 1; }catch(Exception ex){ }  // 월은 0부터 시작
}

if(rq_dd_str == null || rq_dd_str.equals(""))
{
  toDay = today.get(Calendar.DATE);
}
else
{
  try{ toDay = Integer.parseInt(rq_dd_str); }catch(Exception ex){ }
}

//out.println("toYear:"+toYear);
//out.println("toMonth:"+toMonth);
//out.println("toDay:"+toDay);

// -----------------------------------------------------------------------------
// 해당 월의 첫번째, 마직막 날짜 계산
// -----------------------------------------------------------------------------
firstday.set(toYear, toMonth, 1);     // 해당월의 첫번째 날짜 (월은 0부터 시작)
lastday.set(toYear, toMonth, 1);      // 해당월의 마지막 날짜 (월은 0부터 시작)
lastday.add(Calendar.MONTH, 1);  
lastday.add(Calendar.DATE, -1);
// -----------------------------------------------------------------------------

// 신청가능한 마지막 년월일(+3)
lastmonth.set(today.get(Calendar.YEAR), today.get(Calendar.MONTH), today.get(Calendar.DATE));  
lastmonth.add(Calendar.MONTH, 3);



// 오늘 일짜
Calendar cal = Calendar.getInstance();

// 날짜작성 (년-월-01)
cal.set(toYear, toMonth, 1);  // 월은 0부터 시작

// 이전 달
cal.add(Calendar.MONTH, -1);
date_year_prve = cal.get(Calendar.YEAR);
date_month_prve = cal.get(Calendar.MONTH);

// 다음 달
cal.add(Calendar.MONTH, 2);
date_year_next = cal.get(Calendar.YEAR);
date_month_next = cal.get(Calendar.MONTH);

// -----------------------------------------------------------------------------
//              예약 중간에 예약을 완료하지 않았다면 삭제 (하루단위)                    
// -----------------------------------------------------------------------------

sql = "";
sql = "delete from ta0103 where rseqid = 0 and inst_date < '" + sdf.format(now_cal.getTime())+"'"; 

stl.executeUpdate(sql);
//out.println(sql);
// -----------------------------------------------------------------------------
//              미입금으로 숙박 예약 자동취소 처리 (2일 이전)                    
// -----------------------------------------------------------------------------
now_cal.set(now_cal.DATE, now_cal.get(now_cal.DATE)-2);

sql = "";
sql = sql + "update ta0103 set ";
sql = sql + "rstate = 0, ";
sql = sql + "updt_id = '', updt_date = SYSDATETIME, updt_ip = '' ";
sql = sql + "where rnumber in ";
sql = sql + "(select rnumber from ta0102 where rstate < 3 and inst_date < '" + sdf.format(now_cal.getTime())+"')";

stl.executeUpdate(sql);
//out.println(sql);

// -----------------------------------------------------------------------------
//             미입금으로 사용자 예약 자동취소 처리 (2일 이전)                    
// -----------------------------------------------------------------------------

sql = "";
sql = sql + "update ta0102 set ";
sql = sql + "rstate = 5, rcancel_state = 3, ";
sql = sql + "updt_id = '', updt_date = SYSDATETIME, updt_ip = '' ";
sql = sql + "where rnumber in ";
sql = sql + "(select rnumber from ta0102 where rstate < 3 and inst_date < '" + sdf.format(now_cal.getTime())+ "')";
//out.println(sdf.format(now_cal.getTime()));
stl.executeUpdate(sql);
//out.println(sql);
/*
	HtmlEmail sender_email = new HtmlEmail();
 String msg_email = "";
	String msg_email_head = "";       //헤더부분
	String msg_email_body = "";       //바디부분
 
	msg_email_head  = "<head></head>";
 msg_email_body = "<body>";
	msg_email_body = msg_email_body + "<table width='600'>";
	msg_email_body = msg_email_body + "<tbody>";
	msg_email_body = msg_email_body + "<tr>";
	msg_email_body = msg_email_body + "<td>";
	msg_email_body = msg_email_body + "<img src='http://changribada.com/main/images/mail_logo.PNG' alt='창리바다 예약' width='600' height='50'>";
	msg_email_body = msg_email_body + "</td>";
	msg_email_body = msg_email_body + "</tr>";
 msg_email_body = msg_email_body + "</tbody>";
	msg_email_body = msg_email_body + "</table>";
	
	
	//out.println("<html>"+msg_email_head+msg_email_body+"</html>");
	msg_email = "<html>"+msg_email_head+msg_email_body+"</html>";

 sender_email.setCharset("UTF-8");
 //email.setSSL(true);
 sender_email.setHostName("121.126.239.169");
 //email.setAuthentication("USER", "PASSWORD"); //SMTP 인증이 필요한 경우
	sender_email.setFrom("webmaster@changribada.com", "창리바다"); //보내는 사람
 sender_email.addTo("bungkerlush@naver.com"); //받는사람
	sender_email.setSubject("창리바다 펜션 예약 완료 안내"); //메일 제목
 sender_email.setHtmlMsg(msg_email); //메일 내용 
	sender_email.send(); //메일 발송
*/
// -----------------------------------------------------------------------------
//              휴일데이터                        
// -----------------------------------------------------------------------------

sql = "";
sql = sql + "select ddate_std, year(ddate_std), month(ddate_std), day(ddate_std), ";
sql = sql + "ddate_end, year(ddate_end), month(ddate_end), day(ddate_end) from TC0101 ";

sql = sql + "where ((year(ddate_std) <= " + toYear + " and year(ddate_end) >= " + toYear + " and month(ddate_std) <= " + (toMonth + 1) + " and month(ddate_end) >= " + (toMonth + 1) + ") ";
sql = sql + "or (year(ddate_std) >= " + toYear + " and year(ddate_end) <= " + toYear + " and month(ddate_std) >= " + (toMonth + 1) + " and month(ddate_end) <= " + (toMonth + 1) + ") ";
sql = sql + "or (year(ddate_std) <= " + toYear + " and year(ddate_end) >= " + toYear + " and month(ddate_std) >= " + (toMonth + 1) + " and month(ddate_end) <= " + (toMonth + 1) + ")) ";

sql = sql + "and dstate = 1 ";

//out.println(sql);
ResultSet rs_list = stl.executeQuery(sql);


Calendar nextmonth_first_day = Calendar.getInstance(); // 숙박일 및 예약일을 계산하기 위해 사용
Calendar nextmonth_end_day = Calendar.getInstance(); // 숙박일 및 예약일을 계산하기 위해 사용
String date_std_full = "";
String date_end_full = "";
int date_std_year = 0;
int date_std_month = 0;
int date_std_day = 0;
int date_end_year = 0;
int date_end_month = 0;
int date_end_day = 0;

int end_day_cal = 0;
int day_i = 0;

// 초기화
for(day_i = 0; day_i <= 31; day_i++)
{
  date_data_array[day_i] = 0;
}

while(rs_list.next())
{
  i = 1;
  String zeroaddmonth="";
		String zeroaddday="";
  date_std_full  = rs_list.getString(i++);
  date_std_year  = rs_list.getInt(i++);
  date_std_month = rs_list.getInt(i++);
  date_std_day   = rs_list.getInt(i++);
  
  date_end_full  = rs_list.getString(i++);
  date_end_year  = rs_list.getInt(i++);
  date_end_month = rs_list.getInt(i++);
  date_end_day   = rs_list.getInt(i++);
  
 // out.println(date_std_full + "/" + date_end_full);
  
	
	//ddate_std_array.add(date_std_year);
	//ddate_std_array.add(date_std_month);
	//ddate_std_array.add(date_std_day);
			
		
			if(date_std_month<10)
				{
						zeroaddmonth="0";
				}
	 if(date_std_day<10)
				{
						zeroaddday="0";
				}

					ddate_std_array.add(""+date_std_year+"-"+zeroaddmonth+date_std_month+"-"+zeroaddday+date_std_day);
	//out.println(ddate_std_array.get(0));
				//out.println(ddate_std_array.get(0));

	 //out.println(date_std_month);

  // 년/월/일이 동일
  if(date_std_year == date_end_year && date_std_month == date_end_month && date_std_day == date_end_day) 
  {
    date_data_array[date_std_day] = 1;
  }
  // 년/월이 동일
	 else if(date_std_year == date_end_year && date_std_month == date_end_month)
	 {
	   for(day_i = date_std_day; day_i <= date_end_day; day_i++)
	   date_data_array[day_i] = 1;
	 }
	 // 년만 동일
	 else if(date_std_year == date_end_year)
	 //else
	 {
	   // 현재 월과 범위 시작 월이 같을때
	   if(date_std_month == (toMonth+1))
	   {
  	    calday.set(date_std_year, date_std_month-1, 1);								
  	    calday.add(calday.MONTH, 1);  					
       calday.add(calday.DATE, -1);
       end_day_cal = calday.get(Calendar.DATE);

							//out.println("현재달의 마지막일 :"+calday.get(calday.DATE));
       	
      
       
  	   for(day_i = date_std_day; day_i <= end_day_cal; day_i++)
  	   date_data_array[day_i] = 1;
	   }
	   // 현재 월과 범위 끝 월이 같을때
	   else if(date_end_month == (toMonth+1))
	   {
	     for(day_i = 1; day_i <= date_end_day; day_i++)
  	   date_data_array[day_i] = 1;
					
	   }
				// 만약 휴무일이 시작월과 끝 월의 사이에 존재한다면.
				else if(date_std_month < (toMonth+1) && date_end_month > (toMonth+1))
			{

							calday.set(date_std_year, toMonth, 1);						
  	    calday.add(calday.MONTH, 1);  
       calday.add(calday.DATE, -1);
       end_day_cal = calday.get(calday.DATE);

						//	out.println(calday.get(calday.DATE));

					 for(day_i = 1; day_i <= end_day_cal; day_i++)
  	   date_data_array[day_i] = 1;
			}
	 }
	 // 년/월/일 모두 동일 하지 않을때
  else
  {
   if(date_std_year == toYear && date_std_month == (toMonth+1))
    {
     calday.set(date_std_year, date_std_month-1, 1);
     calday.add(Calendar.MONTH, 1);
     calday.add(Calendar.DATE, -1);
     end_day_cal = calday.get(Calendar.DATE);
     
     for(day_i = date_std_day; day_i <= end_day_cal; day_i++)
     date_data_array[day_i] = 1;
    }
   else if(date_end_year == toYear && date_end_month == (toMonth+1))
    {
     for(day_i = 1; day_i <= date_end_day; day_i++)
      date_data_array[day_i]=1;
    }
  }
	 //else
	 //{
	 //  
	 //}
	
}
	nextmonth_first_day.set(toYear, toMonth+1, 1);
	nextmonth_end_day.set(toYear, toMonth+1, 3);
	
//	for(int c=0; c<32; c++)
//	{
//		out.println(c+"번째 배열 :" + date_data_array[c]);
//	}
	
		//다음달 첫날부터 3일까지(최대숙박일) 에 휴무일이 있을경우 컬렉션에 넣어서 숙박일을 계산
	sql = "";
	sql = "select ddate_std from tc0101 where ddate_std >= '" + sdf.format(nextmonth_first_day.getTime()) + "' and ddate_std <= '" + sdf.format(nextmonth_end_day.getTime()) + "'";
	ResultSet rs_list1 = stl.executeQuery(sql);

	while(rs_list1.next())
	{
			i = 1;
			ddate_std_array.add(rs_list1.getString(i++));
	}

	rs_list1 = null;
	rs_list = null;
	

//for(day_i = 1; day_i <= 31; day_i++)
//{
	//  out.println(date_data_array[day_i]);
//}


//**************************************************//

//--------------------------------------------------
//                  예약 데이터																			--
//--------------------------------------------------

				
					//예약이 완료 되었는지 확인하자                         

					int reservation_cnt = 0;

					// 초기화
					for(day_i = 0; day_i <= 34; day_i++)
					{
							reservation_data_array[day_i] = 0;
					}
						
					for(int a = 0; a < lastday.get(lastday.DATE)+3; a++)
					{
						sql = "";
						sql = sql + "select seqid from ta0101 ";

						ResultSet ta0101_list = stl.executeQuery(sql);

					 reservation_cnt = 0;
						
						 while(ta0101_list.next())
      {
        int m = 1;
								
								seqid = ta0101_list.getInt(m++);
									
										sql = "";
										sql = sql + "select count(*) ";										
										sql = sql + "from ta0103 ";
										sql = sql + "where rstate = 1 ";
										sql = sql + "and rcheckin_date = '" + sdf.format(firstday.getTime()) + "' ";
										sql = sql + "and aseqid = " + seqid;

									ResultSet reservation_list = stl.executeQuery(sql);		

									if(reservation_list.next())
							{
									reservation_cnt = reservation_cnt + reservation_list.getInt(1);
							}
							
						}
							//out.println(a+1+"일:"+reservation_cnt);
							if(reservation_cnt ==5)
						{
								reservation_data_array[a+1] = 1;
								reservation_end_array.add(sdf.format(firstday.getTime()));
						}
						
							firstday.add(firstday.DATE, 1);
					}		
							



						firstday.set(toYear, toMonth, 1);
					
//--------------------------------------------------------
%>

<script type='text/javascript'>

		function day_select(string_year,string_month,string_day,lastday)
	{


	  var month=12;
		var rin_night;
		var String_select_std_day; 
		var String_select_end_day;
  var next_month=string_month;
		var next_year=string_year;

  //0을 붙이자
		if(string_month<10)
		{
				string_month="0"+string_month;
		}

			if(next_month<10)
		{
				next_month="0"+next_month;
		}
			
			if(string_day<10)
		{
				string_day="0"+string_day;
		}

			if(rin_night<10)
		{
				rin_night="0"+rin_night;
		}

		String_select_std_day = ""+string_year+"-"+string_month+"-"+string_day;
		String_select_end_day = ""+next_year+"-"+next_month+"-"+rin_night;
	
		 document.getElementById('rin_date').value=String_select_std_day;


	}


	function fu_submit_reservation()
{

  var form = document.form_reservation;
  

 

  if(form.rin_date.value.length == 0)
  {
    alert("\n예약하실 날짜를 선택하세요");
    //form.r_date.focus();
    return;
  }
  
  form.submit();
}

	function fu_submit_reservation2()
{
  var form = document.form_reservation2;
  var count=0;
		
	
		for(var i=0; i<form.reserve_select.length; i++)
	{

			{
			if(form.reserve_select[i].checked){count++;}
	
		}

	}

		if(isNaN(form.reserve_select.length))
	{
			
		if(form.reserve_select.checked)
		count++;
	}

  if(count == 0)
  {
    alert("\n예약하실 시설을 선택하세요.");
    form.reserve_select.focus();
		
    return;
  }
   
  form.submit();
}

</script>



<%
			//-----------------------------------------------------------------
			//																									숙박일을 계산하자                     --
			//-----------------------------------------------------------------
									//날짜비교 인스턴스
						Calendar newdate = Calendar.getInstance();
					 Calendar reservation_date_std = Calendar.getInstance();
					 Calendar reservation_date_end = Calendar.getInstance();

					//	reservation_date_std.set(Calendar.DATE,(reservation_date_std.get(Calendar.DATE)+2)); 2일 뒤부터
						reservation_date_std.set(Calendar.DATE,(reservation_date_std.get(Calendar.DATE)+14));  //14일 뒤부터 예약가능
						reservation_date_end.set(Calendar.MONTH,(reservation_date_end.get(Calendar.MONTH)+3));
						
						//정확히 하기 위해
						reservation_date_std.set( Calendar.HOUR_OF_DAY, 0 );
						reservation_date_std.set( Calendar.MINUTE, 0 );
						reservation_date_std.set( Calendar.SECOND, 0 );
						reservation_date_std.set( Calendar.MILLISECOND, 0 );

						reservation_date_end.set( Calendar.HOUR_OF_DAY, 0 );
						reservation_date_end.set( Calendar.MINUTE, 0 );
						reservation_date_end.set( Calendar.SECOND, 0 );
						reservation_date_end.set( Calendar.MILLISECOND, 0 );

						newdate.set( Calendar.HOUR_OF_DAY, 0 );
						newdate.set( Calendar.MINUTE, 0 );
						newdate.set( Calendar.SECOND, 0 );
						newdate.set( Calendar.MILLISECOND, 0 );

			
					Calendar	cal_rin_date = null;
					Calendar	cal_rin_end_date = null;
					int	rin_date_Year=0;
					int rin_date_Month=0;
					int rin_date_Day=0;
					boolean chk = true;
						if(!(rq_rin_date.equals("")))
						{
						cal_rin_date =	Calendar.getInstance();	 //예약시작날짜
						cal_rin_end_date = Calendar.getInstance(); //끝 날짜
						StringTokenizer st = new StringTokenizer(rq_rin_date,"-");

						int it_rq_rin_night=0;
						it_rq_rin_night = Integer.parseInt(rq_rin_night);

						while(st.hasMoreElements())
							{
							rin_date_Year = Integer.parseInt(st.nextToken());
							rin_date_Month = Integer.parseInt(st.nextToken());
							rin_date_Day = Integer.parseInt(st.nextToken());
					
							}

					//끝 날짜 초기화
						cal_rin_end_date.set(cal_rin_end_date.YEAR,rin_date_Year);
						cal_rin_end_date.set(cal_rin_end_date.MONTH,rin_date_Month-1);
						cal_rin_end_date.set(cal_rin_end_date.DATE,rin_date_Day+it_rq_rin_night);

				 		for(int j=0; j<ddate_std_array.size(); j++)
							{
											cal_rin_date.set(cal_rin_date.YEAR,rin_date_Year);
											cal_rin_date.set(cal_rin_date.MONTH,rin_date_Month-1);
											cal_rin_date.set(cal_rin_date.DATE,rin_date_Day);

									for(int k=0; k<it_rq_rin_night; k++)
								{
													cal_rin_date.set(cal_rin_date.DATE,cal_rin_date.get(cal_rin_date.DATE)+1);
											//		out.println(ddate_std_array.get(j));
													
												if(sdf.format(cal_rin_date.getTime()).equals(ddate_std_array.get(j)))
										{
														//out.println((k+1)+"박 뒤 휴일입니다");
														rq_rin_night=(k+1)+"";
														j=ddate_std_array.size();
														chk = false;
													
											cal_rin_end_date.set(cal_rin_date.DATE,rin_date_Day+(k+1));
											break;
										}									
								}							
							}
								//out.println(sdf.format(cal_rin_date.getTime()));
							//------------------------------------------
							//                예약 만료               --
							//------------------------------------------
							
						if(chk){
							for( int j=0; j<reservation_end_array.size(); j++)
							{
											cal_rin_date.set(cal_rin_date.YEAR,rin_date_Year);
											cal_rin_date.set(cal_rin_date.MONTH,rin_date_Month-1);
											cal_rin_date.set(cal_rin_date.DATE,rin_date_Day);

								for( int k=0; k<it_rq_rin_night; k++)
								{
													cal_rin_date.set(cal_rin_date.DATE,cal_rin_date.get(cal_rin_date.DATE)+1);
											//		out.println(ddate_std_array.get(j));
													
										if(sdf.format(cal_rin_date.getTime()).equals(reservation_end_array.get(j)))
										{
													//	out.println((k+1)+"박 뒤 예약만료입니다");
														rq_rin_night=(k+1)+"";
														j=reservation_end_array.size(); //휴무일 계산은 컬렉션에 휴무일 시작일만 넣지만 예약 계산은 컬렉션에 전부다 넣기때문에 포문을 탈출해야한다
							
											cal_rin_end_date.set(cal_rin_date.DATE,rin_date_Day+(k+1));
											break;
											
										}									
								}						
							}
						}

							//------------------------------------------
							//                예약의 끝               --
							//------------------------------------------
						 
							//시작날짜 초기화
									cal_rin_date.set(rin_date_Year,rin_date_Month-1 , rin_date_Day + Integer.parseInt(rq_rin_night));
								//	out.println(sdf.format(cal_rin_date.getTime()));

									if(cal_rin_date.after(reservation_date_end))
									{
										 //out.println("실행됨");
												cal_rin_date.set(rin_date_Year,rin_date_Month-1 , rin_date_Day);

												for(int l=1; l<Integer.parseInt(rq_rin_night);	l++)
												{
																cal_rin_date.set(cal_rin_date.DATE,cal_rin_date.get(cal_rin_date.DATE)+1);	

																if(sdf.format(cal_rin_date.getTime()).equals(sdf.format(reservation_date_end.getTime())))
																{
																 rq_rin_night=l+"";
																//	out.println(rq_rin_night);
																	cal_rin_end_date.set(cal_rin_date.DATE,rin_date_Day+l);
																	break;
																}
												}
									}

									cal_rin_date.set(rin_date_Year,rin_date_Month-1 , rin_date_Day);

						
						}
		//------------------------------------------------------------------

	  

			%>

<div class="step_area">

	<div class="step_on" id="step1">
		<dt class="step_area_btn">1. 예약날짜입력</dt><dd class="ribbon"></dd>
	</div>

	<div class="step" id="step2">
		<dt class="step_area_btn">2. 예약정보입력</dt><dd class="ribbon"></dd>
	</div>

	<div class="step" id="step3">
		<dt class="step_area_btn">3. 결제정보입력</dt><dd class="ribbon"></dd>
	</div>

	<div class="step last" id="step3">
		<dt class="step_area_btn">4. 예약완료</dt><dd></dd>
	</div>

</div>

<h4 class="mt30">예약하기</h4>
<div id="dhMnGdsDtlDivA" class="git_selSchedule_wrap" style="display: block;">
			<div class="sel_startDay">
				
				<div id="dhMnGdsDtlDivA1" class="datePrice_wrap" style="height: 420px;">

						<div class="git_calendar_month">
							<a href="<%=req_str%>&amp;y=<%=date_year_prve%>&amp;m=<%=date_month_prve + 1%>&amp;rin_date=<%=rq_rin_date%>&amp;rin_night=<%=rq_rin_night%>&amp;default_date_check=<%=rq_default_date_check%>" class="prev" title="이전달보기"></a>
							<a href="<%=req_str%>&amp;y=<%=date_year_next%>&amp;m=<%=date_month_next + 1%>&amp;rin_date=<%=rq_rin_date%>&amp;rin_night=<%=rq_rin_night%>&amp;default_date_check=<%=rq_default_date_check%>" class="next" title="다음달보기"></a>
							<h3 class="ta_c"><span class="year"><%=toYear%>.</span> <span class="month"><%=toMonth + 1%>.</span></h3>
						</div>
						<div class="monthly_wrap">
							<ul class="weekDay">
								<li>일</li>
								<li>월</li>
								<li>화</li>
								<li>수</li>
								<li>목</li>
								<li>금</li>
								<li>토</li>
							</ul>

							<div class="git_calendarDay">
										
						
						<%
					//	int jcount = (int)Math.ceil((double)(lastday.get(Calendar.DATE)-1 + firstday.get(Calendar.DAY_OF_WEEK)) / 7);
						int jcount = 6;
						int count  = 2;   // 첫번째 요일까지 공백 때분에...
						int _day   = 0;
						int tcnt   = 0;
						
						String app_day_str = "";
						String day_str = "";
						String td_str = "";
						String link_str = "";
						





				//		out.println(reservation_date_end.get(Calendar.MONTH));
					String str_date_std="";
					String std_date_end="";
					//int reservation_list_check = 0;
						
						//out.println(nowdate.toString());
						for(int ju = 0; ju < jcount; ju++)
						{
						 
        
								for(i = 0; i < 7; i++)
								{

									 if(firstday.get(Calendar.DAY_OF_WEEK) < count)
									 {
												_day = count - firstday.get(Calendar.DAY_OF_WEEK);
												
												if(_day > lastday.get(Calendar.DATE))
												{
													 _day = 0;
													 day_str = "";
										  }
										  else
										  {
											   day_str = "" + _day;
										  }
								  }
								  
									 count++;
									 
									 td_str = "";
  								//link_str = "<a href='"+ req_str + "&amp;y=" + toYear + "&amp;m=" + (toMonth+1) + "&amp;d=" + _day +"' title='" + day_str +  "' " + schedule_pin_style + ">" + day_str + "</a>";
										link_str = req_str + "&amp;y=" + toYear + "&amp;m=" + toMonth + "&amp;d=" + _day;
										
										calday.set(toYear, toMonth, _day);
										calday_str = sdf.format(calday.getTime());
										
										td_str = "";
			 
				//*********************************************************************
				//																								예약 체크                                  //
				//*********************************************************************
					//reservation_list_check = 0;

	
										classFinish = "";
										classFinishtext = "";
								
							
										//out.println(sql);
									if(!(day_str.equals(""))){
						   	daycount = Integer.parseInt(day_str);


									 if(calday.before(reservation_date_std))
										{
															classFinish = "class='end'";
														classFinishtext = "예약마감";
										}

										else if(date_data_array[daycount] == 1)
										{
														classFinish = "class='No'";
														classFinishtext = "예약불가";
										}


										else if(calday.after(reservation_date_end))
										{
														 classFinish = "class='No'";
														classFinishtext = "예약불가";
										}

										else if(reservation_data_array[daycount] == 1)
										{

															classFinish = "class='Finish'";
														classFinishtext = "예약완료";

										}
							
										else 
										{
														classFinish = "class='Ok' href='javascript:;' onclick='javascript:day_select("+toYear+","+(toMonth+1)+","+_day+","+lastday.get(Calendar.DATE)+");'";
														classFinishtext = "예약가능";
										}

									}

							
		
							//*********************************************************************
		
										// 일(SUN)
										if(i == 0)
										{
												td_str += "<a "+classFinish+">";
												td_str += "<span class='day sun'>" + day_str +  "</span>";
												
												td_str += "<span class='days'><br>" + classFinishtext + "</span>";
												//if(_day!=0) { td_str += "<a href='" + link_str + "' title='" + day_str +  "일 " + schedule_pin_txt + "' " + schedule_pin_style + ">" + day_str + "</a>"; }
												
										}
										// 토(SAT)
										else if(i == 6)
										{
												td_str += "<a "+classFinish+">";
												td_str += "<span class='day sat'>" + day_str + "</span>";
											
												//if(_day!=0) { td_str += "<a href='" + link_str + "' title='" + day_str +  "일 " + schedule_pin_txt + "' " + schedule_pin_style + ">" + day_str + "</a>"; }
													td_str +=  "<span class='days'><br>" + classFinishtext + "</span>";
										}
										// 월(MON)~금(FRI)
										else
										{
												td_str += "<a "+classFinish+">";
												td_str += "<span class='day'>" + day_str + "</span>";
												
												//if(_day!=0) { td_str += "<a href='" + link_str + "' title='" + day_str +  "일 " + schedule_pin_txt + "' " + schedule_pin_style + ">" + day_str + "</a>"; }
													td_str +=  "<span class='days'><br>" + classFinishtext + "</span>";
										}
										
									
						
										
										td_str+="</a>";
									
										out.println(td_str);

																	
							
								}

										}
             

			%>



								
							</div>
						</div>


</div>
			</div>
			
			
				<form name="form_reservation" action="program.action" method="post">
      
         <input type="hidden" name="cmsid"    value="<%=rq_cmsid%>" />
									<input type="hidden" name="method"   value="register" />
									<input type="hidden" name="y"							 value="<%=toYear%>" />
									<input type="hidden" name="m"							 value="<%=toMonth+1%>" />
									<input type="hidden" name="arg"      value="" />
								 <input type="hidden" name="r_date"   value="" />
								
									<input type="hidden" name="default_date_check" value="0"/>


			<div class="selOption_res">
				
				<div id="dhMnGdsDtlDivA2" class="wrap">					

						<div class="infoWrite_wrap dhOpt mg_l20 pd_t10">
							<p class="mt10 mb20 red">※ 예약시작일, 숙박기간을 선택하세요.</p>
							<dl class="mg_t5">
								<dt class="item"><label for="rin_date">예약시작일</label></dt>
								<dd> <input id="rin_date" name="rin_date" class="w95 fb" type="text" value='<%=rq_rin_date%>' readOnly></dd>
								<dt class="item"><label for="rin_night">숙박기간</label></dt>
								<dd class="mg_l5">
									<select id="rin_night" name="rin_night" class="w60">
										<%
											for(i=1; i<=3; i++)
											{
												String str = "";
												str = str + "<option value='" + i + "'";

												if(Integer.parseInt(rq_rin_night) == i)
												str = str + " selected='selected'>";
												else
												str = str + ">";

												str = str + i + "박";
												str = str + "</option>";
												out.println(str);
											}
									%>

									</select>
								</dd>
							</dl>

						
						</div>
						
						<div class="button_group btnfix">	
							<span class="button"><a href="#" onclick="fu_submit_reservation();">예약검색</a></span>							
						</div> 

<!-- 검색 시  -->
							<%if( cal_rin_date != null && rq_default_date_check.equals("0")){%>
						<div class="boxGrayTxt mt10">
							<p class="txtRefer">고객님이 선택하신 사항입니다.</p>
							<p id="id_reg_selected" class="red f16 tc"><%=sdf.format(cal_rin_date.getTime()) + "~" + sdf.format(cal_rin_end_date.getTime())%></b>
						</div>
						<%}%>
<!-- 검색 시  -->           

						<p class="mt10">※ 선택사항으로 예약가능 목록를 검색합니다.</p>

			</div>	

		</div>
</div>
		</form>





<%
if( cal_rin_date != null && rq_default_date_check.equals("0"))
{
//--------------------------------------------------
//              리스트구성                        //
//-------------------------------------------------
int record_count = 0;


sql = "";
sql = "select count(*) from TA0101 a ";
//sql = sql + "where seqid >= 0 " + request_where_str;
sql = sql + "where seqid >= 0 ";

//out.println(sql);
ResultSet rs_count = stl.executeQuery(sql);

if(rs_count != null)
{
  rs_count.next();
  record_count = rs_count.getInt(1);
}
rs_count.close();
rs_count = null;



		// 예약가능한 정보를 가져오자
  sql = "";
  sql = sql + "select seqid, aclass, aname, aprice1, aprice2, aprice3, aprice4 from ";
  sql = sql + "ta0101 ";
  sql = sql + "where seqid not in ";
  sql = sql + "(select aseqid from ta0103 ";
  sql = sql + "where rstate = 1 ";
  sql = sql + "and rcheckin_date >= '" + sdf.format(cal_rin_date.getTime()) + "' ";
  sql = sql + "and rcheckin_date < '" + sdf.format(cal_rin_end_date.getTime()) + "') ";
		sql = sql + "order by aclass, aname ";

//out.println(sql);
rs_list = stl.executeQuery(sql);


//**************************************************//

%>




	<form name="form_reservation2" action="program.action" method="post">

									<input type="hidden" name="cmsid"    value="<%=rq_cmsid%>" />
									<input type="hidden" name="method"   value="apply_step1" />

									<input type="hidden" name="arg"      value="" />
								 <input type="hidden" name="r_date"   value="" />
									

<h4 class="mt30">예약검색 결과</h4>

<!-- 예약검색 결과 -->
<!--<p class="mb10">예약가능한 해상낚시만 검색됩니다. 검색결과가 없다면 <em class="red">[예약현황]</em>을 참고해주세요.</p>-->

		<div class="tbl_list_area">
			<table class="tbl_list" summary="선택, 구분, 구역, 이용기간, 요금(원), 요금비교 시설보기 목록 입니다.">
				<caption>예약검색 결과 목록 </caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">선택</th>
						<th scope="col">구분</th>
						<th scope="col">구역</th>
						<th scope="col">이용기간</th>
						<th scope="col">요금(원)</th>
						<th scope="col">요금비교</th>
						<th scope="col" class="last">시설보기</th>
					</tr>
				</thead>
				<tbody>								

					<%
    i = 0;
    
    if(record_count > 0)
    {
					
      while(rs_list.next())
      {
        i = 1;
								seqid = rs_list.getInt(i++);
							//pclass    = rs_list.getInt(i++);
        aclass = rs_list.getInt(i++);
        aname = rs_list.getString(i++);
        aprice1    = rs_list.getInt(i++);
								aprice2    = rs_list.getInt(i++);
								aprice3    = rs_list.getInt(i++);
								aprice4    = rs_list.getInt(i++);
    
        int week_rin_date_std;
								int week_rin_date_end;
								String st_rin_date = "";
								int set_price_sum = 0;
								String set_price_txt1 = "";
								String set_price_txt2 = "";
								String set_price_txt3 = "";
								String set_price_txt4 = "";
        String set_price_txt = "";
								cal_rin_date.set(rin_date_Year,rin_date_Month-1 , rin_date_Day);
								
								week_rin_date_std = cal_rin_date.get(cal_rin_date.DAY_OF_WEEK);
								week_rin_date_end = cal_rin_end_date.get(cal_rin_end_date.DAY_OF_WEEK);
						
							//-------------------------------
							//												성수기           --
							//-------------------------------
							for( int m=1; m<=Integer.parseInt(rq_rin_night); m++)
								{

							st_rin_date = sdf.format(cal_rin_date.getTime());
							int week_rin_date = cal_rin_date.get(cal_rin_date.DAY_OF_WEEK);
							int pdate_count = 0;
							int set_price_val = 0;


							sql="";
							sql= sql + "SELECT COUNT(*) FROM tc0102 WHERE pdate_std <='" + st_rin_date +"' AND pdate_end >='" + st_rin_date +"'";
						//	out.println(sql);
						//	out.println(rq_rin_night);
							ResultSet rs_pdate_count = stl.executeQuery(sql);

								if(rs_pdate_count != null)
								{
										rs_pdate_count.next();
										pdate_count = rs_pdate_count.getInt(1);
										//out.println("숙박일:"+pdate_count);
								}
								rs_pdate_count.close();
								rs_pdate_count = null;

								//-----------------------------
								//										요금계산									--
								//-----------------------------

								//성수기(평일)
								if(pdate_count > 0)
									{
											set_price_val = aprice3;
											set_price_txt3 = " 성수기(평일)";
									}
								//성수기(주말)
								if(pdate_count > 0 && (week_rin_date == 7 || week_rin_date == 1))
									{
											set_price_val = aprice4;
											set_price_txt4 = " 성수기(주말)";
									}
								//비수기(평일)
								if(pdate_count == 0)
									{
											set_price_val = aprice1;
											set_price_txt1 = " 비수기(평일)";
									}
									//비수기(주말)
									if(pdate_count == 0 && (week_rin_date == 7 || week_rin_date == 1))
									{
											set_price_val = aprice2;
											set_price_txt2 = " 비수기(주말)";
									}
								
								set_price_sum = set_price_sum + set_price_val;
								cal_rin_date.set(cal_rin_date.DATE,cal_rin_date.get(cal_rin_date.DATE)+1);


								}
							//------------------------------
							//         텍스트 출력        --
							//------------------------------
								if(!(set_price_txt1.equals("")))
							{
									set_price_txt = set_price_txt +set_price_txt1;
							}

									if(!(set_price_txt2.equals("")))
							{
									set_price_txt = set_price_txt + set_price_txt2;
							}

									if(!(set_price_txt3.equals("")))
							{
									set_price_txt = set_price_txt + set_price_txt3;
							}

									if(!(set_price_txt4.equals("")))
							{
									set_price_txt = set_price_txt + set_price_txt4;
							}
					
							cal_rin_date.set(rin_date_Year,rin_date_Month-1 , rin_date_Day);

        //if(rs_bnm == null) rs_bnm = "";
				   

								out.println("<tr>");
								out.println("<td><input type='checkbox' name='reserve_select' id='checkbox1' class='chk' value='"+ seqid + "," +aclass_array[aclass-1]+","+aname+","+sdf.format(cal_rin_date.getTime())+","+sdf.format(cal_rin_end_date.getTime())+","+set_price_sum+","+set_price_txt+","+rq_rin_night+"' /></td>");
								//out.println("<td class='tal'>" + pclass_array[pclass-1] + "</td>");
								//out.println("<td class='tal'></td>");
								out.println("<td>" + aclass_array[aclass-1] + "</td>");
								out.println("<td>" + aname + "</td>");
								out.println("<td>" + sdf.format(cal_rin_date.getTime()) + "~" + sdf.format(cal_rin_end_date.getTime()) + "</td>");
								out.println("<td class='tar'>" + df.format(set_price_sum) + "원</td>"); 
								out.println("<td>" + set_price_txt + "</td>");
								//out.println("<td class='last'><span class='sbtn_t'><a href='program.action?method=edit&idx='>수정/삭제</a></span></td>");
								out.println("<td class='last'><span class='sbtn_t openmodal1'><a href='#none' onclick=''>시설보기</a></span></td>");
								out.println("</tr>");
								
								i++;
      }
      
      rs_list.close();
      rs_list = null;
    }
    else
    {
      out.println("<tr><td class='last' width='100%' colspan='7'>검색된 데이터가 없습니다.</td></tr>");
    }
    
    %>
	</tbody>
			</table>				
		</div>		
	</form>

		<!-- //예약검색 결과 -->

	<div class="button_group btnfix">	
		<span class="button"><a href="#" onclick="fu_submit_reservation2(); return false;">예약신청</a></span>							
	</div>
	<%}%>
		<%
if(stl != null) 
{ 
  stl.close(); 
  stl = null;
}
%>
