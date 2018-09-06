<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
	<m:Content contentPlaceHolderId="css">

<style>
.layui-form-label {
	width: 145px;
}

.must {
	color: red;
	margin-right: 2%;
	size: 10px;
	font-size: 15px;
}

.layui-input {
	width: 330%;
}
.only-input{
	width: 87%;
}
.layui-textarea{
	width: 87%;
}
.photoDiv{
	border: 1px solid #E6E6E6;
	width: 200px;
	height: 250px;
	margin-left: 175px;
	color: #C1C1C1;
	text-align: center;
	line-height: 250px;
	font-size: 15px;
	cursor: pointer;
}
/* .layui-form-select .layui-edge {
	right: -215%;
}

.layui-form-select dl {
	width: 325%;
}

.bootstrap-select>.btn {
	width: 281%;
}

.dropdown-menu {
	width: 280%;
}

.dropdown-menu>li>a {
	width: 595%;
} */



</style>
	</m:Content>
	<m:Content contentPlaceHolderId="content">
		<div style="padding: 0 30px" class="layui-anim layui-anim-upbit">
			<blockquote class="layui-elem-quote layui-bg-blue">
				财务统计计算
			</blockquote>
		
			<div class="layui-field-box" style="border-color: #666; border-radius: 3px; padding: 10px;">
				<form class="layui-form">
					
					<div class="layui-form-item" style="margin-top: -8px;">
					    <label class="layui-form-label"><span class="must">*</span>统计分类：</label>
					    <div class="layui-input-block">
					      <input type="radio"  name="sex" value="1" title="月统计" >
					      <input type="radio"  name="sex" value="2" title="季度统计" >
					      <input type="radio"  name="sex" value="3" title="年统计" >
					    </div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>教师姓名：</label>
						<div class="layui-input-block">
							<input type="text" name="teaName" id="teaName" value="${teacherName}" lay-verify="teaName"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>年龄：</label>
						<div class="layui-input-block">
							<input type="text" name="age" id="age" value="${age}" lay-verify="age"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>家庭住址：</label>
						<div class="layui-input-block">
							<input type="text" name="address" id="address" value="${address}" lay-verify="address"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>手机号：</label>
						<div class="layui-input-block">
							<input type="text" name="phoneNum" id="phoneNum" value="${phoneNum}" lay-verify="phoneNum"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: -8px;">
					    <label class="layui-form-label"><span class="must">*</span>所教科目：</label>
					    <div class="layui-input-block">
					      <input type="radio"  name="subject" value="1" title="舞蹈" <c:if test="${subject==1 || subject==null}">checked</c:if> >
					      <input type="radio"  name="subject" value="2" title="美术" <c:if test="${subject==2}">checked</c:if> >
					    </div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">入职时间：</label>
						<div class="layui-input-inline">
							<input type="text" readonly="readonly" value="${entryTime}" name="ruzhiTime" id="ruzhiTime" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: 10px;">
						<label class="layui-form-label"><span class="must">*</span>学历：</label>
						<div class="layui-input-block">
							<input type="text" name="education" id="education" value="${education}" lay-verify="education"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">资历介绍：</label>
						<div class="layui-input-block">
							<textarea name="seniority" id="seniority" required lay-verify="seniority" placeholder="请输入" class="layui-textarea">${seniority}</textarea>
						</div>
					</div>
					<div class="layui-form-item" style="text-align: center;">
						<button class="layui-btn" style="width: 50%; margin-top: 12px;" id="saveInfo" lay-submit="" lay-filter="addEqBtn">保存</button>
					</div>
				</form>
			</div>
		</div>
	</m:Content>
	<m:Content contentPlaceHolderId="js">
	
		<script type="text/javascript" src="/manage/public/js/jquery.form.min.js"></script>
		<script type="text/javascript">
	
		layui.use(['form','laydate','layedit'], function(){
			var form = layui.form;
			var laydate = layui.laydate;
			var index = parent.layer.getFrameIndex(window.name);
			//监听提交
			form.on('submit(addEqBtn)', function(data){
				if(!check()){
					return false;
				}
				var success = function(data){
					if(data.result){
						layer.msg(data.msg, {icon: 1});
						setTimeout(function(){
							parent.layer.close(index);
						},1000);
						
					}else{
						layer.msg(data.msg, {icon: 2});
					}
				}
				var postData = $(data.form).serialize();
				ajax('/${applicationScope.adminprefix }/teachers/addTeachersInfo', postData, success, 'post', 'json');
				return false;
			})
			
			laydate.render({
				elem: '#ruzhiTime',
				type:'date'
				/* range: true  区间时间选择*/
			});
			
			function check(){
					
				var teaName = $("#teaName").val();
				var age = $("#age").val();
				var address = $("#address").val();
				var phoneNum = $("#phoneNum").val();
				var education = $("#education").val();
				
				if(teaName==null || teaName==''){
					layer.msg("请输入教师姓名！",{icon:2});
					return false;
				}
				var reg=/^\+?[1-9][0-9]*$/;
				var aa = reg.test(age);
				if(age==null || age=='' || !reg.test(age)){
					layer.msg("请输入正确的年龄！",{icon:2});
					return false;
				}
				if(address==null || address==''){
					layer.msg("请输入教师住址！",{icon:2});
					return false;
				}
				var regPhone = /^((\d{3}-\d{8}|\d{4}-\d{7,8})|(1[3|5|7|8][0-9]{9}))$/
				if(phoneNum==null || phoneNum=='' || !regPhone.test(phoneNum)){
					layer.msg("请填写正确的手机号！",{icon:2});
					return false;
				}
				if(education==null || education==''){
					layer.msg("请输入教师学历！",{icon:2});
					return false;
				}
				
				return true;
			}
			
			
			$("#triggerUpload").click(function(){
				$("#photoUpload").click();
			})
			
		})
		
		//删除活动计划
		function delplan(planNum){
			var text = "确定删除'活动计划"+planNum+"'?";
			layer.confirm(text, {icon: 7}, function(){
				
				$("#plan"+planNum).remove();
				layer.closeAll('dialog');
				$("#allNum").val($("#allNum").val().replace(planNum+",",""));
			})
		}
    	
		function submitfile(){
			$("#fileForm").ajaxSubmit({
				type:"post",
		    	dataType:"json",
		  		success: function (data) {
		  			var imghtml = '<img alt="" src="'+data.photoUrl+'" width="200px;" heigth="250px;" >';
		  			$("#triggerUpload").html(imghtml);
		  			$("#photoUrl").val(data.photoUrl);
		   	    }
		   	}) 
		}
		
	</script>
	</m:Content>
</m:ContentPage>