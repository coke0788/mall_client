<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ebookList</title>
  
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
				<h3>ALL OF E-BOOK LIST</h3>
			</div>
		</div>
	</div>
	<!-- Container End -->
</section>
<!--================================
=            List		           =
=================================-->
<section class="section-sm">
	<div class="container">
		
	<!-- 카테고리 -->
	<div class="view text-center">
		<strong>Category</strong>
		<ul class="list-inline view-switcher">
			<li class="list-inline-item">
				<a href="${pageContext.request.contextPath}/EbookListController?categoryName="><i class="fa fa-reorder"></i> All</a>
			</li>
			<li class="list-inline-item">
				<c:forEach var="cn" items="${categoryNameList}">
					<a href="${pageContext.request.contextPath}/EbookListController?categoryName=${cn}"><i class="fa fa-folder-open-o"></i> ${cn} </a>
				</c:forEach>
			</li>
		</ul>
	</div>
	<!-- /카테고리 -->
	
	<!-- 검색 -->
	<div class="widget search p-0">
		<form action="${pageContext.request.contextPath}/EbookListController" method="get">
			<input type="text" style="width:30%" class="form-control" placeholder="Search..." name="searchWord">
			<span class="input-group-addon"><button type="submit" class="btn btn-main-sm"><i class="fa fa-search"></i></button></span>
		</form>
	</div>
	<!-- /검색 -->
	
	<!-- 베스트셀러 -->
	<strong>Best Seller</strong>
	<table border="1">
		<tr>
		<c:forEach var="m" items="${bestOrdersList}">
			<td>
				<div><img src="${pageContext.request.contextPath}/img/default.jpg"></div>
				<div><a href="${pageContext.request.contextPath}/EbookOneController?ebookNo=${m.ebookNo}">${m.ebookTitle}</a></div>
				<div>${m.ebookPirce}</div>
					<c:if test="${m.ebookSummary==null}">
					</c:if>
					<c:if test="${m.ebookSummary.length()<40}">
						<div>${m.ebookSummary}</div>
					</c:if>
					<c:if test="${m.ebookSummary.length()>=40}">
						<div>${m.ebookSummary.substring(0,40)}...</div>
					</c:if>
			</td>
		</c:forEach>
		</tr>
	</table>
	<hr>
	<!-- /베스트셀러 -->
	
	<!-- 상품 리스트 -->
	<Strong> E-book List </Strong>
	<table border="1">
		<tr>
			<!-- i 변수를 사용할거기 때문에 변수 선언. -->
			<c:set var="i" value="0"/>
			<c:forEach var="e" items="${ebookList}">
				<!-- i 변수는 i+1을 반복할거고 5로 나눴을 때 나눠떨어지면 줄바꿈. -->
				<c:set var="i" value="${i+1}"/>
					<td>
						<div><img src="${pageContext.request.contextPath}/img/default.jpg"></div>
						<!-- EbookOneController, EbookDao.selectEbookOne, ebookOne.jsp -->
						<div><a href="${pageContext.request.contextPath}/EbookOneController?ebookNo=${e.ebookNo}">${e.ebookTitle}</a></div>
						<div>${e.categoryName}</div>
						<div>${e.ebookPrice}</div>
					</td>
					<c:if test="${i%5==0}">
						<tr></tr>
					</c:if>
			</c:forEach>
		</tr>
	</table>
	</div>
</section>
	<!-- 마지막 페이지가 1이면 그냥 현재페이지만 출력 -->
	<c:if test="${lastPage<=1}">
		<button>현재페이지</button>
	</c:if>
	<!-- 마지막 페이지가 1이 아닐 경우에만 페이징 작업 실행. -->
	<c:if test="${lastPage>1}">
		<!-- searchword가 null이면 페이징 작업에 searchword쪽 다 지워버리기. -->
		<c:if test="${searchWord eq '' && categoryName ne '' }">
			<c:if test="${1<currentPage && currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=1&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>이전</button></a>
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${lastPage}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==1}">
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${lastPage}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==lastPage}">
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=1&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>이전</button></a>
				<button>현재페이지</button>
			</c:if>
		</c:if>
		<!-- categoryName이 null이면 페이징 작업에 categoryName쪽 다 지워버리기. -->
		<c:if test="${categoryName eq '' && searchWord ne ''}">
			<c:if test="${1<currentPage && currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=1&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>이전</button></a>
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${lastPage}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==1}">
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${lastPage}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==lastPage}">
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=1&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>이전</button></a>
				<button>현재페이지</button>
			</c:if>
		</c:if>
		<!-- 둘다 null일 경우에도 출력 시켜야 함. 둘 다 안받을거. -->
			<c:if test="${categoryName eq '' && searchWord eq ''}">
			<c:if test="${1<currentPage && currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=1&rowPerPage=${rowPerPage}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}"><button>이전</button></a>
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${lastPage}&rowPerPage=${rowPerPage}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==1}">
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${lastPage}&rowPerPage=${rowPerPage}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==lastPage}">
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=1&rowPerPage=${rowPerPage}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/EbookListController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}"><button>이전</button></a>
				<button>현재페이지</button>
			</c:if>
		</c:if>
	</c:if>
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