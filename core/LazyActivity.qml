Item {
	property string name;
	property string component;

	Loader {
		id : loader;
	}

	function getItem() {
		if (!loader.item)
			loader.component = this.component
		return loader.item
	}
}
