//중복 아이디 체크
$('#id_write').focusout(function(){ //.change도 가능
   if($('#id_write').val() == ''){
      $('#idDiv_write').html('먼저 아이디 입력');
      $('#idDiv_write').css('color', 'magenta');
      $('#idDiv_write').css('font-size', '8pt');
      $('#idDiv_write').css('font-weight', 'bold');
   } else{
			$.ajax({ /* jQuery 라고 쓰던지, $라고 쓰던지 / ajax 호출*/
         url: '/SpringProject/member/checkId',
         type: 'post',
         //data: 'id='+$('#id_write').val(), //서버로 보낼 데이터 
         data: {'id' : $('#id_write').val()}, //서버로 보낼 데이터, JSON // data : 지정된 명령어라 바꾸지 못함
         dataType: 'text', //서버로부터 받는 데이터 형식
         success: function(data){  /*위에있는 data이름과 다르게 바꿀 수 있음. 지정어아님*/
            data = data.trim();
            
            if(data == 'exist'){
               $('#idDiv_write').html('사용 불가능');
               $('#idDiv_write').css('color', 'red');
               $('#idDiv_write').css('font-size', '8pt');
               $('#idDiv_write').css('font-weight', 'bold');
            
			} else if(data == 'non_exist'){
               $('input[name="check"]').val($('#id_write').val());
               $('#idDiv_write').html('사용 가능');
               $('#idDiv_write').css('color', 'blue');
               $('#idDiv_write').css('font-size', '8pt');
               $('#idDiv_write').css('font-weight', 'bold');
            }
         },
			
			error:function(err){
				console.log(err);
			}
		});
  	 }
});

//회원가입
// 리턴값이 없다 = 데이터 타입을 빼자!
$('#writeBtn').click(function(){
   $('#nameDiv').empty();
   $('#idDiv_write').empty();
   $('#pwdDiv_write').empty();
   
   if($('#name').val() == ''){
      $('#nameDiv').html('이름을 입력하세요');
      $('#nameDiv').css('color', 'red');
      $('#nameDiv').css('font-size', '8pt');
      $('#nameDiv').css('font-weight', 'bold');
   
   }else if($('#id_write').val() == ''){
      $('#idDiv_write').html('아이디를 입력하세요');
      $('#idDiv_write').css('color', 'red');
      $('#idDiv_write').css('font-size', '8pt');
      $('#idDiv_write').css('font-weight', 'bold');
   
   }else if($('#pwd_write').val() == ''){
      $('#pwdDiv_write').html('비밀번호를 입력하세요');
      $('#pwdDiv_write').css('color', 'red');
      $('#pwdDiv_write').css('font-size', '8pt');
      $('#pwdDiv_write').css('font-weight', 'bold');
   
   }else if($('#repwd').val() != $('#pwd_write').val()){
      $('#repwdDiv').html('비밀번호가 맞지 않습니다');
      $('#repwdDiv').css('color', 'red');
      $('#repwdDiv').css('font-size', '8pt');
      $('#repwdDiv').css('font-weight', 'bold');
   }else if($('#id_write').val() != $('input[name="check"]').val()){
      $('#idDiv_write').html('중복체크 하세요');
      $('#idDiv_write').css('color', 'red');
      $('#idDiv_write').css('font-size', '8pt');
      $('#idDiv_write').css('font-weight', 'bold');
   
   }else{
//      $('#writeForm').submit();
      $.ajax({
    	  type : 'post',
    	  url:'/SpringProject/member/write',
    	  data : $('#writeForm').serialize(), // 폼안에 있는 데이터 다 가져가자 'name=홍길동&id=hong~~'
    	  success: function(){
    		  alert('회원가입을 축하합니다.');
    		  location.href = "/SpringProject/index";
    	  }, 
    	  error:function(err){
    		  console.log(err);
    	  }
      });
      /*$.ajax({
         url: '/miniProject/member/checkWrite.do',
         type: 'post',
         data: {'name' : $('#id_write').val()}, //서버로 보낼 데이터, JSON
         data: {'id' : $('#id_write').val()}, 
         data: {'pwd' : $('#id_write').val()}, 
         data: {'repwd' : $('#id_write').val()}, 
         success: ,
         
         error: function(err){
            console.log(err);
         }
      });*/
   }
});
function checkPost() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
               

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("zipcode").value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
    }
