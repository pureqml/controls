/// Object for loading files via drag'n'drop
BaseMixin {
	signal filesAdded;	///< any file dropped inside DropZone signal

	///@private
	constructor: {
		var parent = this.parent
		var element = parent.element
		element.style('pointer-events', 'auto')
		element.style('touch-action', 'auto')

		element.on('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
			e.dataTransfer.dropEffect = 'copy';
		})

		var self = this
		element.on('drop', function(e) {
			e.stopPropagation();
			e.preventDefault();
			self.filesAdded(e.dataTransfer.files)
		}.bind(parent));
	}
}
