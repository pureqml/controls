///simple activity control
BaseActivity {
	property bool handleDisplay;	///< use this flag if you want to hide inactive activivties with CSS 'display' property.

	///start activity
	start: {
		if (this.handleDisplay)
			this.style('display', 'block')
		this.visible = true
		this.started()
	}

	///stop activity
	stop: {
		if (this.handleDisplay)
			this.style('display', 'none')
		this.visible = false
		this.stopped()
	}

	///get activity item
	function getActivity() {
		return this
	}
}
