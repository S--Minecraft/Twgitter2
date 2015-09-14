package twgitter2.core;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import twgitter2.pipe.StandardOutputReader;

public class Log {
	public static PrintWriter logger;

	public static void create() {
		File file = new File(System.getProperty("user.dir") + "\\config\\java.log");
		if (ensureFileExists(file)) {
			try {
				FileWriter fw = new FileWriter(file);
				BufferedWriter bw = new BufferedWriter(fw);
				logger = new PrintWriter(bw);
				StandardOutputReader sor = new StandardOutputReader(logger);
				System.setOut(sor);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			System.err.println("ファイルが開けません");
		}
	}

	public static void close() {
		logger.close();
	}

	private static boolean ensureFileExists(File file){
		boolean ok = false;
		if (file.exists()){
			ok = (file.isFile() && file.canWrite());
		} else {
			try {
				file.createNewFile();
				ok = true;
			} catch (IOException e) {
				e.printStackTrace();
				ok = false;
			}
		}
		return ok;
	}
}
