<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<%@ taglib uri="cn.core.AuthorizeTag" prefix="px" %>
<m:ContentPage materPageId="master">
<m:Content contentPlaceHolderId="css">
	<link rel="stylesheet" href="/manage/public/css/layui_public/layui_dyx.css"/>
	<link type="text/css" href="/manage/public/css/video-js.min.css" rel="stylesheet">
	<style type="text/css">
		body{
			height: 100%;
		}
		.layui-form-mid {
			margin-left: 10px;
		}
	</style>
</m:Content>
<m:Content contentPlaceHolderId="content">
	<!-- 内容主体区域 -->
	<div style="padding: 15px;" class="layui-anim layui-anim-upbit">
		<blockquote class="layui-elem-quote layui-bg-blue">
			统计列表
		</blockquote>
		<div class="yw_cx">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">统计类型：</label>
					<div class="layui-input-inline">
						<select class="layui-input" name="statisticsType" id="statisticsType">
							<option value="">请选择</option>
							<option value="1">季度</option>
							<option value="2">上半年</option>
							<option value="3">下半年</option>
							<option value="4">全年</option>
						</select>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">统计时间：</label>
					<div class="layui-input-inline">
						<input type="text" name="tjTime" id="tjTime" lay-verify="date" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline" id="layerDemo" style="margin-left: 15px;">
					<div class="layui-input-inline">
						<button class="layui-btn layui-btn-normal" id="search"><i class="layui-icon">&#xe615;</i>搜索</button>
					</div>
				</div>
				<div class="layui-inline" id="layerDemo" style="margin-left: -7%;">
					<div class="layui-input-inline">
						<button class="layui-btn layui-btn-normal" style="background-color: #FF6633" id="reset"><i class="layui-icon">&#xe620;</i>重置</button>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-form">
			<table class="layui-table" lay-skin="line" id="dataList" lay-filter="tableContent"></table>
		</div>
		<div id="demo7"></div>
		
	</div>
	
	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-xs" style="background-color: red;" lay-event="delete">删除</a>
	</script>
	
</m:Content>
<m:Content contentPlaceHolderId="js">
	<script src="/manage/public/js/jquery.form.min.js"></script>
	<script src="/manage/public/js/video/video.min.js"></script>
	<script src="/manage/public/js/video/videojs-ie8.min.js"></script>
	<script src="http://vjs.zencdn.net/5.19/lang/zh-CN.js"></script>
	<script type="text/javascript">
		//JavaScript代码区域
		layui.use(['laypage', 'layer', 'table', 'form', 'laydate'], function(){
			var table = layui.table;
			var laypage = layui.laypage;
			var layer = layui.layer;
			var form = layui.form;
			var laydate = layui.laydate;
			
			laydate.render({
				elem: '#ruzhiTime',
				range : "~"
				/* range: true  区间时间选择*/
			});
			
			//绑定文章表格
			var tableIns = table.render({
				id: 'dataList',
				elem: '#dataList',
				url: '/${applicationScope.adminprefix }/finance/statisticsListData', //数据接口
				cellMinWidth: 100,
				page: true, //开启分页
				limits: [10, 20, 30, 40, 50],
				cols: [
					[	
						//表头
						{
							width:'13%',
							field: 'typeText',
							title: '统计类型',
						},
						{
							width:'10%',
							field: 'studentPay',
							title: '学生缴费收入',
						},
						{
							width:'10%',
							field:"activityIncome",	
							title: '活动收入',
						},
						{
							width:'17%',	
							field: 'otherIncome',
							title: '其他收入',
						}, 
						{
							width:'13%',	
							field: 'expenditure',
							title: '购买支出',
						},
						{
							width:'13%',
							field: 'otherBuy',
							title: '其他支出',
						},
						{
							width:'13%',	
							field: 'profit',
							title: '总收益',
						},
						{
							fixed: 'right',
							title: '操作',
							width:'10%',
							align: 'center',
							toolbar: '#barDemo',
							rowType:"operation",
						}
					]
				],
				done: function(res, curr, count){
					
				 }
			});
			
			
			//监听锁定操作
			form.on('checkbox(approveFilter)', function(obj){
				var id = obj.value;
				if(obj.elem.checked){
					unapproveOraprove(id, 1);
				}else{
					unapproveOraprove(id, 0);
				}
			});
			table.on('tool(tableContent)', function(obj){
				var data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				var tr = obj.tr; //获得当前行 tr 的DOM对象
				
				if(layEvent === 'delete'){ //删除
					delStatistics(data.Id);
			  	}
			})
			
			$('#search').click(function() { //搜索，重置表格
				tableIns.reload({
					where: { //设定异步数据接口的额外参数，任意设
						statisticsType:$('#statisticsType').val(),
						tjTime:$('#tjTime').val(),
					},
					page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			})
			$('#reset').click(function(){//重置
				$('#statisticsType').val("");
				$('#tjTime').val("");
				tableIns.reload({
					where: { //设定异步数据接口的额外参数，任意设
						statisticsType:"",
						tjTime:"",
					},
					page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			})
			
			
			//删除操作
			function delStatistics(staId){
				layer.confirm('确定删除该教师吗？', {icon: 7}, function(){
					$.ajax({
						type : "POST",
						url : "/${applicationScope.adminprefix }/finance/delStatistics",
						data : {"infoId" : staId},
						success : function(data) {
							tableIns.reload({
								where: { //设定异步数据接口的额外参数，任意设
									num:Math.random()
								},
								page: {
									curr: 1 //重新从第 1 页开始
								}
							});
							if(data.result){
								layer.msg(data.msg,{icon: 1});
							}else{
								layer.msg(data.msg,{icon: 2});
							}
						},
						error : function(data) {
							layer.alert(data.msg,{icon: 2});
						}
					});
				})
			}
			
		});
		
	</script>
</m:Content>
</m:ContentPage>
