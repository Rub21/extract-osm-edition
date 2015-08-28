
Processing file 080
gzip -d 080.osc.gz
./osmfilter 080.osc --keep=highway= -o=hig-080.osm
./osmfilter hig-080.osm --keep="@user=PlaneMad" -o=080-PlaneMad.osm
./osmfilter hig-080.osm --keep="@user=Aaron Lidman" -o=080-AaronLidman.osm
./osmfilter hig-080.osm --keep="@user=andygol" -o=080-andygol.osm
./osmfilter hig-080.osm --keep="@user=geohacker" -o=080-geohacker.osm
./osmfilter hig-080.osm --keep="@user=Rub21" -o=080-Rub21.osm
./osmfilter hig-080.osm --keep="@user=lxbarth" -o=080-lxbarth.osm
./osmfilter hig-080.osm --keep="@user=ediyes" -o=080-ediyes.osm
./osmfilter hig-080.osm --keep="@user=Luis36995" -o=080-Luis36995.osm
./osmfilter hig-080.osm --keep="@user=srividya_c" -o=080-srividya_c.osm
./osmfilter hig-080.osm --keep="@user=RichRico" -o=080-RichRico.osm
./osmfilter hig-080.osm --keep="@user=dannykath" -o=080-dannykath.osm
./osmfilter hig-080.osm --keep="@user=shvrm" -o=080-shvrm.osm
./osmfilter hig-080.osm --keep="@user=abel080" -o=080-abel080.osm
./osmfilter hig-080.osm --keep="@user=calfarome" -o=080-calfarome.osm
./osmfilter hig-080.osm --keep="@user=samely" -o=080-samely.osm
./osmfilter hig-080.osm --keep="@user=ruthmaben" -o=080-ruthmaben.osm
./osmfilter hig-080.osm --keep="@user=Chetan_Gowda" -o=080-Chetan_Gowda.osm
./osmfilter hig-080.osm --keep="@user=karitotp" -o=080-karitotp.osm
./osmfilter hig-080.osm --keep="@user=ramyaragupathy" -o=080-ramyaragupathy.osm
./osmfilter hig-080.osm --keep="@user=Nikhil Prabhakar U" -o=080-NikhilPrabhakarU.osm
./osmfilter hig-080.osm --keep="@user=jinalfoflia" -o=080-jinalfoflia.osm
./osmfilter hig-080.osm --keep="@user=pratikyadav" -o=080-pratikyadav.osm
./osmfilter hig-080.osm --keep="@user=aarthy" -o=080-aarthy.osm
./osmconvert 080-* -o=u-080.osm
node index.js --osmfile=u-080.osm
ogr2ogr -f PostgreSQL PG:host=localhost user=postgres dbname=dbprotiger -append u-080.geojson
rm 080-*
rm 080.osc
rm 080.o5m
rm hig-080.osm
rm u-080.osm
rm u-080.geojson
Process completed 080
