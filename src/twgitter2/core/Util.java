package twgitter2.core;

public class Util {
	public static void debug(String s) {
		System.out.println("[Debug]" + s);
	}

	public static void message(String type, String s) {
		System.out.println("[Message]" + type + ": " + s);
	}
}
