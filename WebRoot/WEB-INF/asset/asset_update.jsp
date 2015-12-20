<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/easyui/themes/default/easyui.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/easyui/themes/icon.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui/easyui-lang-zh_CN.js"></script>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-responsive.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-image-gallery.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.fileupload-ui.css">
        
	    <script src="${pageContext.request.contextPath}/js/upload/vendor/jquery.ui.widget.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/tmpl.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/load-image.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/canvas-to-blob.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/bootstrap.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/bootstrap-image-gallery.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/jquery.iframe-transport.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/jquery.fileupload.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/jquery.fileupload-fp.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/jquery.fileupload-ui.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/locale.js"></script>
	    <script src="${pageContext.request.contextPath}/js/upload/main.js"></script>
	    
<script type="text/javascript">

	var assetid="${assetid}";
	$(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/asset!getDetailList.action",
			type:"post",
			data:{assetid:assetid},
			async:false,
			dataType:"json",
			success:function(data){
				var list=eval(data);
				for(var j=0;j<list.length;j++){
					addRow();
					$("#asid").val(list[j].ID);
					$("#a1").val(list[j].NAME);
					$("#a2").val(list[j].MODEL);
					$("#a3").val(list[j].NUM);
					$("#a4").val(list[j].CONTENT);
					//console.log("list[j].NAME="+list[j].NAME);
				}
			}
		});
		$.ajax({
			url:"${pageContext.request.contextPath}/asset!getImgList.action",
			type:"post",
			data:{assetid:assetid},
			async:false,
			dataType:"json",
			success:function(data){
					var list=eval(data);
					for(var i in list){
					$("#imgList").append("<div><a href='UploadServlet?getfile="+list[i].PATH+"' title='"+list[i].NAME+"' rel='gallery' download='"+list[i].NAME+"'><img src='UploadServlet?getthumb="+list[i].PATH+"'>"+list[i].NAME+"</a><button type='button' class='btn btn-primary' onclick=\"removeImg('"+list[i].ID+"','"+list[i].PATH+"')\">删除按钮</button></div><br/>");
				}
			}
		});
	});
	

	function removeImg(id,url){
	
		event.target.parentElement.remove();
	
		console.log("要删除的图片id是="+id+"; 要删除的图片地址是="+url);
		$.post("${pageContext.request.contextPath}/asset!deleteImg.action?id="+id,function(data){
			if(data=="ok"){
				console.log("数据库图片删除ok!");	
			}else{
				alert("数据库图片删除失败!"); 
			}
		});
		$.get("UploadServlet?delfile="+url,function(data){
				console.log("服务器图片删除ok!");	
		});
	}
	
  /*  ---------------------添加输入框-------------------------------*/
  function addRow(){
  	$("#testtr").after("<tr class='tr'>"+
  	"<input  type=hidden  maxlength=30 name='assetdetail.id' id='asid'>"+
  	"<td align='center'><input  type=text class='td' id='a1'  maxlength=30 name='assetdetail.name'></td>"+
  	"<td align='center'><input  type=text class='td' id='a2'  maxlength=30 name='assetdetail.model'></td>"+
  	"<td align='center'><input  type=text class='td' id='a3' maxlength=30 name='assetdetail.num'></td>"+
  	"<td align='center'><input  type=text class='td' id='a4'  maxlength=30 name='assetdetail.content'></td>"+
  	"<td align='left'><input  type=button value='删除' onclick='delRow(this)'  maxlength=30></td>"+
  	"</tr>");
  }
  
  /* ---------------删除输入框--------------------- */
  function delRow(obj){
	  	var id=$("#asid").val();
	  	$.post("${pageContext.request.contextPath}/asset!deleteDetail.action",{id:id},function(data){
	   			if(data=="ok"){
	   				console.log("资产明细表删除ok");
				  	$(obj).parent().parent().remove();	
	   			}else{
	   				alert("资产明细表删除失败");
	   			}
	   		});
	  	
  }
  
  /* ------------------------添加资源配置----------------------------------- */
  function addDetail(){
  	var details='';
  	var j=0;
	$(".td").each(function(){
  		details+=$(this).val()+",";
  		j++;
		if(j%4==0){
			details=details.substring(0,details.length-1)+";";
		}	
	});
  	
  	$.post("${pageContext.request.contextPath}/detail!addDetail.action",{details:details},function(data){
   			if(data=="detailok"){
   				console.log("资产明细表ok");
   			}else{
   				alert("资产明细表添加失败");
   			}
   		});
  }
	
  /* --------------------提交表单----------------- */
   function submitForm(){
  
		var imgs ='';
   		$('td[class="name"] a').each(function(){
   			imgs+=';'+$(this).text()+','+$(this).attr('href').split('=')[1];
   		});
   		imgs=imgs.substring(1);
   		$("#imgs").val(imgs);
   		console.log("imgs="+imgs);
   		
   		var details='';
	  	var j=0;
		$(".td").each(function(){
	  		details+=$(this).val()+",";
	  		j++;
			if(j%4==0){
				details=details.substring(0,details.length-1)+";";
			}	
		});
		$("#details").val(details);
   		console.log("details="+details);
   		console.log("序列化="+$("#assetForm").serialize());
   		
  		$.post("${pageContext.request.contextPath}/asset!updateForm.action",$("#assetForm").serialize(),function(data){
   			if(data=="ok"){
   				console.log("表单修改ok");
		   		window.parent.closeWindow();
   			}else{
   				alert("表单修改失败");
   			}
   		});
	 }
