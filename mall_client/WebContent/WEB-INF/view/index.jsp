<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
	<!-- 상단 메뉴바. -->
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<h1> index </h1>
	<div>
		<a href="${pageContext.request.contextPath}/IndexController?categoryName=">전체보기</a>
		<c:forEach var="cn" items="${categoryNameList}">
			<a href="${pageContext.request.contextPath}/IndexController?categoryName=${cn}">${cn}</a>
		</c:forEach>
	</div>
	<div>
		<form action="${pageContext.request.contextPath}/IndexController" method="get">
			<input type="text" placeholder="검색어를 입력하세요." name="searchWord"><button type="submit">검색</button>
		</form>
	</div>
	<!-- 베스트셀러를 먼저 추력시킴. -->
	<h3>Best Seller</h3>
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
	<!-- 상품 출력 테이블 -->
	<h3> Ebook List </h3>
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
	
	<!-- 마지막 페이지가 1이면 그냥 현재페이지만 출력 -->
	<c:if test="${lastPage<=1}">
		<button>현재페이지</button>
	</c:if>
	<!-- 마지막 페이지가 1이 아닐 경우에만 페이징 작업 실행. -->
	<c:if test="${lastPage>1}">
		<!-- searchword가 null이면 페이징 작업에 searchword쪽 다 지워버리기. -->
		<c:if test="${searchWord eq '' && categoryName ne '' }">
			<c:if test="${1<currentPage && currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=1&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>이전</button></a>
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${lastPage}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==1}">
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${lastPage}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==lastPage}">
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=1&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}&categoryName=${categoryName}"><button>이전</button></a>
				<button>현재페이지</button>
			</c:if>
		</c:if>
		<!-- categoryName이 null이면 페이징 작업에 categoryName쪽 다 지워버리기. -->
		<c:if test="${categoryName eq '' && searchWord ne ''}">
			<c:if test="${1<currentPage && currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=1&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>이전</button></a>
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${lastPage}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==1}">
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${lastPage}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==lastPage}">
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=1&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}&searchWord=${searchWord}"><button>이전</button></a>
				<button>현재페이지</button>
			</c:if>
		</c:if>
		<!-- 둘다 null일 경우에도 출력 시켜야 함. 둘 다 안받을거. -->
			<c:if test="${categoryName eq '' && searchWord eq ''}">
			<c:if test="${1<currentPage && currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=1&rowPerPage=${rowPerPage}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}"><button>이전</button></a>
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${lastPage}&rowPerPage=${rowPerPage}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==1}">
				<button>현재페이지</button>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage+1}&rowPerPage=${rowPerPage}"><button>다음</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${lastPage}&rowPerPage=${rowPerPage}"><button>끝으로</button></a>
			</c:if>
			<c:if test="${currentPage==lastPage}">
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=1&rowPerPage=${rowPerPage}"><button>처음으로</button></a>
				<a href="${pageContext.request.contextPath}/IndexController?currentPage=${currentPage-1}&rowPerPage=${rowPerPage}"><button>이전</button></a>
				<button>현재페이지</button>
			</c:if>
		</c:if>
	</c:if>
</body>
</html>