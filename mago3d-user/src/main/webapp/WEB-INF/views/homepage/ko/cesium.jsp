<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<!-- <meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
	<meta http-equiv="Pragma" content="no-cache"/> -->
	<title>demo | mago3D User</title>
	<link rel="stylesheet" href="/css/${lang}/style.css?currentTime=${currentTime}" />
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css?currentTime=${currentTime}" />
	<link rel="stylesheet" href="/externlib/${lang}/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-toast/jquery.toast.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-toast/jquery.toast.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<div class="trigger" >
		<button type="button"></button>
		<ul>
			<li><a href="/homepage/index.do">Home</a></li>
			<li><a href="/homepage/about.do">Mago3D</a></li>	
			<li><a href="/homepage/download.do">Download</a></li>
			<li><a href="/homepage/docs.do">Documentation</a></li>
		</ul>
	</div>
	<div class="ctrl">
		<div>
			<button id="issueEnable">Issue 등록</button>
			<button id="objectInfoEnable">Object 정보</button>	
			<button id="issuesEnable">Issues 표시</button>
			<input type="hidden" id="now_latitude" name="now_latitude" value="${now_latitude }" />
			<input type="hidden" id="now_longitude" name="now_longitude" value="${now_longitude }"  />
		</div>
		<ul class="tab">
			<li id="issueMoreImage">My Issue</li>
			<li id="apiMoreImage">API목록</li>
		</ul>
		<ul id="recentIssueListContent" class="issue" style="display: none">
<c:if test="${empty issueList }">
			<li style="text-align: center; padding-top:20px; height: 50px;">
				Issue가 존재하지 않습니다.
			</li>
</c:if>
<c:if test="${!empty issueList }">
	<c:set var="issueTypeCss" value="i1" />
	<c:set var="issuePriorityCss" value="t1" />
	<c:forEach var="issue" items="${issueList}" varStatus="status">
		<c:if test="${issue.issue_type eq 'BUGGER'}">
			<c:set var="issueTypeCss" value="i1" />
		</c:if>
		<c:if test="${issue.issue_type eq 'IMPROVE'}">
			<c:set var="issueTypeCss" value="i2" />
		</c:if>
		<c:if test="${issue.issue_type eq 'NEW'}">
			<c:set var="issueTypeCss" value="i3" />
		</c:if>
		<c:if test="${issue.issue_type eq 'ETC'}">
			<c:set var="issueTypeCss" value="i4" />
		</c:if>
		<c:if test="${issue.priority eq 'CRITICAL'}">
			<c:set var="issuePriorityCss" value="t1" />
		</c:if>
		<c:if test="${issue.priority eq 'MUST'}">
			<c:set var="issuePriorityCss" value="t2" />
		</c:if>
		<c:if test="${issue.priority eq 'MINOR'}">
			<c:set var="issuePriorityCss" value="t3" />
		</c:if>
		<c:if test="${issue.priority eq 'TRIVIAL'}">
			<c:set var="issuePriorityCss" value="t4" />
		</c:if>
			<li>
				<p class="title">
					${issue.title }
				</p>
				<p class="info">
					<span class="tag ${issueTypeCss }">${issue.issue_type_name }</span>
					<span class="tag ${issuePriorityCss }">${issue.priority_name }</span>
					<span>[${issue.data_group_name }]</span>
					<button type="button" title="바로가기" onclick="flyTo('${issue.issue_id}', '${issue.issue_type}', '${issue.longitude}', '${issue.latitude}', '${issue.height}', '2')">바로가기</button>
					<span class="date">${issue.viewInsertDate }</span>
				</p>
			</li>
	</c:forEach>
