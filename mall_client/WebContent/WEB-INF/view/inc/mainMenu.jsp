<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mall.client.vo.*" %>
<!-- 상단 메뉴바 -->
<%
	if(session.getAttribute("loginClient")==null){
%>
	<!-- 로그아웃 상태, 로그인 폼 존재 -->
	<div>
		<form action="<%=request.getContextPath() %>/LoginController" method="post">
			ID : <input type="text" name="clientMail" placeholder="input your email." value="test@test.com">
			PW : <input type="password" name="clientPw" placeholder="●●●●" value="1234">
			<button type="submit">login</button>
		</form>
	</div>
<%
	} else {
%>
	<!-- 로그인 상태, 로그아웃 버튼 존재 -->
	<div>
		<div>
			<%=((Client)(session.getAttribute("loginClient"))).getClientMail()%>님 반갑습니다.
		</div>
		<ul>
			<li><a href="<%=request.getContextPath() %>/IndexController"><button type="button">home</button></a></li>
			<li><a href="<%=request.getContextPath() %>/LogoutController"><button type="button">logout</button></a></li>
			<li><a href="<%=request.getContextPath() %>/CartListController"><button type="button">Cart</button></a></li>
		</ul>
	</div>
<%
	}
%>