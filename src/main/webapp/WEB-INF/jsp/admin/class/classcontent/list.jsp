<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
<m:Content contentPlaceHolderId="css">
	<style>
		.layui-input, .layui-textarea{
			width: 92%;
		} 
		.layui-form-label{
			width: 125px;
		}
		.must{
			color: red;
			margin-right: 2%;
			size: 10px;
			font-size: 15px;
		}
		.clear{
			clear:both;
		}
		.ss_biao{
			float: right;
			margin-top: -4%;
			margin-right:3%;
			cursor:pointer;
		}
		.nowPage{
			margin-top: 10px;
		}
	</style>
</m:Content>
<m:Content contentPlaceHolderId="content">
	<div style="padding:0 30px" class="layui-anim layui-anim-upbit">
	<blockquote class="layui-elem-quote nowPage">
			教学内容
	</blockquote>
		<div class="layui-field-box" style=" border-color:#666; border-radius:3px; padding:10px;">
			<form class="layui-form">
			<input type="hidden" name="contentId" id="contentId" value="${Id}">
            	<div class="layui-form-item">
					<label class="layui-form-label"><span class="must">*</span>标题：</label>
					<div class="layui-input-block">
						<input type="text" name="title" id="title" value="${title}" lay-verify="title"  autocomplete="off" class="layui-input" />
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="must">*</span>教学内容：</label>
					<div style="width: 83%;margin-left: 155px">
						<textarea id="content" style="display: none;">${content}</textarea>
					</div>
				</div>
				
				<div class="layui-form-item" style="text-align: center;">
					<button class="layui-btn" style="width: 50%;margin-top: 60px;" id="saveInfo" lay-submit="" lay-filter="addEqBtn">保存</button>
				</div>
			
			</form>
		</div>
	</div>
</m:Content>
<m:Content contentPlaceHolderId="js">
	<script type="text/javascript">
		layui.use(['form','laydate','layedit'], function(){
			var form = layui.form;
			var laydate = layui.laydate;
			var layedit = layui.layedit;
			
			//建立编辑器
			 var content = layedit.build('content',{
				 height:300
			 });
			
			//监听提交
			form.on('submit(addEqBtn)', function(data){
				/* if(!check()){
					return false;
				} */
				var success = function(data){
					if(data.result){
						layer.msg(data.msg, {icon: 1});
					}else{
						layer.msg(data.msg, {icon: 2});
					}
				}
				var classContent = layedit.getText(content)
				var postData = {"contentId":$("#contentId").val(),"title":$("#title").val(),"content":classContent};
				ajax('/${applicationScope.adminprefix }/danceClass/addClassContent', postData, success, 'post', 'json');
				return false;
			})
			//自定义验证规则
			form.verify({
				
				title: function(value) {
					if(value.length < 2) {
						return '请填写标题';
					}
				}
				
			});
		
		})
		
	</script>
</m:Content>
</m:ContentPage>