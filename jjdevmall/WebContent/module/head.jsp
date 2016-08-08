<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">
 <!-- JQUERY -->
        <script src="<%=request.getContextPath()%>/js/vendor/jquery-1.11.2.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/vendor/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/isotope.pkgd.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/owl.carousel.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/wow.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/custom.js"></script>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>쇼핑몰 </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="<%=request.getContextPath()%>/images/favicon.png">

        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
        <!--[if lt IE 9]>
            <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
            <script>window.html5 || document.write('<script src="js/vendor/html5shiv.js"><\/script>')</script>
        <![endif]-->
    </head>
<%
	String memberName = (String)session.getAttribute("memberName");
	String level = (String)session.getAttribute("");
%>
    <body>

        <!-- PRELOADER -->
        <div id="preloader">
            <div class="preloader-area">
            	<div class="preloader-box">
            		<div class="preloader"></div>
            	</div>
            </div>
        </div>


        <section class="header-top-section">
            <div class="container">
                <div class="row">
                    <div  class="col-md-6">
                        <div class="header-top-content">
                            <ul class="nav nav-pills navbar-left">
                                <li><a href="#"><i class="pe-7s-call"></i><span>063-000-0000</span></a></li>
                                <li><a href="#"><i class="pe-7s-mail"></i><span> kji212@naver.com</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div  class="col-md-6">
                        <div class="header-top-menu">
                            <ul class="nav nav-pills navbar-right">
                                <li><a href="#">My Account</a></li>
                                <li><a href="#">Wishlist</a></li>
                                <li><a href="#">Cart</a></li>
                                <li><a href="#">Checkout</a></li>
                               	<%
                               	if(memberName == null){
                               	%>
                                	<li><a href="<%=request.getContextPath() %>/member/login/memberLogin.jsp"><i class="pe-7s-lock"></i>로그인/회원가입</a></li>
                                <%
                               	}else{
                               	%>	
                               		<li><a href="<%=request.getContextPath() %>/member/login/memberLogout.jsp"><%=memberName%>님 로그인 / 로그아웃</a></li>
                               	<%
                               	}
                                %>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <header class="header-section">
            <nav class="navbar navbar-default">
                <div class="container">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#"><b>M</b>art</a>
                    </div>
                    
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="<%=request.getContextPath()%>/main.jsp">Home</a></li>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">page</a></li>
                            <li><a href="#">shop</a></li>
                            <li><a href="#">Blog</a></li>
                            <li><a href="#">Contact Us</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right cart-menu">
                        <li><a href="#" class="search-btn"><i class="fa fa-search" aria-hidden="true"></i></a></li>
                        <li><a href="#"><span> Cart -$0&nbsp;</span> <span class="shoping-cart">0</span></a></li>
                    </ul>
                    </div><!-- /.navbar-collapse -->
                </div><!-- /.container -->
            </nav>
            
	            <section class="search-section">
	            <div class="container">
	                <div class="row subscribe-from">
	                    <div class="col-md-12">
	                        <form class="form-inline col-md-12 wow fadeInDown animated">
	                            <div class="form-group">
	                                <input type="text" class="form-control subscribe" id="email" placeholder="Search...">
	                                <button class="suscribe-btn" ><i class="pe-7s-search"></i></button>
	                            </div>
	                        </form><!-- end /. form -->
	                    </div>
	                </div><!-- end of/. row -->
	            </div><!-- end of /.container -->
	        </section><!-- end of /.news letter section -->
        </header>
        
       