</script>

</head>
<body>


  <form id='assetForm' >
 <table>
 	<tr  align="right">
 		<td>资产编号:</td>
 		<td>
 			<input type="hidden" id="imgs"  name="imgs" >
 			<input type="hidden" id="details"  name="details" >
 			<input type="hidden" id="id"  name="asset.id" value="${asset.id}">
 			<input type="text" id="num"  name="asset.num" value="${asset.num}">
 		</td>
 		<td>资产名称:</td>
 		<td><input type="text" id="name"  name="asset.name" value="${asset.name}"></td>
 	</tr>
 	<tr  align="right">
 		<td>资产类型:</td>
 		<td>
	 		<input id="type" name="asset.typeid" value="${asset.typeid}"   class="easyui-combobox" 
	 		data-options="valueField: 'ID',    
	        textField: 'TYPENAME',    
	        url: 'asset!getAssetType.action',    
	        onSelect: function(rec){    
	            var url = 'asset!getFactory.action?id='+rec.ID;  
	            //console.log('rec.ID='+rec.ID); 
	            
	            $('#factory').combobox('clear');    
	            $('#factory').combobox('reload', url);    
	        }" />
        </td>
        <td>购买厂家</td>   
        <td>
			<input id="factory" name="asset.factory" value="${asset.factory}"  class="easyui-combobox" 
			data-options="valueField:'ID',textField:'NAME',url:'asset!getFactory.action?id='+${asset.typeid}" />  
        </td>   
 	</tr>
 	<tr align="right">
 		<td>负责人:</td>
 		<td>
 			<input id="type" class="easyui-combobox" id="user" name="asset.userid" value="${asset.userid}"  
   			 data-options="valueField:'ID',textField:'LOGINNAME',url:'user!userCombox.action'" /> 
 		</td>
 		<td>资产状态:</td>
 		<td align="left">
 			<select id="status" class="easyui-combobox" style="width: 170px" name="asset.status" value="${asset.status}">
				<option value="1">在库</option> 			
				<option value="2">出库</option> 			
				<option value="3">禁用</option> 			
 			</select>
 		</td>
		 		
 	</tr>
 	<tr  align="right">
 		<td>购买日期:</td>
 		<td><input type="text" id="buydate" name="asset.buydate" onclick="WdatePicker()" value="${asset.buydate}"></td>
 		<td>购买价格:</td>
 		<td><input type="text" id="price"  name="asset.price" value="${asset.price}"></td>
 	</tr>
 	<tr  align="right">
 		<td>资产备注:</td>
 		<td>
 			<textarea rows="5" cols="21" id="content" name="asset.content">${asset.content}</textarea>
 		</td>
 	</tr>
 </table>

   </form>
   
  	<hr/>
   <!-- ----------------------------文件上传----------------------------------------- -->
    <div class="container">
            <form id="fileupload" action="UploadServlet" method="POST" enctype="multipart/form-data">
                <div class="row fileupload-buttonbar">
                    <div class="span7">
                        <span class="btn btn-success fileinput-button">
                            <i class="icon-plus icon-white"></i>
                            <span>添加图片</span>
                            <input type="file" name="files[]" multiple>
                        </span>
                        <button type="submit" class="btn btn-primary start">
                            <i class="icon-upload icon-white"></i>
                            <span>开始上传</span>
                        </button>
                        <button type="reset" class="btn btn-warning cancel">
                            <i class="icon-ban-circle icon-white"></i>
                            <span>取消上传</span>
                        </button>
                        <button type="button" class="btn btn-danger delete">
                            <i class="icon-trash icon-white"></i>
                            <span>删除</span>
                        </button>
                    </div>
                    <div class="span5 fileupload-progress fade">
                        <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                            <div class="bar" style="width:0%;"></div>
                        </div>
                        <div class="progress-extended">&nbsp;</div>
                    </div>
                </div>
                <div class="fileupload-loading"></div>
                <br>
                <table role="presentation" class="table table-striped"><tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery"></tbody></table>
           		<div id="imgList"></div>
           	
            </form>
            <br>
        </div>
