<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/WEB-INF/views/common/header.jsp" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 처방약 등록"/>
</c:import>

<style>
.content-wrapper {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 90%;
	margin: 20px auto;
}
.single-line {
	width: 90%;
	text-align: center;
	padding: 10px;
	margin: 10px;
}

.same-line {
	justify-content: center;
	display: flex;
	width: 100%;
}
</style>

<div class="whiteBox">

<div class="content-wrapper">
	<h2 class="single-line">처방약 등록</h2>
	<form action="/medication/schedule${not empty result.medId ? '/edit-med' : '/add-med'}" method="post">
		<div style="display: block;">
		<input type="hidden" name="medId" value="${result.medId}">
		<input type="text" name="medName"placeholder="복약이름" value="${result.medName}" required> <br>
		
		<c:forEach var="resultAlarmType" items="${result.alarmTypes}">
			<c:choose>
				<c:when test="${resultAlarmType eq '1'}">
					<c:set var="alarmOn1" value="true"/>
				</c:when>
				<c:when test="${resultAlarmType eq '2'}">
					<c:set var="alarmOn2" value="true"/>
				</c:when>
				<c:when test="${resultAlarmType eq '3'}">
					<c:set var="alarmOn3" value="true"/>
				</c:when>
				<c:when test="${resultAlarmType eq '4'}">
					<c:set var="alarmOn4" value="true"/>
				</c:when>
			</c:choose>
		</c:forEach>
		<input type="checkbox" id="alarm1" name="alarmTypes" value="1" ${not empty alarmOn1 ? 'checked' : ''}>
		<label for="alarm1">아침</label>
		<input type="checkbox" id="alarm2" name="alarmTypes" value="2" ${not empty alarmOn2 ? 'checked' : ''}>
		<label for="alarm2">점심</label>
		<input type="checkbox" id="alarm3" name="alarmTypes" value="3" ${not empty alarmOn3 ? 'checked' : ''}>
		<label for="alarm3">저녁</label>
		<input type="checkbox" id="alarm4" name="alarmTypes" value="4" ${not empty alarmOn4 ? 'checked' : ''}>
		<label for="alarm4">취침전</label>
		<br>
		
		<label for="startDate">처방일자</label> 
		<input type="text" name="startDate" id="start" value="<fmt:formatDate value="${result.startDate}" />" required readonly> <br>
		<label for="endDate">만료일자</label> 
		<input type="text" name="endDate" id="end" value="<fmt:formatDate value="${result.endDate}"/>" required readonly> <br>
		
		<c:import url="/WEB-INF/views/calendar/calendar.jsp" charEncoding="utf-8"></c:import>
		
		<input type="submit" id="button" value="${empty result.medName ? '등록' : '수정'}">
		<button type="button" onclick="location.href='/medication/schedule/list'">취소</button>
		</div>
		<sec:csrfInput/>
	</form>
</div>

<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
<script>
//공백제거
$('input').on('input', function() {
	$(this).val($(this).val().replace(/\s/g, ''));
});
</script>
	
</div>
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>
	