Image {
	property bool running;
	visible: running;
	source: "res/spinner.gif";

	start: {
		this.running = true;
	}

	stop: {
		this.running = false;
	}
}