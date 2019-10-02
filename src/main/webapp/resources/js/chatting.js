'use strict';

$(document).ready(function() {
	// enter 처리
	$('#messageinput').on('keydown', function(evt) {
		if (evt.keyCode == 13 && $('#messageinput').val() != "") {
			var msg = $('#messageinput').val();
			ws.send(msg);
			$('#messageinput').val('');
		}
		scrollAdjust();
	});
	openSocket();  
})

function scrollAdjust() {
	$("#message").scrollTop($("#message")[0].scrollHeight);
}

var ws;
var messages = document.getElementById("message");

function openSocket() {
	if (ws !== undefined && ws.readyState !== WebSocket.CLOSED) {
		writeResponse("WebSocket is already opend.");
		return;
	}

	// 웹소켓 객체 만드는 코드
	var url = window.location.host;// 웹브라우저의 주소창의 포트까지 가져옴
	var pathname = window.location.pathname; /* '/'부터 오른쪽에 있는 모든 경로 */
	var appCtx = pathname.substring(0, pathname.indexOf("/", 2));
	var root = url + appCtx;

	ws = new WebSocket('ws://' + root + '/Echo');

	ws.onopen = function(event) {
		if (event.data === undefined)
			return;
		console.log(event.data);
		writeResponse("ONOPEN : "+event.data);
	};  
	ws.onmessage = function(event) {
		console.log("ONMESSAGE data: "+event.data);
		console.log("ONMESSAGE event: "+event);
		writeResponse(event.data);
	};
	ws.onclose = function(event) {
		writeResponse("Connection closed");
		console.log("ONCLOSE : "+event.data);
		setTimeout(function() {
			//openSocket();
		}, 1000); // retry connection!!
	}
}
function send() {
	var text = document.getElementById("messageinput").value;
	ws.send(text);
	$('#messageinput').val('');
}
function closeSocket() {
	ws.close();
}
function writeResponse(text) {
	message.innerHTML += "<br/>" + text;
	scrollAdjust();
}