package test3;

import itaf.framework.common.page.Page;
import itaf.framework.log.model.AdminLog;
import itaf.framework.log.service.AdminLogService;
import itaf.framework.util.DateUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solution.jxt.admin.dao.ICard3gDao;
import solution.jxt.admin.dao.ICardAgentDao;
import solution.jxt.admin.dao.ICardBoxDao;
import solution.jxt.admin.dao.ICardHardDao;
import solution.jxt.admin.dao.ICardInvoiceStutusDao;
import solution.jxt.admin.dao.ICardProductDao;
import solution.jxt.admin.dao.ICardSimDao;
import solution.jxt.admin.dao.IPackageDao;
import solution.jxt.admin.dao.IWarehouseInvoiceDao;
import solution.jxt.admin.dao.IWarehouseProductDao;
import solution.jxt.admin.model.Card3g;
import solution.jxt.admin.model.CardAgent;
import solution.jxt.admin.model.CardBox;
import solution.jxt.admin.model.CardHard;
import solution.jxt.admin.model.CardInvoiceStutus;
import solution.jxt.admin.model.CardProduct;
import solution.jxt.admin.model.CardSim;
import solution.jxt.admin.model.Package;
import solution.jxt.admin.model.WarehouseInvoice;
import solution.jxt.admin.model.WarehouseProduct;
import solution.jxt.storage.service.StorageService;

@Service("storageService")
public class StorageServiceImpl implements StorageService{
	
	@Autowired
	private ICardHardDao cardHardDao;
	
	@Autowired
	private ICardBoxDao cardBoxDao;
	
	@Autowired 
	private ICardSimDao cardSimDao;
	
	@Autowired
	private ICardInvoiceStutusDao cardInvoiceStutusDao;
	
	@Autowired
	private ICardProductDao cardProductDao;
	
	@Autowired
	private ICardAgentDao cardAgentDao;
	
	@Autowired
	private IWarehouseInvoiceDao warehouseInvoiceDao;
	
	@Autowired
	private IWarehouseProductDao warehouseProductDao;
	
	@Autowired
	private ICard3gDao card3gDao;
	
	@Autowired
	private IPackageDao packageDao;
	
	@Autowired
	private AdminLogService adminLogService;

	public WarehouseInvoice findWIByWINo(String recordKey) {
		return warehouseInvoiceDao.findUniqueBy("wiNo", recordKey);
	}
	
	public Object[] findCardStorage(Map<String,String> param) {
		Object[] reobject = new Object[2];
		Page page = cardProductDao.findCardProductByParam(param);
		Map<String,Integer> product_num = cardProductDao.findCardProductNum();
		reobject[0] = page;
		reobject[1] = product_num;
		return reobject;
	}

	public Page findAllWI(Map<String, Object> param) {
		return warehouseInvoiceDao.findAllWI(param);
	}
	
	//新增入库
	public Map<String,Object> doCreateWIForIn(Map<String, Object> param, AdminLog log) {
		if (null != fileTypeValidator(param).get("error")) {
			return param;
		}
		if (null != readFileValidator(param).get("error")) {
			return param;
		}
		return createWIForIn(param, log);
	}

	
	/**
	 * 上传方案严整
	 * @param 	validator_str      用户(自定�?匹配模式
	 * @param   str                将要验证的字�?
	 * */
	public boolean validatorFasion(String validator_str, String str){
		return Pattern.compile( validator_str ).matcher(str).matches();
	} 
	
	/**
	 * 文件类型和大小严�?
	 * */
	public Map<String, Object> fileTypeValidator(Map<String, Object> param) {
		File file = (File) param.get("file");
		String fileFileName = (String) param.get("fileFileName");
		if (file.length() > 1024*2000L) {
			param.put("error", "上传方案太大!");
			return param;
		}
		if (null == fileFileName) {
			param.put("error", "方案名称有误!");
			return param;
		} else {
			int j = fileFileName.indexOf(".");
			if (-1 == j) {
				param.put("error", "方案名称有误!");
				return param;
			} else if (!"xls".equals(fileFileName.substring(j + 1, fileFileName.length()))) {
				param.put("error", "请使�?.xls 文件!");
				return param;
			}
		}
		return param;
	}
	
