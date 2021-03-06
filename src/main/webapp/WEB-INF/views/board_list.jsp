<%@page import="java.util.Set"%>
<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.exam.boardlist.BoardDAO" %>
<%@ page import="com.exam.boardlist.JoinBULCTO" %>
<%@ page import="com.exam.boardlist.BoardPagingTO" %>
<%@ page import="java.util.ArrayList" %>

<%
	//현재 세션 상태를 체크한다
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	}
	
	BoardPagingTO pagingTO = (BoardPagingTO)request.getAttribute( "pagingTO" );

	int cpage = pagingTO.getCpage();
	
	//BoardDAO dao = new BoardDAO();
	//pagingTO = dao.boardList(pagingTO);

	int recordPerPage = pagingTO.getRecordPerPage();
	int totalRecode = pagingTO.getTotalRecord();
	
	int totalPage = pagingTO.getTotalPage();
	
	int blockPerPage = pagingTO.getBlockPerPage();
	
	int startBlock = pagingTO.getStartBlock();
	int endBlock = pagingTO.getEndBlock();
	
	ArrayList<JoinBULCTO> lists = pagingTO.getJoinbulcList();
	//ArrayList<BoardTO> lists = (ArrayList)request.getAttribute( "lists" );
	
	StringBuffer sbHtml = new StringBuffer();
	
	//seq, date, filename, title, useq, nickname, Lcount, Ccount 
	int cnt = 0;
	if(lists != null){
		for( JoinBULCTO to : lists ) {
			cnt++;
			String seq = to.getSeq();
			String date = to.getDate();
			 String filename = to.getFilename();
	         if(filename!=null){
	            filename = filename.split("//")[0];
	         }
			String title = to.getTitle();
			/* 210406
			// title 처리랑, css에 text width 설정함.
			if (title != null && title.length() > 25) {
				title = title.substring(0, 24)+"...";
			}
			*/
			String useq = to.getUseq();
			String nickname = to.getNickname();
			String Lcount = to.getLcount();
			String Ccount = to.getCcount();
			
			if(cnt % 5 == 1) {
				sbHtml.append("</tr>");
				sbHtml.append("<tr>");
			}
		
			/* 완성코드
			sbHtml.append("<td class='board'>");
			// 사진 크기 250 250
			sbHtml.append("	<div class='img'>");
			sbHtml.append("		<a href='view.do'><img src='./upload/"+filename+"' border='0' width=250px height=250px/></a>");
			sbHtml.append("	</div>");
			sbHtml.append("	<div class='text'>");
			//sbHtml.append("		<a href='board_view.jsp'><p>"+title+"</p></a>");
			sbHtml.append("		<a href='board_view.jsp'>"+title+"</a>");
			sbHtml.append("	</div>");
			sbHtml.append("</td>");
			*/
			
			if(filename == null) {
				
				sbHtml.append("<td class='board'  width=250px height=250px >");
				// 사진 크기 250 250
				sbHtml.append("	<div class='img'>");
				sbHtml.append("	</div>");
				sbHtml.append("	<div class='text'>");
				sbHtml.append("	</div>");
				sbHtml.append("</td>");


				//sbHtml.append("<td>"+filename+"</td>");
			} else {
				sbHtml.append("<td class='board board1' bseq='"+seq+"' data-bs-toggle='modal' data-bs-target='#view-modal'>");
				// 사진 크기 250 250
				sbHtml.append("	<div class='img'>");
				sbHtml.append("		<img src='./upload/"+filename+"' border='0' width=250px height=250px/>");
				sbHtml.append("	</div>");
				sbHtml.append("	<div class='text'>");
				
				// 여기 레이아웃 수정 후 search_tlist.jsp도 수정 ★★★
				//sbHtml.append("		<a href='board_view.jsp'><p>"+title+"</p></a>");
				// 수정하기 ★★
				//sbHtml.append("		<div id='text_title'><p>"+title+title.length()+"</p></div>");
				//<div class='user_intro' style='width:490px; height:47px; overflow-x:hidden; overflow-y:hidden;'>
				//sbHtml.append("		<div id='text_title'><p>"+title+"</p></div>");
				sbHtml.append("		<div id='text_title' style='width:180px; height:48px; overflow-x:hidden; overflow-y:hidden; margin-bottom: 16px;'><p>"+title+"</p></div>");
				sbHtml.append("		<div id='text_nickname'><p>by "+nickname+"</p></div>");
				sbHtml.append("		</br>");
				//sbHtml.append("		<span id='text_likey'><i class='fas fa-heart'></i>"+Lcount+"</span>");
				sbHtml.append("		<div id='text_count' align='right'>");
				sbHtml.append("			<span id='text_likey'><i class='fas fa-heart'></i>&nbsp;"+Lcount+"</span>");
				sbHtml.append("			&nbsp;");
				sbHtml.append("			<span id='text_comment'><i class='fas fa-comment-dots'></i>&nbsp;"+Ccount+"</span>");
				sbHtml.append("		</div>");
				
				sbHtml.append("	</div>");
				sbHtml.append("</td>");
			}		
		}		
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책갈피</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>

<!-- 글쓰기 Summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


<!-- ■■ 내가 추가한 부분 ■■ -->
<style type="text/css">	
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap');
 #main{
 font-family: 'Noto Serif KR', serif;
}
#view-modal{
		font-family: 'Noto Serif KR', serif;
}
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap');
   body {
 font-family: 'Noto Serif KR', serif;
  background: #white;
}	
.button1{
	float: right;
	margin-right: 0px;
	width: 30px;
	font-size: 20px;

}
.button2{
	float: right;
	margin-right: 30px;
	width: 30px;
	font-size: 20px;
}
.button3{
	float: right;
	width: 30px;
	font-size: 20px;
}
	.board:hover .img {filter: brightness(60%);}
	.text {text-align: center; position: absolute; top: 50%; left: 50%; transform: translate( -50%, -50% ); color: white; opacity: 0;}
	.text {width: 180px;}
	#text_title p {font-size: 16px;}
	#text_nickname p {font-size: 12px;}
	#text_count span {font-size: 12px;}
	.board:hover .text {opacity: 1;}
	.board {position: relative;}
	.board_pagetab { text-align: center; } 
	.board_pagetab a { text-decoration: none; font: 15px verdana; padding: 0 3px 0 3px; color: gray;}
	.board_pagetab a:hover { text-decoration: underline; color: black; }
	.board {padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 10px;}
	/*#content {position: absolute; left: 50%; transform: translateX(-50%);}*/
	
