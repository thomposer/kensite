<%@ page import="com.seeyoui.kensite.common.constants.StringConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/taglib/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>    
    <title>数据建模</title>
	<%@ include file="/WEB-INF/view/taglib/header.jsp" %>
	<%@ include file="/WEB-INF/view/taglib/easyui.jsp" %>
	<%@ include file="/WEB-INF/view/taglib/layer.jsp" %>
  </head>
  <body style="overflow:hidden">
 	<div style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;">
		<div style="position:absolute;top:0px;bottom:0px;width:450px;">
		    <table id="dataList" title="数据表" class="easyui-datagrid" style="width:100%;height:100%"
		    		url="${ctx}/sys/table/getListData.do"
		            toolbar="#toolbar" pagination="true"
		            rownumbers="true" fitColumns="true" singleSelect="false">
		        <thead>
		            <tr>
					    <th field="id" width="100px" hidden>主键</th>
					    <th field="name" width="100px">名称</th>
					    <th field="comments" width="100px">描述</th>
					    <th field="parentTable" width="100px" hidden>关联父表</th>
					    <th field="parentTableFk" width="100px" hidden>关联父表外键</th>
		            </tr>
		        </thead>
		    </table>
		    <div id="toolbar">
		    	<shiro:hasPermission name="sys:table:insert">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newInfo()">新建</a>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="sys:table:update">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editInfo()">修改</a>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="sys:table:delete">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyInfo()">删除</a>
		        </shiro:hasPermission>
		        <br/>
				名称<input id="sel_name" name="sel_name" class="easyui-textbox" data-options=""/>
				描述<input id="sel_comments" name="sel_comments" class="easyui-textbox" data-options=""/>
			    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="selectData()">查询</a>
		    </div>
	    </div>
		<div style="position:absolute;top:0px;right:0px;left:450px;bottom:0px;">
		    <table id="dataSubList" title="数据列" class="easyui-datagrid" style="width:100%;height:100%"
		            toolbar="#subtoolbar" pagination="true"
		            rownumbers="true" fitColumns="false" singleSelect="true">
		        <thead>
		            <tr>
					    <th field="id" width="100px" hidden>主键</th>
					    <th field="tableName" width="100px" hidden>业务表</th>
					    <th field="name" width="100px">列名</th>
					    <th field="comments" width="100px">注释</th>
					    <th field="jdbcType" width="60px">类型</th>
					    <th field="isPk" width="60px" formatter="formatNullable">是否主键</th>
					    <th field="isNull" width="60px" formatter="formatNullable">是否为空</th>
					    <th field="isInsert" width="60px" formatter="formatNullable">是否插入</th>
					    <th field="isEdit" width="60px" formatter="formatNullable">是否编辑</th>
					    <th field="isList" width="60px" formatter="formatNullable">是否列表</th>
					    <th field="isQuery" width="60px" formatter="formatNullable">是否查询</th>
					    <th field="queryType" width="60px" hidden>查询方式</th>
					    <th field="category" width="100px" hidden>生成方案</th>
					    <th field="sortType" width="100px" hidden>排序（升序）</th>
					    <th field="defaultValue" width="100px" hidden>默认值</th>
					    <th field="validType" width="100px" hidden>校验类型</th>
					    <th field="settings" width="100px" hidden>扩展设置</th>
		            </tr>
		        </thead>
		    </table>
		    <div id="subtoolbar">
		    	<shiro:hasPermission name="sys:tableColumn:insert">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newSubInfo()">新建</a>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="sys:tableColumn:update">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editSubInfo()">修改</a>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="sys:tableColumn:delete">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroySubInfo()">删除</a>
		        </shiro:hasPermission>
		        <br/>
				列名<input id="sel_name" name="sel_name" class="easyui-textbox" data-options=""/>
				注释<input id="sel_comments" name="sel_comments" class="easyui-textbox" data-options=""/>
				类型<input id="sel_jdbcType" name="sel_jdbcType" class="easyui-textbox" data-options=""/>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="selectSubData()">查询</a>
		    </div>
	    </div>
    </div>
    <div id="dataWin" class="easyui-window" title="业务表信息维护" data-options="modal:true,closed:true,iconCls:'icon-save',resizable:false" style="width:400px;height:260px;padding:10px;">
        <div class="ftitle">业务表信息维护</div>
        <form id="dataForm" method="post">
					<div class="fitem">
		                <label>名称</label>
		                <input id="name" name="name" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-name" class="err-msg"></span>
		            </div>
					<div class="fitem">
		                <label>描述</label>
		                <input id="comments" name="comments" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-comments" class="err-msg"></span>
		            </div>
					<div class="fitem">
		                <label>关联父表</label>
		                <input id="parentTable" name="parentTable" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-parenttable" class="err-msg"></span>
		            </div>
					<div class="fitem">
		                <label>关联父表外键</label>
		                <input id="parentTableFk" name="parentTableFk" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-parenttablefk" class="err-msg"></span>
		            </div>
		</form>
		
	    <div id="dataWin-buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveInfo()" style="width:90px">保存</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dataWin').window('close')" style="width:90px">取消</a>
	    </div>
    </div>
    <div id="dataSubWin" class="easyui-window" title="业务表字段信息维护" data-options="modal:true,closed:true,iconCls:'icon-save',resizable:false" style="width:800px;height:260px;padding:10px;">
        <div class="ftitle">业务表字段信息维护</div>
        <form id="dataSubForm" method="post">
					<div class="fitem">
		                <label>列名</label>
		                <input id="name" name="name" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-name" class="err-msg"></span>
		                <label>注释</label>
		                <input id="comments" name="comments" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-comments" class="err-msg"></span>
		                <label>类型</label>
		                <input id="jdbcType" name="jdbcType" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-jdbctype" class="err-msg"></span>
		            </div>
					<div class="fitem">
		                <label>是否主键</label>
		                <input id="isPk" name="isPk" class="easyui-combobox" data-options="panelHeight: 'auto',required:true,valueField: 'value',textField: 'text'"/>
		                <span id="msg-ispk" class="err-msg"></span>
		                <label>是否为空</label>
		                <input id="isNull" name="isNull" class="easyui-combobox" data-options="panelHeight: 'auto',required:true,valueField: 'value',textField: 'text'"/>
		                <span id="msg-isnull" class="err-msg"></span>
		                <label>是否插入</label>
		                <input id="isInsert" name="isInsert" class="easyui-combobox" data-options="panelHeight: 'auto',required:true,valueField: 'value',textField: 'text'"/>
		                <span id="msg-isinsert" class="err-msg"></span>
		            </div>
					<div class="fitem">
		                <label>是否编辑</label>
		                <input id="isEdit" name="isEdit" class="easyui-combobox" data-options="panelHeight: 'auto',required:true,valueField: 'value',textField: 'text'"/>
		                <span id="msg-isedit" class="err-msg"></span>
		                <label>是否列表</label>
		                <input id="isList" name="isList" class="easyui-combobox" data-options="panelHeight: 'auto',required:true,valueField: 'value',textField: 'text'"/>
		                <span id="msg-islist" class="err-msg"></span>
		                <label>是否查询</label>
		                <input id="isQuery" name="isQuery" class="easyui-combobox" data-options="panelHeight: 'auto',required:true,valueField: 'value',textField: 'text'"/>
		                <span id="msg-isquery" class="err-msg"></span>
		            </div>
					<div class="fitem">
		                <label>查询方式</label>
		                <input id="queryType" name="queryType" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-querytype" class="err-msg"></span>
		                <label>生成方案</label>
		                <input id="category" name="category" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-category" class="err-msg"></span>
		                <label>排序（升序）</label>
		                <input id="sortType" name="sortType" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-sorttype" class="err-msg"></span>
		            </div>
					<div class="fitem">
		                <label>默认值</label>
		                <input id="defaultValue" name="defaultValue" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-defaultvalue" class="err-msg"></span>
		                <label>校验类型</label>
		                <input id="validType" name="validType" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-validtype" class="err-msg"></span>
		                <label>扩展设置</label>
		                <input id="settings" name="settings" class="easyui-validatebox textbox" data-options="required:true"/>
		                <span id="msg-settings" class="err-msg"></span>
		            </div>
		            
		            <input id="tableName" name="tableName" type="hidden"/>
		</form>
		
	    <div id="dataWin-buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveSubInfo()" style="width:90px">保存</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dataSubWin').window('close')" style="width:90px">取消</a>
	    </div>
    </div>
    <script type="text/javascript">
    var nullableJson = [{text: '是',value: 'Y'},{text: '否',value: 'N'}];
    var tableName;
    $(document).ready(function(){
		$('#isPk').combobox('loadData', nullableJson);
		$('#isNull').combobox('loadData', nullableJson);
		$('#isInsert').combobox('loadData', nullableJson);
		$('#isEdit').combobox('loadData', nullableJson);
		$('#isList').combobox('loadData', nullableJson);
		$('#isQuery').combobox('loadData', nullableJson);
    	$('#dataList').datagrid({
    		onDblClickRow: function(index,row){
				tableName = row.tableName;
				changeTabCol(row.tableName);
			}
		});
    	$('#dataSubList').datagrid('loadData',{total:0,rows:[]});
    });
    
    function changeTabCol(tableName) {
    	//清空历史查询结果
    	$('#dataSubList').datagrid('loadData',{total:0,rows:[]});
    	$('#dataSubList').datagrid({url:'${ctx}/sys/tableColumn/getListData.do?tableName='+tableName});
    }
    
    function selectData() {
    	var sel_name = $("#sel_name").val();
	    var sel_comments = $("#sel_comments").val();
    	$('#dataList').datagrid('load',{
    		name:sel_name,
		    comments:sel_comments
    	});
    }
    
    function formatNullable(val,row) {
    	if(nullableJson == null) {
    		return "";
    	}
    	for(var obj in nullableJson) {
    		if(nullableJson[obj].value == val) {
    			return nullableJson[obj].text;
    		}
    	}
    }
    
    function selectSubData() {
    	var sel_name = $("#sel_name").val();
	    var sel_comments = $("#sel_comments").val();
	    var sel_jdbcType = $("#sel_jdbcType").val();
    	$('#dataSubList').datagrid('load',{
    		name:sel_name,
		    comments:sel_comments,
		    jdbcType:sel_jdbcType
    	});
    }
    
    </script>
    
    <script type="text/javascript">
    var url;
    function newInfo(){
        cleanErrMsg();
        $('#dataForm').form('clear');
        $('#dataWin').window('open');
        url = '${ctx}/sys/table/saveByAdd.do';
    }
    function editInfo(){
        var row = $('#dataList').datagrid('getSelected');
        if (row){
        	cleanErrMsg();
            $('#dataForm').form('load',row);
            $('#dataWin').window('open');
            url = '${ctx}/sys/table/saveByUpdate.do?id='+row.id;
        }    	
    }
    var loadi;
    function saveInfo(){
        $('#dataForm').form('submit',{
            url: url,
            onSubmit: function(param){
            	if($(this).form('validate')) {
            		loadi = layer.load(2, {time: layerLoadMaxTime});
            	}
                return $(this).form('validate');
            },
            success: function(info){
                cleanErrMsg();
            	data = eval('(' + info + ')');
                if (data.success=="<%=StringConstant.TRUE%>"){
                    layer.msg("操作成功！", {offset: 'rb',icon: 6,shift: 8,time: layerMsgTime});
            		$('#dataWin').window('close'); 
            		reloadData();
                } else {
                    layer.msg("操作失败！", {offset: 'rb',icon: 5,shift: 8,time: layerMsgTime});
                    renderErrMsg(data.message);
                }
            	layer.close(loadi);
            }
        });
    }
    function destroyInfo(){
        var row = $('#dataList').datagrid('getSelected');
        if (row){
            $.messager.confirm('确认','你确定删除该记录吗？',function(r){
                if (r){
                	$.ajax({
						type: "post",
						url: '${ctx}/sys/table/delete.do',
						data: {delDataId:row.id},
						dataType: 'json',
						beforeSend: function(XMLHttpRequest){
						},
						success: function(data, textStatus){
							if (data.success=="<%=StringConstant.TRUE%>"){
		                        layer.msg("操作成功！", {offset: 'rb',icon: 6,shift: 8,time: layerMsgTime});
								reloadData();
		                    } else {
			                    layer.msg("操作失败！", {offset: 'rb',icon: 5,shift: 8,time: layerMsgTime});
		                    }
						}
					});
                }
            });
        }
    }
    </script>
    <script type="text/javascript">
    var url;
    function newSubInfo(){
        cleanErrMsg();
        $('#dataSubForm').form('clear');
        $('#dataSubWin').window('open');
        url = '${ctx}/sys/tableColumn/saveByAdd.do';
    }
    function editSubInfo(){
        var row = $('#dataSubList').datagrid('getSelected');
        if (row){
        	cleanErrMsg();
            $('#dataSubForm').form('load',row);
            $('#dataSubWin').window('open');
            url = '${ctx}/sys/tableColumn/saveByUpdate.do?id='+row.id;
        }    	
    }
    var loadi;
    function saveSubInfo(){
        $('#dataSubForm').form('submit',{
            url: url,
            onSubmit: function(param){
            	if($(this).form('validate')) {
            		loadi = layer.load(2, {time: layerLoadMaxTime});
            	}
                return $(this).form('validate');
            },
            success: function(info){
            	layer.close(loadi);
                cleanErrMsg();
            	data = eval('(' + info + ')');
                if (data.success=="<%=StringConstant.TRUE%>"){
                    layer.msg("操作成功！", {offset: 'rb',icon: 6,shift: 8,time: layerMsgTime});
            		$('#dataSubWin').window('close'); 
            		reloadData();
                } else {
                    layer.msg("操作失败！", {offset: 'rb',icon: 5,shift: 8,time: layerMsgTime});
                    renderErrMsg(data.message);
                }
            }
        });
    }
    function destroySubInfo(){
        var row = $('#dataSubList').datagrid('getSelected');
        if (row){
            $.messager.confirm('确认','你确定删除该记录吗？',function(r){
                if (r){
                	$.ajax({
						type: "post",
						url: '${ctx}/sys/tableColumn/delete.do',
						data: {delDataId:row.id},
						dataType: 'json',
						beforeSend: function(XMLHttpRequest){
							loadi = layer.load(2, {time: layerLoadMaxTime});
						},
						success: function(data, textStatus){
							layer.close(loadi);
							if (data.success=="<%=StringConstant.TRUE%>"){
		                        layer.msg("操作成功！", {offset: 'rb',icon: 6,shift: 8,time: layerMsgTime});
								reloadData();
		                    } else {
			                    layer.msg("操作失败！", {offset: 'rb',icon: 5,shift: 8,time: layerMsgTime});
		                    }
						}
					});
                }
            });
        }
    }
    </script>
  </body>
</html>