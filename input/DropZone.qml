Object {
	signal filesAdded;

	constructor: {
		this.parent.element.on('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
			e.dataTransfer.dropEffect = 'copy';
		})

		this.parent.element.on('drop', function (e) {
			e.stopPropagation();
			e.preventDefault();
			this.filesAdded(e.dataTransfer.files)
		}.bind(this));
	}
}