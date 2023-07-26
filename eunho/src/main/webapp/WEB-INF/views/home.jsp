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
	height: 400px;
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
	font-size: 17px;
	background: #4cb5f9;
	font-weight: bold;
}

.login-message {
	text-align: center;
	color: #333;
}
</style>

<main id="main" class="main">
	<div class="whole-container">
		<div class="login-form shadow-sm">
			<div class="login-top">시작하기</div>
			
			<form name="loginForm" method="post">
				<div class="login-bottom">
					<div class="login-ment"><i class="fa-solid fa-user-large"></i>&nbsp;아이디</div>
					<input type="text" class="login-input" name="userId" placeholder="아이디를 입력하세요.">
					<div class="login-ment"><i class="fa-solid fa-lock"></i>&nbsp;비밀번호</div>
					<input type="password" class="login-input" name="userPwd" placeholder="비밀번호를 입력하세요.">
					<button type="button" class="login-btn shadow-sm" onclick="sendOk();">로그인</button>
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
	
	str = f.userId.value.trim();
    if(!str) {
    	alert('아이디를 입력하세요.');
        f.userId.focus();
        return;
    }

    str = f.userPwd.value.trim();
    if(!str) {
    	alert('비밀번호를 입력하세요.');
        f.userPwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/login";
    f.submit();
}

</script>