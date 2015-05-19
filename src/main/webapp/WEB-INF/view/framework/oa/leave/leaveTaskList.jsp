<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/taglib/common.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/view/taglib/header.jsp" %>
</head>

<body class="page-body">
<div id="jsAutoHeight" class="scrollable" data-max-height="600">
	<div class="page-container" class="scrollable" data-max-height="400"><!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->
		<div class="main-content">
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<script type="text/javascript">
							jQuery(document).ready(function($) {
								$("#jsAutoHeight").attr("data-max-height", $(window).height());
								$("#dataList").dataTable({
									dom: "<'toolbar'>rtip",
									"language": {
     			       					"url": "${ctx_assets}/js/datatables/zh_CN.txt"
      			  					},
     					   			"iDisplayLength" : 10
								});
							});
							</script>
				
				<table class="table table-bordered table-striped" id="dataList">
					<thead>
						<tr>
							<th>假种</th>
							<th>申请人</th>
							<th>申请时间</th>
							<th>开始时间</th>
							<th>结束时间</th>
							<th>当前节点</th>
							<!--
							<th>任务创建时间</th>
							<th>流程状态</th>
							-->
							<th>操作</th>
						</tr>
					</thead>
					<tbody class="middle-align">
						<c:forEach items="${leaveList}" var="leave">
						<c:set var="task" value="${leave.task}" />
						<c:set var="pi" value="${leave.processInstance}" />
						<tr id="${leave.id }" tid="${task.id}">
							<td>${leave.leaveType}</td>
							<td>${leave.createUser.name}</td>
							<td><fmt:formatDate value="${leave.createDate}" type="both"/></td>
							<td><fmt:formatDate value="${leave.startTime}" type="both"/></td>
							<td><fmt:formatDate value="${leave.endTime}" type="both"/></td>
							<td>${task.name}</td>
							<!--
							<td><fmt:formatDate value="${task.createTime}" type="both"/></td>
							<td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${leave.processDefinition.version}</b></td>
							-->
							<td>
								<a target="_blank" href="${ctx}/act/task/trace/photo/${task.processDefinitionId}/${task.executionId}">跟踪</a>
								<c:if test="${empty task.assignee}">
									<a class="claim" href="#" onclick="javescript:claim('${task.id}');">签收</a>
								</c:if>
								<c:if test="${not empty task.assignee}">
									<%-- 此处用tkey记录当前节点的名称 --%>
									<a class="handle" href="#" data-pdid="${task.processDefinitionId}" data-tkey="${task.taskDefinitionKey}" data-tname="${task.name}"  data-id="${leave.id}"  data-tid="${task.id}">办理</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
						</div>					
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#sboxit-1").selectBoxIt().on('open', function() {
				$(this).data('selectBoxSelectBoxIt').list.perfectScrollbar();
			});
			$(".handle").click(function(){
				var obj = $(this);
				var taskId = obj.data("tid");
				var leaveId = obj.data("id");
				var processDefinitionId = obj.data("pdid");
				var tkey=obj.data("tkey");
				//jQuery("#"+tkey+"Win").modal("show", {backdrop: "static"});
				window.location.href = "${ctx}/oa/leave/form.do?id="+leaveId+"&pdid="+processDefinitionId+"&tdkey="+tkey;
			});
		});
		
		/**
		 * 签收任务
		 * @param {Object} taskId
		 */
		function claim(taskId) {
			$.get('${ctx}/act/task/claim' ,{taskId: taskId}, function(data) {
	        	toastr.info("签收成功！");
	        	location.reload();
		    });
		}
	</script>
	<%@ include file="/WEB-INF/view/taglib/footer.jsp" %>
	<%@ include file="/WEB-INF/view/taglib/datatables.jsp" %>
	<script src="${ctx_assets}/js/rwd-table/js/rwd-table.min.js"></script>
	<%@ include file="/WEB-INF/view/taglib/dataform.jsp" %>
</body>
</html>
