<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="공지사항 - TimePill"/>
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

.container{
	width: 80%;
	margin: 0 auto;
}

.frm{
	width: 100%;
}

.form-input {
	width: 100%;
	height: 32px;
	font-family: 'Noto Sans KR';
	font-size: 15px;
	border: 0;
	border-radius: 12px;
	outline: none;
	background-color: rgb(233, 233, 233);
}

.form-input-area {
	width: 100%;
	height: 100%;
	font-family: 'Noto Sans KR';
	font-size: 15px;
	border: 0;
	border-radius: 12px;
	outline: none;
	background-color: rgb(233, 233, 233);
}

.btn-sky {
	width: 100px;
	height: 40px;
	border-radius: 15px;
	margin-right: 2%;
	margin-bottom: 3%;
	background-color: skyblue;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
}

.btn-white {
	width: 100px;
	height: 40px;
	border-radius: 15px;
	background-color: #dddddd;
	margin-bottom: 3%;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
}
.btns {
	display: flex;
	justify-content: center;
}

</style>

<div id="contents">
	<h1 class="txa subtitle">공지사항</h1>	
	<div class="container">
		<form class="frm" action="/notice/write" method="post">
			<div>				
				<label class="label">제목</label> 
			 	<input type="text" name="title" class="form-input" required>			 
			
				<label class="label">내용</label>
				<textarea name="content" rows="10" class="form-input-area" required></textarea>				
			</div>
			<div class="btns">				
				<a id="write" class="btn-sky">글쓰기</a>			
				<a href="/notice" class="btn-white">취소</a>			
			</div>
			<sec:csrfInput/>
		</form>				
	</div>
</div>

<script type="text/javascript">
	document.querySelector('#write').onclick = function(){
		let writeForm = document.querySelector('.frm');
		let ok = writeForm.checkValidity();
		if(ok)
			writeForm.submit();
	};
</script>


<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

