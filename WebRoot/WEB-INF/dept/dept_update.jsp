<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'dept_add.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<%@include file="/src/easyui.jsp" %>
	<script type="text/javascript">
	
		var idkey ='';
  		var namekey ='';
  		
  		function getUsers(){
  			
  			idkey =$('#'+event.target.id).prev().attr('id');
  			namekey =event.target.id;
			openWindow('部门',300,250,'user!userTree.action');
			
		}
  		
		function closeTree(){
			$('#win').window('close');
		}
		function openWindow(title,width,height,url){
			$('#win').window({
				title:title,
			    width:width,    
			    height:height,
			    //相对居中
			    left:($(window).width()-width)*0.5,
				top:($(window).height()-height)*0.5, 
			    collapsible:false,
			    minimizable:false,
			    maximizable:false,
			    modal:true   
			});
			$('#win').html('<iframe id="child" name="child" src="${pageContext.request.contextPath}/'+url+'" frameborder="0" style="width: 100%;height: 100%"></iframe>');
		}
		function openWindow(title,width,height,url){
			$('#win').window({
				title:title,
			    width:width,    
			    height:height,
			    //相对居中
				top:50, 
			    collapsible:false,
			    minimizable:false,
			    maximizable:false,
			    draggable:true,
			    modal:true   
			});
			$('#win').html('<iframe id="child" name="child" src="${pageContext.request.contextPath}/'+url+'" frameborder="0" style="width: 100%;height: 100%"></iframe>');
		}
		function submitForm(){
			$("#dept_update").submit(function(e){
			//alert($(this).serialize());
				e.preventDefault();
				$.post("${pageContext.request.contextPath}/dept!updateDept.action",$(this).serialize(),function(data){
					if(data=="yes"){
						//alert("部门修改成功");
						window.parent.closeWindow();
					}else{
						alert("部门修改失败");
					};
					window.parent.closeWindow();
					window.parent.flushDate();
					
					
				},"text");
			});
		}
	</script>
  </head>
  
  <body>
  	<!-- 窗口 -->
  	<div id="win"></div>
  	<form id="dept_update" method="post" > 
  		<table>
  			<tr>
	  			<td><label for="name">部门编号:</label>   </td>
	  			<td><input class="easyui-validatebox" type="text" name="id" value="${depts.id}" data-options="required:true" />   </td>
  			</tr>
  			<tr>
	  			<td><label for="name">部门名称:</label>   </td>
	  			<td><input class="easyui-validatebox" type="text" name="name"  value="${depts.name}" data-options="required:true" />   </td>
  			</tr>
  			<!-- <tr>
	  			<td><label for="name">职能类型:</label>   </td>
	  			<td><input class="easyui-validatebox" type="text" name="typeid"  data-options="required:true" />   </td>
  			</tr> -->
  			<tr>
	  			<td><label for="name">上级部门:</label>   </td>
	  			<td>
	  				<!--下拉菜单  -->
	  				<input id="cc" class="easyui-combobox" name="pid"  value="${depts.pid}" 
    				data-options="valueField:'ID',textField:'NAME',url:'${pageContext.request.contextPath}/dept!ptree.action'" />  
	  			</td>
  			</tr>
  			<tr>
  				<td><label for="name">部门正职:</label>   </td>
	  			<td>
	  				<input type="hidden" id="firstuser" name="firstuser" value="${depts.firstuser}" >
	  				<input class="easyui-validatebox" onclick="getUsers()" type="text" id="firstuserName" value="${depts.firstuserName}"  data-options="required:true" />   
	  			</td>
  			</tr>
  			<tr>
  				<td><label for="name">部门副职:</label>   </td>
	  			<td>
	  			<input type="hidden" id="seconduser" name="seconduser" value="${depts.seconduser}">
	  			<input class="easyui-validatebox" onclick="getUsers()" type="text" id="seconduserName" value="${depts.seconduserName}"  data-options="required:true" />   </td>
  			</tr>
  			<tr>
  				<td><label for="name">部门秘书:</label>   </td>
	  			<td>
	  			<input type="hidden" id="secretary" name="secretary" value="${depts.secretary}">
	  			<input class="easyui-validatebox" onclick="getUsers()" type="text" id="secretaryName" value="${depts.secretaryName}"  data-options="required:true" />   </td>
  			</tr>
  			
  			<tr>
  				<td colspan="2">
  					<input type="submit" value="修改" onclick="submitForm()"/>
  					<input type="reset" value="重置"/>
  				</td>
  			</tr>
  		</table>
</form> 
  
  
  </body>
</html>
  