<#import "/templets/commonQuery/CommonQueryTagMacro.ftl" as CommonQueryMacro>
<@CommonQueryMacro.page title="�ʽ�������ͽṺ����Ϣ">
<@CommonQueryMacro.CommonQueryTab id="bopCfaStrdeDsEntryTabs" navigate="false" currentTab="bopCfaStrdeDsEntryInoutMo">
	<@CommonQueryMacro.CommonQuery id="bopCfaStrdeDsEntryInoutMo" init="false" submitMode="all" navigate="false" >
		<table align="left">
			<tr>
				<td colspan="2">
					<@CommonQueryMacro.Interface id="interface" label="�������ѯ����" />
				</td>
			</tr>
			<tr>
				<td valign="top">
					<@CommonQueryMacro.PagePilot id="ddresult" maxpagelink="9" showArrow="true" />
				</td>
		    </tr>
		    <tr>
		    	<td colspan="2">
					<@CommonQueryMacro.DataTable id ="datatable1" paginationbar="btAdd" fieldStr="operation[100],filler2[80],workDate[100],actiontype[80],recStatus[80],approveStatus[80],repStatus[80],branchcode[120],buocmonth[100],currency[200],moexamusd,moamreusd,mopfexamusd,mosettamusd,remark[300]" hasFrame="true" width="900" height="260" readonly="true"/>
		      	</td>
		    </tr>
		</table>
	</@CommonQueryMacro.CommonQuery>
</@CommonQueryMacro.CommonQueryTab>
</td></tr></table>
<script language="JavaScript">
	function initCallGetter_post() {
		//��������
		<#assign v_txdate = statics["com.huateng.ebank.business.common.GlobalInfo"].getCurrentInstance().getTxdate()>
		bopCfaStrdeDsEntryInoutMo_interface_dataset.setValue("qworkDateStart","${v_txdate}");
		bopCfaStrdeDsEntryInoutMo_interface_dataset.setValue("qworkDateEnd","${v_txdate}");
	}
	//ˢ�²�������
	function datatable1_operation_onRefresh(cell,value,record) {
		if(record) {
			cell.innerHTML="<center><a href=\"JavaScript:doMod('"+value+"')\">�޸�</a>&nbsp;&nbsp;<a href=\"JavaScript:doDel('"+value+"')\">ɾ��</a></center>";
		} else {
			cell.innerHTML = "&nbsp;";
		}
	}
	function datatable1_filler2_onRefresh(cell,value,record) {
		if(record && record != null) {
			var id = record.getValue("id");
			cell.innerHTML = "<center><a href=\"JavaScript:doDetail('"+id+"')\">"+value+"</a></center>";
		} else {
			cell.innerHTML = "&nbsp;";
		}
	}
	
	function btAdd_onClick(button) {
			btNewClick();
	}
	//��ϸ
	function doDetail(id) {
		showWin("�ʽ�������ͽṺ����Ϣ��ϸ","${contextPath}/fpages/datacollection/ftl/BopCfaStrdeDsEntryInoutMoInfo.ftl?id="+id+"&op="+"detail");
	}	
	//����
	function btNewClick() {
		showWin("�ʽ�������ͽṺ����Ϣ����","${contextPath}/fpages/datacollection/ftl/BopCfaStrdeDsEntryInoutMoAdd.ftl?op=add","report","flushPage()");
	}
	//�޸�
	function doMod(id) {
		showWin("�ʽ�������ͽṺ����Ϣ�޸�","${contextPath}/fpages/datacollection/ftl/BopCfaStrdeDsEntryInoutMoInfo.ftl?op=mod&id="+id,"report","flushPage()");
	}
	//ɾ��
	function doDel(id) {
		showWin("�ʽ�������ͽṺ����Ϣɾ��","${contextPath}/fpages/datacollection/ftl/BopCfaStrdeDsEntryInoutMoInfo.ftl?op=del&id="+id,"report","flushPage()");
	}
	//ˢ��ҳ��
	function flushPage() {
		bopCfaStrdeDsEntryInoutMo_dataset.flushData(1);
	}
</script>
</@CommonQueryMacro.page>