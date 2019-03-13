///simple activity control
BaseActivity {
	///start activity
	start: {
		this.active = true
		this.started()
	}

	///stop activity
	stop: {
		this.active = false
		this.stopped()
	}

	///get activity item
	function getActivity() {
		return this
	}
}
