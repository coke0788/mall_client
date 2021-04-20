<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartList</title>
</head>
<body>
	<!-- 상단 메뉴바. -->
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<!-- 카트 리스트 -->
	<h1>cartList</h1>
	<table border="1">
			<tr>
				<td>cartNo</td>
				<td>ebookNo</td>
				<td>ebookTitle</td>
				<td>cartDate</td>
				<td>삭제</td>
				<td>주문</td>
			</tr>
			<c:forEach var="m" items="${cartList}">
			<tr>
				<td>${m.cartNo}</td>
				<td>${m.ebookNo}</td>
				<td>${m.ebookTitle}</td>
				<td>${m.cartDate.substring(0,10)}</td>
				<!-- DeleteCartController - CartDao.deleteCart() - redirect:CartListController 
					Controller로 cartNo값 넘겨 줘야 한다.-->
				<td><a href="${pageContext.request.contextPath}/DeleteCartController?ebookNo=${m.ebookNo}">삭제</a></td>
				<!-- InsertOrdersController - insertOrders(),deleteCart():issue 트랜잭션? 처리 - redirect:OrdersListController-->
				<td><a href="${pageContext.request.contextPath}/InsertOrdersController?ebookNo=${m.ebookNo}">주문</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>