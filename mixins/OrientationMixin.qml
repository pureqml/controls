/// The mixin provides information from the physical orientation of the device.
BaseMixin {
	property real alpha;	///< The rotation of the device around the Z axis; that is, the number of degrees by which the device is being twisted around the center of the screen.
	property real beta;		///< The rotation of the device around the X axis; that is, the number of degrees, ranged between -180 and 180,  by which the device is tipped forward or backward.
	property real gamma;	///< The rotation of the device around the Y axis; that is, the number of degrees, ranged between -90 and 90, by which the device is turned left or right.
	property bool absolute;	///< Indicates whether or not the device is providing orientation data absolutely (that is, in reference to the Earth's coordinate frame) or using some arbitrary frame determined by the device.

	constructor: {
		this._bindOrientation(this.enabled)
	}

	/// @private
	function _bindOrientation(value) {
		if (value && !this._orientationBinder && this._context.window) {
			var self = this
			this._context.window.on("deviceorientation", function(e) {
				self.absolute = e.absolute
				self.alpha = e.alpha
				self.beta = e.beta
				self.gamma = e.gamma
			}.bind(this))
		}
		if (this._orientationBinder)
			this._orientationBinder.enable(value)
	}

	///@private
	onEnabledChanged: { this._bindOrientation(value) }
}
