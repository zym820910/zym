package test3;

import org.springframework.dao.DataAccessException;
import org.springframework.security.providers.encoding.PasswordEncoder;


/**
 * 密码加密算法
 */
public class PasswordUtil implements PasswordEncoder{
	
//	/**
//	 * 使用Sha_ sh a_256加密.
//	 */
//	public static String sha_SHA_256(String password) {
//		ShaPasswordEncoder sha = new ShaPasswordEncoder();
//		sha.setEncodeHashAsBase64(false);
//		String pwd = sha.encodePassword(password, null);
////		System.out.println("哈希算法 SHA-256: " + pwd + " len=" + pwd.length());
//		return pwd;
//	}
	
	/**
	 * 使用Sha_ sh a_256加密.
	 * DES加密
	 */
	public static String sha_SHA_256(String password){
		
		 String pwd = password;
		
		try{
			 DESPlus des = new DESPlus("jxt123456");//自定义密�?
			 pwd =  des.encrypt(password);
			 
		}catch(Exception e){
			System.out.println("加密失败");
			e.printStackTrace();
		}

		return pwd;
	}
	
	/**
	 * 使用Sha_ sh a_256加密.
	 */
	public static String decode(String password) {
		
		String pwd = password;
		try{
			
			DESPlus des = new DESPlus("jxt123456");//自定义密�?
			pwd =  des.decrypt(password);
			
		}catch(Exception e){
			System.out.println("解密失败");
			e.printStackTrace();
		}
		
		return pwd;
	}

	/* 
	 * 密码加密
	 */
	public String encodePassword(String password, Object salt) throws DataAccessException {
		 String pwd = password;
		
		try{
			 DESPlus des = new DESPlus("jxt123456");//自定义密�?
			 pwd =  des.encrypt(password);
			
		}catch(Exception e){
			
			System.out.println("加密失败");
			e.printStackTrace();
		}
		return pwd;
	}

	/* (non-Javadoc)
	 * @see org.springframework.security.providers.encoding.PasswordEncoder#isPasswordValid(java.lang.String, java.lang.String, java.lang.Object)
	 */
	public boolean isPasswordValid(String encPass, String rawPass, Object salt) throws DataAccessException {
		return encPass.equals(encodePassword(rawPass,null));
	}
	
	public static void main(String[] args) {
		PasswordUtil p = new PasswordUtil();
		String pass = p.encodePassword("520320", "jxt123456");
		System.out.println(pass);
		
		
		
	}
	
}
