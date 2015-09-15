package twgitter2.pipe;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class StandardInputReader {
	public BufferedReader input;

	public StandardInputReader(Pipe pipe) {
		InputStreamReader isr = new InputStreamReader(System.in);
		input = new BufferedReader(isr);

		String line;
		try {
			while( (line = input.readLine()) != null) {
				if(!line.equals("")) {
					pipe.recieved(line);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			input.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
