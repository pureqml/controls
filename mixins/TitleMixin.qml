BaseMixin {
	property string value;

	onValueChanged: { this.parent.element.setAttribute('title', value); }
}
