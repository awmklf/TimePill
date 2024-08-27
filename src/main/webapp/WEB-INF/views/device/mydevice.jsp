<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:,">
<meta charset="UTF-8">
<title>mydevice</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addUserInfo.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="wrap">
		<h1>기기정보변경</h1>
		<form action="${pageContext.request.contextPath}/mydevice" method="post">
			<ul>
				<li><label class="label">나의기기</label> <input type="text"
					name="deviceId" class="input" value="${mydeviceInfo.deviceId}" readonly><br></li>
				<li><label class="label">기기이름</label> <input type="text"
					name="deviceName" class="input" value="${mydeviceInfo.deviceName}"><br></li>
				
			</ul>
			
			</ul>
			<ul id="buttons">
				<li>
					<button type="submit" id="changedeviceInfo">변경</button>
				</li>
				
				<li>
					<a href="device/delete">기기삭제</a><br>
				</li>
				<li>
					<button type="button" onclick="location.href='main'">취소</button> <br>
				</li>
			</ul>
		</form>
	</div>
<script>
	$(document).ready(function(){
		//정보변경
		$("#changedeviceInfo").click(function(){
			if(!confirm("변경하시겠습니까?")){
				return false;
			}
		});
		
		$("#deletemydevice").click(function(){
			if(!confirm("삭제하시겠습니까?")){
				return "device/mydelete";
			}
		});
	});
</script>
</body>
</html>