BaseActivity {
	start: {
		this.style('display', 'block')
		this.visible = true
		this.started()
	}

	stop: {
		this.style('display', 'none')
		this.visible = false
		this.stopped()
	}
}
