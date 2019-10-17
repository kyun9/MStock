/**
 * 
 */
	$(document).ready(function() {
			
			/* 회원가입 Disable 해제 */
			var checkPassword = false;
			var checkID = false;
			var checkEmail = false;
			var checkNickname = false;
			
			var checkRegisterBtn = function(){
				if(checkPassword && checkID && checkEmail && checkNickname){
					$("#registerBtn").removeAttr("disabled");
				} else {
					$("#registerBtn").attr("disabled", "disabled");
				}
			}
		
					
			/* 비밀번호 확인 */
			$('#repassword').on("blur",function() {
				if($('#repassword').val().length < 8 || $('#password').val() < 8){
					$('#checkpassword').text("비밀번호를 8자 이상 입력해주세요").css("color", "red");
				} else {
					if ($('#repassword').val() != $('#password').val()) {
						$('#checkpassword').text("비밀번호가 다릅니다").css("color", "red");
						checkPassword = false;
					} else {
						$('#checkpassword').text("비밀번호가 같습니다").css("color", "blue");
						checkPassword = true;
					}
				}
				checkRegisterBtn();
			});
					
			/* 아이디 중복확인 */
			$("#checkIdBtn").on("click", function(){
				$.ajax({
					url: "/mstock/register/check/id",
					type: "POST",
					data: $('#id').val(),
					contentType: "application/json; charset=utf-8;",
					dataType: "json",
					success: function(data){
						if(data.result != "success"){
							$("#checkId").text(data.msg).css("color", "red");
							checkID = false;
						} else {
							$("#checkId").text(data.msg).css("color", "blue");
							checkID = true;
						}
						checkRegisterBtn();
					}
				})
			});
			
			/* 닉네임 중복확인 */
			$("#checkNicknameBtn").on("click", function(){
				$.ajax({
					url: "/mstock/register/check/nickname",
					type: "POST",
					data: $('#nickname').val(),
					contentType: "application/json; charset=utf-8;",
					dataType: "json",
					success: function(data){
						if(data.result != "success"){
							$("#checkNickname").text(data.msg).css("color", "red");
							checkNickname = false;
						} else {
							$("#checkNickname").text(data.msg).css("color", "blue");
							checkNickname = true;
						}
						checkRegisterBtn();
					}
				})
			});
			
			/* 이메일 중복확인 */
			$("#checkEmailBtn").on("click", function(){
				$.ajax({
					url: "/mstock/register/check/email",
					type: "POST",
					data: $('#email').val(),
					contentType: "application/json; charset=utf-8;",
					dataType: "json",
					success: function(data){
						if(data.result != "success"){
							$("#checkEmail").text(data.msg).css("color", "red");
							checkEmail = false;
						} else {
							$("#checkEmail").text(data.msg).css("color", "blue");
							checkEmail = true;
						}
						checkRegisterBtn();
					}
				})
			});

		});