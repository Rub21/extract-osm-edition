var osmium = require('osmium');
var reader = new osmium.Reader("map.osm","osm");
var handler = new osmium.Handler();
var nodes = 0;
handler.on('node', function(node) {
    ++nodes;
});
osmium.apply(reader, handler);
console.log(nodes);