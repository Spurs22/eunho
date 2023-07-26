<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
   
<style type="text/css">
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}
	
body {
	background: #fafafa;
}
	
.whole-container {
	min-height: 800px;
	background: #fafafa;
}
	
header .navigation {
	width: 100%;
	height: 78px;
	background: white;
}
	
header .menubar {
	width: 1100px;
	height: 100%;
	margin: 0 auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
	
header .logo {
	width: 200px;
	cursor: pointer;
	justify-content: space-between;
	align-items: center;
	font-weight: bold;
	font-size: 20px;
	font-family: 'MapoGeumBitNaru', sans-serif;
}
	
header .login-button {
	border: none;
	color: #333;
	background: none;
	border-radius: 5px;
	width: 150px;
	height: 40px;
	text-align: center;
	display: flex;
	align-items: center;
}

header .login-div {
	height: 20px;
	margin: 0 auto;
	font-size: 20x;
	font-weight: bold;
}

header .login-button:hover {
	cursor: pointer;
	color: #333;
	background: none;
}

header .login-button:focus {
	cursor: pointer;
	color: #333;
	background: none;
}

header .login-button:active {
	cursor: pointer;
	color: #333;
	background: none;
}

header .dropdiv {
	height: 20px;
	margin: 0 auto;
	font-size: 20x;
	font-weight: bold;
	width: 200px;
	color: #333;
}

header .dropdown-item {
	text-align: center;
}

header .logo-img {
	width: 200px;
}

</style>

<header id="header" class="header">
<div class="navigation">
	<div class="menubar">
		<c:if test="${empty sessionScope}">
			<div class="logo" onclick="location.href='${pageContext.request.contextPath}/'">
				<img class="logo-img" src="${pageContext.request.contextPath}/resources/images/title.png">
			</div>
		</c:if>
		
		<c:if test="${not empty sessionScope}">
			<div class="logo" onclick="location.href='${pageContext.request.contextPath}/main/main?categoryNum=${main == null ? 0 : main.categoryNum}'">
				<img class="logo-img" src="${pageContext.request.contextPath}/resources/images/title.png">
			</div>
		</c:if>
		
		<!-- 로그인 전 -->
		<c:if test="${empty sessionScope}">
			<button class="login-button" onclick="location.href='${pageContext.request.contextPath}/member/member'"><div class="login-div">회원가입</div></button>
		</c:if>
			 
		<!-- 로그인 후 -->
		<c:if test="${not empty sessionScope}">
			<div class="dropdown">
			 	<button class="btn login-button dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    	<div class="dropdiv">${sessionScope.member.name}의 블로그</div>
				</button>
			  	<ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mypage/myhome">마이페이지</a></li>
				    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
			  	</ul>
			</div>
		</c:if>
	</div>
</div>
</header>