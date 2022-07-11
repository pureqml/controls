Item {
    property Model model;
    property bool trace;

    onModelChanged: {
        if (this._modelAttached) {
            this._modelAttached.detachFrom(this)
        }
        this.model.attachTo(this)
    }

	/// @private
	function _onReset() {
        var model = this.model
        var mc = model.count
        var dom = this.element.dom
        var vc = dom.childNodes.length
        if (this.trace)
            log("Datalist reset, model count:" + mc + ", current option count: " + vc)

        if (vc > mc) {
            var elements = [].slice.call(dom.childNodes);
            var removed = elements.splice(mc, vc - mc);
            removed.forEach(function(element) {
                dom.removeChild(element)
            })
        } else if (vc < mc) {
            this._onRowsInserted(vc, mc)
        }
        this._onRowsChanged(0, Math.min(vc, mc))
	}

	/// @private
	function _onRowsInserted(begin, end) {
        if (begin >= end)
            return
        if (this.trace)
            log("DataList::onRowsInserted", begin, end)

        var model = this.model
        var dom = this.element.dom
        var n = dom.childNodes.length
        if (begin > n)
            throw new Error("invalid begin in rowsInserted " + begin + "/" + n)
        if (begin < n) {
            var lastChild = dom.childNodes[begin]
            for(var i = begin; i < end; ++i) {
                dom.insertBefore(this._createValue(model.get(i)), lastChild)
            }
        } else {
            for(var i = begin; i < end; ++i) {
                dom.append(this._createValue(model.get(i)))
            }
        }
	}

	/// @private
	function _onRowsChanged(begin, end) {
        if (begin >= end)
            return
        if (this.trace)
            log("DataList::onRowsChanged", begin, end)

        var model = this.model
        var dom = this.element.dom
        var valueProperty = this.valueProperty
        for(var i = begin; i < end; ++i) {
            this._updateValue(dom.childNodes[i], model.get(i))
        }
	}

	/// @private
	function _onRowsRemoved(begin, end) {
        if (begin >= end)
            return
        if (this.trace)
            log("DataList::onRowsRemoved", begin, end)

        var dom = this.element.dom
        for(var i = begin; i < end; ++i) {
            dom.removeChild(dom.childNodes[begin]);
        }
	}

	/// @private
	function addChild (child) {
        throw new Error(this.componentName + " can't have any children. They will be overwritten by model update")
    }
}