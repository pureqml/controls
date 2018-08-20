///simple activity control
BaseActivity {
	///start activity
	start: {
		this.visible = true
		this.started()
	}

	///stop activity
	stop: {
		this.visible = false
		this.stopped()
	}

	///get activity item
	function getActivity() {
		return this
	}
}
