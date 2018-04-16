BaseActivity {
	property string component;
	anchors.fill: manager;

	Loader {
		id : loader;
		anchors.fill: parent.manager;
	}

	function createItem() {
		var item = loader.item
		if (!item) {
			loader.source = this.component
			item = loader.item
			item.anchors.fill = this
			this._context._processActions() //we have to process all actions before starting setting up items
			item.manager = this.manager
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
		var activity = this.createItem()
		if (activity)
			activity.init.apply(this, arguments)
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