</style>
<!--
class=board에 마우스 갖다대면 class=img를 filter 적용
class=text 사진 정가운데에 위치시키고, opacity(불투명도)를 0으로 줘서 안보이게 함
text부분 길이 조절
title 글씨 크기 조절
nicckname 글씨 크기 조절
count 글씨 크기 조절
class=board에 마우스 갖다대면 class-text opacity(불투명도)를 1로 줘서 보이게 함
이미지 위에 텍스트 갖다 놓으려면 이미지와 텍스트를 묶고있는 class에 position을 relative로 해야한다고 해서 함
class=board_pagetab 페이지탭 가운데 위치
class=board_pagetab의 a인 링크부분  링크지만 글자색 검은색
class=board_pagetab의 a 페이지탭에 마우스 갖다대면 밑줄 & 회색 배경
class=board 각 사진마다 padding 여백
id=content 본문 가운데 위치

-->
<!-- ■■ /내가 추가한 부분 ■■ -->
<script>
$(document).ready(function(){	
	$('.board1').click(function(e){
		//alert($(this).attr('bseq')+"클릭");
		//console.log("./view.do?seq=" + $(this).attr('bseq'));
		$('.view-content').load("./view.do?seq=" + $(this).attr('bseq'));
	});
	
	$("#write_button").on('click', function(){
		<%if(userInfo!=null){%>
			$("#write-modal").modal("show");
			$('.write-content').load("./write.do");
		<%}else{%>
			var comfirm_login = confirm("로그인이 필요한 서비스입니다. \n'확인'버튼을 클릭 시, 로그인 창으로 이동합니다.");
			if(comfirm_login==true){
				location.href="./login.do";
			}
		<%}%>	
	});
	
	$('#view-modal').on('hidden.bs.modal', function(){
		location.reload();
	});
})
</script>

</head>
<body>

<div id="mySidebar" class="sidebar">
	<div class="sidebar-header">
		<a><h3>당신의 책갈피</h3></a>
	</div>

	<%if (userInfo != null) {%>
		<div class="sidebar-userprofile">
			<div class="sidebar-user_img" align="center" style="padding-top: 10px; padding-bottom: 10px;">
				<img src="./profile/<%=userInfo.getProfile_filename() %>" border="0" width=80px height=80px style="border-radius: 50%;"/>
			</div>	
			<div  align="center" style="color:gray; font-size:18px;"><%=userInfo.getNickname()%>님이</div>
			<div  align="center" style="color:gray; font-size:18px;">로그인 중 입니다.</div>
			<br/>
		</div>
	<%} else {%>
		<p>로그인해주세요.</p>
	<%}%>
	<a href="./home.do">Home</a>
		<%if(userInfo != null){
		if(userInfo.getId().equals("testadmin1")) {%>
			<a href="./admin.do">Admin Page</a>
		<%} else{ %>
			<a href="./mypage.do?useq=<%=userInfo.getSeq()%>" >My Page</a>
		<%}
	}%>
	<a href="./list.do">모든 게시글 보기</a>
	<a href="./book_list.do">책 구경하기</a>
	
	<div style="padding:8px; position:absolute; bottom:2%; width:100%">
		<button style="width:100%" id="write_button" type="button" class="btn btn-outline-light">글쓰기</button>
	</div>
