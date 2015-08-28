var fs = require('fs');
var osmium = require('osmium');
var argv = require('optimist').argv;
var _ = require('underscore');
var osmfile = argv.osmfile;
var nodes = {};
var bounds;
var geojson = {
        "type": "FeatureCollection",
        "features": []
};
//var file = new osmium.File(osmfile);
var reader = new osmium.Reader(osmfile);
var handler = new osmium.Handler();

handler.on('node', function(node) {
        var coord = [node.lon, node.lat];
        nodes[node.id] = coord;
});
handler.on('way', function(way) {
        var feature = {
                "type": "Feature",
                "properties": {
                        "osmid": null,
                        "osmversion": null,
                        "osmuser": null,
                        "osmtimestamp": null
                },
                "geometry": {
                        "type": "LineString",
                        "coordinates": []
                }
        };
        for (var i = 0; i < way.node_refs().length; i++) {
                if (nodes.hasOwnProperty(way.node_refs()[i])) {
                        feature.geometry.coordinates.push(nodes[way.node_refs()[i]]);
                }
        }
        if (feature.geometry.coordinates.length > 0) {
                feature.properties['osmid'] = way.id;
                feature.properties['osmversion'] = way.version;
                feature.properties['osmuser'] = way.user;
                feature.properties['osmtimestamp'] = way.timestamp;
                geojson.features.push(feature);
        }
});

osmium.apply(reader, handler);
var outputFilename = osmfile.split('.')[0] + '.geojson';
fs.writeFile(outputFilename, JSON.stringify(geojson), function(err) {
	if (err) {
		console.log(err);
	}
});