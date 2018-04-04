	/**
	 * 产品管理.js
	 */
	var datagrid;
	var editor;
	$(function() { 
		datagrid = $('#datagrid').datagrid({
			method:'post',
			url : '/admin/product?method=categorys',
			pagination : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
			fit : true,
			fitColumns : false,
			nowrap : false,
			border : false,
			idField : 'id',
			singleSelect:true,
			rownumbers: true,
			toolbar:[ {
				text:"新增",
				iconCls : 'icon-add',
				handler : add
			},{
				text:"刷新",
				iconCls : 'icon-reload',
				handler : reload
			}],
			onBeforeLoad : function(param){
				 param["currentPage"] = param.page;
                 param["pageCount"] = param.rows;
                 delete param.rows;
                 delete param.page;
            },
 			frozenColumns : [[{
				field : 'id',
				title:'序号',
				align:'center',
				hidden:true,
				width : 50
			},{
				title : '产品名称',
				field : 'name',
				align:'center',
				sortable:true,
				width : 150
			}, {
				title : '产品类别',
				field : 'category',
				align:'center',
				formatter:function(value,row,index){
					return value.description;
				},
				width : 150
			}, {
				title : '图片地址',
				field : 'image',
				align:'center',
				width : 450
			},{
				title : '库存',
				field : 'inventory',
				align:'center',
				sortable:true,
				width : 80
			},{
				title : '规格',
				field : 'specification',
				align:'center',
				sortable:true,
				formatter:function(value,row,index){
					return value.desc;
				},
				width : 80
			},{
				title : '重量',
				field : 'weight',
				align:'center',
				sortable:true,
				formatter:function(value,row,index){
					return row.specification.weight+row.specification.unit;
				},
				width : 80
			},{
				title : '价格',
				field : 'price',
				align:'center',
				sortable:true,
				formatter:function(value,row,index){
					return "￥"+value;
				},
				width : 80
			},{
				title : '描述',
				field : 'content',
				align:'center',
				sortable:true,
				width : 80
			},{
				title : '状态',
				field : 'status',
				align:'center',
				sortable:true,
				formatter:function(value,row,index){
					return value.desc;
				},
				width : 80
			},{
				title : '创建时间',
				field : 'createTime',
				align:'center',
				sortable:true,
				width : 80
			},{
				title : '是否打折',
				field : 'discounted',
				align:'center',
				formatter:function(value,row,index){
					return value?"是":"否";
				},
				sortable:true,
				width : 80
			},{
				title : '折后价',
				field : 'discountPrice',
				align:'center',
				sortable:true,
				width : 80
			}, {field : 'opt',
				title:'操作选项',
				align:'center',
				width : 300,
				formatter:function(value,row,index){
					var handleHtml = "";
					if(row.status.name == 'TO_SELL'){
						handleHtml += "<a href='javascript:void(0);' onclick='edit("+row.id+")'>修改</a>&nbsp;";
						handleHtml += "<a href='javascript:void(0);' onclick='changeStatus("+row.id+",0)'>上架</a>&nbsp;";
					}
					if(row.status.name == 'FAYE_FLY'){
						handleHtml += "<a href='javascript:void(0);' onclick='changeStatus("+row.id+",1)'>下架</a>&nbsp;";
					}
					handleHtml += "<a href='javascript:void(0);' onclick='del("+row.id+")'>删除</a>&nbsp;";
					handleHtml += "<a href='javascript:void(0);' onclick='view("+row.id+")'>查看</a>&nbsp;";
					return handleHtml;
				}
			}
			
			] ]
		});
		
	});			
	
	//新增
	function add(obj){
		var win;
		win = $("<div></div>").dialog({
			title:'新增',
			width:900,
			height:'90%',
			maximizable:true,
			modal:true,
			href:'/pages/admin/menu/productConfig/add.jsp',
			onClose:function(){
				$(this).dialog("destroy");
			},
			buttons:[{
				text:'确定',
			    iconCls:'icon-ok',
			    handler:function(){
		    		$("#productAddForm").form('submit',{
			    		 type:'POST',
			    		 url:'/admin/product',
			    		 success:function(data){
			    			 	$.messager.show({"title":"系统提示","msg":"新增产品成功！","timeout":1000});
			    			 	$("#datagrid").datagrid("reload");
								win.dialog('destroy');
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
	function edit(sid){
		win = $("<div></div>").dialog({
			title:'编辑',
			width:900,
			height:'90%',
			maximizable:true,
			modal:true,
			href:'/admin/product?method=updateProductPrepare&adminIgnoreAjaxHeader=false&productId='+sid,
			onClose:function(){
		    	$(this).dialog("destroy");
		    },
			buttons:[{
					text:'确定',
				    iconCls:'icon-ok',
				    handler:function(){
				    	$("#productAddForm").form('submit',{
				    		 type:'POST',
				    		 url:'/admin/product',
				    		 success:function(data){
			    			 	$.messager.show({"title":"系统提示","msg":"修改产品成功！","timeout":1000});
			    			 	$("#datagrid").datagrid("reload");
			    			 	win.dialog('destroy');
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
	
	//发布
	function changeStatus(sid,status){
		var tip = "信息无误，确定上架吗？";
		var statusEnum = "";
		if(status == 1){
			tip = "确定结束下架吗？";
			statusEnum = "TO_SELL";
		}else{
			statusEnum ="FAYE_FLY";
		}
		
		$.messager.confirm("提示",tip,function(r){
			if(r){
				$.ajax({
					type:"POST",
					url: '/admin/product?method=updateProductStatus&productId=' + sid+'&status='+statusEnum,
					dataType:"json",
					success:function(data){
	    				$.messager.show({"title":"系统提示","msg":"操作成功！","timeout":1000});
	    				$("#datagrid").datagrid("reload");
					}
				});
			}
		});
	}
	
	//查看
	function view(sid){
		win = $("<div></div>").dialog({
			title:'查看',
			width:700,
			height:400,
			maximizable:true,
			modal:true,
			href:'/admin/product?method=queryProduct&adminIgnoreAjaxHeader=false&productId='+sid,
			onClose:function(){
		    	$(this).dialog("destroy");
		    },
			buttons:[{
						 text:'关闭',
					     iconCls:'icon-cancel',  
					 	 handler:function(){
					 		 win.dialog('destroy');
					 	 }   
					}]
		});
	}
	
	//删除
	function del(sid){
		$.messager.confirm("提示","确定删除此记录吗？",function(r){
			if(r){
				$.ajax({
					type:"POST",
					url:'/admin/product?method=deleteProduct&productId=' + sid,
					dataType:"json",
					success:function(data){
	    				$.messager.show({"title":"系统提示","msg":"删除成功！","timeout":1000});
    					$("#datagrid").datagrid("reload");
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
	function doSearch(method){
		$("#datagrid").datagrid("load",serializeObject($("#giftConfigSearchForm")));
	}
	
	
	//重置
	function reset(){
		$("#giftConfigSearchForm").form("reset");
	}
	
	