TableElement {
	htmlTag: "table";

	property Object model: ListModel { }
	property Object headerModel: ListModel { }
	property Color textColor;

	onTextColorChanged: { this.style('color', _globals.core.Color.normalize(value)) }

	TableHeader {
		model: parent.headerModel;
		delegate: TableHeaderCell { text: model.text; }
	}

	TableBody {
		model: parent.model;
		delegate: TableRow {
			model: ListModel { data: model.data; }
			delegate: TableCell { text: model.value; }
		}
	}

	assign(data, columns): {
		log('table data', data, columns)
		var headerModel = this.headerModel
		columns.forEach(function(name) { headerModel.append({ text: name }) })
		var rowData = []
		data.forEach(function (srcRow) {
			var row = []
			columns.forEach(function(name) {
				var value = srcRow[name]
				if (value !== undefined)
					row.push({ value: value })
				else
					row.push('')
			})
			rowData.push({ data: row})
		})
		log('table data', rowData)
		this.model.assign(rowData)
	}
}
