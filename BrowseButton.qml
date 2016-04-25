Item {
	property string value;
	property string accept;
	width: 220;
	height: 40;

	onCompleted: {
		var input = document.createElement("input");
		input.setAttribute("type", "file");
		if (this.accept)
			input.setAttribute("accept", this.accept);
		input.style.width = this.width + "px"
		input.style.height = this.height + "px"

		var self = this
		input.onchange = function(e) { self.value = input.value }

		this.element.append(input)
	}
}
