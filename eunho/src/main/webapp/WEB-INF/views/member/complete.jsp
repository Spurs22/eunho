<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.whole-container {
	min-height: 800px;
	background: #fafafa;
}

.complete {
	width: 400px;
	height: 300px;
	margin: 110px auto;
	background: #fff;
	border-radius: 10px;
	padding: 20px;
	border: 1px solid #d9d9d9;
}

.login-top {
	margin-top: 20px;
	widows: 100%;
	text-align: center;
	font-size: 35px;
	font-weight: bold;
}

.login-ment {
	width: 100%;
	text-align: center;
	margin: 30px 0;
}

.btndiv {
	width: 100%;
	margin: 0 auto;
	text-align: center;
}

.login-btn {
	border: none;
	height: 40px;
	width: 180px;
	margin: 20px auto;
	border-radius: 10px;
	color: white;
	font-size: 17px;
	background: #4cb5f9;
	font-weight: bold;
}
</style>

<main id="main" class="main">
	<div class="whole-container">
		<div class="complete shadow-sm">
			<div class="login-top">${title}</div>
			<div class="login-ment">${message}</div>
			<div class="btndiv"><button type="button" class="login-btn" onclick="location.href='${pageContext.request.contextPath}/';">홈</button></div>
		</div>
	</div>
</main>