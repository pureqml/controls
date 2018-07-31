PageStack {
	function _layout() {
		this.count = this.children.length;
		if (this.trace)
			log('laying out ' + this.count + ' children in ' + this.width + 'x' + this.height)

		for (var i = 0; i < this.count; ++i) {
			if (i === this.currentIndex) {
				var activity = this.children[this.currentIndex].createPage()
				activity.visibleInView = true
			}
		}

		var c = this.children[this.currentIndex];
		if (!c)
			return

		var page = c.getPage();
		if (!page)
			return

		this.contentHeight = page.height;
		this.contentWidth = page.width;
	}
}
