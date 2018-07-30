Item {
	property string component;
	property Item manager: parent;
	anchors.fill: manager;

	Loader {
		id: loader;
		anchors.fill: parent.manager;
	}

	///create page
	function createPage() {
		var item = loader.item
		if (!item) {
			loader.source = this.component
			item = loader.item
			item.anchors.fill = this
			this._context._processActions()
			item.manager = this.manager
			if (!item)
				throw new Error("can't create component " + this.component)
		}
		return loader.item
	}
}
