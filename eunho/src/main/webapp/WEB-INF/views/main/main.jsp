<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.whole-container {
	min-height: 800px;
	background: #fafafa;
	display: flex;
}

.profile {
	background: white;
	width: 300px;
	min-height: 800px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
	padding: 20px;
}

.profile-img {
	border-radius: 50%;
	width: 160px;
	height: 160px;
	margin: 30px auto 0 auto;
	position: relative;
	border: 1px solid black;
}

.profile-img-info {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 100%;
	height: 100%;
	border-radius: 50%;
}

.profile-name {
	font-weight: bold;
	margin: 20px auto;
	width: 100%;
	font-size: 18px;
	text-align: center;
	color: #333;
}

.category-title {
	font-weight: bold;
	margin-bottom: 10px;
	font-size: 18px;
	display: flex;
	justify-content: space-between;
}

.category-info {
	display: flex;
	justify-content: space-between;
	min-height: 30px;
	padding: 5px;
	border-radius: 4px;
}

.category-rmv {
	display: none;
	border: none;
	background: none;
}

.category-info:hover .category-rmv {
	display: inline-block;
}

.category-info:hover {
	background: #4cb5f9;
	color: white;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.category-name {
	cursor: pointer;
	width: 220px;
}

.category-add {
	font-size: 16px;
	cursor: pointer;
}

.modalInput {
	width: 100%;
	height: 60px;
	padding: 10px;
	outline: none;
	border-radius: 10px;
	border: 1px solid #d9d9d9;
}

.modal-footer {
	display: flex;
	justify-content: space-between;
}

.modal-button {
	width: 48%;
	border: none;
	background: #4cb5f9;
	color: white;
	border-radius: 5px;
	height: 50px;
}

.modal-close {
	background: #d9d9d9;
}

.articleList {
	margin: 40px;
	min-height: 800px; 
	width: 1150px;
}

.listTitle {
	font-weight: bold;
	font-size: 20px;
	display: flex;
	align-items: flex-end;
	padding-left: 10px;
}

.article-bundle {
	width: 80%;
	margin: 20px auto;
	background: white;
}

.article-info {
	display: flex;
	height: 40px;
	align-items: center;
	border-bottom: 1px solid #d9d9d9;
	width: 100%;
}

.article-num {
	font-weight: bold;
	width: 10%;
	text-align: center;
}

.article-subject {
	width: 60%;
	padding-left: 40px;
	display: flex;
	align-items: center;
}

.link:hover {
	text-decoration: underline;
	color: #4cb5f9;
	cursor: pointer;
}

.article-date {
	width: 30%;	
	text-align: center;
}

.article-menu {
	width: 912px;
	text-align: right;
	margin: 0 auto;
	display: flex;
	justify-content: space-between;
}

.search-input {
	height: 40px;
	border: 1px solid #d9d9d9;
	border-radius: 10px;
	width: 200px;
	outline: none;
	padding: 10px;
	color: #333;
}

.write-btn {
	width: 120px;
	height: 40px;
	border: none;
	background: #4cb5f9;
	color: white;
	border-radius: 10px;
	margin-left: 20px;
	font-weight: bold;
}


</style>

<main id="main" class="main">
	<div class="whole-container">
		<div class="profile">
			<div class="profile-img shadow-sm">
				<c:if test="${dto.main_img_name == null}">
					<img class="profile-img-info" src="${pageContext.request.contextPath}/resources/images/default-man.png">
				</c:if>
				<img class="profile-img-info" src="${pageContext.request.contextPath}/uploads/images/${dto.main_img_name}">
			</div>
			<div class="profile-name">	
				${member.name}의 블로그
			</div>
			
			<div class="category">
				<div class="category-title"><div>카테고리</div><div class="category-add">추가</div></div>
				<div class="category-bundle">
					<c:forEach var="category" items="${categoryList}">
						<div class="category-info">
							<div class="category-name" data-categoryNum="${category.categoryNum}">${category.category}</div><button class="category-rmv" type="button" data-categoryNum="${category.categoryNum}" data-category="${category.category}"><i class="fa-solid fa-minus"></i></button>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="articleList">
			<div class="article-menu">
				<div class="listTitle">${main.category}</div>
				<div>
					<input class="search-input shadow-sm" type="text"><button ${main.category == null ? 'disabled=disabled' : '' } type="button" class="write-btn shadow-sm" onclick="location.href='${pageContext.request.contextPath}/main/write?categoryNum=${main.categoryNum}';">글 쓰기</button>
				</div>
			</div>
			<div class="article-bundle shadow-sm">
				<div class="article-info" style="background: #4cb5f9; font-weight: bold; color: white; border-top: 1px solid #d9d9d9; border-bottom: 1px solid #d9d9d9;">
					<div class="article-num">번호</div>
					<div class="article-subject" style="justify-content: center;">제목</div>
					<div class="article-date">등록날짜</div>
				</div>
				<!-- foreach -->
				<c:if test="${empty articleList}"><div class="article-info" style="justify-content: center;">등록된 게시물이 없습니다.</div></c:if>
				<c:forEach var="article" items="${articleList}" varStatus="status">
					<div class="article-info">
						<div class="article-num">${status.count}</div>
						<div class="article-subject"><div class="link" onclick="location.href='${pageContext.request.contextPath}/main/article?articleNum=${article.articleNum}'">${article.subject}</div><c:if test="${article.point == 1}">&nbsp;&nbsp;<i class="fa-solid fa-map-pin"></i></c:if></div>
						<div class="article-date" style="padding-left: 55px;">${article.reg_date}</div><div style="width: 20px;"><c:if test="${article.article_img_name != null}"><i class="fa-solid fa-image"></i></c:if></div>&nbsp;&nbsp;
					</div>
				</c:forEach>
			</div>
		</div>
		
		
	</div>
</main>

<div class="modal" id="modal-add" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">카테고리 추가하기</h5>
				<button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form name="categoryForm" id="categoryForm" method="post">
				<div class="modal-body">
					<input class="modalInput shadow-sm" type="text" name="category">
				</div>
				<div class="modal-footer">
					<button type="reset" class="modal-button modal-close shadow-sm" data-bs-dismiss="modal" aria-label="Close">취소하기</button>
					<button type="button" class="modal-button shadow-sm" onclick="sendOk();">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</div>  

<script type="text/javascript">
<%-- 카테고리 이동 --%>
$(function() {
	$("body").on("click", ".category-name", function() {
		let categoryNum = $(this).attr("data-categoryNum");
		
		location.href="${pageContext.request.contextPath}/main/main?categoryNum=" + categoryNum;
	});
});

<%-- 카테고리 추가 --%>
$(function() {
	$("body").on("click", ".category-add", function() {
		$('#modal-add').show();
		document.categoryForm.category.focus();
	});
});

<%-- 카테고리 삭제 --%>
$(function() {
	$("body").on("click", ".category-rmv", function() {
		let categoryNum = $(this).attr("data-categoryNum");
		let category = $(this).attr("data-category");
		
		if(! confirm('카테고리를 삭제하면 카테고리의 게시글도 삭제됩니다.\n' + category + ' 카테고리를 삭제하시겠습니까 ? ')) {
			return;
		}
		
		location.href="${pageContext.request.contextPath}/main/deleteCategory?categoryNum=" + categoryNum;
	});
});

<%-- 모달 관련 --%>
$('.modal-close').click(function() {
    $('.modal').hide();
});

$('.btn-close').click(function() {
    $('.modal').hide();
});

function sendOk() {
	const f = document.categoryForm;
	
	let str;
	
	str = f.category.value;
	if(!str) {
		alert('카테고리 이름을 입력해 주세요.');
		f.category.focus();
		return;
	}
	
	if (str.length > 25) {
	    alert('카테고리 이름은 최대 25자까지 입력할 수 있습니다.');
	    f.category.focus();
	    return;
	}
	
	f.action="${pageContext.request.contextPath}/main/addCategory";
	f.submit();
};

</script>