<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>Insert title here</title>

<script>
	$(document).ready(function() {

		//위도 경도 구하기
		navigator.geolocation.getCurrentPosition(function(position) {
			$('#xLoc').text(position.coords.latitude);
			$('#yLoc').text(position.coords.longitude);
		});

		$.getJSON('station', function(data) {
			$.each(data, function(i, item) {
				if (i == "list") {
					console.log(item);
					station = item;
				}
			})

			var temp = "";
			var stt = [];
			for (var i = 0; i < station.length; i++) {
				stt.push(station[i].stationName);
			}

			//관측소 뽑아오기
			console.log(stt);

			//자동완성 기능
			$("#tags").autocomplete({
				source : stt
			});
		});
	})

	function changeLoc() {
		//선택된 option값의 이름을 가져온다 ex) 종로
		var data = $('#tags').val();
		var list;

		//미세먼지 측정 json을 지역을 넘겨줘서 출력하게 한다. (Mise servlet은 지역값을 먹으면 지역값의 정보를 반환하게 되어있음)
		$.getJSON('Mise', data, function(data) {
			$.each(data, function(i, item) {
				console.log(i);
				// 받아온 json 종류중 list(미세먼지 정보가 담겨있는 object들의 뭉치) 를 받아온다
				if (i == "list") {
					// 선택받은 리스트를 담는다123123 응애에요 오우야 오우야ㅐ
					list = item;
				}
			})

			for (var i = 0; i < list.length; i++) {
				console.log(list[i]);
				// 리스트중 가장 최근것.. 0번째 배열
				if (i == 0) {
					var pm10 = list[i].pm10Value;
					if(pm10 <= 30){
						$('#face').attr("src","img/good.png");
						$('#status').text("미세먼지 걱정 끝!");
					}else if(pm10 <= 80 && pm10 > 30){
						$('#face').attr("src","img/notgood.png");
						$('#status').text("짧은 외출까지는 괜찮습니다.");
					}else{
						$('#face').attr("src","img/frown.png");
						$('#status').text("외출 금지!");
					}
					$('#pm25Value').text(list[i].pm25Value);
					$('#pm10Value').text(list[i].pm10Value);
					$('#dataTime').text(list[i].dataTime);
					$('#o3Value').text(list[i].o3Value);
					$('#coValue').text(list[i].coValue);
					
					
				}
			}
		});
	}
</script>

<style>
img {
	width: 150px;
}

#tags{
	padding : 5px;
	font-size: 15px;
}

#status {
	font-size : 30px;
	font-weight: bold;;
}
</style>

</head>
<body>
	<div style="width: 100%">
		<div style="width: 100%;">
			<div style="width: 80px; margin: 0 auto;">
				<div style="margin-left: -40px">
					<img
						src="https://cdn.iconscout.com/public/images/icon/free/png-512/wind-air-turbine-weather-windy-3aeb9aed3acf036e-512x512.png">
						<input id="tags" onblur="changeLoc()" placeholder="지역" size="15"> <br>
				</div> 
			</div>
		</div>
		<hr>
		
		<div style="width: 1000px; margin: 100px auto; text-align: center">
		<img id="face" src="img/fuck.png" style="width: 200px"><br><label id="status"></label><br><br>
			측정일 : <span id="dataTime"></span> <br>
			초미세먼지 : <span id="pm25Value"></span> <br> 
			미세먼지 : <span id="pm10Value"></span> <br>
			오존 : <span id="o3Value"></span> <br>
			일산화탄소 : <span id="coValue"></span> <br>
		</div>
		
		<div style="width:100%; position: fixed; bottom: 0; text-align: center; font-style: italic;">
			비트캠프 미세먼지 협회
		</div>
		<!--  
	현재위도 : <span id="xLoc"></span><br>
	현재경도 : <span id="yLoc"></span><br>
	-->
	</div>
</body>
</html>