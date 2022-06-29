<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#currentPaging {
	color : red;
	text-deciration : underline;
	cursor : pointer;
}

#paging {
	color : black;
	text-decoration : none;
	 cursor : pointer; 
}
</style>
</head>
<body>
<input type="text" id = "pg" value="${requestScope.pg}">
<form id = "imageboardListForm" method="get" action="/SpringProject/imageboard/imageboardDelete">
<table id= "imageboardListTable" border ="1" cellpadding="5" frame="hsides" rules="rows"> <!-- cellpadding - 간격! hside : 한줄만 나와라! rules="rows" 행단위로!-->
	<tr>
		<th width="100"><input type="checkbox" id="all">번호</th> <!--전부 선택 / 전부 해제 -->
		<th width="150">이미지</th>
		<th width="150">상품명</th>
		<th width="150">단가</th>
		<th width="150">개수</th>
		<th width="150">합계</th>
	</tr>
	<!-- 동적 처리 -->
</table>

<input type="button" value="선택삭제" id = "imageboardDeleteBtn" style="margin:5px 10px; float:left;"> <!-- 좌우 , 위아래 -->
<div id = "imageboardPagingDiv" style="border: 1px solid red; width:750px; float:left; text-align:center;">
	<!-- 동적 처리 -->
</div>
</form>

<script type="text/javascript"  src="http://code.jQuery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function imageboardPaging(pg2) { /* 지역변수이기때문에 이 안에서만 써먹는것. 10번 라인에 있는 pg랑 헷갈리니까 pg2로 잡음.  */
	location.href="/SpringProject/imageboard/imageboardList?pg=" + pg2; /* 변수명은 pg고 넘어가는 값은 pg2니까 헷갈리지 말기~! */
}
</script>
<script type="text/javascript">
$(function(){
	$.ajax({
		type:'post',
		url:'/SpringProject/imageboard/getImageboardList', 
		data:{'pg' : $('#pg').val()},
		dataType: 'json',
		success : function(data){ // list를 통해서 데이터 받아와야함
			//colsole.log(JSON.stringify(data));
			//location.href = '/SpringProject/imageboard/imageboardList';
			$.each(data.list, function(index,items){
				$('<tr/>').append($('<td/>',{
					align:'center', // 가운데 정렬
					text:items.seq
					}).prepend($('<input/>', {
						type: 'checkbox',
						name: 'check',
						value: items.seq
					}))
				).append($('<td/>',{
					align:'center', // 가운데 정렬
					
					}).append($('<img/>', {
						src:'/SpringProject/storage/'+items.image1,
						style:'width:70px; height:70px;'
					}))
				
				).append($('<td/>',{
					align:'center', // 가운데 정렬
					text:items.imageName
				})).append($('<td/>',{
					align:'center', // 가운데 정렬
					text:items.imagePrice.toLocaleString()
				})).append($('<td/>',{
					align:'center', // 가운데 정렬
					text:items.imageQty
				})).append($('<td/>',{
					align:'center', // 가운데 정렬
					text:(items.imagePrice * items.imageQty).toLocaleString() /* toLocaleString(): 3자리 수 마다 끊어서 쉼표찍히게 하기 */
				})).appendTo($('#imageboardListTable'));
			}); // each
			
			//페이징 처리
			$('#imageboardPagingDiv').html(data.imageboardPaging.pagingHTML);
		}, 
			error : function(err) {
				console.log(err);
		}
	}); // $.ajax
	
	//전체 선택 또는 전체 해제
	$('#all').click(function(){
		// alert($('#all').attr('checked')); /* >>이러면 결과가 안나옴. >  'checked' 의 문자열을 찾기때문에 결과가 나오지 않음. attr은 문자열로 꺼내온다. true/false를 받아와야하니까 prop(property)를 써야함 */
		//checked라는 속성이 없어서 undefined라고 나온다.
		//alert($('#all').prop('checked'));
		
		if($('#all').prop('checked')) /* // submit은 name속성밖에 안먹음. */
			$('input[name="check"]').prop('checked', true);
		else
			$('input[name="check"]').prop('checked', false);
	});
		
	//선택삭제
	$('#imageboardDeleteBtn').click(function(){
		var count = $('input[name="check"]:checked').length; /* 체크된 애들이 몇개인지 센다. */
		if(count==0) 
			alert('삭제할 항목을 선택하세요.');
		else 
			if(confirm('정말로 삭제하시겠습니까?')) $('#imageboardListForm').submit();	
	});
});
</script>
</body>
</html>

