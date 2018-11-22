/*package test;

import itaf.framework.common.page.Page;
import itaf.framework.log.model.AdminLog;
import itaf.framework.log.service.AdminLogService;
import itaf.framework.util.DateUtil;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solution.jxt.admin.dao.ICardAgentDao;
import solution.jxt.admin.dao.ICardBoxDao;
import solution.jxt.admin.dao.ICardHardDao;
import solution.jxt.admin.dao.ICardInvoiceStutusDao;
import solution.jxt.admin.dao.ICardProductDao;
import solution.jxt.admin.dao.ICardProductNoDao;
import solution.jxt.admin.dao.ICardSimDao;
import solution.jxt.admin.dao.IWarehouseInvoiceDao;
import solution.jxt.admin.dao.IWarehouseProductDao;
import solution.jxt.admin.model.CardAgent;
import solution.jxt.admin.model.CardBox;
import solution.jxt.admin.model.CardInvoiceStutus;
import solution.jxt.admin.model.CardProduct;
import solution.jxt.admin.model.CardProductNo;
import solution.jxt.admin.model.CardSim;
import solution.jxt.admin.model.WarehouseInvoice;
import solution.jxt.admin.model.WarehouseProduct;
import solution.jxt.storage.service.CardProductService;

@Service("cardProductService")
public class CardProductServiceImpl implements CardProductService{
	
	@Autowired 
	private ICardSimDao cardSimDao;
	
	@Autowired
	private ICardBoxDao cardBoxDao;
	
	@Autowired
	private ICardHardDao cardHardDao;
	
	@Autowired
	private ICardInvoiceStutusDao cardInvoiceStutusDao;
	
	@Autowired
	private ICardProductDao cardProductDao;
	
	@Autowired
	private ICardProductNoDao cardProductNoDao;
	
	@Autowired
	private ICardAgentDao cardAgentDao;
	
	@Autowired
	private IWarehouseInvoiceDao warehouseInvoiceDao;
	
	@Autowired
	private IWarehouseProductDao warehouseProductDao;
	
	@Autowired
	private AdminLogService adminLogService;
	
	
	
	public Object[] findAllCardProduct(Map<String, String> param) {
		Object[] reobject = new Object[2];
		Page page = cardProductDao.findCardProductByParam(param);
		Map<String,Integer> product_num = cardProductDao.findCardProductNum();
		reobject[0] = page;
		reobject[1] = product_num;
		return reobject;
	}
	
	
	//产品出库
	public Map<String,Object> doAddProductOut(Map<String,Object> param, AdminLog log) {
		String productList = (String)param.get("productList");
		WarehouseInvoice wi = (WarehouseInvoice)param.get("wi");
		String[] p_s = productList.split(";");
		int p_num = p_s.length;
		CardProduct cp = null;
		CardSim cs = null;
		CardAgent ca = null;
		CardInvoiceStutus ci = null;
		WarehouseProduct wp = null;
		
		//保存出库�?
		//生成随机库单�?
		String wi_no = DateUtil.formatDate(Calendar.getInstance().getTime(), "yyyyMMddHHmmss") + "c";
		
		WarehouseInvoice warehouse = new WarehouseInvoice();
		if(null != wi.getAgentNo() &&  !"0".equals(wi.getAgentNo()) ){
			warehouse.setAgentName(wi.getAgentName());
			warehouse.setAgentNo(wi.getAgentNo());
		}
		Date entryDate = wi.getEntryDate();
		warehouse.setEntryDate(entryDate);
		warehouse.setProductPrice(wi.getProductPrice());
		warehouse.setCardSimPrice(wi.getCardSimPrice());
		warehouse.setCardSnPrice(wi.getCardSnPrice());
		warehouse.setCardBoxPrice(wi.getCardBoxPrice());
		warehouse.setCardBoxNum(p_num);
		warehouse.setCardSimNum(p_num);
		warehouse.setCardSnNum(p_num);
		warehouse.setProductNum(p_num);
		
		warehouse.setStatus("1");
		warehouse.setWiNo(wi_no);
		warehouseInvoiceDao.create(warehouse);
		Long wi_id = warehouse.getId();
		
		//alter card agent 
		ca = cardAgentDao.findUniqueBy("agentNo", wi.getAgentNo());
		ca.setCard_box_no_agent_num(ca.getCard_box_no_agent_num() + p_num);
		ca.setCard_sim_no_agent_num(ca.getCard_sim_no_agent_num() + p_num);
		ca.setCard_sn_no_agent_num(ca.getCard_sn_no_agent_num() + p_num);
		ca.setProduct_no_agent_num(ca.getProduct_no_agent_num() + p_num);
		cardAgentDao.update(ca);
		
		StringBuilder card_nos = new StringBuilder();
		for(int i= 0; i<p_s.length; i++){
			
			
			//alter product status
			cp = cardProductDao.findUniqueBy("product_no", p_s[i]);
			cp.setPno_status("1");
			cp.setSim_status("1");
			cp.setSn_status("1");
			cp.setBox_status("1");
			cardProductDao.update(cp);
			
			card_nos.append(cp.getCard_sim()+",");
			
			//create warehouse product
			cs = cardSimDao.findUniqueBy("cardNo", cp.getCard_sim());
			wp = new WarehouseProduct();
			wp.setBoxNo(cp.getCard_box());
			wp.setCardNo(cp.getCard_sim());
			wp.setIccidNo(cs.getIccid());
			wp.setImsiNo(cs.getImsi());
			wp.setProductNo(p_s[i]);
			wp.setSnNo(cp.getCard_sn());
			wp.setWiNo(wi_no);
			wp.setWiId(wi_id);
			warehouseProductDao.create(wp);
			
			//alter card invoice
			ci = cardInvoiceStutusDao.findUniqueBy("cpId", cp.getId());
			ci.setCard_box_no_out_date(entryDate);
			ci.setCard_sim_no_out_date(entryDate);
			ci.setCard_sn_no_out_date(entryDate);
			ci.setProduct_no_out_date(entryDate);
			
			ci.setCard_box_no_agent_name(wi.getAgentName());
			ci.setCard_sim_no_agent_name(wi.getAgentName());
			ci.setCard_sn_no_agent_name(wi.getAgentName());
			ci.setProduct_no_agent_name(wi.getAgentName());
			
			ci.setCard_box_no_wi_out_id(wi_id);
			ci.setCard_sim_no_wi_out_id(wi_id);
			ci.setCard_sn_no_wi_out_id(wi_id);
			ci.setProduct_no_wi_out_id(wi_id);
			cardInvoiceStutusDao.update(ci);
		}
		//更新3G卡出货时�?
		cardProductDao.doUpdateCard3gByCardNos(card_nos.toString().substring(0, card_nos.length()-1), DateUtil.formatDate(entryDate));
		
		param.put("message", "恭喜您！出库成功！您�?��出库�?" + p_num +"个完整的产品�? 
				+ p_num + "个硬件卡�? + p_num + "个SIM卡，" + p_num + "个盒子�?");
		log.setLogDesc("仓库产品出库�?+ wi_no );
		adminLogService.doCreate(log);
		return param;
	}


	public Map<String, String> doAddCardProductNo(Map<String, String> param, AdminLog log) {
		String name1 = param.get("name1");
		String name2 = param.get("name2");
		String startNo = param.get("startNo");
		String endNo = param.get("endNo");
		String sequance = param.get("sequance");
		CardProductNo pno = cardProductNoDao.findcpNoByName(name1,name2);
		if(null == pno){
			CardProductNo p_no = new CardProductNo();
			p_no.setEnable("1");
			p_no.setName1(name1);
			p_no.setName2(name2);
			p_no.setStartNo(startNo);
			p_no.setEndNo(endNo);
			p_no.setSequance(sequance);
			p_no.setUsed("0");
			cardProductNoDao.create(p_no);
			param.put("message", "新增成功");
		}else{
			param.put("error", "产品编号前缀已被使用，请更换");
		}
		log.setLogDesc("新增产品编号�?+ name1 + name2);
		adminLogService.doCreate(log);
		return param;
	}


	public Page findAllcpn(Map<String, String> param) {
		return cardProductNoDao.findAllcpn(param);
	}

	public String idoDeleteProductNo(String deleteFlag, AdminLog log) {
		cardAgentDao.updateBySql(" delete from card_product_no where id in(" + deleteFlag +")");
		log.setLogDesc("修改产品编号");
		adminLogService.doCreate(log);
		return "success";
	
	}

	public void doUpdatePnEnable(Map<String, String> param, AdminLog log) {
		CardProductNo cpn =  cardProductNoDao.findById(Long.parseLong(param.get("recordKey")));
		cpn.setEnable(param.get("status"));
		cardProductNoDao.update(cpn);
		log.setLogDesc("修改产品编号是否可用");
		adminLogService.doCreate(log);
	}

	public String doAddProductNo(CardProductNo cpn, AdminLog log) {
		String name1 = cpn.getName1();
		String name2 = cpn.getName2();
		CardProductNo pn = cardProductNoDao.findcpNoByName(name1,name2);
		if(null != pn)
			return "编号重复，请更换编号";
		cpn.setEnable("1");
		cpn.setUsed("0");
		cardProductNoDao.create(cpn);
		log.setLogDesc("新增产品编号" + name1 + name2);
		adminLogService.doCreate(log);
		return "success";
	}


	public String doUpdatePN(Map<String, Object> param) {
		AdminLog log = (AdminLog)param.get("log");
		CardProductNo cpn = (CardProductNo) param.get("cpn");
		CardProductNo pn = cardProductNoDao.findcpNoByName(cpn.getName1(),cpn.getName2());
		if(null != pn && !pn.getId().equals(cpn.getId()))
			return "编号重复，请更换编号";
		
		CardProductNo cardProductNo = cardProductNoDao.findById(cpn.getId());
		
		cardProductNo.setName1(cpn.getName1());
		cardProductNo.setName2(cpn.getName2());
		cardProductNo.setStartNo(cpn.getStartNo());
		cardProductNoDao.update(cardProductNo);
		
		log.setLogDesc("新增产品编号" + cpn.getName1() + cpn.getName2());
		adminLogService.doCreate(log);
		return "success";
	}


	
	//---------------------       sim卡管�?        -------------------------------------
	
	public Page findAllCS(Map<String, String> param) {
		return cardSimDao.findAllCS(param);
	}
	
	public String doAddCS(Map<String, Object> param) {
		return null;
	}


	public String doDeleteCS(String deleteFlag, AdminLog adminLog) {
		cardSimDao.updateBySql(" delete from card_sim where pk_auto_incremental in(" + deleteFlag +")");
		return "success";
	}


	public String doEditCS(Map<String, Object> param) {
		CardSim cs = (CardSim) param.get("cs");
		CardSim temp = cardSimDao.findUniqueBy("cardNo", cs.getCardNo());
		if(null != temp && !temp.getId().equals(cs.getId()))
			return "您输入卡号已被其他卡占用，请更换卡号";
		CardSim old_cs = cardSimDao.findById(cs.getId());
		if(null != cs.getActiveTime())
			old_cs.setActiveTime(cs.getActiveTime());
		if(null != cs.getProviderTime())
			old_cs.setProviderTime(cs.getProviderTime());
		old_cs.setCardNo(cs.getCardNo());
		old_cs.setIccid(cs.getIccid());
		old_cs.setMessagePrice(cs.getMessagePrice());
		old_cs.setMonthCost(cs.getMonthCost());
		old_cs.setOutNetPrice(cs.getOutNetPrice());
		old_cs.setPackageName(cs.getPackageName());
		old_cs.setPackageNo(cs.getPackageNo());
		old_cs.setPuk(cs.getPuk());
		old_cs.setVpdnPrice(cs.getVpdnPrice());
		return "success";
	}
	
	public CardSim findCSById(long id) {
		return cardSimDao.findById(id);
	}

	public CardSim findCSByImsi(String imsi) {
		return cardSimDao.findUniqueBy("imsi", imsi);
	}

	//---------------------       盒子管理         -------------------------------------
	public Page findAllCB(Map<String, String> param) {
		return cardBoxDao.findAllCB(param);
	}


	public String doAddCB(Map<String, Object> param) {
		return null;
	}


	public CardBox findCBByID(String recordKey) {
		return cardBoxDao.findById(Long.parseLong(recordKey));
	}

	public String doEditCB(Map<String, Object> param) {
		
		
		return null;
	}
	
	public String doDeleteCB(String deleteFlag, AdminLog adminLog) {
		
		
		return null;
	}

	//---------------------       硬件卡管�?        -------------------------------------
	public Page findAllCH(Map<String, String> param) {
		return cardHardDao.findAllCH(param);
	}
	
}
*/