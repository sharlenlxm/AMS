package com.huateng.report.basis.getter;

import org.apache.commons.lang.StringUtils;

import resource.report.dao.ROOTDAO;
import resource.report.dao.ROOTDAOUtils;

import com.huateng.common.err.Module;
import com.huateng.common.err.Rescode;
import com.huateng.commquery.result.Result;
import com.huateng.commquery.result.ResultMng;
import com.huateng.ebank.business.common.PageQueryCondition;
import com.huateng.ebank.business.common.PageQueryResult;
import com.huateng.ebank.framework.exceptions.CommonException;
import com.huateng.ebank.framework.report.common.ReportConstant;
import com.huateng.ebank.framework.web.commQuery.BaseGetter;
import com.huateng.exception.AppException;
import com.huateng.report.utils.ReportEnum;


/**
 * Get the data from DB with HQL and full the dataset to webpage
 * @author cwenao
 * 2012-8-13
 */

public class CurrencyManEntryGetter extends BaseGetter{

	@Override
	public Result call() throws AppException {
		// TODO Auto-generated method stub

		try {
			
			this.setValue2DataBus(ReportConstant.QUERY_LOG_BUSI_NAME, "币种信息维护查询");
			
			PageQueryResult queryResult = getData();
			ResultMng.fillResultByList(getCommonQueryBean(),
					getCommQueryServletRequest(), queryResult.getQueryResult(),
					getResult());
			result.setContent(queryResult.getQueryResult());
			result.getPage().setTotalPage(queryResult.getPageCount(getResult().getPage().getEveryPage()));

			result.init();
			return result;

		} catch (AppException appEx) {
			throw appEx;
		} catch (Exception ex) {
			throw new AppException(Module.SYSTEM_MODULE,
					Rescode.DEFAULT_RESCODE, ex.getMessage(), ex);
		}
	}
	private PageQueryResult getData() throws CommonException
		{

		   ROOTDAO rootdao = ROOTDAOUtils.getROOTDAO();
		   //
		   int pageSize = getResult().getPage().getEveryPage();
		   //页码
		   int pageIndex = getResult().getPage().getCurrentPage();

		   PageQueryCondition queryCondition = new PageQueryCondition();

		   StringBuffer hql = new StringBuffer(" from SysCurrency sc where sc.del='F' ");

		   String qCurrencyCode = getCommQueryServletRequest().getParameter("qCurrencyCode");
		   String qCurrencyName = getCommQueryServletRequest().getParameter("qCurrencyName");
		   String qst = getCommQueryServletRequest().getParameter("st");

		   if(StringUtils.isNotBlank(qCurrencyCode))
		   {
			   hql.append(" and lower(sc.id) like lower('%").append(qCurrencyCode).append("%')");
		   }
		   if(StringUtils.isNotBlank(qCurrencyName))
		   {
			   hql.append(" and sc.currencyName like '%").append(qCurrencyName).append("%'");
		   }
		   if(qst!=null && qst.length()>0){
			   hql.append(" and sc.st ='"+qst+"'");
		   }else{
			   
			   hql.append(" and sc.st<>'"+ReportEnum.REPORT_ST1.N.value+"'");
		   }
		   
		   hql.append(" order by sc.id,sc.currencyName");

		   queryCondition.setPageIndex(pageIndex);
		   queryCondition.setPageSize(pageSize);
		   queryCondition.setQueryString(hql.toString());

		   return (PageQueryResult) rootdao.pageQueryByQL(queryCondition);

		}
}
