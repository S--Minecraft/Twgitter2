package twgitter2.core;

import twgitter2.pipe.Pipe;

public class Core {
	public static void main(String[] args) {
		//ログを記録開始
		Log.create();

		//パイプ開始
		Pipe pipe = new Pipe();
		pipe.start();

		//ただのテストコード
		Test.test();

		//終了時処理
		Runtime.getRuntime().addShutdownHook(new Thread() {
			@Override
			public void run() {
				//ログを閉じる
				Log.close();

				Util.debug("finished");
			}
		});
	}
}
