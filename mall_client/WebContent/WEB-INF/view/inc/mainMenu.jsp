<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 상단 메뉴바 -->
<c:if test="${loginClient == null}">
	<!-- 로그아웃 상태, 로그인 폼 존재 -->
		<ul class="navbar-nav ml-auto main-nav">
			<li class="nav-item active">
				<a class="nav-link" href="${pageContext.request.contextPath}/IndexController">HOME</a></li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/EbookListController">E-BOOK</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/EbookCalendarController">NEW RELEASED</a>
			</li>
			<!-- InsertClientController, /view/client/insertClient.jsp -->
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/InsertClientController"><i class="fa fa-plus" style="size:7x"> SIGNIN</i></a>
			</li>
		</ul>
</c:if>
<c:if test="${loginClient != null}">
	<!-- 로그인 상태, 로그아웃 버튼 존재 -->
		<ul class="navbar-nav ml-auto main-nav">
			<li class="nav-item active">
				<a class="nav-link" href="${pageContext.request.contextPath}/IndexController">HOME</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/EbookListController">E-BOOK</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/EbookCalendarController">NEW RELEASED</a>
			</li>
			<li class="nav-item dropdown dropdown-slide">
				<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						MY PAGE <span><i class="fa fa-angle-down"></i></span>
				</a>
				<!-- Dropdown list -->
				<div class="dropdown-menu">
					<a class="dropdown-item" href="${pageContext.request.contextPath}/CartListController">CART</a>
				<!-- OrdersListController - OrdersDao.selectOrdersListByClient() - ordersList.jsp -->
					<a class="dropdown-item" href="${pageContext.request.contextPath}/OrdersListController">ORDER</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/ClientOneController">INFO</a>
				</div>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/LogoutController">LOGOUT</a>
			</li>
		</ul>
</c:if>
