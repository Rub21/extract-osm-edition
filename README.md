# extract-osm-edition


Ejecutar `./install` para instalar la base de datos y demas apps

Para ejecutar en background los scrpit hacer 

```
#Ejecucion para establecer las columnas de la tabla
wget http://planet.osm.org/replication/day/000/001/080.osc.gz
gzip -d 080.osc.gz
./osmconvert 080.osc -B=us.poly -o=080.osm 
./osmfilter 080.osm --keep="@user=PlaneMad" -o=PlaneMad.osm
node index.js --osmfile=PlaneMad.osm
ogr2ogr -f "PostgreSQL" PG:"host=localhost user=postgres dbname=dbprotiger" -append PlaneMad.geojson
rm 080.osc
rm PlaneMad.geojson
rm PlaneMad.osm

# Ejecucion  en de varios archivos a la ves

touch log-1-200
touch log-201-400
touch log-401-600
touch log-601-800
touch log-801-999

nohup ./extract 1 200 us.poly users  > log-1-200  2>&1 &
nohup ./extract 201 400 us.poly users  > log-201-400  2>&1 &
nohup ./extract 401 600 us.poly users  > log-401-600  2>&1 &
nohup ./extract 601 800 us.poly users  > log-601-800 2>&1 &
nohup ./extract 801 999 us.poly users  > log-801-999  2>&1 &

echo ./extract 0 999  us.poly users

```

**Nota**

Este ejemplo es solo para eeuu, si se decea hacer para otro lugar se debe hacer otro [poly](https://cloud.githubusercontent.com/assets/1152236/7383718/e99548fc-ede9-11e4-8cd4-e57bc6c62124.png), [Convert shp to poly
](https://oegeo.wordpress.com/2011/11/05/tutorial-poly/)


#### Agregar usuario

Se debe agregar en el archivo `users`.