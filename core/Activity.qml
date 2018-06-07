BaseActivity {
	property bool handleDisplay;

	start: {
		if (this.handleDisplay)
			this.style('display', 'block')
		this.visible = true
		this.started()
	}

	stop: {
		if (this.handleDisplay)
			this.style('display', 'none')
		this.visible = false
		this.stopped()
	}

	function getActivity() {
		return this
	}
}
