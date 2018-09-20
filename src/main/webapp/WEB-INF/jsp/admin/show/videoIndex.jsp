<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
<m:Content contentPlaceHolderId="css">

<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/manage/public/css/selected/bootstrap-select.css">

	<style>
		.layui-form-label{
			width: 145px;
		}
		.must{
			color: red;
			margin-right: 2%;
			size: 10px;
			font-size: 15px;
		}
		.nowPage{
			margin-top: 10px;
		}
		.layui-input {
		    width: 325%;
		}
		.layui-form-select .layui-edge{
			right: -215%;
		}
		.layui-form-select dl{
			width: 325%;
		}
		.bootstrap-select > .btn {
		    width: 281%;
		}
		.dropdown-menu{
			width: 280%;
		}
		.dropdown-menu>li>a{
			width: 595%;
		}
		li{
			width: 10%;
		}
		.delonePlan{
			margin-right: 10px;
		}
		.deloneicon{
			font-size: 18px;
			color: #EB3B42;
			cursor: pointer;
		}
	</style>
</m:Content>
<m:Content contentPlaceHolderId="content">
	<div style="padding:0 30px" class="layui-anim layui-anim-upbit">
	<blockquote class="layui-elem-quote nowPage">
		<c:if test="${roleType==1}">
			教师视频
		</c:if>
		<c:if test="${roleType==2}">
			学生视频
		</c:if>	
	</blockquote>
		<div class="layui-form-item" style="padding-top: 10px; margin-bottom: 0;">
			<div class="layui-inline">
				<button class="layui-btn layui-btn-normal" id="addVideo"><i class="layui-icon">&#xe654;</i>上传视频</button>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-danger" id="delPlan"><i class="layui-icon">&#xe640;</i><span id="delText">删除视频</span></button>
			</div>
		
			<div style="clear: both"></div>
		</div>
		<div class="layui-field-box" style=" border-color:#666; border-radius:3px; padding:10px;">
			<!-- 上传视频 -->
			<form action="/${applicationScope.adminprefix }/show/uoloadVideo" enctype="multipart/form-data" id="videoForm" method="post" style="display: none;">
				<input type="hidden" name="roleType" id="roleType" value="${roleType}">
				<input type="file" id="videoFile" name="videoFile" value="" onchange="submitVideo();" >
			</form>
		</div>
	</div>
</m:Content>
<m:Content contentPlaceHolderId="js">
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/manage/public/js/bootstrap-select.js"></script>
<script type="text/javascript" src="/manage/public/js/jquery.form.min.js"></script>

	<script type="text/javascript">
	
	
		layui.use(['form','laydate','layedit'], function(){
			var form = layui.form;
			var laydate = layui.laydate;
			//监听提交
			form.on('submit(addEqBtn)', function(data){
				if(!check()){
					return false;
				}
				var success = function(data){
					if(data.result){
						layer.msg(data.msg, {icon: 1});
					}else{
						layer.msg(data.msg, {icon: 2});
					}
				}
				var postData = $(data.form).serialize();
				ajax('/${applicationScope.adminprefix }/danceClass/addClassPlan', postData, success, 'post', 'json');
				return false;
			})
			
			
			
			
			//点击删除按钮，显示活动计划前的叉号
			$("#delPlan").click(function(){
				
				var delText = $(this).find("#delText").html();
				if(delText=='删除活动'){
					$(this).find("#delText").html('取消删除');
					$(".delonePlan").css("display","inline");
				}else{
					$(this).find("#delText").html('删除活动');
					$(".delonePlan").css("display","none");
				}
			})
			
			$("#addVideo").click(function(){
				$("#videoFile").click();
			})
			
		})
		
		function submitVideo(){
			$("#videoForm").ajaxSubmit({
				type:"post",
		    	dataType:"json",
		  		success: function (data) {
		  			if(data.result){
		  				layer.msg(data.msg,{icon:1});
		  			}else{
		  				layer.msg(data.msg,{icon:2});
		  			}
					
		   	    }
		   	}) 
		}
		
    	
	
	</script>
</m:Content>
</m:ContentPage>