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
	width: 325%;
}
.only-input{
	width: 87%;
}
.layui-textarea{
	width: 87%;
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

			<div class="layui-field-box" style="border-color: #666; border-radius: 3px; padding: 10px;">
				<form class="layui-form">
					<div class="layui-form-item">
						<label class="layui-form-label">教师照片：</label>
						<div class="layui-input-block"></div>
						
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>教师姓名：</label>
						<div class="layui-input-block">
							<input type="text" name="teaName" id="teaName" value="${teaName}" lay-verify="teaName"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: -8px;">
					    <label class="layui-form-label"><span class="must">*</span>性别：</label>
					    <div class="layui-input-block">
					      <input type="radio"  name="sex" value="2" title="女" <c:if test="${sex==2 || sex==null}">checked</c:if> >
					      <input type="radio"  name="sex" value="1" title="男" <c:if test="${sex==1}">checked</c:if> >
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
							<input type="text" readonly="readonly" value="${ruzhiTime}" name="ruzhiTime" id="ruzhiTime" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>学历：</label>
						<div class="layui-input-block">
							<input type="text" name="education" id="education" value="${education}" lay-verify="education"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>资历介绍：</label>
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
				ajax('/${applicationScope.adminprefix }/student/addStudent', postData, success, 'post', 'json');
				return false;
			})
			
			laydate.render({
				elem: '#ruzhiTime',
				type:'date'
				/* range: true  区间时间选择*/
			});
			
			function check(){
					
				var stuName = $("#stuName").val();
				var age = $("#age").val();
				var fatherName = $("#fatherName").val();
				var fatherPhone = $("#fatherPhone").val();
				var motherName = $("#motherName").val();
				var motherPhone = $("#motherPhone").val();
				var inShop = $("#inShop").next().find(".layui-this").attr("lay-value");
				var inClass = $("#inClass").next().find(".layui-this").attr("lay-value");
				var ruxueTime = $("#ruxueTime").val();
				
				if(stuName==null || stuName==''){
					layer.msg("请输入学生姓名！",{icon:2});
					return false;
				}
				var reg=/^\+?[1-9][0-9]*$/;
				var aa = reg.test(age);
				if(age==null || age=='' || !reg.test(age)){
					layer.msg("请输入正确的学生年龄！",{icon:2});
					return false;
				}
				if((fatherName==null || fatherName=='') && (fatherPhone==null || fatherPhone=='') && (motherName==null || motherName=='') && (motherPhone==null || motherPhone=='')){
					layer.msg("请至少填写一位家长的信息！",{icon:2});
					return false;
				}
				var regPhone = /^((\d{3}-\d{8}|\d{4}-\d{7,8})|(1[3|5|7|8][0-9]{9}))$/
				if(fatherName!=null && fatherName!=''){
					if(fatherPhone==null || fatherPhone=='' || !regPhone.test(fatherPhone)){
						layer.msg("请填写正确的父亲的手机号！",{icon:2});
						return false;
					}
				}
				if(motherName!=null && motherName!=''){
					if(motherPhone==null || motherPhone==''){
						layer.msg("请填写母亲的手机号！",{icon:2});
						return false;
					}
				}
				if(inShop==null || inShop==' '){
					layer.msg("请选择所在店铺！",{icon:2});
					return false;
				}
				if(inClass==null || inClass==' '){
					layer.msg("请选择所在班级！",{icon:2});
					return false;
				}
				if(ruxueTime==null || ruxueTime==''){
					layer.msg("请选择入学时间！",{icon:2});
					return false;
				}
				
				return true;
			}
			
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
    	
		
	</script>
	</m:Content>
</m:ContentPage>