<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordersList</title>
</head>
<body>
	<!-- 상단 메뉴바. -->
	<div>
		<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	</div>
	<h1>주문리스트</h1>
	<table border="1">
		<tr>
			<th>ordersNo</th>
			<th>ebookNo</th>
			<th>ordersDate</th>
			<th>ordersState</th>
			<th>ebookTitle</th>
			<th>ebookPrice</th>
		</tr>

			<c:forEach var="m" items="${ordersList}">
			<tr>
				<td>${m.ordersNo}</td>
				<td>${m.ebookNo}</td>
				<td>${m.ordersDate.substring(0,10)}</td>
				<td>${m.ordersState}</td>
				<td>${m.ebookTitle}</td>
				<td>${m.ebookPrice}</td>
			</tr>
			</c:forEach>
	</table>
	
</body>
</html>