package test;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class passwordUtil {
	
	public static void main(String[] args) {
		passwordUtil t = new passwordUtil();
		byte[] b = t.encrypt("2".getBytes());
		// e13d152426b46510df36a8f02b1a368f81d172f3
		System.out.println(t.toHex(b));
	}
	protected byte[] encrypt(byte[] obj){
		 MessageDigest md5 = null;
	    try{
	        md5 = MessageDigest.getInstance("SHA");
	        md5.update(obj);
	        return md5.digest();
	    } catch (NoSuchAlgorithmException e){
	        e.printStackTrace();
	    }
	    return md5.digest();
	}
	
	private static String toHex(byte[] buffer) {
       StringBuffer sb = new StringBuffer(buffer.length * 3);
       for (int i = 0; i < buffer.length; i++) {
           sb.append(Character.forDigit((buffer[i] & 0xf0) >> 4, 16));
           sb.append(Character.forDigit(buffer[i] & 0x0f, 16));
       }
       return sb.toString();
   }
}
