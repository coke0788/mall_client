<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookCalendar</title>
</head>
<body>
	<!-- 상단 메뉴바. -->
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<h1>Ebook Calendar</h1>
	<!-- n행 7열 달력 -->
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
</body>
</html>