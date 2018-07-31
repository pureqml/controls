PageStack {
	function _layout() {
		this.count = this.children.length;
		if (this.trace)
			log('laying out ' + this.count + ' children in ' + this.width + 'x' + this.height)

		var currentLazyPage = this.children[this.currentIndex]
		if (!currentLazyPage)
			return

		var page = currentLazyPage.getPage() ? currentLazyPage.getPage() : currentLazyPage.createPage()
		this._currentPage = page

		for (var i = 0; i < this.count; ++i) {
			var currentPage = this.children[i].getPage()
			if (currentPage) {
				currentPage.visible  = i === this.currentIndex
				currentPage.visibleInView  = i === this.currentIndex
			}
		}

		this.contentHeight = page ? page.height : 0;
		this.contentWidth = page ? page.width : 0;
	}

	chooseCurrentPage: {
		if (this._currentPage)
			this._currentPage.setFocus()
	}
}
