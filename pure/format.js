exports.currency = function(v, n, x) {
	var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
	return v.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
}

exports.format = function() {
	var args = [].slice.call(arguments);
	var initial = args.shift();

	function replacer (text, replacement) {
		return text.replace('%s', replacement);
	}
	return args.reduce(replacer, initial);
}