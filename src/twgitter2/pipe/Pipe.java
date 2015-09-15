package twgitter2.pipe;

import twgitter2.core.Util;

public class Pipe extends Thread{
	public StandardInputReader sir;

	@Override
	public void run() {
		sir = new StandardInputReader(this);
	}

	public void recieved(String s) {
		Util.debug("Receieved: " + s);
	}

	public void close() {
		sir.close();
	}

}