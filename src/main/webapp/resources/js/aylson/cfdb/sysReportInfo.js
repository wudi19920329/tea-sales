	/**
	 * 统计报表数据查询
	 */
	var datagrid;
	var editor;
	
	$(function() { 
		datagrid = $('#datagrid').datagrid({
			method:'get',
			url : projectName+'/cfdb/sysReportInfo/admin/list?num=7',
			pagination : true,
			pageSize : 30,
			pageList : [ 30, 60, 90 ],
			fit : true,
			fitColumns : false,
			nowrap : false,
			border : false,
			idField : 'dateStr',
			singleSelect:true,
			rownumbers: true,
			toolbar:[{
				text:"详细列表"
			},{
				text:"刷新",
				iconCls : 'icon-reload',
				handler : reload
			}],
 			frozenColumns : [[ {
				title : '日期',
				field : 'dateStr',
				align : 'center',
				width : 200
			}, {
				title : '新增用户数',
				field : 'newUserOfDay',
				align : 'center',
				width : 120
			}, {
				title : '做任务总人数',
				field : 'userCountOfTask',
				align : 'center',
				width : 120
			}, {
				title : '完成任务总数',
				field : 'taskCountOfFinished',
				align : 'center',
				width : 120
			}, {
				title : '用户总收入',
				field : 'userIncomeOfDay',
				align : 'center',
				width : 120
			}, {
				title : '公司总收入',
				field : 'sysIncomeOfDay',
				align : 'center',
				width : 120
			}
			] ]
		});
		
	});
	
	//新增
	function add(obj){
		var win;
		win = $("<div></div>").dialog({
			title:'新增',
			width:450,
			height:'60%',
			modal:true,
			href:projectName+'/cfdb/sysReportInfo/admin/toAdd',
			onClose:function(){
				$(this).dialog("destroy");
			},
			buttons:[{
				text:'确定',
			    iconCls:'icon-ok',
			    handler:function(){
				    	$("#sysReportInfoConfigForm").form('submit',{
				    		 type:'POST',
				    		 url : projectName+'/cfdb/sysReportInfo/admin/add',
				    		 success:function(responseData){
				    			 if(responseData){
				    				var data = $.parseJSON(responseData);
				    			 	$.messager.show({"title":"系统提示","msg":data.message,"timeout":1000});
				    			 	if(data.success){
										$("#datagrid").datagrid("reload");
										win.dialog('destroy');
				    				}
				    			 } 
				    		 }
				    	 });
			    }   
			   },{
				 text:'取消',
			     iconCls:'icon-cancel',  
			 	 handler:function(){
			 		 win.dialog('destroy');
			 	 }   
			  }]
		});
	}
	
	//修改
	function edit(id){
		win = $("<div></div>").dialog({
			title:'修改',
			width:450,
			height:'60%',
			maximizable:true,
			modal:true,
			href:projectName+'/cfdb/sysReportInfo/admin/toEdit?id='+id,
			onClose:function(){
		    		$(this).dialog("destroy");
		    },
			buttons:[{
					text:'确定',
				    iconCls:'icon-ok',
				    handler:function(){
					    	$("#sysReportInfoConfigForm").form('submit',{
					    		 type:'POST',
					    		 url : projectName+'/cfdb/sysReportInfo/admin/update',
					    		 success:function(responseData){
					    			 win.dialog('destroy');
					    			 if(responseData){
					    				var data = $.parseJSON(responseData);
					    			 	$.messager.show({"title":"系统提示","msg":data.message,"timeout":1000});
					    			 	if(data.success){
					    			 		$("#datagrid").datagrid("reload");
					    				}
					    			 } 
					    		 }
					    	 });
				     }   
				   },{
					 text:'取消',
				     iconCls:'icon-cancel',  
				 	 handler:function(){
				 		 win.dialog('destroy');
				 	 }   
				  }]
		});
	}

	//删除
	function del(id){
		$.messager.confirm("提示","确定删除此记录吗？",function(r){
			if(r){
				$.ajax({
					type:"POST",
					url:projectName+'/cfdb/sysReportInfo/admin/deleteById?id=' + id,
					dataType:"json",
					success:function(data){
						if(data){
		    				$.messager.show({"title":"系统提示","msg":data.message,"timeout":1000});
		    				if(data.success){
		    					$("#datagrid").datagrid("reload");
		    				}
		    			 }
					}
				});
			}
		});
	}
	
	//刷新
	function reload(){
		$("#datagrid").datagrid("reload");
	}
	
	//搜索
	function doSearch(num){
		getMapData(num);
		//查询参数直接添加在queryParams中     
        $('#datagrid').datagrid({  
        		url : projectName+'/cfdb/sysReportInfo/admin/list?num=' + num
        })  
        var queryParams =$('#datagrid').datagrid('options').queryParams;  
        getQueryParams(queryParams);  
        $('#datagrid').datagrid('options').queryParams = queryParams;  
       	$("#datagrid").datagrid('reload'); 
	}
	
	//重置
	function reset(){
		$("#sysReportInfoForm").form("reset");
	}
	