</div>

<div id="main">
	<div id="header">
		<div>
			<table>
				<tr>
					<td width=5%><span>
						<button class="sidebar-btn" onclick="sidebarCollapse()">
							<span><i class="fa fa-bars" aria-hidden="true"></i></span>
			             </button>
					</span>
					</td>
					<td width=5%><span><a class="navbar-brand" href="./home.do"> <img src="./images/logo.png" alt="logo" style="width: 200px; height:50px; "></a></span></td>
					<% if(userInfo == null){ %>
						<td width=75% ><span><a class="button1" href="./login.do" id="start-button" style="color: black;">START</a></span></td>
	        		<% }else{ %>
	        			<td width=75% ><span><a class="button2" href="./logout_ok.do" id="logout-button" style="color: black;">LOGOUT</a></span></td>
	        		<% } %>
					<td width=5%><span><a class="button3" href="./search.do" style="color: black;"><i class="fa fa-search" aria-hidden="true"></i></a></span></td>
				</tr>
			</table>		
    	</div>
    </div>
    
    <div id="content" style="padding: 100px 0px;" align= "center">
         <div style="width:1320px"><h1 align='left'>전체 게시글</h1></div>
         <br/> 
        	
        <!-- ■■ 내가 추가한 부분 ■■ -->
        <!-- 게시판 -->
	    <table class="board_list">
			<tr>
				<%= sbHtml %>
			</tr>
		</table>
		<!--//게시판-->
	
        <!--페이지넘버-->
		<div class="paginate_regular">
			<div class="board_pagetab">
<%
	// << 표시 설정
	//if(startBlock == 1) {
	if(cpage == 1) {
		out.println("<span class='off'><a style='color:gray;'>처음</a>&nbsp;&nbsp;</span>");
	} else {
		//out.println("<span class='off'><a href='./list.do?cpage="+(startBlock-blockPerPage)+"'>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
		out.println("<span class='off'><a href='./list.do?cpage="+1+"' >처음</a>&nbsp;&nbsp;</span>");
	}

	// < 표시 설정
	if (cpage == 1) {
		out.println("<span class='off'><a style='color:gray;'>이전</a>&nbsp;&nbsp;</span>");
	} else {
		out.println("<span class='off'><a href='./list.do?cpage="+(cpage-1)+"'>이전</a>&nbsp;&nbsp;</span>");
	}


	for(int i=startBlock; i<=endBlock; i++) {
		
		if(cpage == i) {
			// 현재 페이지
			out.println("<span class='on'><a style='color: black;'>["+i+"]</a></span>");
		} else {
			out.println("<span class='off'><a href='./list.do?cpage="+i+"'>"+i+"</a></span>");
		}
	}

	// > 표시 설정
	if (cpage == totalPage) {
		out.println("<span class='off'>&nbsp;&nbsp;<a style='color:gray;'>다음</a></span>");
	} else {
		out.println("<span class='off'>&nbsp;&nbsp;<a href='./list.do?cpage="+(cpage+1)+"'>다음</a></span>");
	}

	// >> 표시 설정
	//if(endBlock == totalPage) {
	if(cpage == totalPage) {
		out.println("<span class='off'>&nbsp;&nbsp;<a style='color:gray;'>끝</a></span>");
	} else {
		//out.println("<span class='off'>&nbsp;&nbsp;<a href='list.do?cpage="+(startBlock+blockPerPage)+"'>&lt;끝&gt;</a></span>");
		out.println("<span class='off'>&nbsp;&nbsp;<a href='list.do?cpage="+totalPage+"'>끝</a></span>");
	}
		
%>
				<!--  
				<span class="off"><a href="#">&lt;처음&gt;</a>&nbsp;</span>
				<span class="off"><a href="#">&lt;이전&gt;</a>&nbsp;</span>
				<span class="on"><a href="#">( 1 )</a></span>
				<span class="off"><a href="#"> 2 </a></span>
				<span class="off"><a href="#"> 3 </a></span>
				<span class="off"><a href="#"> 4 </a></span>
				<span class="off"><a href="#"> 5 </a></span>
				<span class="off">&nbsp;<a href="#">&lt;다음&gt;</a></span>
				<span class="off">&nbsp;<a href="#">&lt;끝&gt;</a></span>
				-->
			</div>
		</div>
		<!--//페이지넘버-->
		<!-- ■■ /내가 추가한 부분 ■■ -->
    </div>
</div>
<!-- 모달창 정보 -->
<div id="view-modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content view-content">                   
		</div>
	</div>
</div>
             
<div id="write-modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content write-content">
	    </div>
	</div>
</div>
</body>
</html>