</c:if>
		</ul>

		<div id="apiListContent" style="display: none">
			<div style="height: 20px;"></div>
			<div>
				<span style="padding-left: 10px; padding-right: 100px;">Data Key</span>
				<input type="text" id="search_data_key" name="search_data_key" size="15" />
				<button type="button" id="searchData" style="width: 50px; background: #727272; font-size: 1.2rem;">검색</button>
			</div>
			<div style="margin-top: 15px;">
				<span style="padding-left: 10px; padding-right: 70px;">Bounding Box</span>
				<input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" />
				<label for="showBoundingBox"> 표시 </label>
				<input type="radio" id="hideBoundingBox" name="boundingBox" value="false" onclick="changeBoundingBox(false);"/>
				<label for="hideBoundingBox"> 비표시 </label>
			</div>
			<div style="margin-top: 15px;">
				<span style="padding-left: 10px; padding-right: 16px;">Selecting And Moving</span>
				<input type="radio" id="mouseNoneMove" name="mouseMoveMode" value="2" onclick="changeMouseMove('2');"/>
				<label for="mouseNoneMove"> None </label>
				<input type="radio" id="mouseAllMove" name="mouseMoveMode" value="0" onclick="changeMouseMove('0');"/>
				<label for="mouseAllMove"> ALL </label>
				<input type="radio" id="mouseObjectMove" name="mouseMoveMode" value="1" onclick="changeMouseMove('1');"/>
				<label for="mouseObjectMove"> Object </label>
			</div>
			<div style="margin-top: 15px;">
				<div style="padding-left: 10px;">
					Location And Rotation
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 102px; padding-right: 12px;">
						<label for="move_data_key">Data Key</label>
						<input type="text" id="move_data_key" name="move_data_key" size="15" />
					</span>
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_latitude">위도 </label>
						<input type="text" id="move_latitude" name="move_latitude" size="15"/> 
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_longitude">경도 </label>
						<input type="text" id="move_longitude" name="move_longitude" size="15"/>
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_height">높이 </label>
						<input type="text" id="move_height" name="move_height" size="15" />
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 97px; padding-right: 12px;">
						<label for="move_heading">HEADING </label>
						<input type="text" id="move_heading" name="move_heading" size="15" />
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_pitch">PITCH </label>
						<input type="text" id="move_pitch" name="move_pitch" size="15" />
					</span>
				</div> 
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_roll">ROLL </label>
						<input type="text" id="move_roll" name="move_roll" size="15" /> 
						<button type="button" id="changeLocationAndRotationAPI">변환</button>
					</span>
				</div>
			</div>
			<div style="height: 20px;"></div>
		</div>
	</div>
		
	<div class="shortcut" style="top:60px;">
		<p>바로가기</p>
		<ul>
<c:forEach var="dataGroup" items="${projectDataGroupList}" varStatus="status">
			<li onclick="flyTo(null, null, '${dataGroup.longitude}', '${dataGroup.latitude}', '${dataGroup.height}', '${dataGroup.duration}')">${dataGroup.data_group_name }</li>
</c:forEach>
		</ul>
	</div>	

	<!-- 맵영역 -->
	<div id="magoContainer" style="position: absolute; width: 100%; height: 100%; margin-top: 0; padding: 0; overflow: hidden;"></div>

	<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
	<div id="inputIssueLayer" style="display: none; top:40%; left:45%; width:450px; margin:-250px 0 0 -150px; " class="layer">
	    <div class="layerHeader">
	        <h2>Issue Register</h2>
	        <div>
	            <button id="inputIssueClose" type="button" title="닫기">닫기</button>
	        </div>
	    </div>
	    <div class="layerContents">
	        <table>
	        	<tr>
	        		<th style="width: 120px;">
	        			<form:label path="data_group_id">데이터 그룹</form:label>
	        			<span class="icon-glyph glyph-emark-dot color-warning"></span>
	        		</th>
	        		<td>
	        			<form:select path="data_group_id" cssClass="select">
<c:forEach var="dataGroup" items="${projectDataGroupList}">
							<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name}</option>
</c:forEach>
						</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>
	        			<form:label path="issue_type">Issue Type</form:label>
	        		</th>
	        		<td>
	        			<form:select path="issue_type" cssClass="select">
<c:forEach var="commonCode" items="${issueTypeList}">
							<option value="${commonCode.code_value}">${commonCode.code_name}</option>
