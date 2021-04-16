<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordersList</title>
</head>
<body>
<%
	List<Map<String,Object>> ordersList = (List<Map<String,Object>>)(request.getAttribute("ordersList"));
%>
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

			<%
			for(Map<String,Object> map : ordersList) {
			%>
			<tr>
				<td><%=(Integer)(map.get("ordersNo"))%></td>
				<td><%=(Integer)(map.get("ebookNo"))%></td>
				<td><%=((String)(map.get("ordersDate"))).substring(0,10)%></td>
				<td><%=(String)(map.get("ordersState"))%></td>
				<td><%=(String)(map.get("ebookTitle"))%></td>
				<td><%=(Integer)(map.get("ebookPrice"))%></td>
			</tr>
			<%
			}
			%>

	</table>
	
</body>
</html>