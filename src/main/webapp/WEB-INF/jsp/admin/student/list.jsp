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
			学生列表
		</blockquote>
		<div class="yw_cx">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">学生姓名：</label>
					<div class="layui-input-inline">
						<input type="text" name="studentName" id="studentName" placeholder="请填写学生姓名" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">父母姓名：</label>
					<div class="layui-input-inline">
						<input type="text" name="parent" id="parent" placeholder="请填父母姓名" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">所属门店：</label>
					<div class="layui-input-inline">
						<select class="layui-input" name="inShop" id="inShop">
							<option value="">请选择</option>
								<c:forEach items="${shopList}" var="slist">
									<option value="${slist.Id}">${slist.shopName}</option>
								</c:forEach>
						</select>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">所属班级：</label>
					<div class="layui-input-inline">
						<select class="layui-input" name="inClass" id="inClass">
							<option value="">请选择</option>
								<c:forEach items="${classList}" var="clist">
									<option value="${clist.Id}">${clist.className}</option>
								</c:forEach>
						</select>
					</div>
				</div>
				
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">入学时间：</label>
					<div class="layui-input-inline">
						<input type="text" name="ruxueTime" id="ruxueTime" lay-verify="date" autocomplete="off" class="layui-input">
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
				<div class="layui-inline" id="layerDemo" style="margin-left: -7%;">
					<div class="layui-input-inline">
						<button class="layui-btn layui-btn-normal" id="addStudent"><i class="layui-icon">&#xe654;</i>添加学生</button>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-form">
			<table class="layui-table" lay-skin="line" id="dataList" lay-filter="tableContent"></table>
		</div>
		<div id="demo7"></div>
		
	</div>
	<script type="text/html" id="fatherinfo">
  		{{# if(d.fatherName!=null && d.fatherName!='' && d.fatherPhone!=null && d.fatherPhone!=''){ }}
			{{d.fatherName}}/{{d.fatherPhone}}
		{{# }else{ }}
		{{#	if(d.fatherName!=null){ }}
				{{d.fatherName}}
		{{#	} }}
		{{#	if(d.fatherPhone!=null){ }}
				{{d.fatherPhone}}
		{{#	} }}	 		

		{{# } }}
	</script>
	<script type="text/html" id="motherinfo">
		{{# if(d.motherName!=null && d.motherName!='' && d.motherPhone!=null && d.motherPhone!=''){ }}
			{{d.motherName}}/{{d.motherPhone}}
		{{# }else{ }}
		{{#	if(d.motherName!=null){ }}
				{{d.motherName}}
		{{#	} }}
		{{#	if(d.motherPhone!=null){ }}
				{{d.motherPhone}}
		{{#	} }}	 		

		{{# } }}

  		
	</script>
	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-xs" lay-event="update">编辑</a>
		<a class="layui-btn layui-btn-xs" style="background-color: red;" lay-event="delete">删除</a>
	</script>
	<script type="text/html" id="isPay">
		{{# if(d.isPay==0){ }}
			{{d.isPayText}}/{{d.payType}}
		{{# }else{ }}
			{{d.isPayText}}
		{{# } }}
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
				elem: '#ruxueTime',
				range : "~"
				/* range: true  区间时间选择*/
			});
			
			//绑定文章表格
			var tableIns = table.render({
				id: 'dataList',
				elem: '#dataList',
				url: '/${applicationScope.adminprefix }/student/studentListData', //数据接口
				cellMinWidth: 100,
				page: true, //开启分页
				limits: [10, 20, 30, 40, 50],
				where:{
		            'type':${isPayType},
		        },
				cols: [
					[	
						//表头
						{
							width:'8%',
							field: 'stuName',
							title: '学生姓名',
						},
						{
							width:'5%',
							field: 'sexText',
							title: '性别',
						},
						{
							width:'5%',
							field:"age",	
							title: '年龄',
						},
						{
							width:'15%',	
							toolbar: '#fatherinfo',
							title: '父亲姓名及电话',
						}, 
						{
							width:'15%',	
							toolbar: '#motherinfo',
							title: '母亲姓名及电话',
						},
						{
							width:'9%',
							field: 'shopName',
							title: '所属门店',
						},
						{
							width:'9%',	
							field: 'className',
							title: '所属班级',
						},
						{
							width:'10%',
							field: 'entranceTime',
							title: '入学时间',
						},
						{
							width:'14%',
							toolbar: '#isPay',
							title: '是否缴费',
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
				
				if(layEvent === 'update'){ //编辑
			  		updStudent(2,data.Id);
			  	}else if(layEvent === 'delete'){ //删除
			  		delStudent(data.Id);
			  	}
			})
			
			
			$('#search').click(function() { //搜索，重置表格
				tableIns.reload({
					where: { //设定异步数据接口的额外参数，任意设
						studentName:$('#studentName').val(),
						parentsinfo:$('#parent').val(),
						inShop:$("#inShop").val(),
						inClass:$("#inClass").val(),
						ruxueTime:$("#ruxueTime").val(),
						type:${isPayType},
					},
					page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			})
			$('#reset').click(function(){//重置
				$('#studentName').val("");
				$('#parent').val("");
				$("#inShop").val("");
				$("#inClass").val("");
				$("#ruxueTime").val("")
				tableIns.reload({
					where: { //设定异步数据接口的额外参数，任意设
						studentName:"",
						parentsinfo:"",
						inShop:"",
						inClass:"",
						ruxueTime:"",
						type:${isPayType},
					},
					page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			})
			//添加学生
			$("#addStudent").click(function(){
				updStudent(1," ");
			})
			
			//编辑学生信息
			function updStudent(type,Id){
				var title = "编辑学生信息";
				if(type==1){
					title = "添加学生信息";
				}
				openwindow("/student/addStudentFace?type="+type+"&isPayType="+${isPayType}+"&stuId="+Id,title,1000,1500,false,function(){
					tableIns.reload({
						page: {
							curr: 1
						}
					});
				});
			}
			
			//删除操作
			function delStudent(stuId){
				layer.confirm('确定删除该学生吗？', {icon: 7}, function(){
					$.ajax({
						type : "POST",
						url : "/${applicationScope.adminprefix }/student/delStudentInfo",
						data : {"stuId" : stuId},
						success : function(data) {
							tableIns.reload({
								where: { //设定异步数据接口的额外参数，任意设
									type:${isPayType},
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
