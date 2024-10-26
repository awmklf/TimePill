<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:choose>
	<c:when test="${empty result.medId}">
		<c:import url="/header" charEncoding="utf-8">
			<c:param name="title" value="복약등록 - TimePill"/>
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/header" charEncoding="utf-8">
			<c:param name="title" value="복약수정 - TimePill"/>
		</c:import>
	</c:otherwise>
</c:choose>

<link rel="stylesheet" href="/resources/css/medication/registMed.css">

<!-- 컨텐츠 시작 -->
<div id="contents" class="">
	
	<!-- 타이틀 -->
	<div>
		<c:choose>
			<c:when test="${empty result.medId}">
				<h1 class="txa subtitle">복약 등록</h1>
			</c:when>
			<c:otherwise>
				<h1 class="txa subtitle">복약 수정</h1>
			</c:otherwise>
		</c:choose>
	</div>
	
	<!-- 작성 영역 -->
		<form id="frm" action="/medication/${result.medId}${empty result.medId ? 'add' : '/edit'}" method="post">
			
			<div class="frm" style="width: 80%;">
				<input type="hidden" name="medId" value="${result.medId}">
				<div class="label-input-container">
					<label for="medName">약이름 :</label> 
					<input type="text" name="medName" id="medName" placeholder="약이름을 입력해주세요." value="${result.medName}" maxlength="8">
				</div>
				
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
				<div class="label-input-container" style="margin-top: 0px; margin-bottom: 0px;">
					<input type="checkbox" id="alarm1" name="alarmTypes" value="1" ${not empty alarmOn1 ? 'checked' : ''}>
					<label for="alarm1">아침</label>
					<input type="checkbox" id="alarm2" name="alarmTypes" value="2" ${not empty alarmOn2 ? 'checked' : ''}>
					<label for="alarm2">점심</label>
					<input type="checkbox" id="alarm3" name="alarmTypes" value="3" ${not empty alarmOn3 ? 'checked' : ''}>
					<label for="alarm3">저녁</label>
					<input type="checkbox" id="alarm4" name="alarmTypes" value="4" ${not empty alarmOn4 ? 'checked' : ''}>
					<label for="alarm4">취침전</label>
				</div>
				
				<div class="label-input-container" style="margin-bottom: 0px;">
					<label for="startDate">시작일 :</label> 
					<input type="text" name="startDate" id="start" class="inp-date" value="<fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd"/>" placeholder="캘린더에서 날짜를 선택해주세요." readonly>
				</div>
				<div class="label-input-container">
					<label for="endDate">만료일 :</label> 
					<input type="text" name="endDate" id="end" class="inp-date" value="<fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd"/>" placeholder="캘린더에서 날짜를 선택해주세요." readonly>
				</div>
			</div>
			
			<c:import url="/calendar"/>
			<style>
			/* 캘린더 */
			.calendar {
				margin: 0 auto;
   				height: 355px;
			}
			
			.days {
				display: flex;
				margin: 10px 0 10px;
			}
			
			.dates {
				height: 290px;
			}
			</style>

		<div class="btns boxh">
				<button type="button" id="btn-frm">
                    <p class="btn-sky btndesc">${empty result.medId ? '등록' : '수정'}</p>
                </button>
                <button type="button" id="btn-csl" onclick="location.href='/medication'">
                    <p class="btn-white btndesc">취소</p>
                </button>
                <%-- 삭제버튼 --%>
				<c:if test="${not empty result.medId}">
					<button type="button" id="btn-del">
	                    <p class="btn-white btndesc">삭제</p>
	                </button>
				</c:if>
            </div>
			
			<sec:csrfInput/>
		</form>
	
</div>
<!-- 컨텐츠 끝 -->

<!-- medCalendar.js -->
<script src="/resources/js/calendar/medCalendar.js"></script>

<script>
$(document).ready(function () {
	let medId = "${result.medId}";
	
	// 공백제거
	$('input').on('input', function() {
		$(this).val($(this).val().replace(/\s/g, ''));
	});
	
	// 등록&수정 버튼
	$('#btn-frm').on('click', function () {
		if ($('#medName').val().trim() == '') {
			alert('약이름을 입력해 주세요');
			return false;
		}
		if ($('#start').val().trim() == '' || $('#end').val().trim() == '') {
			alert('날짜를 선택해 주세요');
			return false;
		}
		console.log($('#end').val().trim());
		const today = new Date(); // 오늘 날짜
		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		let tday = year + '-' + month + '-' + date;
		if ($('#end').val().trim() < tday) {
			alert('복약만료일을 오늘보다 이전으로 지정하실 수 없습니다.')
			return false;
		}
		if (!confirm("등록하시겠습니까?")) {
			return false;
		}
		$('#frm').submit();
	});
	
	// 삭제 버튼
	$('#btn-del').on('click', function () {
// 		event.preventDefault();
		if (!confirm("복약 스케줄과 기록이 같이 삭제됩니다.\n삭제하시겠습니까?")) {
			return false;
		}
		$('#frm').attr('action', '/medication/' + medId + '/del');
		$('#frm').submit();
	});
});
</script>
	
<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>