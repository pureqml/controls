/// PageStack which pages will be initialized only after opening. Wrap your pages in LazyPage component.
PageStack {
	///@private
	function _layout() {
		this.count = this.children.length;
		if (this.trace)
			log('laying out ' + this.count + ' children in ' + this.width + 'x' + this.height)

		var currentLazyPage = this.children[this.currentIndex]
		currentLazyPage.element.dom.style.display = 'block';
		if (!currentLazyPage)
			return

		var page = currentLazyPage.getPage() ? currentLazyPage.getPage() : currentLazyPage.createPage()
		this._currentPage = page

		for (var i = 0; i < this.count; ++i) {
			this.children[i].element.dom.style.display = (i === this.currentIndex) ? 'block' : 'none';
			var currentPage = this.children[i].getPage()
			if (currentPage) {
				currentPage.visible = i === this.currentIndex
				currentPage.visibleInView = i === this.currentIndex
				if (currentPage.visible && currentPage.init)
					currentPage.init(currentPage.intent, currentPage.state)
			}
		}

		this.contentHeight = page ? page.height : 0;
		this.contentWidth = page ? page.width : 0;
	}

	/**@param name:string page name
	show page by its name*/
	showPageByName(name): {
		var idx = this.getPageIndexByName(name)
		if (idx >= 0)
			this.currentIndex = idx
		throw new Error("Page " + name + " not found")
	}

	/**@param name:string page name
	find page index in pagestack by its name*/
	getPageIndexByName(name): {
		var pages = this.children
		for (var i = 0; i < pages.length; ++i) {
			var page = this.children[i]
			if (page instanceof _globals.controls.core.LazyPage && page.name == name)
				return i
		}
		return -1
	}

	setState(state): {
		if (this.count === 0)
			throw new Error("There is no activity in stack")

		var currentPage = this.children[this.currentIndex].getPage()
		currentPage.state = state
	}

	///set focus on current LazyPage content
	chooseCurrentPage: {
		if (this._currentPage)
			this._currentPage.setFocus()
	}
}
