package twgitter2.pipe;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;

public class StandardOutputReader extends PrintStream {
	private final PrintWriter LOGGER;

	public StandardOutputReader(PrintWriter out) {
		super(System.out);
		LOGGER = out;
	}

	@Override
	public void write(byte[] buf, int off, int len) {
		super.write(buf, off, len);
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		stream.write(buf, off, len);
		LOGGER.write(stream.toString());
	}

	@Override
	public void write(int b) {
		super.write(b);
		LOGGER.write(b);
	}
}
