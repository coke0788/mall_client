<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 상단 메뉴바 -->
<c:if test="${loginClient == null}">
	<!-- 로그아웃 상태, 로그인 폼 존재 -->
	<div>
		<form action="${pageContext.request.contextPath}/LoginController" method="post">
			ID : <input type="text" name="clientMail" placeholder="input your email." value="test@test.com">
			PW : <input type="password" name="clientPw" placeholder="●●●●" value="1234">
			<button type="submit">login</button>
		</form>
		<ul>
			<li><a href="${pageContext.request.contextPath}/IndexController"><button type="button">home</button></a></li>
			<!-- InsertClientController, /view/client/insertClient.jsp -->
			<li><a href="${pageContext.request.contextPath}/InsertClientController"><button type="button">회원가입</button></a></li>
			<li><a href="${pageContext.request.contextPath}/EbookCalendarController"><button type="button">신간달력</button></a></li>
		</ul>
	</div>
</c:if>
<c:if test="${loginClient != null}">
	<!-- 로그인 상태, 로그아웃 버튼 존재 -->
	<div>
		<div>
			${loginClient.clientMail}님 반갑습니다.
		</div>
		<ul>
			<li><a href="${pageContext.request.contextPath}/IndexController"><button type="button">home</button></a></li>
			<li><a href="${pageContext.request.contextPath}/LogoutController"><button type="button">logout</button></a></li>
			<li><a href="${pageContext.request.contextPath}/ClientOneController"><button type="button">회원정보</button></a></li>
			<li><a href="${pageContext.request.contextPath}/CartListController"><button type="button">장바구니</button></a></li>
			<!-- OrdersListController - OrdersDao.selectOrdersListByClient() - ordersList.jsp -->
			<li><a href="${pageContext.request.contextPath}/OrdersListController"><button type="button">주문리스트</button></a></li>
			<li><a href="${pageContext.request.contextPath}/EbookCalendarController"><button type="button">신간달력</button></a></li>
		</ul>
	</div>
</c:if>