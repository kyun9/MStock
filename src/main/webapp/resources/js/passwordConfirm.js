/**
 * 
 */
		/* 비밀번호 확인 */
		$(function() {
			$('#inputPasswordRe').on(
					"blur",
					function() {
						if ($('#inputPasswordRe').val().length < 8
								|| $('#inputPassword').val() < 8) {
							$('#checkpassword').text("비밀번호를 8자 이상 입력해주세요").css(
									"color", "red");
						} else {
							if ($('#inputPasswordRe').val() != $(
									'#inputPassword').val()) {
								$('#checkpassword').text("비밀번호가 다릅니다").css(
										"color", "red");
								$("#registerBtn").attr("disabled", "disabled");
							} else {
								$('#checkpassword').text("비밀번호가 같습니다").css(
										"color", "blue");
								$('#updateBtn').removeAttr('disabled');
							}
						}
					});

		});