<script id="template-upload" type="text/x-tmpl">
            {% for (var i=0, file; file=o.files[i]; i++) { %}
        <tr class="template-upload fade">
            <td class="preview"><span class="fade"></span></td>
            <td class="name"><span>{%=file.name%}</span></td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            {% if (file.error) { %}
            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
            {% } else if (o.files.valid && !i) { %}
            <td>
                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
            </td>
            <td class="start">{% if (!o.options.autoUpload) { %}
                <button class="btn btn-primary">
                    <i class="icon-upload icon-white"></i>
                    <span>开始</span>
                </button>
                {% } %}</td>
            {% } else { %}
            <td colspan="2"></td>
            {% } %}
            <td class="cancel">{% if (!i) { %}
                <button class="btn btn-warning">
                    <i class="icon-ban-circle icon-white"></i>
                    <span>取消</span>
                </button>
                {% } %}</td>
        </tr>
        {% } %}
</script>
<script id="template-download" type="text/x-tmpl">
        {% for (var i=0, file; file=o.files[i]; i++) { %}
        <tr class="template-download fade">
            {% if (file.error) { %}
            <td></td>
            <td class="name"><span>{%=file.name%}</span></td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
            {% } else { %}
            <td class="preview">{% if (file.thumbnail_url) { %}
                <a href="{%=file.url%}" title="{%=file.name%}" rel="gallery" download="{%=file.name%}"><img src="{%=file.thumbnail_url%}"></a>
                {% } %}</td>
            <td class="name">
                <a href="{%=file.url%}" title="{%=file.name%}" rel="{%=file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td colspan="2"></td>
            {% } %}
            <td class="delete">
                <button class="btn btn-danger" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}"{% if (file.delete_with_credentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                        <i class="icon-trash icon-white"></i>
                    <span>Delete</span>
                </button>
                <input type="checkbox" name="delete" value="1">
            </td>
        </tr>
        {% } %}
</script>
    
    
    <!--  ------------资产配置明细-------------------------------------------------------------- -->
   	<hr/>
   	
   	<a href="javascript:void(0)" title="请填写资产配置明细表" class="easyui-tooltip">资产配置明细表</a>
    <form action="" id="detailForm">
    	<table  width="900" id="detailTable" bordercolor="green" border="1">
	        <tr id="testtr">   
	            <th  width="20%" align='center'>配置名称</th>   
	            <th  width="20%" align='center'>规格型号</th>   
	            <th  width="20%" align='center'>数量</th>   
	            <th  width="20%" align='center'>配置备注</th>   
	            <th  width="20%" align='center'><a id="addbtn" href="javascript:void(0)" onclick="addRow()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">++</a></th>   
	        </tr>
	        
    	</table>
    </form>
    
    <hr/>
    <div align="center" style="width: 200px;">
	   	<a id="btn" href="javascript:void(0)"  onclick="submitForm()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">修改资产</a>
    </div>
</body>
 
</html>