</c:forEach>
						</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>
	        			<form:label path="data_key">Data Key</form:label>
	        			<span class="icon-glyph glyph-emark-dot color-warning"></span>
	        		</th>
	        		<td><form:input path="data_key" cssClass="ml" />
						<form:errors path="data_key" cssClass="error" />
						<form:hidden path="latitude"/>
						<form:hidden path="longitude"/>
						<form:hidden path="height"/>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>
	        			<form:label path="title">제목</form:label>
	        			<span class="icon-glyph glyph-emark-dot color-warning"></span>
	        		</th>
	        		<td><form:input path="title" cssClass="ml" />
						<form:errors path="title" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="priority">Issue Priority</form:label></th>
	        		<td>
	        			<form:select path="priority" cssClass="select">
<c:forEach var="commonCode" items="${issuePriorityList}">
							<option value="${commonCode.code_value}">${commonCode.code_name}</option>
</c:forEach>
						</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="due_day">마감일</form:label></th>
	        		<td><form:hidden path="due_date" />
						<input type="text" id="due_day" name="due_day" placeholder="0000-00-00" size="7" maxlength="10" />
						일&nbsp;&nbsp;
						<input type="text" id="due_hour" name="due_hour" placeholder="00" size="2" maxlength="2" /> :
						<input type="text" id="due_minute" name="due_minute" placeholder="00" size="2" maxlength="2" />
						분
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="assignee">Assignee</form:label></th>
	        		<td><form:input path="assignee" cssClass="m" placeholder="대리자" />
						<form:errors path="assignee" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="reporter">reporter</form:label></th>
	        		<td><form:input path="reporter" cssClass="m" placeholder="보고 해야 하는 사람" />
						<form:errors path="reporter" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr style="height: 50px;">
	        		<th><form:label path="contents">내용</form:label></th>
	        		<td>
	        			<form:textarea path="contents" />
						<form:errors path="contents" cssClass="error" />
	        		</td>
				</tr>
	        </table>
	        
	      	<div class="btns">
	 			<button id="issueInsertButton">Save</button>
			</div>
	    </div>
	</div>
	</form:form>
	
	<ul class="controlStick">
		<li>
			<span id="moveForwardImage"><img src="/images/${lang}/plus.png" alt="plus" /></span>
			<span id="moveRightImage"><img src="/images/${lang}/rotate_right.png" alt="rotate right" /></span>
			<span id="moveUpImage"><img src="/images/${lang}/pitch_up.png" alt="plus" /></span>
		</li>
		<li>
			<span id="moveBackwardImage"><img src="/images/${lang}/minus.png" alt="minus" /></span>
			<span id="moveLeftImage"><img src="/images/${lang}/rotate_left.png" alt="rotate left" /></span>
			<span id="moveDownImage"><img src="/images/${lang}/pitch_down.png" alt="down" /></span>
		</li>
	</ul>

