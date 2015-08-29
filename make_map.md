Remove  ways with diferent version, remove min version

First make a backup from database `pg_dump --host=localhost --port=5432 --username=postgres --password dbworld > dbworld.pg_dump`

run: 

```
DELETE FROM ogrgeojson a WHERE a.osmversion <> (SELECT min(b.osmversion)  FROM   ogrgeojson b  WHERE  a.osmid = b.osmid);
```

### Mapbox Studio


```
git clone https://github.com/mapbox/postgis-vt-util.git
cd postgis-vt-util
psql --host=localhost --port=5432 --username=postgres  --dbname=dbworld -f ./postgis-vt-util.sql 

```

Select in Mapbox Studio:

add lenght colum in table:

```sql
ALTER TABLE ogrgeojson ADD COLUMN  length decimal;
UPDATE ogrgeojson  SET length =ST_Length(wkb_geometry)*100000;

```

```sql

(SELECT ogc_fid, wkb_geometry,osmid, osmversion,osmuser  FROM ogrgeojson
   WHERE wkb_geometry && !bbox! AND CASE
   WHEN  z(!scale_denominator!)=2 AND length > zres(7)  THEN TRUE
   WHEN  z(!scale_denominator!)=3 AND length > zres(7)  THEN TRUE
   WHEN  z(!scale_denominator!)=4 AND length > zres(7)  THEN TRUE
   WHEN  z(!scale_denominator!)=5 AND length > zres(8)  THEN TRUE
   WHEN  z(!scale_denominator!)=6 AND length > zres(9)  THEN TRUE
   WHEN  z(!scale_denominator!)=7 AND length > zres(10)  THEN TRUE
   WHEN  z(!scale_denominator!)=8 AND length > zres(10)  THEN TRUE
   WHEN  z(!scale_denominator!)=9 AND length > zres(11)  THEN TRUE
   WHEN  z(!scale_denominator!)=10 AND length > zres(12)  THEN TRUE
   WHEN  z(!scale_denominator!)=11 AND length > zres(13)  THEN TRUE
   WHEN  z(!scale_denominator!)>=12 THEN TRUE
   END
   ) AS data

```


### Tipecanoe

`ogr2ogr -f "GeoJSON" ogrgeojson.geojson PG:"host=localhost user=postgres dbname=dbworld" "ogrgeojson"`

`tippecanoe -l osm -n way -o output.mbtiles -z2 -z12 -pscfkr ogrgeojson.geojson`