/*package test;

import itaf.framework.common.page.ExtremeTablePage;
import itaf.framework.common.page.Page;
import itaf.framework.util.DateUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ecside.table.limit.Limit;
import org.springframework.beans.factory.annotation.Autowired;

import solution.jxt.action.util.AdminLogUtil;
import solution.jxt.admin.model.CardAgent;
import solution.jxt.admin.model.CardProduct;
import solution.jxt.admin.model.WarehouseInvoice;
import solution.jxt.admin.vo.CardProductVO;
import solution.jxt.agent.sevice.CardAgentService;
import solution.jxt.storage.service.CardProductService;
import solution.jxt.storage.service.StorageService;

import com.svw.framework.web.action.AjaxAction;

@SuppressWarnings("serial")
public class CardProductAction  extends AjaxAction{
	
	@Autowired 
	private StorageService storageService;
	
	@Autowired 
	private CardProductService cardProductService;
	
	@Autowired
	private CardAgentService cardAgentService;
	
	@SuppressWarnings("unchecked")
	public  String view(){
		Limit limit = ExtremeTablePage.getLimit(request,"ec",10);
		Map<String,String> param = new HashMap<String,String>();
		param.put("pageNo", limit.getPage()+"");
		param.put("pageSize", limit.getCurrentRowsDisplayed()+"");
		
		param.put("p_no", request.getParameter("p_no"));
		param.put("p_no_from", request.getParameter("p_no_from"));
		param.put("p_no_to", request.getParameter("p_no_to"));
		
		param.put("card_no", request.getParameter("card_no"));
		param.put("card_no_from", request.getParameter("card_no_from"));
		param.put("card_no_to", request.getParameter("card_no_to"));
		
		param.put("sn_no", request.getParameter("sn_no"));
		param.put("sn_no_from", request.getParameter("sn_no_from"));
		param.put("sn_no_to", request.getParameter("sn_no_to"));
		
		param.put("box_no", request.getParameter("box_no"));
		param.put("box_no_from", request.getParameter("box_no_from"));
		param.put("box_no_to", request.getParameter("box_no_to"));
		
		param.put("p_type", request.getParameter("p_type"));
		param.put("p_status", request.getParameter("p_status"));
		
		param.put("agent_name", getKeyword(request.getParameter("agent_name")));
		param.put("provider_name", getKeyword(request.getParameter("provider_name")));
   	 
		param.put("start_entryTime", request.getParameter("start_entryTime"));
		param.put("end_entryTime", request.getParameter("end_entryTime"));
		
		Object[] reObject = storageService.findCardStorage(param);
		Page page = (Page)reObject[0];
		cardProduct_list = (List<CardProductVO>)page.getResult();
		p_num = (Map<String,Integer>)reObject[1];
		
		request.setAttribute("agent_list", cardAgentService.findAllAgent("1"));
		request.setAttribute("provider_list", cardAgentService.findAllAgent("2"));
		
		limit.setRowAttributes(page.getTotalCount(), limit.getCurrentRowsDisplayed());
		return SUCCESS;
	}
	
	public String preAddProductOut(){
		agentList = cardAgentService.findAllAgent("1");
		productList = getProductList();
		return SUCCESS;
	}
	
	public void addProductOut(){
		Map<String,Object> param = new HashMap<String,Object>();
		wi.setEntryDate(DateUtil.parse(entryDate, "yyyy-MM-dd"));
		wi.setAgentName(getKeyword(wi.getAgentName()));
		param.put("productList", productList);
		param.put("status", "1");
		param.put("wi", wi);
		param = cardProductService.doAddProductOut(param, AdminLogUtil.getAdminLog());
		if(null != param.get("error")){
			ajaxForAction((String)param.get("error"));  
		}else if(null != param.get("message")){
			ajaxForAction((String)param.get("message"));  
		}
	}
	
	private WarehouseInvoice wi;
	private List<CardProduct> card_list ;
	private List<CardProductVO> cardProduct_list;
	private List<CardAgent> agentList;
	private Map<String,Integer> p_num;
	private String productList;
	private String entryDate;
	
	public WarehouseInvoice getWi() {
		return wi;
	}

	public void setWi(WarehouseInvoice wi) {
		this.wi = wi;
	}

	public List<CardProduct> getCard_list() {
		return card_list;
	}

	public void setCard_list(List<CardProduct> cardList) {
		card_list = cardList;
	}

	public List<CardProductVO> getCardProduct_list() {
		return cardProduct_list;
	}

	public List<CardAgent> getAgentList() {
		return agentList;
	}

	public void setAgentList(List<CardAgent> agentList) {
		this.agentList = agentList;
	}

	public void setCardProduct_list(List<CardProductVO> cardProductList) {
		cardProduct_list = cardProductList;
	}

	public Map<String, Integer> getP_num() {
		return p_num;
	}

	public void setP_num(Map<String, Integer> pNum) {
		p_num = pNum;
	}

	public String getProductList() {
		return productList;
	}

	public void setProductList(String productList) {
		this.productList = productList;
	}

	public String getEntryDate() {
		return entryDate;
	}

	public void setEntryDate(String entryDate) {
		this.entryDate = entryDate;
	}

}
*/