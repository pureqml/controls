BaseMixin {
	property string value;

	onValueChanged: { this.parent.element.dom.setAttribute('title', value); }
}
