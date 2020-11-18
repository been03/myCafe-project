<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date" />

	<div class="cafe_info_wrap">
		<div class="mem_info_wrap">
			<c:if test="${member.imageId.equals('basic') && !member.role.equals('ADMIN') }">
				<img src="${contextPath }/resources/upload/photo_profile/profile_basic.png">
			</c:if>
			<c:if test="${member.role.equals('ADMIN') }">
				<img src="${contextPath }/resources/upload/photo_profile/profile_admin.png">
			</c:if>
			<c:if test="${!member.imageId.equals('basic') && !member.role.equals('ADMIN') }">
				<img src="${contextPath }/resources/upload/photo_profile/${member.memberId}/${member.imageId}">
			</c:if>
			<span style="font-size: 17px; font-weight: bold; width: 200px;">${member.nickName }<span style="font-size: 15px; color: coral; font-weight: bold;">(${member.memberId })</span></span>
			
			<c:if test="${member.role != 'GUEST' }">
			<span style="display: block;">가입일자: ${member.memberJoinDate }</span>
			</c:if>
			<c:if test="${member.role == 'GUEST' }">
				<span style="display: block;">접속일자: <fmt:formatDate value="${now}" pattern="yyyy.MM.dd HH:mm:ss" /></span>
			</c:if>
			<c:if test="${member.role != 'GUEST' }">
				<div class="mem_stat_wrap" style="margin: 0 auto">
					<p><span style="font-weight:bold">등급: </span><span style="width: 125px;">${member.levelName }</span>
					<a href='javascript:void(0);' onclick="window.open('${contextPath}/member/levelCheck.do?mini=mini','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=630, height=550, left=500, top=100, scrollbars=yes'); return false;">등급안내</a></p>
					<p><span style="font-weight:bold">방문횟수: </span><span>${member.loginCnt }</span></p>
					<p><span style="font-weight:bold">게시글 수: </span><span style="width: 51px;">${member.articleCnt }</span>
					<a href="${contextPath }/member/myPageMain.do?memberId=${member.memberId }">내가 쓴 글 보러가기</a></p>
					<p><span style="font-weight:bold">댓글 수: </span><span style="width: 50px;">${member.commentCnt }</span>
					<a href="${contextPath }/member/myPageMain.do?memberId=${member.memberId }">내가 쓴 댓글 보러가기</a></p>
				</div>
			</c:if>
			<c:if test="${member.role == 'GUEST' }">
				<div class="mem_stat_wrap" style=" margin:-20px auto 0;">
					<p class="guest_buttons_wrap">
						<a href="${contextPath }/member/memberJoinForm.do">회원가입하기</a>
						<a href="${contextPath }/member/loginForm.do">로그인하기</a>
					</p>
				</div>	
			</c:if>
		</div>
	<c:if test="${member.role == 'GUEST' }">		
		<button class="info_button" onClick="popUp()">카페채팅</button>
		<button class="info_button" onClick="javascript:alert('myCafe 멤버만 게시글 작성이 가능합니다! 회원가입을 먼저 해주세요!!')">글 작성하기</button>
	</c:if>
	<c:if test="${member.role != 'GUEST' }">		
		<button class="info_button" onClick="popUp()">카페채팅</button>
		<button class="info_button" onClick="location.href='${contextPath}/member/articleNew.do?boardId=6'">글 작성하기</button>
	</c:if>
	</div>
	<form id="side_search_form" name="side_search_form" class="side_search_form" method="post" action="${contextPath }/member/articleSearch.do" style="margin-top: 15px;">
		<input type="text" name="searchInput" class="side_search_searchInput">
		<input type="hidden" name="searchCondition" value="all">
		<input type="hidden" name="articleCategory" value="all">
		<input type="submit" name="search_submit_button" value="검색">
	</form>
	<ul class="ctg_menu_outer_ul" >
		<c:forEach var="ctgList" items="${categories }">
			<c:if test="${ctgList.ctgId != 4 }">
				<li id="${ctgList.ctgId }" class="ctg_menu_outer_li">
					<span>[${ctgList.ctgName }]</span>
					<ul class="ctg_menu_inner_ul">
						<c:forEach var="boardList" items="${boards }" varStatus="status">
							<c:if test="${ctgList.ctgId == boardList.ctgId }">
								<li class="ctg_menu_inner_li">
									<a href="${contextPath }/member/boardMain.do?boardId=${boardList.boardId }" title="${boardList.boardName }">
										<span>${boardList.boardName }</span>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<ul class="ctg_menu_outer_ul">
		<c:forEach var="ctgList" items="${categories }">
			<c:if test="${ctgList.ctgId == 4 }">
				<li id="${ctgList.ctgId }" class="ctg_menu_outer_li">
					<span>[${ctgList.ctgName }]</span>
					<ul class="ctg_menu_inner_ul">
						<c:forEach var="boardList" items="${boards }" varStatus="status">
							<c:if test="${ctgList.ctgId == boardList.ctgId }">
								<li class="ctg_menu_inner_li">
									<a href="${contextPath }/member/boardMain.do?boardId=${boardList.boardId }" title="${boardList.boardName }">
										<span>${boardList.boardName }</span>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<div class="recent_article_wrap">
		<p>최신 게시글</p>
		<ul class="recent_article_ul" id="change_content_ul_1">
			<c:if test="${empty recentArticles}">
				<li class="recent_article_li">
					<p style="line-height: 20px; text-align:center;">조회된 게시글이 없습니다</p>
				</li>
			</c:if>
			<c:if test="${not empty recentArticles }">
				<c:forEach var="list" items="${recentArticles }" begin="0" end="3" varStatus="status">
					<li class="recent_article_li">
						<a href="${contextPath }/member/articleDetail.do?articleId=${list.articleId}&boardId=${list.boardId}" title="게시판: ${list.articleBoard } 댓글: ${list.articleCommentCnt } 조회: ${list.articleReadCnt} 좋아요: ${list.articleLikeCnt}">${list.articleTitle }</a>
					</li>
				</c:forEach>
			</c:if>
		</ul>
		<ul class="recent_article_ul" id="change_content_ul_2" style="display:none;">
			<c:if test="${not empty recentArticles }">
				<c:forEach var="list" items="${recentArticles }" begin="4" end="7">
					<li class="recent_article_li">
						<a href="${contextPath }/member/articleDetail.do?articleId=${list.articleId}&boardId=${list.boardId}" title="게시판: ${list.articleBoard } 댓글: ${list.articleCommentCnt } 조회: ${list.articleReadCnt} 좋아요: ${list.articleLikeCnt}">${list.articleTitle }</a>
					</li>
				</c:forEach>
			</c:if>
		</ul>
		<c:if test="${fn:length(recentArticles) > 5 }">
			<button class="change_content_btn" onClick="changeContent()">다음</button> 
		</c:if>
	</div>
	<div id="Line_Controls_Chart" style="margin-bottom:30px;">
		<!-- 라인 차트 생성할 영역 -->
		<div id="lineChartArea" style="width: 265px;overflow: hidden;margin-left: -14px;">
			<div id="controlsArea" style="padding: 0px 20px 0px 0px;"></div>
		</div>
		<!-- 컨트롤바를 생성할 영역 -->
	</div>
	
	<div id="Line_Controls_Chart2" >
		<!-- 라인 차트 생성할 영역 -->
		<div id="lineChartArea2" style="width: 265px;overflow: hidden;margin-left: -14px;">
			<div id="controlsArea2" style="padding: 0px 20px 0px 0px;"></div>
		</div>
		<!-- 컨트롤바를 생성할 영역 -->
	</div>
	<script>
		function popUp(){
		    var url = "${contextPath}/chatForm";
		    var name = "myCafe 채팅";
		    var option = "width = 500, height = 800, top = 100, left = 200, location = no"
		    window.open(url, name, option);
		}
		$("input[name=search_submit_button]").click(function(e){
			e.preventDefault();
			if ($(".side_search_searchInput").val() == ""){
				alert("검색어를 입력하세요!");
				document.side_search_form.searchInput.focus();
				return false;
			}else{
				$("#side_search_form").submit();
			}
		});
		function changeContent(){
			var text = document.getElementsByClassName("change_content_btn")[0].innerHTML;
			if (text === '이전'){
				document.getElementsByClassName("change_content_btn")[0].innerHTML = '다음';
				document.getElementById("change_content_ul_1").style.display = "block";
				document.getElementById("change_content_ul_2").style.display = "none";
			}else if (text === '다음'){
				document.getElementsByClassName("change_content_btn")[0].innerHTML = '이전';
				document.getElementById("change_content_ul_2").style.display = "block";
				document.getElementById("change_content_ul_1").style.display = "none";
			}
		}
	
		var chartDrowFun = {
			//방문자
			chartDrow : function() {
				var chartData = '';
				//날짜형식 변경
				var chartDateformat = 'MM월dd일';
				//라인차트의 라인 수
				var chartLineCount = 10;
				//컨트롤러 바 차트의 라인 수
				var controlLineCount = 10;
				function drawDashboard() {
					var data = new google.visualization.DataTable();
					data.addColumn('datetime', '날짜');
					data.addColumn('number', '방문자수');
	
					//그래프에 표시할 데이터
					var dataRow = [];
					var array = new Array();
	
					<c:forEach items="${chart}" var="list">
						var json = new Object();
						json.loginCnt = "${list.loginCnt}";
						json.loginTime = "${list.loginTimeString}";
						array.push(json);
					</c:forEach>
					
					var date = new Date();
					var thisMonth = (date.getMonth()+1).toString();
					var firstDayOfMonth = new Date( date.getFullYear(), date.getMonth() , 1 );
					var lastMonth = new Date ( firstDayOfMonth.setDate( firstDayOfMonth.getDate() - 1 ) );
					var lastMonthNum = (lastMonth.getMonth()+1).toString();
					for (var i = 1; i <= 30; i++) {
						var check = false;
						// 방문자 
						for (var j = 0; j < array.length; j++) {
							if (Number(array[j].loginTime.substring(6) == i)) {
								dataRow = [ new Date('2020', lastMonthNum, i, thisMonth),
										Number(array[j].loginCnt)
								]; //dataRow 회원가입 수 추가 Number(array[j].joinCnt)
								data.addRow(dataRow);
								check = true;
							}
						}
						if (check) {
							continue;
						}
						//그래프에 추가 시작 값
						dataRow = [ new Date('2020', lastMonthNum, i, thisMonth), 0 ]; //각각 0부터 시작 회원가입 통계 추가
						data.addRow(dataRow);
					}
	
					var chart = new google.visualization.ChartWrapper({
						// 포인트가 오른쪽으로 밀림
						chartType : 'LineChart',
						containerId : 'lineChartArea', //라인 차트 생성할 영역
						options : {
							isStacked : 'percent',
							focusTarget : 'category',
							height : 100,
							width : 300,
							//각각의 위치 지정
							legend : {
								position : "top",
								textStyle : {
									fontSize : 13
								}
							},
							pointSize : 3,
							pointShape : 'circle',
							tooltip : {
								textStyle : {
									fontSize : 12
								},
								showColorCode : true,
								trigger : 'both'
							},
	
							//x축
							hAxis : {
								format : chartDateformat, //var chartDateformat = 'yyyy년MM월dd일';
								//format : 'dd MM ',
								gridlines : {
									count : chartLineCount,
									units : {
										/* years : {
											format : [ 'yyyy년' ]
										}, */
										months : {
											format : [ 'MM월' ]
										},
										days : {
											format : [ 'dd일' ]
										},
									/* 	hours : {
											format : [ 'HH시' ]
										} */
									}
								},
								textStyle : {
									fontSize : 12
								}
							},
	
							//y축
							vAxis : {
								minValue : 10, //데이터에 따라서 값 변화 
								viewWindow : {
									min : 0
								},
								gridlines : {
									count : -1
								},
								textStyle : {
									fontSize : 12
								}
							},
							animation : {
								startup : true,
								duration : 1000,
								easing : 'in'
							},
							annotations : {
								pattern : chartDateformat,
								textStyle : {
									fontSize : 15,
									bold : true,
									italic : true,
									color : '#871b47',
									auraColor : '#d799ae',
									opacity : 0.8,
									pattern : chartDateformat
								}
							}
						}
					});
	
					var control = new google.visualization.ControlWrapper({
						controlType : 'ChartRangeFilter',
						containerId : 'controlsArea', //control bar를 생성할 영역
						options : {
							ui : {
								chartType : 'LineChart',
								chartOptions : {
									chartArea : {
										'width' : 100,
										'height' : 400
									},
									hAxis : {
										'baselineColor' : 'none',
										format : chartDateformat,
										textStyle : {
											fontSize : 12
										},
										gridlines : {
											count : controlLineCount,
											units : {
												years : {
													format : [ 'yyyy년' ]
												},
												months : {
													format : [ 'MM월' ]
												},
												days : {
													format : [ 'dd일' ]
												},
											 	hours : {
													format : [ 'HH시' ]
												} 
											}
										}
									}
								}
							},
							filterColumnIndex : 0
						}
					});
	
					var date_formatter = new google.visualization.DateFormat({
						pattern : chartDateformat
					});
					date_formatter.format(data, 0);
	
					//추가
					var dashboard = new google.visualization.Dashboard(document
							.getElementById('Line_Controls_Chart'));
	
					window.addEventListener('resize', function() {
						dashboard.draw(data);
						//추가
					}, false); //화면 크기에 따라 그래프 크기 변경
					dashboard.bind([ control ], [ chart ]);
					dashboard.draw(data);
				}
				google.charts.setOnLoadCallback(drawDashboard);
			}
		}
	
		//test
		var chartDrowFun2 = {
			//방문자
			chartDrow : function() {
				var chartData = '';
				//날짜형식 변경
				//var chartDateformat = 'yyyy년MM월dd일HH시';
				var chartDateformat = 'MM월dd일';
				//라인차트의 라인 수
				var chartLineCount = 10;
				//컨트롤러 바 차트의 라인 수
				var controlLineCount = 10;
				
				function drawDashboard() {
					var data = new google.visualization.DataTable();
					data.addColumn('datetime', '날짜');
					var visit = data.addColumn('number', '회원가입수');
					var dataRow = [];
					
					var array = new Array();
					<c:forEach items="${chart2}" var="list">
						var json = new Object();
						json.joinCnt = "${list.joinCnt}";
						json.memberJoinDate = "${list.joinTimeString}";
						array.push(json);
					</c:forEach>
	
					var date = new Date();
					var thisMonth = (date.getMonth()+1).toString();
					var firstDayOfMonth = new Date( date.getFullYear(), date.getMonth() , 1 );
					var lastMonth = new Date ( firstDayOfMonth.setDate( firstDayOfMonth.getDate() - 1 ) );
					var lastMonthNum = (lastMonth.getMonth()+1).toString();
					
					for (var i = 1; i <= 30; i++) {
						var check = false;
						// 방문자 
						for (var j = 0; j < array.length; j++) {
							if (Number(array[j].memberJoinDate.substring(6) == i)) {
								dataRow = [ new Date('2020', lastMonthNum, i, thisMonth),
								Number(array[j].joinCnt) ]; 
								data.addRow(dataRow);
								check = true;
							}
						}
						if (check) {
							continue;
						}
						//그래프에 추가 시작 값
						dataRow = [ new Date('2020', lastMonthNum, i, thisMonth), 0 ]; 
						data.addRow(dataRow);
					}
	
					var chart = new google.visualization.ChartWrapper({
						// 포인트가 오른쪽으로 밀림
						chartType : 'LineChart',
						containerId : 'lineChartArea2', //라인 차트 생성할 영역
						options : {
							isStacked : 'percent',
							focusTarget : 'category',
							height : 100,
							width : 300,
							//각각의 위치 지정
							legend : {
								position : "top",
								textStyle : {
									fontSize : 13
								}
							},
							series : {
								0 : {
									color : '#ef962d'
								}
							},
							pointSize : 3,
							pointShape : 'star',
							tooltip : {
								textStyle : {
									fontSize : 12
								},
								showColorCode : true,
								trigger : 'both'
							},
	
							//x축
							hAxis : {
								format : chartDateformat, //var chartDateformat = 'yyyy년MM월dd일';
								gridlines : {
									count : chartLineCount,
									units : {
										/* years : {
											format : [ 'yyyy년' ]
										}, */
										months : {
											format : [ 'MM월' ]
										},
										days : {
											format : [ 'dd일' ]
										},
									/* 	hours : {
											format : [ 'HH시' ]
										} */
									}
								},
								textStyle : {
									fontSize : 12
								}
							},
	
							//y축
							vAxis : {
								minValue : 5, //데이터에 따라서 값 변화 
								viewWindow : {
									min : 0
								},
								gridlines : {
									count : -1
								},
								textStyle : {
									fontSize : 12
								}
							},
							animation : {
								startup : true,
								duration : 1000,
								easing : 'in'
							},
							annotations : {
								pattern : chartDateformat,
								textStyle : {
									fontSize : 15,
									bold : true,
									italic : true,
									color : '#871b47',
									auraColor : '#d799ae',
									opacity : 0.8,
									pattern : chartDateformat
								}
							}
						}
					});
	
					var control = new google.visualization.ControlWrapper({
						controlType : 'ChartRangeFilter',
						containerId : 'controlsArea2', //control bar를 생성할 영역
						options : {
							ui : {
								chartType : 'LineChart',
								chartOptions : {
									 chartArea : {
										'width' : 100,
										'height' : 300
									}, 
									series : {
										0 : {
											color : '#e2431e'
										}
									},
									hAxis : {
										'baselineColor' : 'none',
										format : chartDateformat,
										textStyle : {
											fontSize : 12
										},
										gridlines : {
											count : controlLineCount,
											units : {
												years : {
													format : [ 'yyyy년' ]
												},
												months : {
													format : [ 'MM월' ]
												},
												days : {
													format : [ 'dd일' ]
												},
											/* 	hours : {
													format : [ 'HH시' ]
												} */
											}
										}
									}
								}
							},
							filterColumnIndex : 0
						}
					});
	
					var date_formatter = new google.visualization.DateFormat({
						pattern : chartDateformat
					});
					date_formatter.format(data, 0);
	
					var dashboard = new google.visualization.Dashboard(document
							.getElementById('Line_Controls_Chart2'));
	
					window.addEventListener('resize', function() {
						dashboard.draw(data);
						//추가
					}, false); //화면 크기에 따라 그래프 크기 변경
					dashboard.bind([ control ], [ chart ]);
					dashboard.draw(data);
				}
				google.charts.setOnLoadCallback(drawDashboard);
			}
		}
	
		$(document).ready(function() {
			google.charts.load('current', {
				'packages' : [ 'line', 'controls' ]
			});
			
			//방문자수 그래프
			chartDrowFun.chartDrow(); //chartDrow() 실행
	
			//회원가입 그래프
			chartDrowFun2.chartDrow(); 
		});
	</script>