	/**
	 * 读取xls文件
	 * */
	public Map<String, Object> readFileValidator(Map<String, Object> param) {
		File file = (File) param.get("file");
		Workbook book = null;
		try {
			book = Workbook.getWorkbook(file);
		} catch (BiffException e) {
			e.printStackTrace();
			param.put("error", "读取文件错误!");
			return param;
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(null == book){
			param.put("error", "读取文件错误!");
			return param;
		}
		Sheet sheet = book.getSheet(0);
		int rsCols = sheet.getColumns(); 
		int rsRows = sheet.getRows(); 
		int nullCellNum; 
		int rows = rsRows; 
		//去除行中为空的单元格数，得到行数
		for (int i = 1; i < rsRows; i++) { 
		   nullCellNum = 0; 
		    for (int j = 0; j < rsCols; j++) { 
		        String val = sheet.getCell(j, i).getContents(); 
		        val = StringUtils.trimToEmpty(val); 
		        if (StringUtils.isBlank(val)) 
		           nullCellNum++; 
		    } 
		    if (nullCellNum >= rsCols) { 
		    	rows--;          
		   } 
		} 
		param.put("rows", rows);
		param.put("book", book);
		return param;
	}
	
	
	
	/**
	 * 1.文件内容校验 
	 * 2.保存入库单，保存产品�?
	 *   如果上传文件出错，或者，库存里已经有该产品，返回错误信息到前�?
	 *   
	 * 3.如果是一张完整的卡，则新增一�?G�?
	 * */
	public Map<String, Object> createWIForIn(Map<String, Object> param, AdminLog log) {
		WarehouseInvoice wi = (WarehouseInvoice)param.get("wi");
		Workbook book = (Workbook)param.get("book");
		Sheet sheet = book.getSheet(0); 
		int rows = (Integer)param.get("rows") -1;
		
		
		/**
		 * 第一�?     pn           card_no	      IMSI	       iccid
		 * 
		 * �?�?产品序列�?   �?�?        �?�?                          �?�?                           5      
		 *      pn           card_no    IMSI       iccid          套餐编号     
		 *      
		 *      �?�?                         7        8         9             10
		 *    套餐名称                盒子编号          puk     card_sn         imei
		 *      
		 *    �?1�?                            12        13           14             15
		 * 运营商开通时�?        月租成本       短信成本单价   公网流量成本单价     VPDN流量成本单价
		 * */
		String[] pns = new String[rows];
		String[] card_nos = new String[rows];
		String[] imsis = new String[rows];
		String[] iccids = new String[rows];
		String[] package_no = new String[rows];
		String[] package_name = new String[rows];
		String[] box_nos = new String[rows];
		String[] puks = new String[rows];
		String[] card_sns = new String[rows];
		String[] imeis = new String[rows];
		String[] providerTime = new String[rows];
		String[] monthPrice = new String[rows];
		String[] messagePrice = new String[rows];
		String[] outNetPrice = new String[rows];
		String[] vpdnPrice = new String[rows];
		
		String validator_card_no = "[0-9]{11}";
		String validator_imsi = "[0-9]{15}";
		Map<String,Object> card_map = null;
		CardSim cs = null;
		CardHard ch = null;
		CardBox cb = null;
		CardInvoiceStutus ci = null;
		CardProduct cp = null;
		WarehouseProduct wp = null;
		
		List<Package> pack_list = packageDao.findAll();
		Map<String,Package> pack_map = new HashMap<String,Package>();
		for (Package p : pack_list) {
			pack_map.put(p.getPackageNo().toLowerCase(), p);
		}
		//文件里的数据格式，数据唯�??校验
		for (int j = 0; j<rows; j++ ){
			pns[j] = sheet.getCell(0,j+1).getContents().trim();
			card_nos[j] = sheet.getCell(1,j+1).getContents().trim();
			imsis[j] = sheet.getCell(2,j+1).getContents().trim();
			iccids[j] = sheet.getCell(3,j+1).getContents().trim();
			package_no[j] = sheet.getCell(4,j+1).getContents().trim();
			package_name[j] = sheet.getCell(5,j+1).getContents().trim();
			
			box_nos[j] = sheet.getCell(6,j+1).getContents().trim();
			puks[j] = sheet.getCell(7,j+1).getContents().trim();
			card_sns[j] = sheet.getCell(8,j+1).getContents().trim();
			imeis[j] = sheet.getCell(9,j+1).getContents().trim();
			providerTime[j] = sheet.getCell(10,j+1).getContents().trim();
			monthPrice[j] = sheet.getCell(11,j+1).getContents().trim();
			messagePrice[j] = sheet.getCell(12,j+1).getContents().trim();
			outNetPrice[j] = sheet.getCell(13,j+1).getContents().trim();
			vpdnPrice[j] = sheet.getCell(14,j+1).getContents().trim();
			
			
			int line = j + 2;  //出错行数
			int k = -1;         //重复的行�?
			/**
			 	如果产品序列号不为空，则认为是入库整体产品，否则入库单个零件
				入库条件：零件编号正�?
			*/
			//产品完整性校�?     产品编号 等待 验证
			if(StringUtils.isNotBlank(pns[j])){
				k = arrayValidator(pns, pns[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的产品序列号与�?+ (k+2) +"行重�? );
					return param;
				}
				//sim�?
				if(StringUtils.isBlank(card_nos[j])){
					param.put("error", "�?+ line + "行，sim�?   信息不完�? );
					return param;
				}
				//硬件�?
				if(StringUtils.isBlank(card_sns[j])){
					param.put("error", "�?+ line + "行，硬件�?   信息不完�? );
					return param;
				}
				//盒子
				if(StringUtils.isBlank(box_nos[j])){
					param.put("error", "�?+ line + "行，盒子编号    信息缺失" );
					return param;
				}
				//套餐
				if(StringUtils.isBlank(package_no[j])){
					param.put("error", "�?+ line + "行，套餐编号    信息缺失" );
					return param;
				}
			}
			//硬件卡校�?  IMEI号等待校�?
			if(StringUtils.isNotBlank(card_sns[j])){
				k = arrayValidator(card_sns, card_sns[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的 sn 与第"+ (k+2) +"行重�? );
					return param;
				}
			}
			
			
			//sim卡校�?
			if(StringUtils.isNotBlank(card_nos[j])){
				//卡号
				if(!validatorFasion(validator_card_no, card_nos[j])){
					param.put("error", "�?+ line + "行，sim卡号格式不正�? );
					return param;
				}
				k = arrayValidator(card_nos, card_nos[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的卡号与第"+ (k+2) +"行重�? );
					return param;
				}
				//IMSI�?
				if(StringUtils.isBlank(imsis[j])){
			    	param.put("error", "�?+ line + "行，sim卡的 imsi 为空" );
					return param;
			    }else if(!validatorFasion(validator_imsi, imsis[j])){
			    	param.put("error", "�?+ line + "行，sim�?imsi 格式错误" );
					return param;
			    }
		    	k = arrayValidator(imsis, imsis[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的imsi号与�?+ (k+2) +"行重�? );
					return param;
				}
				//ICCID�?
			    if(StringUtils.isBlank(iccids[j])){
			    	param.put("error", "�?+ line + "行，sim卡的iccid为空" );
					return param;
			    }else if(iccids[j].length() != 20){
			    	param.put("error", "�?+ line + "行，sim�?iccid 格式错误" );
					return param;
			    }
		    	k = arrayValidator(iccids, iccids[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的iccid号与�?+ (k+2) +"行重�? );
					return param;
				}
			}
			
			//盒子编号
			if(StringUtils.isNotBlank(box_nos[j])){
				k = arrayValidator(box_nos, box_nos[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的盒子号与�?+ (k+2) +"行重�? );
					return param;
				}
			}
			
			//套餐编号
			if(StringUtils.isNotBlank(package_no[j]) && null == pack_map.get(package_no[j].toLowerCase())){
				param.put("error", "�?+ line + "行的套餐编号不存�?);
				return param;
			}
		}
		
		//判断产品能否入库
		String pn_result = productValidatorForIn("pns", pns, rows);
		if(!"0".equals(pn_result) && !"success".equals(pn_result)){param.put("error", pn_result);return param;}
		
		String card_sn_result = productValidatorForIn("card_sns", card_sns, rows);
		if(!"0".equals(card_sn_result) && !"success".equals(card_sn_result)){param.put("error", card_sn_result);return param;}
		
		String card_sim_result = productValidatorForIn("card_nos", card_nos, rows);
		if(!"0".equals(card_sim_result) && !"success".equals(card_sim_result)){param.put("error", card_sim_result);return param;}
		
		String card_box_result = productValidatorForIn("box_nos", box_nos, rows);
		if(!"0".equals(card_box_result) && !"success".equals(card_box_result)){param.put("error", card_box_result);return param;}
		
		
		//将上传文件保存到服务�?
		param = saveFile(param);
		if(null != param.get("error")){
			param.put("error", "保存文件出错");
			return param;
		}
		
		//保存入库�?
		//生成随机库单�?
		String wi_no = DateUtil.formatDate(Calendar.getInstance().getTime(), "yyyyMMddHHmmss") + "r";
		Date entryDate = DateUtil.parse((String)param.get("entryDate"), "yyyy-MM-dd");
		WarehouseInvoice warehouse = new WarehouseInvoice();
		if(null != wi.getAgentNo() &&  !"0".equals(wi.getAgentNo()) ){
			warehouse.setAgentName(wi.getAgentName());
			warehouse.setAgentNo(wi.getAgentNo());
		}
		warehouse.setEntryDate(entryDate);
		warehouse.setProductPrice(wi.getProductPrice());
		warehouse.setCardSimPrice(wi.getCardSimPrice());
		warehouse.setCardSnPrice(wi.getCardSnPrice());
		warehouse.setCardBoxPrice(wi.getCardBoxPrice());	
		warehouse.setFilePath((String)param.get("path"));
		warehouse.setStatus("2");
		warehouse.setWiNo(wi_no);
		warehouseInvoiceDao.create(warehouse);
		
		Long wi_id = warehouse.getId();
		//保存产品或零件�?如果文件中没有package_no，则不添加空�?
		int pn_num = 0;
		int card_sn_num = 0;
		int card_no_num = 0;
		int card_box_num = 0;
		Date provider_time = null;
		for (int i = 0; i < rows; i++) {
			//保存产品到仓库中
			cp = new CardProduct();
			ci = new CardInvoiceStutus();
			//创建sim�?
			if(StringUtils.isNotBlank(card_nos[i])){
				card_no_num++;
				cs = new CardSim();
				cs.setCardNo(card_nos[i]);
				cs.setIccid(iccids[i]);
				cs.setImsi(imsis[i]);
				cs.setPackageName(package_name[i]);
				cs.setPackageNo(package_no[i]);
				cs.setPuk(puks[i]);
				//xls文件日期格式�?2010-6-30
				if(StringUtils.isNotBlank(providerTime[i])){
					provider_time = DateUtil.parse(providerTime[i], "yyyy-MM-dd");
					if(null == provider_time){
						if(providerTime[i].length()==9){
							provider_time = DateUtil.parse(providerTime[i].substring(0,5) + "0" 
									+ providerTime[i].substring(5,9), "yyyy-MM-dd");
						}
					}
				}
				cs.setProviderTime(provider_time);
				if(StringUtils.isNotBlank(messagePrice[i]))
					cs.setMessagePrice(new BigDecimal(messagePrice[i]));
				if(StringUtils.isNotBlank(monthPrice[i]))
					cs.setMonthCost(new BigDecimal(monthPrice[i]));
				if(StringUtils.isNotBlank(outNetPrice[i]))
					cs.setOutNetPrice(new BigDecimal(outNetPrice[i]));
				if(StringUtils.isNotBlank(vpdnPrice[i]))
					cs.setVpdnPrice(new BigDecimal(vpdnPrice[i]));
				cardSimDao.create(cs);
				//SIM卡产�?
				cp.setCard_sim(card_nos[i]);
				//cp.setSim_status("2");
				ci.setCard_sim_no_wi_in_id(wi_id);
				ci.setCard_sim_no_in_date(entryDate);
				ci.setCard_sim_no_provider_name(wi.getAgentName());
			}
			
			//创建硬卡
			if(StringUtils.isNotBlank(card_sns[i])){
				card_sn_num++;
				ch = new CardHard();
				ch.setCard_sn(card_sns[i]);
				ch.setImei(imeis[i]);
				cardHardDao.create(ch);
				//硬件卡产�?
				cp.setCard_sn(card_sns[i]);
				//cp.setSn_status("2");
				ci.setCard_sn_no_wi_in_id(wi_id);
				ci.setCard_sn_no_in_date(entryDate);
				ci.setCard_sn_no_provider_name(wi.getAgentName());
			}
			
			//创建盒子
			if(StringUtils.isNotBlank(box_nos[i])){
				card_box_num++;
				cb = new CardBox();
				cb.setBoxNo(box_nos[i]);
				cardBoxDao.create(cb);
				//盒子产品
				cp.setCard_box(box_nos[i]);
				//cp.setBox_status("2");
				ci.setCard_box_no_wi_in_id(wi_id);
				ci.setCard_box_no_in_date(entryDate);
				ci.setCard_box_no_provider_name(wi.getAgentName());
			}
			
			//将产品保存到库存记录表中
			wp = new WarehouseProduct();
			wp.setProductNo(pns[i]);
			wp.setCardNo(card_nos[i]);
			wp.setImsiNo(imsis[i]);
			wp.setIccidNo(iccids[i]);
			wp.setSnNo(card_sns[i]);
			wp.setBoxNo(box_nos[i]);
			wp.setWiNo(wi_no);
			wp.setWiId(wi_id);
			warehouseProductDao.create(wp);
			
			if(StringUtils.isNotBlank(pns[i])){
				pn_num ++;
				//有产品序列号的，设置�?（入库状态），不完整的产品在产品盘点时补�?
				//cp.setProduct_no(pns[i]);
				//cp.setPno_status("2");
				ci.setProduct_no_wi_in_id(wi_id);
				ci.setProduct_no_in_date(entryDate);
				ci.setProduct_no_provider_name(wi.getAgentName());
				//创建�?��没有�?���?G�?
				card_map = new HashMap<String,Object>();
				card_map.put("cardNo", card_nos[i]);
				card_map.put("iccid", iccids[i]);
				card_map.put("imsi", imsis[i]);
				card_map.put("package", pack_map.get(package_no[i]));
				doCreateCard3g(card_map);
			}
			cardProductDao.create(cp);
			ci.setCpId(cp.getId());
			cardInvoiceStutusDao.create(ci);
		}
		warehouse.setProductNum(pn_num);
		warehouse.setCardSimNum(card_sn_num);
		warehouse.setCardSnNum(card_no_num);
		warehouse.setCardBoxNum(card_box_num);
		warehouseInvoiceDao.update(warehouse);
		
		//更新供应商数�?
		CardAgent cardAgent = cardAgentDao.findUniqueBy("agentNo", wi.getAgentNo());
		cardAgent.setProduct_no_provider_num(cardAgent.getProduct_no_provider_num() + pn_num);
		cardAgent.setCard_sn_no_provider_num(cardAgent.getCard_sn_no_provider_num() + card_sn_num);
		cardAgent.setCard_sim_no_provider_num(cardAgent.getCard_sim_no_provider_num() + card_no_num);
		cardAgent.setCard_box_no_provider_num(cardAgent.getCard_box_no_provider_num() + card_box_num);
		cardAgentDao.update(cardAgent);
		
		param.put("message", "恭喜您！入库成功！您�?��入库�?" + pn_num +"个完整的产品�? 
				+ card_sn_num + "个硬件卡�? + card_no_num + "个SIM卡，" + card_box_num + "个盒子�?");
		log.setLogDesc("仓库产品入库，详情请查看入库单："+ wi_no );
		adminLogService.doCreate(log);
		return param;
	}
	
	/**
	 * 文件数据唯一性校�?
	 * @param   source_str
	 * @param   target_str
	 * @return  数组里面没有target_str，返�?-1
	 * */
	public int arrayValidator(String[] source_str, String target_str, int index){
		for(int i=0; i<index; i++){
			if(target_str.equals(source_str[i]) )
				return i;
		}
		return -1;
	}
	
	
	//保存文件
	public Map<String, Object> saveFile(Map<String, Object> param){
		String fileFileName = (String) param.get("fileFileName");
		String savePath     = (String) param.get("savePath");
		File file = (File) param.get("file");
		String root = ServletActionContext.getServletContext().getInitParameter("uploadPath") + savePath + "/";
		if(! (new File(root)).exists()) {
        	new File(root).mkdirs();
        }
		OutputStream fos = null;
		String path = null;
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		try {
			int file_name_index = fileFileName.indexOf(".");
			String file_name = fileFileName.substring(0, file_name_index);
			Date d = Calendar.getInstance().getTime();
			String date = new SimpleDateFormat("yyyyMMddHHmmss").format(d);
			path = root + file_name + "--" + date + fileFileName.substring(file_name_index);
			fos = new FileOutputStream(path);
			IOUtils.copy(fis, fos);
		} catch (IOException e) {
			param.put("error", "文件格式不正�?");
			IOUtils.closeQuietly(fis);
			IOUtils.closeQuietly(fos);
			e.printStackTrace();
			return param;
		} finally {
			IOUtils.closeQuietly(fis);
			IOUtils.closeQuietly(fos);
		}
		param.put("path", path);
		return param;
	}
	
	
	/**
	 * 创建�?��没有�?���?G�?
	 * */
	public void doCreateCard3g(Map<String,Object> card_map){
		String cardNo = (String)card_map.get("cardNo");
		String iccid = (String)card_map.get("iccid");
		String imsi = (String)card_map.get("imsi");
		Package p = (Package)card_map.get("package");
		Date d = Calendar.getInstance().getTime();
		Card3g card = new Card3g();
		card.setCardNo(cardNo);
		card.setImsi(imsi);
		card.setIccid(iccid);
		card.setCustomerCertificateName("");
		card.setCustomerCertificateNo("");
		card.setCustomerName("");
		card.setCustomerPhoneNo("");
		card.setCustomerAddress("");
		card.setCustomerEmail("");
		card.setPassword(cardNo.substring(cardNo.length()-6));
		card.setStatus(Byte.valueOf("1"));
		if(null != p){
			card.setPackageNo(p.getPackageNo());
			card.setPackageName(p.getPackageName());
			card.setMoneyPreCharged(p.getMoneyPreCharged());
		}
		card.setIsDeleted(false);
		card.setIfIdentityVerified(false);
		card.setIfBalanceUnsufficient(false);
		card.setIfLimitExceed(false);
		card.setAppendDatetime(d);
		card3gDao.create(card);
	}

	
	//查看库存产品详情
	public List<WarehouseProduct> findDetailWIProduct(String recordKey, String inOrOut) {
		if("2".equals(inOrOut))
			return warehouseProductDao.findBy("wiNo", recordKey);
		else 
			return warehouseProductDao.findDetailWIProduct(recordKey, inOrOut);
	}
	
	/**
	 * 产品出库
	 * */
	public Map<String, Object> doCreateWIForOut(Map<String, Object> param, AdminLog log) {
		if (null != fileTypeValidator(param).get("error")) {
			return param;
		}
		if (null != readFileValidator(param).get("error")) {
			return param;
		}
		return createWIForOut(param, log);
	}

	/**
	 * 更新 出库 库单�?
	 * */
	private Map<String, Object> createWIForOut(Map<String, Object> param, AdminLog log) {
		WarehouseInvoice wi = (WarehouseInvoice)param.get("wi");
		Workbook book = (Workbook)param.get("book");
		Sheet sheet = book.getSheet(0); 
		//文件有效行数
		int rows = (Integer)param.get("rows") -1;
		/*
		 * 文件第一�?     pn        card_no      card_sn    盒子编号
		 * */
		String[] pns = new String[rows];
		String[] card_nos = new String[rows];
		String[] card_sns = new String[rows];
		String[] box_nos = new String[rows];
		
		String validator_card_no = "[0-9]{11}";
		WarehouseProduct wp = null;
		//文件里的数据格式，数据格式和唯一性校�?
		for (int j = 0; j<rows; j++ ){
			pns[j] = sheet.getCell(0,j+1).getContents().trim();
			card_nos[j] = sheet.getCell(1,j+1).getContents().trim();
			card_sns[j] = sheet.getCell(2,j+1).getContents().trim();
			box_nos[j] = sheet.getCell(3,j+1).getContents().trim();
			
			int line = j + 2;  //出错行数
			int k = -1;         //重复的行�?
			/**
			 	如果产品序列号不为空，则认为是整体产品出库，否则单个零件出库
				出库条件：零件编号正�?
			*/
			//产品编号格式校验
			if(StringUtils.isNotBlank(pns[j])){
				k = arrayValidator(pns, pns[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的产品序列号与�?+ (k+2) +"行重�? );
					return param;
				}
			}
			//sim卡校�?
			if(StringUtils.isNotBlank(card_nos[j])){
				if(!validatorFasion(validator_card_no, card_nos[j])){
					param.put("error", "�?+ line + "行，sim卡号格式不正�? );
					return param;
				}
				k = arrayValidator(card_nos, card_nos[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的卡号与第"+ (k+2) +"行重�? );
					return param;
				}
			}
			
			//硬件卡校�?
			if(StringUtils.isNotBlank(card_sns[j])){
				k = arrayValidator(card_sns, card_sns[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的 sn 与第"+ (k+2) +"行重�? );
					return param;
				}
			}
			
			//盒子校验
			if(StringUtils.isNotBlank(box_nos[j])){
				k = arrayValidator(box_nos, box_nos[j],j);
				if(k != -1){
					param.put("error", "�?+ line + "行的 盒子序号 与第"+ (k+2) +"行重�? );
					return param;
				}
			}
		}
		//判断产品能否出库
		String pn_result = productValidatorForOut("pns", pns, rows);
		if(!"0".equals(pn_result) && !"success".equals(pn_result)){param.put("error", pn_result);return param;}
		
		String card_sn_result = productValidatorForOut("card_sns", card_sns, rows);
		if(!"0".equals(card_sn_result) && !"success".equals(card_sn_result)){param.put("error", card_sn_result);return param;}
		
		String card_sim_result = productValidatorForOut("card_nos", card_nos, rows);
		if(!"0".equals(card_sim_result) && !"success".equals(card_sim_result)){param.put("error", card_sim_result);return param;}
		
		String card_box_result = productValidatorForOut("box_nos", box_nos, rows);
		if(!"0".equals(card_box_result) && !"success".equals(card_box_result)){param.put("error", card_box_result);return param;}
		
		
		//产品出库
		StringBuilder pns_str      = new StringBuilder();
		StringBuilder card_sn_str  = new StringBuilder();
		StringBuilder card_no_str  = new StringBuilder();
		StringBuilder card_box_str = new StringBuilder();
		for(String s : pns){
			if(StringUtils.isNotBlank(s))
				pns_str.append("'" + s + "'" +",");
		}
		for(String s : card_sns){
			if(StringUtils.isNotBlank(s))
				card_sn_str.append("'" + s + "'" +",");
		}
		for(String s : card_nos){
			if(StringUtils.isNotBlank(s))
				card_no_str.append("'" + s + "'" +",");
		}
		for(String s : box_nos){
			if(StringUtils.isNotBlank(s))
				card_box_str.append("'" + s + "'" +",");
		}
		Integer pn_num = 0;
		Integer card_sn_num = 0;
		Integer card_no_num = 0;
		Integer card_box_num = 0;
		
		//将上传文件保存到服务�?
		param = saveFile(param);
		if(null != param.get("error")){
			param.put("error", "保存文件出错");
			return param;
		}
		
		//保存出库�?
		//生成随机库单�?
		String wi_no = DateUtil.formatDate(Calendar.getInstance().getTime(), "yyyyMMddHHmmss") + "c";
		
		WarehouseInvoice warehouse = new WarehouseInvoice();
		if(null != wi.getAgentNo() &&  !"0".equals(wi.getAgentNo()) ){
			warehouse.setAgentName(wi.getAgentName());
			warehouse.setAgentNo(wi.getAgentNo());
		}
		Date entryDate = null;
		if(null != param.get("entryDate"))
			entryDate = DateUtil.parse((String)param.get("entryDate"), "yyyy-MM-dd");
		warehouse.setEntryDate(entryDate);
		warehouse.setProductPrice(wi.getProductPrice());
		warehouse.setCardSimPrice(wi.getCardSimPrice());
		warehouse.setCardSnPrice(wi.getCardSnPrice());
		warehouse.setCardBoxPrice(wi.getCardBoxPrice());
		warehouse.setFilePath((String)param.get("path"));
		warehouse.setStatus("1");
		warehouse.setWiNo(wi_no);
		warehouseInvoiceDao.create(warehouse);
		
		Long wi_id = warehouse.getId();
		for (int i = 0; i < rows; i++) {
			//将产品保存到库存记录表中
			wp = new WarehouseProduct();
			wp.setProductNo(pns[i]);
			wp.setCardNo(card_nos[i]);
			wp.setSnNo(card_sns[i]);
			wp.setBoxNo(box_nos[i]);
			wp.setWiNo(wi_no);
			wp.setWiId(wi_id);
			warehouseProductDao.create(wp);
		}
		
		//更新产品状�?
		Map<String,String> method_param = null;
		if(!"".equals(pns_str.toString())){
			method_param = new HashMap<String,String>();
			method_param.put("pns", pns_str.substring(0, pns_str.length()-1));
			method_param.put("status", "1");
			method_param.put("wi_id", wi_id+"");
			method_param.put("agent_name", wi.getAgentName());
			method_param.put("entryDate", (String)param.get("entryDate"));
			pn_num = cardProductDao.doUpdateProductByPNos(method_param);
			method_param = null;
		}
		//更新零件状�?
		if(!"".equals(card_sn_str.toString())){
			method_param = new HashMap<String,String>();
			method_param.put("field_name", "card_sn_no");
			method_param.put("nos", card_sn_str.substring(0, card_sn_str.length()-1));
			method_param.put("status", "1");
			method_param.put("wi_id", wi_id+"");
			method_param.put("agent_name", wi.getAgentName());
			method_param.put("entryDate", (String)param.get("entryDate"));
			card_sn_num = cardProductDao.doUpdateProductByFieldNos(method_param);
			method_param = null;
		}
		if(!"".equals(card_no_str.toString())){
			method_param = new HashMap<String,String>();
			method_param.put("field_name", "card_sim_no");
			method_param.put("nos", card_no_str.substring(0, card_no_str.length()-1));
			method_param.put("status", "1");
			method_param.put("wi_id", wi_id+"");
			method_param.put("agent_name", wi.getAgentName());
			method_param.put("entryDate", (String)param.get("entryDate"));
			card_no_num = cardProductDao.doUpdateProductByFieldNos(method_param);
			method_param = null;
		}
		if(!"".equals(card_box_str.toString())){
			method_param = new HashMap<String,String>();
			method_param.put("field_name", "card_box_no");
			method_param.put("nos", card_box_str.substring(0, card_box_str.length()-1));
			method_param.put("status", "1");
			method_param.put("wi_id", wi_id+"");
			method_param.put("agent_name", wi.getAgentName());
			method_param.put("entryDate", (String)param.get("entryDate"));
			card_box_num = cardProductDao.doUpdateProductByFieldNos(method_param);
			method_param = null;
		}
		
		
		//更新card_3g表中出货时间
		if(!"".equals(pns_str.toString())){
			List<String> list = cardProductDao.findCardNoByPNO(pns_str.substring(0, pns_str.length()-1));
			StringBuilder card_no = new StringBuilder();
			for(String s : list){
				card_no.append("'" + s + "'" +",");
			}
			cardProductDao.doUpdateCard3gByCardNos(card_no.substring(0, card_no.length()-1),(String)param.get("entryDate"));
		}
		
		warehouse.setProductNum(pn_num);
		warehouse.setCardSimNum(card_no_num);
		warehouse.setCardSnNum(card_sn_num);
		warehouse.setCardBoxNum(card_box_num);
		warehouseInvoiceDao.update(warehouse);
		
		//更新代理商数�?
		CardAgent cardAgent = cardAgentDao.findUniqueBy("agentNo", wi.getAgentNo());
		cardAgent.setProduct_no_agent_num(cardAgent.getProduct_no_agent_num() + pn_num);
		cardAgent.setCard_sn_no_agent_num(cardAgent.getCard_sn_no_agent_num() + card_sn_num);
		cardAgent.setCard_sim_no_agent_num(cardAgent.getCard_sim_no_agent_num() + card_no_num);
		cardAgent.setCard_box_no_agent_num(cardAgent.getCard_box_no_agent_num() + card_box_num);
		cardAgentDao.update(cardAgent);
		
		param.put("message", "恭喜您！出库成功！您�?��出库�?" + pn_num +"个完整的产品�? 
				+ card_sn_num + "个硬件卡�? + card_no_num + "个SIM卡，" + card_box_num + "个盒子�?");
		log.setLogDesc("仓库产品出库（文件）�?+ wi_no );
		adminLogService.doCreate(log);
		return param;
	}
	
	
	
	/**
	 * 产品入库校验
	 * @param   field  �?��验的目标数组
	 * @param	rows   文件行数
	 * @return�?0" : 数组中无产品�?success"：可成功出库     其他�?错误信息
	 * */
	public String productValidatorForIn(String p_array_name, String[] p_array,int rows){
		//编号         在数据库中的         完整性和存在性校�?
		StringBuilder pns_str = new StringBuilder();
		int pns_length = 0;
		for(String s : p_array){
			if(StringUtils.isNotBlank(s)){
				pns_length++;
				pns_str.append("'" + s + "'" +",");
			}
		}
		
		if(pns_length == 0){
			return "0";
		}
		
		String dataFieldName  = null;       // 在数据库中的字段�?
		String pFieldName = null;           // 零件名称
		
		if("pns".equals(p_array_name)){
			dataFieldName  = "product_no";
			pFieldName = "产品序列�?;
		} else if("card_sns".equals(p_array_name)){
			dataFieldName  = "card_sn_no";
			pFieldName = "硬件�?;
		} else if("card_nos".equals(p_array_name)){
			dataFieldName  = "card_sim_no";
			pFieldName = "sim�?;
		} else if("box_nos".equals(p_array_name)){
			dataFieldName  = "card_box_no";
			pFieldName = "盒子编号";
		}
		
		//如果上传文件里的产品不存在，则返回可成功操作信息
		StringBuilder pn_line_sb = new StringBuilder();
		String pn_nos = pns_str.substring(0, pns_str.length()-1);
		Map<String,String> pns_map = cardProductDao.findAllIntegrityByNos(dataFieldName, pn_nos,null);
		if(0 == pns_map.size()){
			return "success";
		//产品不存�?
		}else if(pns_map.size() == pns_length){
			return "文件中所有的 "+ pFieldName +" 都已入库！请更新文件再上�? ;
		}else{
			for (int j = 0; j < rows; j++ ){
				if(null == pns_map.get(p_array[j])){
					pn_line_sb.append((j+2)+",");
				}
			}
			return "文件中对应行数的 "+ pFieldName +" 已入库！" + pn_line_sb.toString().substring(0, pn_line_sb.length()-1);
			
		}
	 }
	
	

	/**
	 * 产品出库校验
	 * @param   field  �?��验的目标数组
	 * @param	rows   文件行数
	 * @return�?0" : 数组中无产品�?success"：可成功出库     其他�?错误信息
	 * */
	public String productValidatorForOut(String p_array_name, String[] p_array,int rows){
		//编号         在数据库中的         完整性和存在性校�?
		StringBuilder pns_str = new StringBuilder();
		int pns_length = 0;
		for(String s : p_array){
			if(StringUtils.isNotBlank(s)){
				pns_length++;
				pns_str.append("'" + s + "'" +",");
			}
		}
		if(pns_length == 0){
			return "0";
		}
		
		String dataFieldName  = null;       // 在数据库中的字段�?
		String pFieldName = null;           // 零件名称
		
		if("pns".equals(p_array_name)){
			dataFieldName  = "product_no";
			pFieldName = "产品序列�?;
		} else if("card_sns".equals(p_array_name)){
			dataFieldName  = "card_sn_no";
			pFieldName = "硬件�?;
		} else if("card_nos".equals(p_array_name)){
			dataFieldName  = "card_sim_no";
			pFieldName = "sim�?;
		} else if("box_nos".equals(p_array_name)){
			dataFieldName  = "card_box_no";
			pFieldName = "盒子编号";
		}
		
		//如果上传文件里的产品不能出库，则返回
		StringBuilder pn_line_sb = new StringBuilder();
		String pn_nos = pns_str.substring(0, pns_str.length()-1);
		Map<String,String> pns_map = cardProductDao.findAllIntegrityByNos(dataFieldName, pn_nos,null);
		if(0 == pns_map.size()){
			return "您输入所�?" + pFieldName +" 都不存在，无法出库，请您核实�?;
		//产品不存�?
		}else if(pns_map.size() != pns_length){
			for (int j = 0; j < rows; j++ ){
				String p = pns_map.get(p_array[j]);
				if(null == p){
					pn_line_sb.append((j+2)+",");
				}
			}
			return "文件中对应行数的 "+ pFieldName +" 不存在！" + pn_line_sb.toString().substring(0, pn_line_sb.length()-1);
		} 
		//产品已出�?
		if(pns_map.containsValue("1")){
			for(Entry<String,String> p : pns_map.entrySet()){
				if(null != p.getValue() && "1".equals(p.getValue())){
					pn_line_sb.append(p.getKey()+",");
				}
			}
			String[] pns_str_temp = pn_line_sb.toString().split(",");
			pn_line_sb = new StringBuilder();
			for(String pn : pns_str_temp){
				for (int j = 0; j < rows; j++ ){
					if(p_array[j].equals(pn)){
						pn_line_sb.append((j+2)+",");
					}
				}
			}
			return "文件中对应行数的 "+ pFieldName +" 已出库！" + pn_line_sb.toString().substring(0, pn_line_sb.length()-1);
		}
		return "success";
	 }

	//更新库存
	public String doEditWI(WarehouseInvoice wi, AdminLog log) {
		WarehouseInvoice w_i =  warehouseInvoiceDao.findUniqueBy("wiNo", wi.getWiNo());
		Map<String,String> param = new HashMap<String,String>();
		param.put("wi_id", w_i.getId()+"");
		param.put("status", w_i.getStatus());
		if(!wi.getEntryDate().equals(w_i.getEntryDate())){
			w_i.setEntryDate(wi.getEntryDate());
			param.put("entryDate",DateUtil.formatDate(wi.getEntryDate()));
			//更新3G卡出货时�?
			if("1".equals(w_i.getStatus())){
				cardProductDao.doUpdateCard3gByWI(param);
			}
		}
		if(!wi.getAgentName().equals(w_i.getAgentName())){
			w_i.setAgentName(wi.getAgentName());
			param.put("angent_name", wi.getAgentName());
		}
		//更新库存（产品）状�?
		cardInvoiceStutusDao.doUpdateCIByWI(param);
		
		//更新库单
		w_i.setProductPrice(wi.getProductPrice());
		w_i.setCardSimPrice(wi.getCardSimPrice());
		w_i.setCardSnPrice(wi.getCardSnPrice());
		w_i.setCardBoxPrice(wi.getCardBoxPrice());
		warehouseInvoiceDao.update(w_i);
		
		if("1".equals(w_i.getStatus())){
			log.setLogDesc("修改出库单：" + w_i.getWiNo());
		}else if("2".equals(w_i.getStatus())){
			log.setLogDesc("修改入库单：" + w_i.getWiNo());
		}
		adminLogService.doCreate(log);
		return "success";
	}

	
}
