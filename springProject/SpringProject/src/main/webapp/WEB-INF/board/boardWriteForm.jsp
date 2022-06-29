<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>

<style>
   .alertMsg{ 
      background-color : yellow;
      color : red;
      font-size : 10px;
      width : 150px;
   }
</style>
<body>
<h3>글쓰기</h3>
<form name="boardWriteForm"><!--  id = "boardWriteForm" action= "/miniProject/board/boardWrite.do" method="post" 지워도됨 -->
	<table border="1" cellspacing="0" cellpadding="5"> <!-- 얘는 무조건 1페이지로 들어가니까 페이지 번호나 원글번호 이런거 안받음. -->
         <tr>
            <td width="70" align="center">제목</td>
            <td>
            	<input type="text" name = "subject" id = "subject" placeholder="제목을 입력하세요 ">
            	<div class="alertMsg" id = "subjectDiv"></div>    
            </td>        
         </tr>

         <tr>
            <td align="center">내용</td>
            <td>
            	<textarea name="content" id="content" rows="15" cols="50" placeholder="내용을 입력하세요 "></textarea>
            	<div class="alertMsg" id="contentDiv"></div>
            </td>
         </tr>
         
         <tr>
            <td colspan="2" align="center"> 
            <!--<button>버튼 태그는 자동으로 submit 해줌 이미지가 들어와서 예쁘긴함 페이지 안넘어가게 하려면 return false 잡아줘야함  -->
               	<input type="button" value="글쓰기" id="BoardWriteBtn">
               	<input type="reset" value="다시작성">
				<input type="button" value="목록" onclick="location.href='/SpringProject/board/boardList'">
            </td>
         </tr>
         
      </table>
   </form>
   
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="../script/member.js"></script>
<script type="text/javascript" src="../script/member_jQuery.js"></script>
<script type="text/javascript">

// 유효성 검사
$('#BoardWriteBtn').click(function(){
	 
	 $('#subjectDiv').empty(); // Div 영역을 클릭하면 비워라  >> 비우지않으면 경고문이 떠있으니까 empty를 꼭 써주기 / 다음번에 글씨가 들어갔을 때 아무이상 없음.
	 $('#contentDiv').empty();
	 
	 if($('#subject').val() == ''){
	      $('#subjectDiv').html('제목을 입력하세요'); 
	      $('#subjectDiv').css('color', 'red'); /* 여기서부터 css 3줄은 위의 alertMsg로 잡아놨기 때문에 지워도됨 */
	      $('#subjectDiv').css('font-size', '8pt');
	      $('#subjectDiv').css('font-weight', 'bold');
	   
	 }else if($('#content').val() == ''){
	      $('#contentDiv').html('내용을 입력하세요');
	      $('#contentDiv').css('color', 'red');
	      $('#contentDiv').css('font-size', '8pt');
	      $('#contentDiv').css('font-weight', 'bold');
	 }else {
		 $.ajax({ // 지정해준 페이지에 화면 안바뀐채로 데이터 가져오는게 ajax의 기능
	    	  type :'post',
	    	  url : '/SpringProject/board/boardWrite',  // 서버주소
	    	  data : {
					 'subject' : $('#subject').val(),
					 'content' : $('#content').val()},
	    		    		 
	    	  success : function() { // 갔다가 다시 여기로 오게됨 
	   			  alert('게시글을 등록하였습니다.');
	   			  location.href = '/SpringProject/board/boardList';
	   		  },
	   		 error: function(err){
		         console.log(err);
		 		} 
			}); 
		}
	});
/*boardList.js파일에서 >  $(document).ready(function(){});  = $(function(){ }); >> 똑같다!!! */
</script>
    

</body>
</html>