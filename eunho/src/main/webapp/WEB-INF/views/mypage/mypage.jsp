<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.whole-container {
	min-height: 800px;
	background: #fafafa;
}

.mypage {
	width: 400px;
	height: 500px;
	border-radius: 10px;
	margin: 40px auto;
	background: white;
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

.mypageTitle {
	font-weight: bold;
	font-size: 20px;
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

.imgbtn-group {
	display: flex;
	gap: 10px;
	width: 100%;
	justify-content: center;
	margin: 10px auto;
}

.imgbtn {
	background: #4cb5f9;
	width: 100px;
	height: 40px;
	border-radius: 10px;
	color: white;
	border: 1px solid #d9d9d9;
}

.profile-info {
	width: 60%;
	margin: 20px auto;
	font-weight: bold;
	gap: 10px;
	display: flex;
	flex-direction: column;
}

.profile-edit {
	display: flex;
	justify-content: center;
	margin-top:65px;
}

.edit-info {
	cursor: pointer;
}

.edit-info:hover {
	color: #4cb5f9;
}
</style>

<main id="main" class="main">
	<div class="whole-container">
		<div class="mypage shadow-sm">
			<div class="mypageTitle">마이페이지</div>
			<div class="profile-img shadow-sm">
				<c:if test="${dto.main_img_name == null}">
					<img class="profile-img-info" src="${pageContext.request.contextPath}/resources/images/default-man.png">
				</c:if>
				<img class="profile-img-info" src="${pageContext.request.contextPath}/uploads/images/${dto.main_img_name}">
			</div>
			<div class="imgbtn-group"><button class="imgbtn changeimage shadow-sm">사진 변경</button><button class="imgbtn deleteimage shadow-sm">사진 삭제</button></div>
			
			<div class="profile-info">
				<div>이름 : ${dto.name}</div>
				<div>생년월일 : ${dto.birth}</div>
				<div>가입날짜 : ${dto.reg_date}</div>
			</div>
			<div class="profile-edit">
				<div class="edit-info update">정보수정</div>&nbsp;&nbsp;|&nbsp;&nbsp;<div class="edit-info deleteMember">회원탈퇴</div>
			</div>
		</div>
	</div>
</main>

<div class="modal" id="change-image" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">사진 변경하기</h5>
				<button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form name="insertImgForm" method="post" enctype="multipart/form-data">
		    	<div class="modal-body">
		    		<div class="fileModal">
		    			<input type="file" name="selectFile" accept="image/*" class="fileInput form-control shadow-sm">
		    		</div>
		    	</div>
				<div class="modal-footer">
					<button type="reset" class="modal-button modal-close shadow-sm" data-bs-dismiss="modal" aria-label="Close">취소하기</button>
					<button type="button" class="modal-button shadow-sm" onclick="sendOk();">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</div>  

<script>

<%-- 사진 삭제 --%>
$(function() {
	$("body").on("click", ".deleteimage", function() {
		if(!confirm('프로필 사진을 삭제하시겠습니까 ? ')) {
			return;
		}
		
		location.href="${pageContext.request.contextPath}/mypage/deleteImage";
	});
});

<%-- 사진 변경 --%>
$(function() {
	$("body").on("click", ".changeimage", function() {
		$('#change-image').show();
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
	const f = document.insertImgForm;
	
	let str = f.selectFile.value;
	if(!str) {
		alert("이미지를 선택해주세요.");
		return;
	}
	
	f.action="${pageContext.request.contextPath}/mypage/addImage";
	f.submit();
};

<%-- 회원정보수정 --%>
$(function() {
	$("body").on("click", ".update", function() {
		
		location.href="${pageContext.request.contextPath}/member/update";
	});
});

<%-- 회원탈퇴 --%>
$(function() {
	$("body").on("click", ".deleteMember", function() {
		if(!confirm('회원을 탈퇴하시겠습니까 ? ')) {
			return;
		}
		if(!confirm('다시 되돌릴 수 없습니다.')) {
			return;
		}
		
		location.href="${pageContext.request.contextPath}/member/deleteMember";
	});
});

</script>