<script type="text/javascript" src="/externlib/${lang}/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d.js?currentTime=${currentTime}"></script>
<script>
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('chrome') < 0) { 
		alert("이 데모 페이지는 대용량 웹 데이터 처리를 위해 Chrome 브라우저에 최적화 되어 있습니다. \n원활한 서비스 이용을 위해 Chrome 브라우저를 이용  하시기 바랍니다.");
	}

	var policyJson = ${policyJson};
	var dataGroupMap = ${dataGroupMap};
	var insertIssueFlag = false;
	var objectInfoViewFlag = false;
	var listIssueFlag = false;
	var imagePath = "/images/${lang}";
	var managerFactory = new ManagerFactory(null, "magoContainer", policyJson, dataGroupMap, imagePath);
	
	$(document).ready(function() {
		$("#due_day").datepicker({ 
			dateFormat : "yy-mm-dd",
			dayNames : [ "일", "월", "화", "수", "목", "금", "토" ],
			dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
			dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
			monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			prevText : "",
			nextText : "",
			showMonthAfterYear : true,
			yearSuffix : "년"
		});
		
		//$("#recentIssueListContent").show();
		
		// BoundingBox
		changeBoundingBox(false);
		// Selecting And Moving
		changeMouseMove("2");
	});
	$("#issueMoreImage").click(function() {
		if($("#recentIssueListContent").css("display") == "none") {
			$("#issueMoreImage").addClass("on");
			$("#apiMoreImage").removeClass("on");
			$("#recentIssueListContent").show();
			$("#apiListContent").hide();
		} else {
			$("#issueMoreImage").removeClass("on");
			$("#recentIssueListContent").hide();
		}
	});
	$("#apiMoreImage").click(function() {
		if($("#apiListContent").css("display") == "none") {
			$("#apiMoreImage").addClass("on");
			$("#issueMoreImage").removeClass("on");
			$("#apiListContent").show();
			$("#recentIssueListContent").hide();
		} else {
			$("#apiMoreImage").removeClass("on");
			$("#apiListContent").hide();
		}
	});
	
	function flyTo(issueId, issueType, longitude, latitude, height, duration) {
		managerFactory.flyTo(issueId, issueType, longitude, latitude, height, duration);
		// 현재 좌표를 저장
		$("#now_latitude").val(latitude);
		$("#now_longitude").val(longitude);
	}
	
	// 이슈 등록
	$("#issueEnable").click(function() {
		if(insertIssueFlag) {
			insertIssueFlag = false;
			$("#issueEnable").removeClass("on");
		} else {
			insertIssueFlag = true;
			$("#issueEnable").addClass("on");
		}
		changeInsertIssueModeAPI(insertIssueFlag);
	});
	// object info 표시
	$("#objectInfoEnable").click(function() {
		if(objectInfoViewFlag) {
			objectInfoViewFlag = false;
			$("#objectInfoEnable").removeClass("on");
		} else {
			objectInfoViewFlag = true;
			$("#objectInfoEnable").addClass("on");			
		}
		changeObjectInfoViewModeAPI(objectInfoViewFlag);
	});
	// issue list 표시
	$("#issuesEnable").click(function() {
		if(listIssueFlag) {
			listIssueFlag = false;
			$("#issuesEnable").removeClass("on");
		} else {
			listIssueFlag = true;
			$("#issuesEnable").addClass("on");
			
			// 현재 위치의 latitude, logitude를 가지고 가장 가까이에 있는 데이터 그룹에 속하는 이슈 목록을 최대 100건 받아서 표시
			var now_latitude = $("#now_latitude").val();
			var now_longitude = $("#now_longitude").val();
			var info = "latitude=" + now_latitude + "&longitude=" + now_longitude;		
			$.ajax({
				url: "/issue/ajax-list-issue-by-geo.do",
				type: "GET",
				data: info,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						var issueList = msg.issueList;
						if(issueList != null && issueList.length > 0) {
							for(i=0; i<issueList.length; i++ ) {
								var issue = issueList[i];
								drawInsertIssueImageAPI(0, issue.issue_id, issue.issue_type, issue.data_key, issue.latitude, issue.longitude, issue.height);
							}
						}
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
				},
				error:function(request,status,error){
			        //alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
		changeListIssueViewModeAPI(listIssueFlag);
	});
	
	// issue input layer call back function
	function showInsertIssueLayer(data_name, data_key, latitude, longitude, height) {
		if(insertIssueFlag) {
			if($("#inputIssueLayer").css("display") == "none") {
				$("#inputIssueLayer").show();
				
				$("#data_key").val(data_name);
				$("#latitude").val(latitude);
				$("#longitude").val(longitude);
				$("#height").val(height);
				
				// 현재 좌표를 저장
				$("#now_latitude").val(latitude);
				$("#now_longitude").val(longitude);
			}
		}
	}
	
	function check() {
		if ($("#data_key").val() == "") {
			alert(JS_MESSAGE["issue.datakey.empty"]);
			$("#data_key").focus();
			return false;
		}
		if ($("#title").val() == "") {
			alert(JS_MESSAGE["issue.title.empty"]);
			$("#title").focus();
			return false;
		}
		/* if ($("#assignee").val() == "") {
			alert(JS_MESSAGE["issue.assignee.empty"]);
			$("#assignee").focus();
			return false;
		}
		if ($("#reporter").val() == "") {
			alert(JS_MESSAGE["issue.reporter.empty"]);
			$("#reporter").focus();
			return false;
		} */
		if ($("#contents").val() == "") {
			alert(JS_MESSAGE["issue.contents.empty"]);
			$("#contents").focus();
			return false;
		}
		/* if ($("#due_day").val() != null && $("#due_time").val() != null) {
			$("#due_date").val($("#due_day").val() + $("#due_time").val());
			return false;
		} */
	}
	
	var isInsertIssue = true;
	$("#issueInsertButton").click(function() {
		if (check() == false) {
			return false;
		}
		if(isInsertIssue) {
			isInsertIssue = false;
			var info = $("#issue").serialize();		
			$.ajax({
				url: "/issue/ajax-insert-issue.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						// pin image를 그림
						drawInsertIssueImageAPI(1, msg.issue.issue_id, msg.issue.issue_type, $("#data_key").val(), $("#latitude").val(), $("#longitude").val(), $("#height").val());
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					
					$("#inputIssueLayer").hide();
					isInsertIssue = true;
					ajaxIssueList();
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        isInsertIssue = true;
				}
			});
			
			changeInsertIssueStateAPI(0);
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	
	$("#inputIssueClose").click(function() {
		$("#inputIssueLayer").hide();
		changeInsertIssueStateAPI(0);
	});
	
	// object 정보 표시 call back function
	function showSelectedObject(projectId, blockId, objectId, latitude, longitude, height, heading, pitch, roll){
		if(objectInfoViewFlag) {
			$("#move_data_key").val(projectId + "_" + blockId);
			$("#move_latitude").val(latitude);
			$("#move_longitude").val(longitude);
			$("#move_height").val(height);
			$("#move_heading").val(heading);
			$("#move_pitch").val(pitch);
			$("#move_roll").val(roll);
			
			$.toast({
			    heading: 'Click Object Info',
			    text: [
			        'projectId : ' + projectId, 
			        'blockId : ' + blockId, 
			        'objectId : ' + objectId,
			        'latitude : ' + latitude,
			        'longitude : ' + longitude,
			        'height : ' + height,
			        'heading : ' + heading,
			        'pitch : ' + pitch,
			        'roll : ' + roll
			    ],
				//bgColor : 'blue',
				hideAfter: 5000,
				icon: 'info'
			});
			
			// 현재 좌표를 저장
			$("#now_latitude").val(latitude);
			$("#now_longitude").val(longitude);
		}
	}
	
	// Data 검색
	$("#searchData").click(function() {
		if ($.trim($("#search_data_key").val()) === ""){
			alert("Data Key를 입력해 주세요.");
			$("#search_data_key").focus();
			return false;
		}
		searchDataAPI($("#search_data_key").val());
	});
	// boundingBox 표시/비표시
	function changeBoundingBox(isShow) {
		$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true);
		changeBoundingBoxAPI(isShow);
	}
	// 마우스 클릭 객체 이동 모드 변경
	function changeMouseMove(mouseMoveMode) {
		$("input:radio[name='mouseMoveMode']:radio[value='" + mouseMoveMode + "']").prop("checked", true);
		changeMouseMoveAPI(mouseMoveMode);
	}
	// 변환행렬
	$("#changeLocationAndRotationAPI").click(function() {
		if(!changeLocationAndRotationCheck()) return false;
		changeLocationAndRotationAPI(	$("#move_data_key").val(), $("#move_latitude").val(), $("#move_longitude").val(), 
										$("#move_height").val(), $("#move_heading").val(), $("#move_pitch").val(), $("#move_roll").val());
	});
	function changeLocationAndRotationCheck() {
		if ($.trim($("#move_data_key").val()) === ""){
			alert("Data Key를 입력해 주세요.");
			$("#move_data_key").focus();
			return false;
		}
		if ($.trim($("#move_latitude").val()) === ""){
			alert("위도를 입력해 주세요.");
			$("#move_latitude").focus();
			return false;
		}
		if ($.trim($("#move_longitude").val()) === ""){
			alert("경도를 입력해 주세요.");
			$("#move_longitude").focus();
			return false;
		}
		if ($.trim($("#move_height").val()) === ""){
			alert("높이를 입력해 주세요.");
			$("#move_height").focus();
			return false;
		}
		if ($.trim($("#move_heading").val()) === ""){
			alert("heading을 입력해 주세요.");
			$("#move_heading").focus();
			return false;
		}
		if ($.trim($("#move_pitch").val()) === ""){
			alert("pitch를 입력해 주세요.");
			$("#move_pitch").focus();
			return false;
		}
		if ($.trim($("#move_roll").val()) === ""){
			alert("roll를 입력해 주세요.");
			$("#move_roll").focus();
			return false;
		}
		return true;
	}
	
	// TODO issue url 밑에 있어야 할지도 모르겠다.
	function ajaxIssueList() {
		var info = "";		
		$.ajax({
			url: "/homepage/ajax-list-issue.do",
			type: "GET",
			data: info,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var issueList = msg.issueList;
					var content = "";
					
					if(issueList == null || issueList.length == 0) {
						content += 	"<li style=\"text-align: center; padding-top:20px; height: 50px;\">"
								+	"	Issue가 존재하지 않습니다."
								+	"</li>";
					} else {
						for(i=0; i<issueList.length; i++ ) {
							var issue = issueList[i];
							var issueTypeCss = "i1";
							var issuePriorityCss = "t1";
							if(issue.issue_type == "BUGGER") {
								issueTypeCss = "i1";
							} else if(issue.issue_type == "IMPROVE") {
								issueTypeCss = "i2";
							} else if(issue.issue_type == "NEW") {
								issueTypeCss = "i3";
							} else if(issue.issue_type == "ETC") {
								issueTypeCss = "i4";
							}
							
							if(issue.priority == "CRITICAL") {
								issuePriorityCss = "t1";
							} else if(issue.priority == "MUST") {
								issuePriorityCss = "t2";
							} else if(issue.priority == "MINOR") {
								issuePriorityCss = "t3";
							} else if(issue.priority == "TRIVIAL") {
								issuePriorityCss = "t4";
							}
							
							content = content 
								+ 	"<li>"
								+ 	"	<p class=\"title\">" + issue.title  + "</p>"
								+ 	"	<p class=\"info\">"
								+ 	"		<span class=\"tag " + issueTypeCss + "\">" + issue.issue_type_name + "</span>"
								+ 	"		<span class=\"tag " + issuePriorityCss + "\">" + issue.priority_name + "</span>"
								+ 	"		<span>[" + issue.data_group_name + "]</span>"
								+ 	"		<button type=\"button\" title=\"바로가기\""
								+				"onclick=\"flyTo('" + issue.issue_id + "', '" + issue.issue_type + "', '" 
								+ 				issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">바로가기</button>"
								+ 	"		<span class=\"date\">" + issue.insert_date.substring(0,19) + "</span>"
								+	"	</p>"
								+ 	"</li>";
						}
					}
					$("#recentIssueListContent").empty();
					$("#recentIssueListContent").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error){
		        //alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	$("#moveForwardImage").click(function() {
		mouseMoveAPI("moveForward");
	});
	$("#moveBackwardImage").click(function() {
		mouseMoveAPI("moveBackward");
	});
	$("#moveRightImage").click(function() {
		mouseMoveAPI("moveRight");
	});
	$("#moveLeftImage").click(function() {
		mouseMoveAPI("moveLeft");
	});
	$("#moveUpImage").click(function() {
		mouseMoveAPI("moveUp");
	});
	$("#moveDownImage").click(function() {
		mouseMoveAPI("moveDown");
	});
</script>
</body>
</html>