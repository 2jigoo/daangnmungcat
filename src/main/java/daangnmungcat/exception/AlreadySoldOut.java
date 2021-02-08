package daangnmungcat.exception;

public class AlreadySoldOut extends RuntimeException {

	public AlreadySoldOut() {
	}

	public AlreadySoldOut(String message, Throwable cause) {
		super(message, cause);
	}

	public AlreadySoldOut(String message) {
		super(message);
	}

	public AlreadySoldOut(Throwable cause) {
		super(cause);
	}

}
