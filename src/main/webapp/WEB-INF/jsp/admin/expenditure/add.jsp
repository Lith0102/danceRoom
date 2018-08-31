<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
<m:Content contentPlaceHolderId="css">

	<style>
	.layui-form-label {
		width: 114px;
	}
	
	.must {
		color: red;
		margin-right: 2%;
		size: 10px;
		font-size: 15px;
	}
	
	.nowPage {
		margin-top: 10px;
	}
	
	.layui-input {
		width: 325%;
	}
	.only-input{
		width: 77%;
	}
	.layui-form-select .layui-edge {
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
	}
	
	</style>
	</m:Content>
	<m:Content contentPlaceHolderId="content">
		<div style="padding: 0 30px" class="layui-anim layui-anim-upbit">

			<div class="layui-field-box" style="border-color: #666; border-radius: 3px; padding: 10px;">
				<form class="layui-form">
					<input type="hidden" name="infoId" id="infoId" value="${infoId}">
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>支出说明：</label>
						<div class="layui-input-block">
							<input type="text" name="expenseExplain" id="expenseExplain" value="${expenseExplain}" lay-verify="expenseExplain"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">购买数量：</label>
						<div class="layui-input-block">
							<input type="text" name="buyCount" id="buyCount" value="${buyCount}" lay-verify="buyCount"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>支出总额：</label>
						<div class="layui-input-block">
							<input type="text" name="expenseMoney" id="expenseMoney" value="${expenseMoney}" lay-verify="expenseMoney"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label"><span class="must">*</span>支出时间：</label>
						<div class="layui-input-inline">
							<input type="text" readonly="readonly" value="${expenseTime}" name="expenseTime" id="expenseTime" autocomplete="off" class="layui-input" style="width: 174%">
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: 13px;">
						<label class="layui-form-label">支出用途：</label>
						<div class="layui-input-block">
							<textarea name="purpose" id="purpose" required lay-verify="purpose" placeholder="请输入" class="layui-textarea" style="width: 77%">${purpose}</textarea>
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
				ajax('/${applicationScope.adminprefix }/expenditure/addORupdZCInfo', postData, success, 'post', 'json');
				return false;
			})
			
			laydate.render({
				elem: '#expenseTime',
				type:'date'
				/* range: true  区间时间选择*/
			});
			
			function check(){
				var expenseExplain = $("#expenseExplain").val();
				var buyCount = $("#buyCount").val();
				var expenseMoney = $("#expenseMoney").val();
				var zhichuTime = $("#expenseTime").val();
				
				if(expenseExplain==null || expenseExplain==''){
					layer.msg("请输入支出说明！",{icon:2});
					return false;
				}
				var reg=/^\+?[1-9][0-9]*$/;//校验正整数
				if(buyCount!=null && buyCount!='' && !reg.test(buyCount)){
					layer.msg("请输入正确的购买数量！",{icon:2});
					return false;
				}
				var patrn  = /^(-)?\d+(\.\d+)?$/;//校验数字
				if(expenseMoney==null || expenseMoney=='' || !patrn.exec(expenseMoney)){
					layer.msg("请输入正确的支出总额！",{icon:2});
					return false;
				}
				
				if(zhichuTime==null || zhichuTime==''){
					layer.msg("请选择支出时间！",{icon:2});
					return false;
				}
				return true;
			}
			
		})
		
	</script>
	</m:Content>
</m:ContentPage>