package cn.util;

import java.util.ArrayList;
import java.util.List;


/**
 * 字符串帮助类
 *
 */
public class StringHelper{

	/**
	 * 判断是否是null或者“”
	 * @param string
	 * @return  boolean
	 */
	public static boolean  IsNullOrEmpty(String string){
		boolean flag=false;
		if(string==null||string.trim().isEmpty()){
			flag=true;
		}
		return flag;
	}

	/**
	 * 左侧补足
	 * @param src 目标字符串
	 * @param len 总长度
	 * @param ch  填充的字符
	 * @return
	 */
	public static String PadLeft(String src,int len,char ch){
		int diff = len - src.length();
        if (diff <= 0) {
            return src;
        }
        char[] charr = new char[len];
        System.arraycopy(src.toCharArray(), 0, charr, diff, src.length());
        for (int i = 0; i < diff; i++) {
            charr[i] = ch;
        }
        return new String(charr);
	}
	/**
	 * 右侧补足
	 * @param src 目标字符串
	 * @param len 总长度
	 * @param ch  填充的字符
	 * @return
	 */
	public static String PadRight(String src,int len,char ch){
		int diff = len - src.length();
        if (diff <= 0) {
            return src;
        }
        char[] charr = new char[len];
        System.arraycopy(src.toCharArray(), 0, charr, 0, src.length());
        for (int i = src.length(); i < len; i++) {
            charr[i] = ch;
        }
        return new String(charr);
	}
	
	/**
	 * string  用 , 分割成 int list
	 * @param src 字符串
	 * @return
	 */
	public static List<Integer> ToIntegerList(String src) {
		return ToIntegerList(src,",");
	}
	
	/**
	 * string  分割 int list
	 * @param src 字符串
	 * @param splitWord 分隔符
	 * @return List
	 */
	public static List<Integer> ToIntegerList(String src,String splitWord) {
		
		List<Integer> list=new ArrayList<Integer>();
		
		if(IsNullOrEmpty(src)){
			return list;
		}
		String[] arr=src.split(splitWord);
		if(arr!=null&&arr.length>0){
			for (String item: arr) {
					list.add(DataConvert.ToInteger(item));
			}
		}
		return list;
	}
	
	/**
	 * array 拼接 成 string 
	 * @param join 拼接字符
	 * @param array  数组
	 * @return string
	 */
	public  static  String  Join(String join, Object[] array){
        StringBuffer sb=new StringBuffer();
        for(int i=0;i<array.length;i++){
             if(i==(array.length-1)){
                 sb.append(array[i]);
             }else{
                 sb.append(array[i]).append(join);
             }
        }
        return new String(sb);
    }
}
