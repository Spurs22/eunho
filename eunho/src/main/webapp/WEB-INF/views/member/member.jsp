<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.whole-container {
	min-height: 800px;
	background: #fafafa;
}

.login-form {
	min-height: 400px;
	border-radius: 10px;
	border: 1px solid #d9d9d9;
	width: 400px;
	margin: 110px auto;
	background: white;
}

.login-top {
	margin-top: 20px;
	widows: 100%;
	text-align: center;
	font-size: 35px;
	font-weight: bold;
}

.login-bottom {
	width: 80%;
	margin: 40px auto;
	display: flex;
	flex-direction: column;
}

.login-input {
	width: 100%;
	height: 40px;
	padding: 10px;
	border-top: none;
	border-right: none;
	border-left: none;
	border-bottom: 1px solid #d9d9d9;
	background: none;
	margin-bottom: 10px;
	margin-top: 5px;
}

.login-input:focus {
	border-bottom: 2px solid #333;
	background: #fafafa;
}

.login-ment {
	font-size: 16px;
	color: #333;
}

.login-btn {
	border: none;
	height: 40px;
	width: 50%;
	margin: 20px auto;
	border-radius: 10px;
	color: white;
	font-size: 14px;
	background: #4cb5f9;
}

.login-message {
	text-align: center;
	color: #333;
}

.login-btn-group {
	display: flex;
	gap: 5px;
}
</style>

<main id="main" class="main">
	<div class="whole-container">
		<div class="login-form shadow-sm">
			<div class="login-top">회원가입</div>
			
			<form name="loginForm" method="post">
				<div class="login-bottom">
					<div class="login-ment"><i class="fa-solid fa-pen"></i>&nbsp;이름</div>
					<input type="text" class="login-input" name="name" placeholder="이름을 입력하세요." value="${dto.name}">
					<div class="login-ment"><i class="fa-solid fa-user-large"></i>&nbsp;아이디</div>
					<input type="text" class="login-input" name="userId" placeholder="아이디를 입력하세요." value="${dto.userId}" ${mode=="update" ? "readonly='readonly' ":""}>
					<div class="login-ment"><i class="fa-solid fa-lock"></i>&nbsp;비밀번호</div>
					<input type="password" class="login-input" name="userPwd" placeholder="비밀번호를 입력하세요.">
					<div class="login-ment"><i class="fa-regular fa-calendar"></i>&nbsp;생년월일</div>
					<input type="date" class="login-input" name="birth" value="${dto.birth}">
					<div class="login-btn-group">
						<button type="button" class="login-btn" onclick="sendOk();">${mode=='update'?'수정완료':'회원가입'}</button>
						<button type="reset" class="login-btn">다시입력</button>
						<button type="button" class="login-btn" onclick="location.href='${pageContext.request.contextPath}/${mode=='update'?'mypage/myhome':''}'">뒤로가기</button>
						<input type="hidden" name="memberNum" value="${dto.memberNum}">
					</div>
					<div class="login-message">${message}</div>
				</div>
			</form>
		</div>
		
	</div>
</main>

<script>

function sendOk() {
	const f = document.loginForm;
	let str;

    str = f.name.value;
    if( !/^[가-힣]{2,5}$/.test(str) ) {
        alert("이름을 다시 입력하세요. ");
        f.name.focus();
        return;
    }
    
    str = f.userId.value;
	if( !/^[a-z][a-z0-9_]{4,9}$/i.test(str) ) { 
		alert("아이디를 다시 입력 하세요. ");
		f.userId.focus();
		return;
	}

    str = f.userPwd.value.trim();
    if(!str) {
    	alert('비밀번호를 입력하세요.');
        f.userPwd.focus();
        return;
    }
    
    str = f.birth.value;
    if( !str ) {
        alert("생년월일를 입력하세요. ");
        f.birth.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/${mode}";
    f.submit();
}

</script>