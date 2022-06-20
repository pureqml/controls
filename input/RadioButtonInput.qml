/// web browser RadioInput - change event is emitted when selected
BaseInput {
	property string groupName: "";
	property string optionId: "";
	height: 20;
	width: 20;
	type: "radio";

	onGroupNameChanged: {
		this.element.setAttribute("name", this.groupName);
	}
	onOptionIdChanged: {
		this.element.setAttribute("id", this.optionId);
	}
	constructor: {
		if("" !== this.groupName) {
			this.element.setAttribute("name", this.groupName);
		}
		if("" !== this.optionId) {
			this.element.setAttribute("id", this.optionId);
		}
	}
}
