$(document).ready(function(){
	
	 //moviedetail 시작시에 처음 페이지에는 몇개를 띄워줄지 정보를 넘겨받는 걸로
	let commentsCount = 10;
	let commentsStart = 0;
	let hidden_movie_cd = $("#hidden_movie_cd").val();
	let hidden_login_user_id = $("#hidden_login_user_id").val();
	
	let sort_sw = "desc";
	let sort_criteria = "comment_write_date";
	
	function add_more_comment_event(){
		$("#more_comments_btn").on("click", function(){
			console.log("more_comments_btn: " + sort_sw);
			console.log("more_comments 내부 commentsStart: " + commentsStart);
			$.ajax({
				url: "morecomment",
				data:{'movie_cd': hidden_movie_cd, 'commentsCount': commentsCount,
				'commentsStart': commentsStart, 'sort_criteria': sort_criteria, 'sort_sw': sort_sw},
				type: 'post',
				dataType: 'json',
				success: function(response){
					render_movie_comment(response);
				},//success end
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
		})
	}
				function render_movie_comment(response){
					if(response.length == commentsCount){
						$("#more_comments_btn").attr("style", "display:inline-block");
					}
					if(response == null){
						$("#more_comments_btn").attr("style", "display:none");
						console.log("결과가 null이라 버튼x");
					}else{
						console.log("response.length"+response.length);
						for(let i = 0; i < response.length; i++){
							let part = "";
							if(hidden_login_user_id == response[i].user_id){
								part = `
									<div id="my_comment_modify_part" style="display: inline-block">
										<form id="updateform" action="updatemoviecomment" method="post" style="display: none">
											<input type="hidden" name="comment_num" value="${response[i].comment_num}">
											<input type="hidden" name="movie_cd" value="${response[i].movie_cd}">
											<select id="update_score" name="comment_score">
												<option value="0">0
												<option value="1">1
												<option value="2">2
												<option value="3">3
												<option value="4">4
												<option value="5">5
											</select>
											<textarea id="updateform_content" name="comment_content" ></textarea>							
											<button id="my_comments_modify_confirm_btn">수정확인</button>
										</form>
											<button id="my_comments_modify_cancel_btn" style="display: none">취소</button>
											<button id="my_comments_modify_btn">수정</button>
										<form id="deleteform" action="deletemoviecomment" method="post" style="display: inline-block">
											<input type="hidden" name="comment_num" value="${response[i].comment_num}">
											<input type="hidden" name="movie_cd" value="${response[i].movie_cd}">
											<button id="my_comments_delete_btn">삭제</button>
										</form>
									</div>	
								`;
							}

							document.getElementById("movie_comments_list").innerHTML+=`
							<div class="comments" id='${response[i].comment_num}'>
								<div>
									<div class="comments_id" style="display: inline-block">
										${response[i].user_id}
									</div>
									<span>
										평점
									</span>
									<span class="comment_score">
										${response[i].comment_score}
									</span>
									<div class="like_btn"  style="display: inline-block">
										<img src="resources/images/like.png"  ><span class="comment_like">${response[i].comment_like}</span>
									</div>
								</div>
								
								<div>
									<div class="comments_date" style="display: inline-block">
										${response[i].comment_write_date}
									</div>
									${part}
								</div>
								<div class="comments_contents">
									${response[i].comment_content}
								</div>
							</div>`
						}//for end
						if(response.length < commentsCount){
							console.log("결과값이 적어서 버튼 x");
							$("#more_comments_btn").attr("style", "display:none");
						}
						commentsStart += commentsCount;
						add_comment_event();
					}//if-else end
				}
	add_more_comment_event();	
	add_comment_event();
		function add_comment_event(){
			let like_btn = document.querySelectorAll(".like_btn");
			let comments = document.querySelectorAll(".comments");
			let click_comment_num = 0;
			let my_comments_modify_btn = $("#my_comments_modify_btn");
			let modify_btn_click = false;
			let like_btn_click = false;
			let my_comments_delete_btn = $("#my_comments_delete_btn");
			let my_comments_modify_cancel_btn = $("#my_comments_modify_cancel_btn");
			let updateform = $("#updateform");
			let delete_btn_click = false;
	
			
			my_comments_modify_btn.on("click", function (e) {
				// 수정버튼 숨기기, 삭제버튼 숨기기
				my_comments_modify_btn.attr("style", "display:none");
				my_comments_delete_btn.attr("style", "display:none");
				//
				modify_btn_click = true;
				//따로 text 생기는거 구현 + submit 동작할 버튼 구성
				updateform.attr("style", "display:inline-block");
				my_comments_modify_cancel_btn.attr("style", "display:inline-block");
			});
			
			my_comments_modify_cancel_btn.on("click", function(){
				//수정 취소 기능
				my_comments_modify_btn.attr("style", "display:inline-block");
				my_comments_delete_btn.attr("style", "display:inline-block");
				//
				modify_btn_click = true;
				
				updateform.attr("style", "display:none");
				my_comments_modify_cancel_btn.attr("style", "display:none");
			});
			
			
			my_comments_delete_btn.on("click", (e) => {
				if (confirm("삭제하시겠습니까?") == true) {
					delete_btn_click = true;
					e.submit();
				}else{
					e.preventDefault();
				}
			});
			
			for(let i = 0; i < comments.length; i++){
				
				like_btn[i].addEventListener("click", function(e){
					//여기서 바로 ajax 사용하면 click_comment_num값이 안넘어옴 
	  				//=> 좋아요 버튼 클릭 여부 확인 + 로그인 여부
	  				console.log(hidden_login_user_id);
					if(hidden_login_user_id == ""){
						if(confirm("좋아요는 로그인 후 등록 가능합니다. 로그인하시겠습니까?") == true){
							location.href = "login";
						}
					}else{
						like_btn_click = true;	
					}
	  				 
					console.log("like btn");
				});
				
				comments[i].addEventListener("click", function(e){
					click_comment_num = comments[i].id;
					console.log("comment div " + click_comment_num);
					
					//좋아요 버튼 클릭시
					if(like_btn_click){
						likeAdd(click_comment_num);
						like_btn_click=false;
					//수정 버튼 클릭시
					}else if(modify_btn_click){
						
						console.log("수정 작동");
						modify_btn_click = false;
						//수정 textarea에 기존에 썼던 content를 기본값으로
						let tmp = $("#" + click_comment_num + " .comments_contents").text();
						$("#updateform_content").text(tmp.trimStart());
						//평점 기본 선택
						let update_score_option = document.querySelector("#update_score").options;
						let comments_score = Number($("#" + click_comment_num + " .comment_score").text().trim());
						console.log(comments_score);
						for(let j = 0; j < update_score_option.length; j++){
							console.log(update_score_option[j].value + "/" + comments_score);
							if(update_score_option[j].value == comments_score){
								update_score_option[j].selected = true;
							}
						}
					}
				});
				
			}//for
		}

		function likeAdd(click_comment_num){
			let hidden_login_user_key = $("#hidden_login_user_key").val();
			$.ajax({
				url: "moviecommentlikeadd",
				data:{'comment_num': click_comment_num, 'user_key': hidden_login_user_key},
				type: 'get',
				dataType: 'json',
				success: function(response){
					//alert(JSON.stringify(response));
					//response 객체형태 -> 출력 -> 문자열형태변경메서드
					if(response.result == "좋아요 추가성공"){
						alert("추가되었습니다");
						let tmp = $("#" + click_comment_num + " .comment_like").text();
						$("#" + click_comment_num + " .comment_like").html(1 + Number(tmp));
					}else if(response.result == "중복"){
						alert("좋아요는 한줄평당 하나씩만 가능합니다");
					}
				},
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
		}

		//******************************    정렬 part   ****************************************//
		//정렬
		let sort_date_btn = document.getElementById("sort_date_btn");
		let sort_like_btn = document.getElementById("sort_like_btn");
		let sort_score_btn = document.getElementById("sort_score_btn");	
		
		sort_date_btn.onclick = ()=>{
			sort_criteria = "comment_write_date"
			if(sort_sw == "desc"){
				sort_sw = "asc";
			}else{
				sort_sw = "desc";
			}
			commentsStart = 0;
			console.log("sort_date_btn: " + sort_sw);
			console.log("sort_date_btn 내부 commentsStart: " + commentsStart);
			$.ajax({
				url: "sortcomment",
				data:{'movie_cd': hidden_movie_cd, 'commentsCount': commentsCount,
				'commentsStart': 0, 'sort_criteria': sort_criteria, 'sort_sw': sort_sw},
				type: 'post',
				dataType: 'json',
				success: function(response){
					console.log("sort_date_btn 내부 sw: " + sort_sw)
					$("#movie_comments_list").html("");
					render_movie_comment(response);
					
				},//success end
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
			
		}
		sort_like_btn.onclick = ()=>{
			sort_criteria = "comment_like";
			if(sort_sw == "desc"){
				sort_sw = "asc";
			}else{
				sort_sw = "desc";
			}
			commentsStart = 0;
			console.log("sort_date_btn: " + sort_sw);
			console.log("sort_date_btn 내부 commentsStart: " + commentsStart);
			$.ajax({
				url: "sortcomment",
				data:{'movie_cd': hidden_movie_cd, 'commentsCount': commentsCount,
				'commentsStart': 0, 'sort_criteria': sort_criteria, 'sort_sw': sort_sw},
				type: 'post',
				dataType: 'json',
				success: function(response){
					console.log("sort_date_btn 내부 sw: " + sort_sw)
					$("#movie_comments_list").html("");
					render_movie_comment(response);
					
				},//success end
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
			
		}
		
		sort_score_btn.onclick = ()=>{
			sort_criteria = "comment_score";
			if(sort_sw == "desc"){
				sort_sw = "asc";
			}else{
				sort_sw = "desc";
			}
			commentsStart = 0;
			console.log("sort_date_btn: " + sort_sw);
			console.log("sort_date_btn 내부 commentsStart: " + commentsStart);
			$.ajax({
				url: "sortcomment",
				data:{'movie_cd': hidden_movie_cd, 'commentsCount': commentsCount,
				'commentsStart': 0, 'sort_criteria': sort_criteria, 'sort_sw': sort_sw},
				type: 'post',
				dataType: 'json',
				success: function(response){
					console.log("sort_date_btn 내부 sw: " + sort_sw)
					$("#movie_comments_list").html("");
					render_movie_comment(response);
					
				},//success end
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
			
		}








});
	

	
	
	
			
