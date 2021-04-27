<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ebookOne</title>
  
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
<!--===================================
=            Store Section            =
====================================-->
<section class="section bg-gray">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<!-- Left sidebar -->
			<div class="col-md-8">
				<div class="product-details">
					<div class="product-meta">${ebook.ebookState}</div>
					<h6 class="product-meta">${ebook.ebookISBN}</h6>
					<h1 class="product-title">${ebook.ebookTitle}</h1>
					<div class="product-meta">
						<ul class="list-inline">
							<li class="list-inline-item"><i class="fa fa-user-o"></i> By ${ebook.ebookAuthor}</li>
							<li class="list-inline-item"><i class="fa fa-folder-open-o"></i> Category ${ebook.categoryName}</li>
							<li class="list-inline-item"><i class="fa fa-building"></i> Publisher ${ebook.ebookCompany}</li>
							<li class="list-inline-item"><i class="fa fa-book"></i> ${ebook.ebookPageCount} Pages</li>
						</ul>
						<br>
					</div>
						<img class="img-fluid" src="${pageContext.request.contextPath}/img/default.jpg" width="350">
					<div class="content mt-5 pt-5">
						<ul class="nav nav-pills  justify-content-center" id="pills-tab" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home"
								 aria-selected="true">E-Book Details</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile"
								 aria-selected="false">Specifications</a>
							</li>
						</ul>
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
								<h3 class="tab-title">Introduce a book <i data-toggle="tooltip" data-placement="top" title="Edit"></i></h3>
								<p>${ebook.ebookSummary}</p>
							</div>
							<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
								<h3 class="tab-title">Product Specifications</h3>
								<table class="table table-bordered product-table">
									<tbody>
										<tr>
											<td>Price</td>
											<td><i class="fa fa-won"></i>${ebook.ebookPrice}</td>
										</tr>
										<tr>
											<td>Author</td>
											<td>${ebook.ebookAuthor}</td>
										</tr>
										<tr>
											<td>State</td>
											<td>${ebook.ebookState}</td>
										</tr>
										<tr>
											<td>Publisher</td>
											<td>${ebook.ebookCompany}</td>
										</tr>
										<tr>
											<td>Pages</td>
											<td>${ebook.ebookPageCount}</td>
										</tr>
										<tr>
											<td>Posting Date</td>
											<td>${ebook.ebookDate}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4 border-left">
				<br><br><br><br><br><br>
				<div class="sidebar">
					<div class="widget price text-center">
						<h4>Price</h4>
						<p><i class="fa fa-won"></i> ${ebook.ebookPrice}</p>
					</div>
					<div class="widget text-center">
					<!-- InsertCartController?ebookNo, CartDao.insertCart(), redirect:CartListController -->
						<!-- EL에서 문자열 비교 연산자 : eq 사용. -->
						<c:if test="${loginClient==null || ebook.ebookState eq '품절' || ebook.ebookState eq '절판' || ebook.ebookState eq '구편절판'}">
							<br>
							<h5 class="text-muted"><i class="fa fa-shopping-cart"></i> 장바구니 추가</h5>
						</c:if>
						<c:if test="${loginClient!=null && ebook.ebookState eq '판매중'}">
							<br>
							<h5><a href="${pageContext.request.contextPath}/InsertCartController?ebookNo=${ebook.ebookNo}">
								<i class="fa fa-shopping-cart"></i> 장바구니 추가
							</a></h5>
						</c:if>
					</div>
					<div class="widget text-center">
						<a href="${pageContext.request.contextPath}/EbookListController"><i class="fa fa-undo"></i> GO TO LIST </a>
					</div>
				</div>
			</div>
			</div>
		</div>
	<!-- Container End -->
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
