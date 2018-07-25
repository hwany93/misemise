<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<title>Insert title here</title>

<script>
$(document).ready(function(){
	//위도 경도 구하기
	navigator.geolocation.getCurrentPosition(function(position){	    
	    $('#xLoc').text(position.coords.latitude);
	    $('#yLoc').text(position.coords.longitude);
	});
	
	$.getJSON('station' ,function(data) {
		$.each(data, function(i, item) {
			if(i == "list"){
				console.log(item);
				station = item;
			}	
		})
		
		var temp = "";
		
		for(var i=0; i<station.length; i++){
			$('#location').append($('<option>', {
			    text: station[i].stationName
			}));
		}
		
		$('#station').text(temp);
	});
})

function changeLoc() {
	//선택된 option값의 이름을 가져온다 ex) 종로
	var data= $('select>option:selected').val();
	var list;
	
	//미세먼지 측정 json을 지역을 넘겨줘서 출력하게 한다. (Mise servlet은 지역값을 먹으면 지역값의 정보를 반환하게 되어있음)
	$.getJSON('Mise', data ,function(data) {
		$.each(data, function(i, item) {
			console.log(i);
			// 받아온 json 종류중 list(미세먼지 정보가 담겨있는 object들의 뭉치) 를 받아온다
			if(i == "list"){
				// 선택받은 리스트를 담는다
				list = item;
			}	
		})
		
		for(var i=0; i<list.length; i++){
			console.log(list[i]);
			// 리스트중 가장 최근것.. 0번째 배열
			if(i==0){
				$('#pm10Value').text(list[i].pm10Value);
				$('#pm10Grade').text(list[i].pm10Grade);
			}
		}
	});
}
</script>

</head>
<body>
	<select id="location" onchange="changeLoc()">
		<option>종로</option>
	</select><br>
	미세먼지등급 : <span id="pm10Grade"></span><br>
	미세먼지지수 : <span id="pm10Value"></span><br>
	<!--  
	현재위도 : <span id="xLoc"></span><br>
	현재경도 : <span id="yLoc"></span><br>
	-->
</body>
</html>