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

<style>
input {
	margin-top: 10px;
    width: 215px;
    height: 30px;
    padding-left: 2%;
    font-family: 'Noto Sans KR';
    font-size: 15px;
    border: 0;
    border-radius: 12px;
    outline: none;
    background-color: rgb(233, 233, 233);
}
h1 {
	margin-top: 10px; 
 	margin-bottom: 10px; 
}
.frm {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 10px auto; /* 가운데 정렬을 위해 추가 */
}
.checkbox-container {
    display: flex;
    align-items: center;
}

.label-input-container {
    display: flex;
    align-items: center;
    justify-content: center; /* 가운데 정렬을 위해 변경 */
    width: 100%;
    margin-bottom: 10px;
}
.label-input-container label {
    margin-right: 10px; /* 라벨과 인풋 사이의 간격 조정 */
}
label {
	margin-top: 15px;
}
.checkbox-container label {
	margin-top: 10px;
}

.btn-sky {
    width: 100px;
    height: 30px;
    border-radius: 15px;
    margin-right: 2%;
    margin-bottom: 3%;
    background-color: skyblue;
    display: flex;
    justify-content: center;
    align-items: center;
}

.btn-white{
    width: 100px;
    height: 30px;
    border-radius: 15px;
    background-color: #dddddd;
    margin-bottom: 3%;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>

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
					<label for="medName">약이름</label> 
					<input type="text" name="medName" placeholder="약이름을 입력해주세요." value="${result.medName}" required>
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
				<div class="checkbox-container">
					<input type="checkbox" id="alarm1" name="alarmTypes" value="1" ${not empty alarmOn1 ? 'checked' : ''}>
					<label for="alarm1">아침</label>
					<input type="checkbox" id="alarm2" name="alarmTypes" value="2" ${not empty alarmOn2 ? 'checked' : ''}>
					<label for="alarm2">점심</label>
					<input type="checkbox" id="alarm3" name="alarmTypes" value="3" ${not empty alarmOn3 ? 'checked' : ''}>
					<label for="alarm3">저녁</label>
					<input type="checkbox" id="alarm4" name="alarmTypes" value="4" ${not empty alarmOn4 ? 'checked' : ''}>
					<label for="alarm4">취침전</label>
				</div>
				
				<div class="label-input-container">
					<label for="startDate">시작일</label> 
					<input type="text" name="startDate" id="start" value="<fmt:formatDate value="${result.startDate}" pattern="yyyy-MM-dd"/>" placeholder="캘린더에서 날짜를 선택해주세요." required readonly>
				</div>
				<div class="label-input-container">
					<label for="endDate">만료일</label> 
					<input type="text" name="endDate" id="end" value="<fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd"/>" placeholder="캘린더에서 날짜를 선택해주세요." required readonly>
				</div>
			</div>
			
			<c:import url="/calendar"/>
			<style>
			.calendar{
				margin: 0 auto;
			}
			.days{
				display: flex;
				margin: 10px 0 10px;
			}
			.dates{
				height: 200px;
			}
			</style>
			
			<div class="btns boxh">
				<button type="submit" id="btn-frm" style="border: 0px; margin: 0; padding: 0; background: none;">
                <a href="#" class="btn-sky">
                    <p class="btndesc">${empty result.medId ? '등록' : '수정'}</p>
                </a>
                </button>
                <button type="button" style="border: 0px; margin: 0; padding: 0; background: none;" onclick="location.href='/medication'">
                <a href="#" class="btn-white">
                    <p class="btndesc"> 취소 </p>
                </a>
                </button>
                <%-- 삭제버튼 --%>
				<c:if test="${not empty result.medId}">
					<button type="button" id="btn-del" style="border: 0px; margin: 0; padding: 0; background: none;" onclick="location.href='/medication'">
		                <a href="#" class="btn-white">
		                    <p class="btndesc"> 삭제 </p>
		                </a>
	                </button>
				</c:if>
            </div>
			
			<sec:csrfInput/>
		</form>
	
</div>
<!-- 컨텐츠 끝 -->

<script src="/resources/js/calendar/medCalendar.js"></script>
<script>
$(document).ready(function () {
	let medId = "${result.medId}";
	
	//공백제거
	$('input').on('input', function() {
		$(this).val($(this).val().replace(/\s/g, ''));
	});
	
	// 삭제버튼
	$('#btn-del').on('click', function () {
		event.preventDefault();
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$('#frm').attr('action', '/medication/'+medId+'/del');
		$('#frm').submit();
	});
});
</script>
	
<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>