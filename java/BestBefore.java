import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;


/**
 * @author davidjy.lee@gmail.com
 * 
 * http://www.spotify.com/se/jobs/tech/best-before/
 * 
 */
public class BestBefore {
	private static List<Integer> THIRTYONE_DAY_MONTHS = Arrays.asList(new Integer[] {1,3,5,7,8,10,12});
	
	public static void main(String[] args) throws IOException {		
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String input = br.readLine();
		String output = processInput(input);			
		
		System.out.println( output );
	}
	
	public static String processInput(String input) {
		String[] parts = input.split("/");
		
		if( parts.length != 3 ) {
			return illegalInputResponse(input);
		}
		
		// Create different date combinations.
		java.util.List<MyDate> dates = new LinkedList<MyDate>();
		dates.add(new MyDate(parts[0], parts[1], parts[2]));
		dates.add(new MyDate(parts[0], parts[2], parts[1]));
		dates.add(new MyDate(parts[1], parts[2], parts[0]));  
		dates.add(new MyDate(parts[1], parts[0], parts[2]));
		dates.add(new MyDate(parts[2], parts[0], parts[1]));
		dates.add(new MyDate(parts[2], parts[1], parts[0]));
		
		// filter out invalid dates
		Iterator<MyDate> iter = dates.iterator();
		while(iter.hasNext()) {
			MyDate d = iter.next();
			if( !isValidDate(d) )
				iter.remove();
		}
		
		if( dates.size() > 0 ) {
			// find earliest
			Collections.sort(dates);
			return dates.get(0).toString();
		}
		
		return illegalInputResponse(input);
	}
	
	public static boolean isValidDate(MyDate date) {
		try {
			Integer.parseInt(date.getYear());
			Integer.parseInt(date.getMonth());
			Integer.parseInt(date.getDay());
		} catch( NumberFormatException e ) {
			return false;
		}
		
		if( !isValidYear(date) || !isValidMonth(date) || !isValidDay(date) )
			return false;
		
		return true;
	}
	
	public static boolean isValidYear(MyDate date) {
		String year = date.getYear();
		int intYear = Integer.parseInt(year);
		
		if( year.length() == 1 || year.length() == 2 ) {
			return true;
		} else if ( year.length() == 4 && intYear >= 2000 && intYear <= 2999 ) {
			return true;
		}
		
		return false;
	}
	
	public static boolean isValidMonth(MyDate date) {
		String month = date.getMonth();
		int intMonth = Integer.parseInt(month);

		if( month.length() == 1 && intMonth > 0 ) {
			return true;
		} else if( month.length() == 2 && intMonth > 0 && intMonth < 13 ) {
			return true;
		}
		
		return false;
	}
	
	public static boolean isValidDay(MyDate date) {
		String day = date.getDay();		
		int intDay = Integer.parseInt(day);
		int intMonth = Integer.parseInt(date.getMonth());	// we check if the day lines up with the month		
		
		if( day.length() == 1 && intDay > 0 ) {
			return true;
		} else if( day.length() == 2 && intDay > 0 ) {			
			if( intDay == 31 && THIRTYONE_DAY_MONTHS.contains(intMonth) ) {
				return true;
			}
			
			// check leap year					
			if( intMonth == 2 ) {
				if( intDay == 29 ) {
					return isLeapYear(date);
				} else {
					return intDay < 29;
				}
			}
			
			return intDay < 31;
		}
		
		return false;
		
	}
	
	public static boolean isLeapYear(MyDate date) {		
		int intYear = Integer.parseInt(date.normalizedYear());
		
		if( intYear % 4 == 0 ) {
			if( intYear % 100 == 0 && intYear % 400 > 0 )
				return false;
			
			return true;
		}
		
		return false;
	}

	public static String illegalInputResponse(String input) {
		return input + " is illegal";
	}
}

class MyDate implements Comparable<MyDate> {
	private String year;
	private String month;
	private String day;
	
	public MyDate(String year, String month, String day) {
		this.year = year;
		this.month = month;
		this.day = day;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}
	
	public String normalizedYear() {
		if( this.year.length() == 1 ) {
			return "200" + this.year;
		} else if( this.year.length() == 2 ) {
			return "20" + this.year;
		}
		
		return this.year;
	}
	
	public int compareTo(MyDate o) {
		int thisYear = Integer.parseInt(this.year);
		int thisMonth = Integer.parseInt(this.month);
		int thisDay = Integer.parseInt(this.day);
		int otherYear = Integer.parseInt(o.getYear());
		int otherMonth = Integer.parseInt(o.getMonth());
		int otherDay = Integer.parseInt(o.getDay());
		
		if( thisYear == otherYear && thisMonth == otherMonth && thisDay == otherDay )
			return 0;
		
		if( thisYear < otherYear ) {
			return -1;
		} else if( thisYear > otherYear ) {
			return 1;
		}
		
		if( thisMonth < otherMonth ) {
			return -1;
		} else if( thisMonth > otherMonth ) {
			return 1;
		}
		
		if( thisDay < otherDay ) {
			return -1;
		} else if( thisDay > otherDay ) {
			return 1;
		}
		
		return 1;
	}
	
	public String toString() {
		StringBuilder sb = new StringBuilder();
		
		sb.append(this.normalizedYear());
		sb.append("-");
		
		if( this.month.length() < 2 )
			sb.append("0");			
		sb.append(this.month);
		sb.append("-");
		
		if( this.day.length() < 2 )
			sb.append("0");
		sb.append(this.day);
		
		return sb.toString();
	}
}
