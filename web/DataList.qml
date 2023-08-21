ElementWithModel {
    property string domId;
    property string valueProperty: "value";

    constructor: {
        var element = this.element
        var id = "datalist-" + element._uniqueId
        element.setAttribute("id", id)
        this.domId = id
    }

	htmlTag: "datalist";

	/// @private
    function _createValue(row) {
        var value = row[this.valueProperty]
        if (this.trace)
            log("DataList::createValue", value)

        var el = document.createElement("option");
        el.setAttribute("value", value)
        return el
    }

	/// @private
    function _updateValue(el, row) {
        var value = row[this.valueProperty]
        if (this.trace)
            log("DataList::updateValue", value)

        el.setAttribute("value", value)
        return el
    }
}
