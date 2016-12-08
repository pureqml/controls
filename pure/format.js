exports.currency = function(v, n, x) {
  var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
  return v.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
}