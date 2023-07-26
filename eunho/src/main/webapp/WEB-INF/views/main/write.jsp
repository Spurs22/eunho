<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.whole-container {
	min-height: 800px;
	background: #fafafa;
}

.write-form {
	width: 800px;
	margin: 60px auto;
	background: white;
	border-radius: 10px;
	padding: 30px;
	height: 600px;
	border: 1px solid #d9d9d9;
}

.subject {
	margin-top: 30px;
	font-weight: bold;
	font-size: 20px;
	display: flex;
	justify-content: space-between;
}

.subjectInput {
	margin: 10px auto;
	width: 100%;
	height: 40px;
	border-radius: 10px;
	outline: none;
	border: 1px solid #d9d9d9;
	padding: 10px;
}

.content {
	font-weight: bold;
	font-size: 20px;
}

.contentText {
	outline: none;
	resize: none;
	width: 100%;
	height: 250px;
	border-radius: 10px;
	border: 1px solid #d9d9d9;
	padding: 10px;
	margin: 10px auto;
}

.btn-group {
	width: 100%;
	display: flex;
	justify-content: center;
	gap: 20px;
	align-items: center;
	height: 100px;
}

.write-btn {
	width: 100px;
	height: 40px;
	border: none;
	background: #4cb5f9;
	border-radius: 10px;
	color: white;
}
</style>

<main id="main" class="main">
	<div class="whole-container">
		<div class="write-form shadow">
		<form name="writeForm" method="post" enctype="multipart/form-data">
			<div class="subject"><div>제목</div><div>카테고리 : ${main.category}</div></div>
			<input class="subjectInput shadow-sm" name="subject" type="text" value="${dto.subject}">
			<div class="content">내용</div>
			<textarea class="contentText shadow-sm" name="content">${dto.content}</textarea>
			<input type="file" name="selectFile" accept="image/*" class="fileInput form-control shadow-sm">
			<input type="hidden" name="categoryNum" value="${categoryNum}">
			<c:if test="${mode == 'write'}">
				<div class="btn-group"><button type="button" class="write-btn shadow-sm" onclick="sendOk();">등록하기</button><button type="button" class="write-btn shadow-sm" onclick="location.href='${pageContext.request.contextPath}/main/main?categoryNum=${categoryNum}';">뒤로가기</button></div>
			</c:if>
			<c:if test="${mode == 'update'}">
				<div class="btn-group"><button type="button" class="write-btn shadow-sm" onclick="sendOk();">수정하기</button><button type="button" class="write-btn shadow-sm" onclick="location.href='${pageContext.request.contextPath}/main/article?articleNum=${dto.articleNum}';">뒤로가기</button></div>
				<input type="hidden" name="articleNum" value="${dto.articleNum}">
			</c:if>
		</form>
		</div>
	</div>
</main>

<script>

function sendOk() {
	const f = document.writeForm;
	
	let str = f.subject.value;
	if(!str) {
		alert("제목을 입력해주세요.");
		f.subject.focus();
		return;
	}
	
	str = f.content.value;
	if(!str) {
		alert("내용을 입력해주세요.");
		f.content.focus();
		return;
	}
	
	f.action="${pageContext.request.contextPath}/main/${mode}";
	f.submit();
};

</script>