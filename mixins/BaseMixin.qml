/// Base object for all mixins
Object {
	stopPropagation(event): {
		if (!event)
			context.window.event.cancelBubble = true;
		else if (event.stopPropagation)
			event.stopPropagation();
	}
}
