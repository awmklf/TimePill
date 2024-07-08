<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:,"> 
<meta charset="UTF-8">
<title>임시</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h1>임시 protector 입력폼</h1>
	<form action="${pageContext.request.contextPath}/addProtectorInfo" method="post">
		<input type="hidden" name="userId" value="${userId}"><br>
		<ul class="input">
			<li><label class="label">이름</label> <input type="text"
				name="protName" required><br></li>
			<li><label class="label">전화번호</label> <input type="text"
				name="protPhone" placeholder="-를 제외한 숫자만 입력"><br></li>
			<li><label class="label">관계</label> <input type="text"
				name="protRelation"><br></li>
		</ul>
		<ul id="buttons">
			<li>
				<button type="submit">등록</button>
				<br>
			</li>
			<li>
				<button type="button" onclick="location.href='cover'">취소</button>
				<br>
			</li>
		</ul>
	</form>
</body>
</html>