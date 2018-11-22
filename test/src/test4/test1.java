package test4;

public class test1 {

	public static void main(String[] args) {
		String s = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16";
		String[] a = s.split(",");
		for (int i = 0; i < a.length; i++) {
			if(i!=0 && i%4==0)
				System.out.println("----------");
			System.out.print(a[i]);
			if(i+4>a.length && i==a.length-1)
				System.out.println("----------");
		}
	}
}	
