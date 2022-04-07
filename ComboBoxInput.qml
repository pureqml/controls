TextInput {
	property Model model;
	property bool trace: false;
	DataList {
		model: parent.model;
		trace: parent.trace;
		onCompleted: {
			var element = this.element
			var input = this.parent
			element.remove()
			input.parent.element.append(element)
			input.element.setAttribute("list", this.domId)
		}
	}
}
