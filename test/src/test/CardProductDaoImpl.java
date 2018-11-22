/*package test;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import solution.jxt.admin.dao.ICardProductDao;
import solution.jxt.admin.model.CardProduct;
import solution.jxt.admin.vo.CardProductVO;
import itaf.framework.common.page.Page;
import itaf.framework.dao.BaseDaoImpl;
import itaf.framework.util.DateUtil;

@Repository("cardProductDao")
public class CardProductDaoImpl extends BaseDaoImpl<CardProduct> implements ICardProductDao {

	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	public Page findCardProductByParam(Map<String, String> param) {
		
		String p_type = param.get("p_type");
		String p_status = param.get("p_status");
		if(StringUtils.isBlank(p_type)||StringUtils.isBlank(p_status))
			return new Page(0,0,Integer.valueOf(param.get("pageSize")), new ArrayList<Object>());
		
		String inOrOutDate = null; 
		String agentOrProvider = null;
		if("1".equals(p_status)){
			inOrOutDate = p_type + "_out_date";
			agentOrProvider = p_type + "_agent_name";
		}else if("2".equals(p_status)){
			inOrOutDate = p_type + "_in_date";
			agentOrProvider = p_type + "_provider_name";
		}
		
		StringBuilder sql = new StringBuilder();
		List<Object> arg = new ArrayList<Object>();
		sql.append(" select cp.product_no,cp.card_sim_no,cp.card_sn_no,cp.card_box_no," +
				   " cp.product_no_status,cp.card_sim_no_status,cp.card_sn_no_status,cp.card_box_no_status,ci." + inOrOutDate);
		sql.append(" ,ci." + agentOrProvider + " from card_product cp left join card_invoice_stauts ci ");
		sql.append(" on ci.cp_id = cp.pk_auto_incremental  where 1=1 ");
		sql.append(" on ci.cp_id = cp.pk_auto_incremental  where 1=1 ");
		sql.append(" on ci.cp_id = cp.pk_auto_incremental  where 1=1 ");
		sql.append("select cp.product_no,cp.card_sim_no,cp.card_sn_no,cp.card_box_no," +
				" cp.product_no_status,cp.card_sim_no_status,cp.card_sn_no_status,cp.card_box_no_status," +
				" wi.agent_no,wi.agent_name,wi.status,wi.entry_date from card_product cp left join warehouse_invoice wi " +
				" on wi.pk_auto_incremental = cp.wi_id  left join warehouse_product wp on wp.  where 1 = 1 ");
		//äº§å“åºåˆ—å?
		if(StringUtils.isNotBlank(param.get("p_no"))){
			sql.append(" and cp.product_no like ? ");
			arg.add("%"+param.get("p_no")+"%");
		}
		if(StringUtils.isNotBlank(param.get("p_no_from"))){
			sql.append(" and cp.product_no >= ? ");
			arg.add(param.get("p_no_from"));
		}
		if(StringUtils.isNotBlank(param.get("p_no_to"))){
			sql.append(" and cp.product_no <= ? ");
			arg.add(param.get("p_no_to"));
		}
		//SIMå?
		if(StringUtils.isNotBlank(param.get("card_no"))){
			sql.append(" and cp.card_sim_no like ? ");
			arg.add("%"+param.get("card_no")+"%");
		}
		if(StringUtils.isNotBlank(param.get("card_no_from"))){
			sql.append(" and cp.card_sim_no >= ? ");
			arg.add(param.get("card_no_from"));
		}
		if(StringUtils.isNotBlank(param.get("card_no_to"))){
			sql.append(" and cp.card_sim_no <= ? ");
			arg.add(param.get("card_no_to"));
		}
		//SNå?
		if(StringUtils.isNotBlank(param.get("sn_no"))){
			sql.append(" and cp.card_sn_no like ? ");
			arg.add("%"+param.get("sn_no")+"%");
		}
		if(StringUtils.isNotBlank(param.get("sn_no_from"))){
			sql.append(" and cp.card_sn_no >= ? ");
			arg.add(param.get("sn_no_from"));
		}
		if(StringUtils.isNotBlank(param.get("sn_no_to"))){
			sql.append(" and cp.card_sn_no <= ? ");
			arg.add(param.get("sn_no_to"));
		}
		//BOXå?
		if(StringUtils.isNotBlank(param.get("box_no"))){
			sql.append(" and cp.card_box_no like ? ");
			arg.add("%"+param.get("box_no")+"%");
		}
		if(StringUtils.isNotBlank(param.get("box_no_from"))){
			sql.append(" and cp.card_box_no >= ? ");
			arg.add(param.get("box_no_from"));
		}
		if(StringUtils.isNotBlank(param.get("box_no_to"))){
			sql.append(" and cp.card_box_no <= ? ");
			arg.add(param.get("box_no_to"));
		}
		
  		//ä»£ç†å•?
		if(StringUtils.isNotBlank(param.get("agent_name"))){
			sql.append(" and ci."+ agentOrProvider +" = ? ");
			arg.add(param.get("agent_name"));
		}
		if(StringUtils.isNotBlank(param.get("provider_name"))){
			sql.append(" and ci."+ agentOrProvider +" = ? ");
			arg.add(param.get("provider_name"));
		}
		
		//æ—¥æœŸ
		if(StringUtils.isNotBlank(param.get("start_entryTime"))){
			sql.append(" and ci."+ inOrOutDate +" >= ? ");
			arg.add(DateUtil.parseDate(param.get("start_entryTime")));
		}
		if(StringUtils.isNotBlank(param.get("end_entryTime"))){
			sql.append(" and ci."+ inOrOutDate +" <= ? ");
			arg.add(DateUtil.parseDate(param.get("end_entryTime")));
		}
		String sql_count = "select count(*) as count " + sql.toString().substring(sql.toString().indexOf("from"));
		
		final Map<String,Integer> p_count = new HashMap<String, Integer>();
		p_count.put("count",0);
		jdbcTemplate.query(sql_count, arg.toArray(), new RowCallbackHandler() {
			public void processRow(ResultSet rs) throws SQLException {
				p_count.put("count", rs.getInt("count"));
			}
		});
		if(p_count.get("count").equals(0)){
			arg = null;
			sql = null;
			return new Page(0,0,Integer.valueOf(param.get("pageSize")), new ArrayList<Object>());
		}
		int page_no = Integer.valueOf(param.get("pageNo"));
		int page_size = Integer.valueOf(param.get("pageSize"));
		int low_row	 = (page_no -1) * page_size;
		sql.append(" limit "+ low_row +", " + page_size);
		final String entryTimeField = inOrOutDate;
		final String agentName = agentOrProvider;
		final List<CardProductVO> list_r = new ArrayList<CardProductVO>();
		jdbcTemplate.query(sql.toString(), arg.toArray(), new RowCallbackHandler() {
			public void processRow(ResultSet rs) throws SQLException {
				CardProductVO vo = new CardProductVO();
				vo.setP_no_agent_name(rs.getString(agentName));
				vo.setEntry_date(rs.getDate(entryTimeField));
				vo.setP_no(rs.getString("product_no"));
				vo.setCrad_no(rs.getString("card_sim_no"));
				vo.setSn_no(rs.getString("card_sn_no"));
				vo.setBox_no(rs.getString("card_box_no"));
				vo.setP_no_status(rs.getString("product_no_status"));
				vo.setCrad_no_status(rs.getString("card_sim_no_status"));
				vo.setSn_no_status(rs.getString("card_sn_no_status"));
				vo.setBox_no_status(rs.getString("card_box_no_status"));
				list_r.add(vo);
			}
		});	
		
		return new Page(Page.getStartOfPage(page_no, page_size), p_count.get("count"), page_size, list_r);
	}
	
	
	public Map<String,String> findAllIntegrityByNos(final String field_name,String NOs,String status) {
		StringBuilder sb = new StringBuilder();
		final String field_status = field_name + "_status";
		sb.append("select cp."+ field_name +",cp."+ field_status +" from card_product cp where ");
		if(null != status){
			sb.append("  cp."+ field_status +" = " + status);
		}else{
			sb.append(" 1=1 ");
		}
		sb.append(" and cp."+ field_name +" in (" + NOs + ")");
		
		final Map<String,String> p_map = new HashMap<String,String>();
		jdbcTemplate.query(sb.toString(), new ArrayList<Object>().toArray(), new RowCallbackHandler() {
			public void processRow(ResultSet rs) throws SQLException {
				p_map.put(rs.getString(field_name), rs.getString(field_status));
			}
		});
		return p_map;
	}

	public Integer doUpdateProductByPNos(Map<String,String> method_param) {
		String pno = (String)method_param.get("pns");
		String status = (String)method_param.get("status");
		String wi_id = (String)method_param.get("wi_id");
		String agent_name = (String)method_param.get("agent_name");
		String entryDate = (String)method_param.get("entryDate");
		
		Date d = Calendar.getInstance().getTime();
		String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
		String batchUpdateBySql = " update card_product cp, card_invoice_stauts ci set " 
				+ " cp.product_no_status = " + status 
				+ " , cp.card_sim_no_status = " + status 
				+ " , cp.card_sn_no_status = " + status 
				+ " , cp.card_box_no_status = " + status 
				
				+ " , ci.product_no_wi_out_id = " + wi_id 
				+ " , ci.card_sim_no_wi_out_id = " + wi_id
				+ " , ci.card_sn_no_wi_out_id = " + wi_id 
				+ " , ci.card_box_no_wi_out_id = " + wi_id
				
				+ " , ci.product_no_agent_name = '" + agent_name +"'"
				+ " , ci.card_sim_no_agent_name = '" + agent_name +"'"
				+ " , ci.card_sn_no_agent_name = '" + agent_name +"'"
				+ " , ci.card_box_no_agent_name = '" + agent_name +"'"
				
				+ " , ci.product_no_out_date = '" + entryDate +"'"
				+ " , ci.card_sim_no_out_date = '" + entryDate +"'"
				+ " , ci.card_sn_no_out_date = '" + entryDate +"'"
				+ " , ci.card_box_no_out_date = '" + entryDate +"'"
				
				+ " , cp.update_date = '" + now + "' where ci.cp_id = cp.pk_auto_incremental "
				+ " and cp.product_no in (" + pno + ")";
		jdbcTemplate.update(batchUpdateBySql);
		return pno.toString().split(",").length;
	}

	
	public Integer doUpdateProductByFieldNos(Map<String,String> method_param ) {
		String fieldName = (String)method_param.get("field_name");
		String nos = (String)method_param.get("nos");
		String status = (String)method_param.get("status");
		String wi_id = (String)method_param.get("wi_id");
		String agent_name = (String)method_param.get("agent_name");
		String entryDate = (String)method_param.get("entryDate");
		
		Date d = Calendar.getInstance().getTime();
		String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
		String fieldStatus = fieldName + "_status";
		String fieldWi = null;
		String fieldDate = null;
		String fieldAgent = null;
		if("1".equals(status)){
			fieldWi = fieldName + "_wi_out_id";
			fieldAgent = fieldName + "_agent_name";
			fieldDate = fieldName + "_out_date";
		}else{
			fieldWi = fieldName + "_wi_in_id";
			fieldAgent = fieldName + "_provider_name";
			fieldDate = fieldName + "_in_date";
		}
			
		String batchUpdateBySql = " update card_product cp, card_invoice_stauts ci set "
			+  "cp."+ fieldStatus +" = "+ status 
			+  " , cp.update_date = '"+ now +"'"
			+  " , ci." + fieldWi + " = " + wi_id
			+  " , ci."+ fieldDate +" = '" + entryDate +"'"
			+  " , ci."+ fieldAgent +" = '" + agent_name +"'"
			+" where ci.cp_id = cp.pk_auto_incremental and  cp."+ fieldName +" in ("+ nos +") ";
		jdbcTemplate.update(batchUpdateBySql);
		return nos.split(",").length;
	}
	
	
	public List<String> findCardNoByPNO(String p_nos) {
		String sql = "select distinct card.card_no from card_product cp left join card_3g card on cp.card_sim_no = card.card_no and cp.product_no in (" + p_nos + ")";
		final List<String> list = new ArrayList<String>();
		jdbcTemplate.query(sql, new ArrayList<Object>().toArray(), new RowCallbackHandler() {
			public void processRow(ResultSet rs) throws SQLException {
				list.add(rs.getString("card_no"));
			}
		});
		return list;
	}
	
	public void doUpdateCard3gByCardNos(String card_nos,String outDate) {
		String batchUpdateBySql = "update card_3g  set out_of_storage_time = '" + outDate + "' where card_no in (" + card_nos + ")" ;
		jdbcTemplate.update(batchUpdateBySql);
	}

	public Map<String, Integer> findCardProductNum() {
		String sql = "select name , num from product_num_view";
		final Map<String,Integer> p_map = new HashMap<String,Integer>();
		jdbcTemplate.query(sql, new ArrayList<Object>().toArray(), new RowCallbackHandler() {
			public void processRow(ResultSet rs) throws SQLException {
				p_map.put(rs.getString("name"), rs.getInt("num"));
			}
		});
		return p_map;
	}

	public void doUpdateCard3gByWI(Map<String, String> param) {
		String wi_id = param.get("wi_id");
		String entryDate = param.get("entryDate");
		String batchUpdateBySql = " update card_3g  set out_of_storage_time = '" + entryDate + "' where card_no in ( "+
					 " select wp.card_no from warehouse_invoice wi left join warehouse_product wp on wi.pk_auto_incremental = wp.wi_id" + 
					 " where wi.pk_auto_incremental = " + wi_id + ")";
		jdbcTemplate.update(batchUpdateBySql);			
	}


	public void doUpdateCard3gByInvoice(Map<String, String> param) {
		String invo_id = param.get("invo_id");
		String operatorDate = param.get("operatorDate");
		String batchUpdateBySql = " update card_3g  set out_of_storage_time = '" + operatorDate + "' where imsi in ( "+
					 " select cp.card_sim_no from invoice wi left join card_product cp on wi.id = cp.wi_in_id " + 
					 " where wi.id = " + invo_id + ")";
		jdbcTemplate.update(batchUpdateBySql);	
	}

}
*/