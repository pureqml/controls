///this activity instanciate only when init method is called
BaseActivity {
	property string component;	///< path to activity source
	anchors.fill: manager;		///< activities manager

	Loader {
		id : loader;
		anchors.fill: parent.manager;
	}

	///create activity
	function createActivity() {
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

	///get activity item
	function getActivity() {
		return loader.item
	}

	///Initialize activity
	function init() {
		_globals.controls.core.BaseActivity.prototype.init.apply(this, arguments)
		var activity = this.createActivity()
		if (activity)
			activity.init.apply(activity, arguments)
	}

	///Start activity lazy way
	start: {
		this.createActivity().start()
		this.visible = true
	}

	///Stop activity
	stop: {
		this.visible = false
		var item = this.getActivity()
		if (item)
			item.stop()
	}
}
