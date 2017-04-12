/// google chart item
Item {
	property enum type { Pie, Line, Column };	///< chart type enum Pie, Line or Column

	/**@param data:Object data for chart building
	@param opt:Object chart displaying properties
	Fill google chart function*/
	fill(data, opt): {
		var elem = this.element
		var w = this.width
		var h = this.height
		var self = this
		google.charts.load("current", {packages:['corechart']});
		google.charts.setOnLoadCallback(function() {
			if (!data)
				return

			var visData = google.visualization.arrayToDataTable(data)
			var view = new google.visualization.DataView(visData);
			var options = opt || []
			var chart
			switch (self.type) {
			case self.Pie:	chart = new google.visualization.PieChart(elem.dom); break
			case self.Line:	chart = new google.visualization.LineChart(elem.dom); break
			default:		chart = new google.visualization.ColumnChart(elem.dom); break
			}
			chart.draw(view, options);
		});
	}

	/// @private
	function registerStyle(style) {
		style.addRule('svg', "position: absolute; visibility: inherit; border-style: solid; border-width: 0px; box-sizing: border-box;")
	}
}
