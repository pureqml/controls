BaseActivity {
	property string component;

	Loader {
		id : loader;
	}

	function createItem() {
		var item = loader.item
		if (!item) {
			loader.source = this.component
			item = loader.item
			item.manager = this.parent
			if (!item)
				throw new Error("can't create component " + this.component)

			var activity = this
			item.on('started', function() { activity.started() })
			item.on('stopped', function() { activity.stopped() })
		}
		return loader.item
	}

	function getItem() {
		return loader.item
	}

	function init() {
		_globals.controls.core.BaseActivity.prototype.init.apply(this, arguments)
		this.createItem()
	}

	start: {
		this.createItem().start()
		this.visible = true
	}

	stop: {
		this.visible = false
		var item = this.getItem()
		if (item)
			item.stop()
	}
}
