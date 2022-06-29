$(document).ready(function(){
	$.ajax({
		type : 'post', // 포스트방식으로
		url : '/SpringProject/board/getBoardList', // getBoardList.do >> getBoardListService
		data: 'pg=' + $('#pg').val(),  /*서버로 보낼 데이터*/
		dataType : 'json', /*서버에서 받을 데이터 타입*/
		success : function(data) {
			console.log(JSON.stringify(data));
			
			$.each(data.list, function(index, items){ // each : data.list의 값이 반복문을 돌면서 찍어낸다.
				$('<tr/>').append($('<td/>', { /*html의 td, tr 써주는 것처럼 ! */
					align:'center',
					text:items.seq
				})).append( $('<td/>',{ /*console에 뜨는 68은 text임.*/
						//이미지가 들어가야함. td의 자식으로 들어와야함 그래야 게시글 옆에 나오징!
						
						
					}).append( $('<a/>', {
						href:'#',
						text : items.subject,
						class : 'subjectA subjectA_' + items.seq /*유효성검사때문에 만들어줌*/
					}))
				).append($('<td/>',{
					align:'center',
					text:items.id
				})).append($('<td/>', {
					align:'center',
					text:items.logtime
				})).append($('<td/>', {
					align:'center',
					text:items.hit
				})).appendTo($('#boardListTable')); /*이렇게 형성된 td는 table에 갖다 붙이자 */
				
				//로그인 여부 - 비동적처리
				$('.subjectA_'+items.seq).click(function(){
					if (data.memId == null) {
						alert("먼저 로그인하세요");
					} else {
						location.href = '/SpringProject/board/boardView?seq='+ items.seq + '&pg=' + $('#pg').val();
					}
					
			});
			
			//답글
			for(i=0; i<items.lev; i++) { // 또 답글을 달면 2 레벨로 들어가게되서 좀 더 오른쪽으로 밀려서 보이게된다~~
				$('.subjectA_' + items.seq).before('&emsp;');
			}
			if(items.pseq != 0) { //== 0 이면 원글 / !=0이면 답글
				$('.subjectA_' + items.seq).before($('<img/>', {
					src : '/SpringProject/image/reply.gif'
				}));
			}
			
		});//each /*items = boardDTO 역할을 해줌 / items가 받는것 ? 배열안의 내용들  / 자바와는 순서를 반대로 써서 꺼내준다. 
		
		
			
			//페이징처리
			$('#boardPagingDiv').html(data.boardPaging.pagingHTML);
		},
		error:function(e){ /*e는 내가 정해준거임. 다른 문자로 해도 상관없음.*/
			console.log(e);
		} 
		
	});
}); 

//검색
$('#boardSearchBtn').click(function(){
	if($('#keyword').val() == '') 
		alert('검색어를 입력하세요');	
	else {
		$.ajax({
			type :'post',
			url : '/SpringProject/board/boardSearch.do',
			data : $('#boardSearchForm').serialize(), // pg값 , searchOption, keyword 
			dataType : 'json',
			success : function(data) {
				//alert(JSON.stringify(data));
				
				//테이블에서 기존의 목록 제거
				$('#boardListTable tr:gt(0)').remove(); /*boardList.jsp의 tr의 태그에서 보면 0보다 아래 있는것들은 다 지워라*/
				
				$.each(data.list, function(index, items){ // each : data.list의 값이 반복문을 돌면서 찍어낸다.
				//console.log(index, items.seq, items.subject, items.id, items.logtime, items.hit);
				
				/* tr태그를 동적으로 만들어주자 / td를 부착할거야 - 형제 지간 / */
				$('<tr/>').append($('<td/>', { /*html의 td, tr 써주는 것처럼 ! */
					align:'center',
					text:items.seq
				})).append( $('<td/>',{ /*console에 뜨는 68은 text임.*/
						//이미지가 들어가야함. td의 자식으로 들어와야함 그래야 게시글 옆에 나오징!
						
						
					}).append( $('<a/>', {
						href:'#',
						text : items.subject,
						/*id:'subjectA' , 
						class : 'subjectA_' +items.seq */
						class : 'subjectA subjectA_' + items.seq /*유효성검사때문에 만들어줌*/
					}))
				).append($('<td/>',{
					align:'center',
					text:items.id
				})).append($('<td/>', {
					align:'center',
					text:items.logtime
				})).append($('<td/>', {
					align:'center',
					text:items.hit
				})).appendTo($('#boardListTable')); /*이렇게 형성된 td는 table에 갖다 붙이자 */
				
				//로그인 여부 - 비동적처리
				$('.subjectA_'+items.seq).click(function(){
					if (data.memId == null) {
						alert("먼저 로그인하세요");
					} else {
						
						location.href = '/SpringProject/board/boardView?seq='+ items.seq + '&pg=' + $('#pg').val();
					}
					
			});
			
			//답글
			for(i=0; i<items.lev; i++) { // 또 답글을 달면 2 레벨로 들어가게되서 좀 더 오른쪽으로 밀려서 보이게된다~~
				$('.subjectA_' + items.seq).before('&emsp;');
			}
			if(items.pseq != 0) { //== 0 이면 원글 / !=0이면 답글
				$('.subjectA_' + items.seq).before($('<img/>', {
					src : '/miniProject/image/reply.gif'
				}));
			}
			
		}); //each
		
		//페이징처리
			$('#boardPagingDiv').html(data.pagingHTML);
		},
				error:function(e){ /*e는 내가 정해준거임. 다른 문자로 해도 상관없음.*/
				console.log(e);
			} 
		
		});
	}
});


