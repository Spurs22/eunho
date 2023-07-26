<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.whole-container {
	min-height: 800px;
	background: #fafafa;
}

.article-form {
	width: 800px;
	margin: 20px auto 60px auto;
	background: white;
	border-radius: 10px;
	padding: 30px;
	min-height: 600px;
	border: 1px solid #d9d9d9;
	position: relative;
}

.subject {
	width: 100%;
	font-weight: bold;
	font-size: 20px;
	border-bottom: 1px solid #d9d9d9;
	height: 40px;
	padding: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.subject-bottom {
	display: flex;
	justify-content: space-between;
	margin: 10px 0;
	width: 100%;
}

.articleImg {
	width: 100%;
	border: 1px solid #d9d9d9;
}

.content {
	width: 100%;
	margin: 20px 0 50px 0;	
}

.btn-group {
	display: flex;
	position: absolute;
	bottom: 20px;
	right: 20px;
	gap: 10px;
}

.btn-bottom {
	border: none;
	border-radius: 10px;
	width: 120px;
	font-weight: bold;
	color: white;
	background: #4cb5f9;
	height: 40px;
}

.btnSendRecipeLike {
	border: none;
	background: none;
}

.topbtn {
	width: 800px;
	margin: 60px auto 0 auto;
}

</style>

<main id="main" class="main">
	<div class="whole-container">
		<div class="topbtn">
			<button type="button" class="btn-bottom shadow-sm" onclick="location.href='${pageContext.request.contextPath}/main/main?categoryNum=${dto.categoryNum}';">목록</button>
		</div>
		<div class="article-form shadow">
			<div class="subject"><div style="width: 99%; text-align: center;">${dto.subject}</div><div><button type="button" class="btnSendRecipeLike" title="상단고정"><i class="fa-solid fa-map-pin" id="likeBtn" style="color: ${likeStatus ? '#000000' : '#d9d9d9'};"></i></button></div></div>
			<div class="subject-bottom">
				<div>카테고리 : ${dto.category}</div>
				<div>${dto.reg_date}</div>
			</div>
			<c:if test="${dto.article_img_name != null}">
				<img class="articleImg" src="${pageContext.request.contextPath}/uploads/images/${dto.article_img_name}">
			</c:if>
			<div class="content">${dto.content}</div>
			<div class="btn-group">
				<button class="btn-bottom updateArticle shadow-sm">수정</button>
				<button class="btn-bottom deleteArticle shadow-sm">삭제</button>
			</div>
		</div>
	</div>
</main>


<script>

$(function() {
	$("body").on("click", ".updateArticle", function() {
		
		location.href="${pageContext.request.contextPath}/main/update?articleNum=${dto.articleNum}";
	});
});

$(function() {
	$("body").on("click", ".deleteArticle", function() {
		if(!confirm('게시글을 삭제하시겠습니까 ?')) {
			return;
		}
		
		location.href="${pageContext.request.contextPath}/main/delete?articleNum=${dto.articleNum}&categoryNum=${dto.categoryNum}";
	});
});

//ajax
function ajaxFun(url, method, query, dataType, fn) {
    $.ajax({
        type: method,
        url: url,
        data: query,
        dataType: dataType,
        success: function (data) {
            fn(data);
        }
    });
}

let likeStatus = ${likeStatus};

<!-- 상단 고정 -->
$(function () {
    $(".btnSendRecipeLike").click(function () {
        let msg = likeStatus ? "상단 고정을 취소하시겠습니까?" : "상단 고정 하시겠습니까 ?";

        if (!confirm(msg)) {
            return false;
        }

        let url = "${pageContext.request.contextPath}/main/like";
        let articleNum = "${dto.articleNum}";
        let qs = "articleNum=" + articleNum;


        const fn = function (data) {
           let state = data.state;
           
           location.href="${pageContext.request.contextPath}/main/article?articleNum=" + articleNum;
           
        };

        ajaxFun(url, "post", qs, "json", fn);
    });
});

</script>