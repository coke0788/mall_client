<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>INDEX</title>
  
  <!-- FAVICON -->
  <link href="img/favicon.png" rel="shortcut icon">
  <!-- PLUGINS CSS STYLE -->
  <!-- <link href="plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"> -->
  <!-- Bootstrap -->
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap-slider.css">
  
  <!-- Font Awesome -->
  <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <!-- Owl Carousel -->
  <link href="plugins/slick-carousel/slick/slick.css" rel="stylesheet">
  <link href="plugins/slick-carousel/slick/slick-theme.css" rel="stylesheet">
  <!-- Fancy Box -->
  <link href="plugins/fancybox/jquery.fancybox.pack.css" rel="stylesheet">
  <link href="plugins/jquery-nice-select/css/nice-select.css" rel="stylesheet">
  <!-- CUSTOM CSS -->
  <link href="css/style.css" rel="stylesheet">


  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

</head>
<body class="body-wrapper">
<section>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg navbar-light navigation">
					<a class="navbar-brand" href="">
						<img src="images/booklogo.png" width="100" height="80">
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
					 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ml-auto main-nav ">
						
						<!-- 상단 메뉴바 -->
						<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>
</section>

<!--===============================
=            Hero Area          
=		여기에 로그인 메뉴를 넣을거임		
================================-->
<section class="hero-area bg-1 text-center overly">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Contetnt -->
				<div class="content-block">
					<h1> INDEX </h1>
					<p>Welcome to come into E-BOOK shopping mall. <br> if you didn't login or register as member, <br> look at below! </p>
				</div>
			</div>
		</div>
	</div>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-12 col-md-12 align-content-center">
				<c:if test="${loginClient == null}">
				<form action="${pageContext.request.contextPath}/LoginController" method="post">
					<div class="form-row">
						<div class="form-group col-md-4">
							<input type="text" class="form-control my-2 my-lg-1" name="clientMail" placeholder="input your email." value="test@test.com" required pattern="^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$">
						</div>
						<div class="form-group col-md-4">
							<input type="password" class="form-control my-2 my-lg-1" name="clientPw" placeholder="●●●●" value="1234" required pattern="^[A-Za-z0-9]{4,16}$">
						</div>
						<div class="form-group align-self-center">
							<button type="submit" class="btn btn-secondary"> ▶LOGIN</button>
							<a href="${pageContext.request.contextPath}/InsertClientController"><button type="button" class="btn btn-primary"> ▶REGISTER</button></a>
						</div>
					</div>
				</form>
				</c:if>
				<c:if test="${loginClient != null}">
					<div>
						<h2 class="text-white">Welcome, ${loginClient.clientMail} ! </h2>
						<br>
						<br>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>

<!--==========================================
=            All Category Section
 			여기에 관리자 메뉴 미리보기		         =
===========================================-->
<section class=" section">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- Section title -->
				<div class="section-title">
					<h2>BEST SELLER</h2>
					<p>Showing the Best Sellers of our mall. </p>
					<p>IF YOU WANT TO LOOK AROUND ALL OF BOOKS, PLEASE CLICK
					<a class="text-right" href="${pageContext.request.contextPath}/EbookListController"><i class="fa fa-caret-right"></i> HERE !</a></p>
				</div>
				<div class="row">
		<!-- 베스트셀러 -->
		<c:forEach var="m" items="${bestOrdersList}">
		<div class="col-lg-3 offset-lg-1 col-md-4 offset-md-1 col-sm-2 col-3">
		<div class="category-block">
		<!-- 타이틀 -->
		<div class="header">
			<img src="${pageContext.request.contextPath}/img/default.jpg" class="img-fluid" width="100" alt="">
			<h4><a href="${pageContext.request.contextPath}/EbookOneController?ebookNo=${m.ebookNo}">${m.ebookTitle}&nbsp;</a></h4>
		</div>
		<!-- /타이틀 -->
		<!-- 상세정보 -->
		<ul class="category-list" >
				<li>
					<c:if test="${m.ebookSummary==null}">
					</c:if>
					<c:if test="${m.ebookSummary.length()<80}">
						<div>${m.ebookSummary}</div>
					</c:if>
					<c:if test="${m.ebookSummary.length()>=80}">
						<div>${m.ebookSummary.substring(0,80)}...</div>
					</c:if>
				</li>
				<li>
					<i class="fa fa-won"></i> ${m.ebookPrice}
				</li>
				<li><a class="text-right" href="${pageContext.request.contextPath}/EbookOneController?ebookNo=${m.ebookNo}"><i class="fa fa-caret-right"></i>detail</a></li>
		
		</ul>
	</div>
	<!-- /공지 -->
    </div>
    </c:forEach>
	</div>
	</div>
	</div>
</section>
<hr>
<!--============================
=            Footer            =
=============================-->

<footer class="footer section section-sm">
  <!-- Container End -->
</footer>
<!-- Footer Bottom -->
<footer class="footer-bottom">
  <!-- Container Start -->
  <div class="container">
    <div class="row">
      <div class="col-sm-6 col-12">
        <!-- Copyright -->
        <div class="copyright">
          <p>Copyright HyeyoungNK© <script>
              var CurrentYear = new Date().getFullYear()
              document.write(CurrentYear)
            </script>. All Rights Reserved, theme by <a class="text-primary" href="https://themefisher.com" target="_blank">themefisher.com</a></p>
        </div>
      </div>
      <div class="col-sm-6 col-12">
      </div>
    </div>
  </div>
  <!-- Container End -->
  <!-- To Top -->
  <div class="top-to">
    <a id="top" class="" href="#"><i class="fa fa-angle-up"></i></a>
  </div>
</footer>

<!-- JAVASCRIPTS -->
<script src="plugins/jQuery/jquery.min.js"></script>
<script src="plugins/bootstrap/js/popper.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap-slider.js"></script>
  <!-- tether js -->
<script src="plugins/tether/js/tether.min.js"></script>
<script src="plugins/raty/jquery.raty-fa.js"></script>
<script src="plugins/slick-carousel/slick/slick.min.js"></script>
<script src="plugins/jquery-nice-select/js/jquery.nice-select.min.js"></script>
<script src="plugins/fancybox/jquery.fancybox.pack.js"></script>
<script src="plugins/smoothscroll/SmoothScroll.min.js"></script>
<!-- google map -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCcABaamniA6OL5YvYSpB3pFMNrXwXnLwU&libraries=places"></script>
<script src="plugins/google-map/gmap.js"></script>
<script src="js/script.js"></script>

</body>

</html>



