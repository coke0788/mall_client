<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>insertClient</title>
  
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
<!--================================
=        Navigation bar            =
=================================-->
<section>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg navbar-light navigation">
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
					 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ml-auto main-nav">
							<!-- 상단 메뉴바 -->
							<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
						</ul>
						<ul class="navbar-nav ml-auto mt-4">
							<li class="nav-item">
							</li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>
</section>
<!--================================
=            Page Title            =
=================================-->
<section class="page-title">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-8 offset-md-2 text-center">
				<!-- Title text -->
				<h3>NEW RELEASE CALENDAR</h3>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>
<!--================================
=	        n행 7열 달력	           =
=================================-->
<section class="section-sm">
	<div class="container">
	<div>
		<span><a href="${pageContext.request.contextPath}/EbookCalendarController?currentYear=${preYear}&currentMonth=${preMonth}">이전달</a></span>
		<span>${currentYear}년 ${currentMonth}월</span> 
		<span><a href="${pageContext.request.contextPath}/EbookCalendarController?currentYear=${nextYear}&currentMonth=${nextMonth}">다음달</a></span>
	</div>
	<table border="1">
		<tr>
			<td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>
		</tr>
		<tr>
			<!-- 공백 + endDay마ㄴ큼 td가 필요. -->
			<c:forEach var="i" begin="1" end="${endDay+(firstDayofWeek-1)}" step="1">
				<c:if test="${(i-(firstDayofWeek-1))>0}">
					<td>
						<div>${i-(firstDayofWeek-1)}</div>
						<div>
							<c:forEach var="m" items="${ebookListByMonth}">
								<!-- 발간일이랑 달력 날짜 같으면 타이틀 출력 시킴 -->
								<c:if test="${(i-(firstDayofWeek-1))==m.d}">
									<div> - <a href="${pageContext.request.contextPath}/EbookOneController?ebookNo=${m.ebookNo}">
									<!-- 타이틀 글자 개수 자르기. 10자 넘으면 줄이는. -->
									<c:if test="${m.ebookTitle.length() > 10}">
										${m.ebookTitle.substring(0, 10)}...
									</c:if>
									<c:if test="${m.ebookTitle.length() <= 10}">
										${m.ebookTitle}
									</c:if>
									</a></div>
								</c:if>
							</c:forEach>
						</div>
					</td>
				</c:if>
				<c:if test="${(i-(firstDayofWeek-1))<=0}">
					<td>&nbsp;</td>
				</c:if>
				<c:if test="${i%7==0}">
					<tr></tr>
				</c:if>
			</c:forEach>
			<c:if test="${(endDay+(firstDayofWeek-1))%7!=0}">
				<c:forEach var="i" begin="1" end="${7-((endDay+(firstDayofWeek-1))%7)}" step="1">
					<td>&nbsp;</td>
				</c:forEach>
			</c:if>
		</tr>
   </table>
	</div>
</section>
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