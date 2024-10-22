# OCSM
This repository contains the modules comprising all the layers of the Open Agri Common Semantic Model (OCSM), which is based on the Agriculture Information Model (AIM) and the Ploutos ontology.

The Agriculture Information Model (AIM) is a common vocabulary providing the basis for semantic interoperability across smart farming solutions. 
AIM defines the data elements, including concepts, properties and relationships relevant to agri applications, as well as their associated semantics/meaning for information exchange.
AIM follows a layered and modular approach, and is realised as a suite of ontologies implemented in line with best practices, reusing existing standards and well-scoped dominant models as much as possible and establishing alignments between them to enable their interoperability and the integration of existing data. 

As part of OpenAgri project, AIM has been extended with Ploutos ontology to cover additional areas in agricultrure, particularly those related to operations on the field.


## Discussion of key terms
The three underlying models have concepts to represent a portion of land where crops or animals are grown, 
and since this is a major concept used in practically all agri applications, we provide here short 
definitions for them, and how they are aligned, so developers will be able to decide which one is 
more suited for their needs.


### General keywords and terms

* Your json-ld content will have *@graph* entry where you can define multiple objects
* All json-ld objects should have
	- *@id*  key to uniquely identify node objects that are being described in the document with IRIs (urn:demeter:ag:88acd214-f633-4db7-9560-0ca69abc1a4a, or https://myorganization.org/objects/88acd214-f633)
	- *@type* key to set the type of a node or the datatype of a typed value (from the context)
* Use (json-ld) attribute *identifier* to associate the identifier of the object in the application (instead of defining your own, e.g, tractorId, animalId, etc.)

### Farm related objects
To represent farm area levels (small farm can have only level 1 and level 3)

| Level   | AIM term   | Saref4Agri |   Fiware   |   foodie   |   Adapt   |
| --------|:----------:|:----------:|:----------:|:----------:|----------:|                   
| Level1  | Farm | Farm | AgriFarm | Holding | Farm |
| Level2  | Site | ---  | ---- | Site | --- |
| Level3 	| Plot | Parel | AgriParcel | Plot | Field |
| Level4  | ManagementZone | ---- | ManagementZone | --- |

```
- Level 1
>Reference JSON-LD concept: Farm 

**Saref4Agri:Farm = inspire:Holding = fiware:AgriFarm 
(saref4agri) A plot of land used for the scope of farming which can contain buildings and parcels. (JSON-LD concept: Farm)
(inspire) The whole area and all infrastructures included on it, covering the same or different sites, 
under the control of an operator to perform agricultural or aquaculture activities. (JSON-LD concept: Holding)
(fiware) Harmonised description of a generic farm made up of buildings and parcels. 
This entity is primarily associated with the agricultural vertical and related IoT applications. (JSON-LD concept: AgriFarm)

From FAO: The holding or farm is all the land being utilized in full or in part for agricultural purposes which is located in a single parish. 
The holding or farm may consist of one parcel of land or may be in several parcels. Where it comprises several parcels all parcels must be located 
within the same parish to be considered a single farm. Where parcels are located in several parishes, there will be as many farms as parishes. 
Where a holding straddles (i.e. on the border of) two parishes, the parish where the house/residence or the headquarters is located is to be regarded 
as the parish of location. A farm may comprise land in crops or it may be animals only. Where there are animals only, and no land dedicated to 
their rearing these are referred to as landless farms.

- Level 2 (e.g., LPIS)
Reference JSON-LD concept: Site 

**inspire/foodie:Site
(inspire/foodie) All land at the same or distinct geographic location under the management control of a holding covering activities, 
products and services. This includes all infrastructure, equipment and materials.
Land area used for a type of activity, e.g., arable land, grassland and vineyards. In particular NACE code, 
e.g., A1.1.1 - Growing of cereals (except rice), leguminous crops and oil seeds. 
LPIS data may be imported on the level of <Site> feature which is equal to LPIS farmer's block level.

- Level 3
Reference JSON-LD concept: Plot

**Saref4Agri:Parcel = foodie:Plot = fiware:AgriParcel
(saref4Agri) An area of land, which might be used for grazing animals or planting crops. The parcel is defined as an undividable logical 
area of land which contains homogeneous items (JSON-LD concept: Parcel)
(foodie) A continuous area of agricultural land with one type of crop species, cultivated by one user in one farming mode 
(conventional vs. transitional vs. organic farming) (JSON-LD concept: Plot)
(fiware) Harmonised description of a generic parcel of land. This entity is primarily associated with the agricultural vertical 
and related IoT applications." (JSON-LD concept: AgriParcel)

- Level 4
Reference JSON-LD concept: ManagementZone

**foodie:ManagementZone
(foodie) A spatial subset of a <Plot> that has specific properties like electric conductivity, organic matter, pH, soil texture, soil type or soil nutrients 

```
### Crops
To represent the crops

| AIM term   | Saref4Agri |   Fiware   |   foodie   |   Adapt   |
|:----------:|:----------:|:----------:|:----------:|----------:|                   
| Crop | Crop | AgriCrop | CropSpecies | CropZone |
| CropType | taxonomic_rank (taxrank vocabulary) | ---- | CropType | Crop |
| cropSpecies (property Crop->CropType) | has_rank (taxrank vocabulary) | ---- | cropSpecies | ---- |
| agroVocConcept (property to agrovoc concept) | ---- | agroVocConcept | ---- | ---- |
| eppoConcept (property to eppo concept) | ---- | ---- | ---- |

```
-- foodie:CropSpecies = saref4Agri:Crop = fiware:AgriCrop
Reference JSON-LD concept: Crop 
Reference JSON-LD property: crop (Plot to Crop)

To associate a crop type:
Reference JSON-LD concept: CropType 
Reference JSON-LD property: cropSpecies (Crop to CropType)

To associate reference agrovoc/eppo concept:
Reference JSON-LD property for agrovoc concept: agroVocConcept
Reference JSON-LD property for eppo concept: eppoConcept
e.g.,
"agroVocConcept": "http://aims.fao.org/aos/agrovoc/c_7951",
"eppoConcept": "https://gd.eppo.int/taxon/TRZAX",

```
### Geospatial properties

To represent the geographical area associated to the land, the following properties are used

```
Reference JSON-LD property: location (to associate countries/regions/municipalities where the land is located or a Point (with lat/long)
Reference JSON-LD property: hasGeometry (to associate the geospatial information (e.g., polygon/multipolygon)

- wgs84_pos:location (generally used to associate countries/regions/municipalities where the land is located) (JSON-LD property: location)

The relation between something and the point, or other geometrical thing in space, where it is.
The range is SpatialThing - anything with spatial extent, i.e. size, shape, or position. e.g. 
people, places, bowling balls, as well as abstract areas like cubes.
For instance, geonames features (countries/regions) like Poznan (https://sws.geonames.org/3088171/) are subclasses of SpatialThing (gn:Feature subclassOf SpatialThing)

- geosparql:hasGeometry (generally used to associate a geometry, e.g., central point or polygon of the land) (JSON-LD property: hasGeometry)

A spatial representation for a given feature.
The range is a Geometry (e.g., Point, Polygon, MultiPolygon, etc.), which has associated the serialization of the geometry, 
typically using the property asWKT to provide the WKT serialization e.g., POLYGON((15.54 50.61,14.14 49.02,17.12 48.32,19.06 49.59,19.76 51.60,15.54 50.61))

- fiware:location (JSON-LD property: locationGeoJson) and fiware:landLocation (JSON-LD property: landLocation) - preferable not used to facilitate interoperability and linked data publication

(location) The geo:json encoded polygon / multi-polygon describing this [entity]. Range is equivalent to GeoProperty
(landLocation). Geometry defining the boundaries of the farm land. Range is equivalent to GeoProperty

```

### Time series

To represent time series (e.g., multiple observations/measurements over a period of time), we follow the [SOSA/SSN](https://www.w3.org/TR/vocab-ssn/) model and approach. This means that we model each of those observations as a SOSA:Observation, that has associated:
* feature of interest (e.g., Crop, Field, Tractor) (via sosa:hasFeatureOfInterest)
* the observed property (e.g., temperature, density, position) (via sosa:observedProperty)
* the result of the observation (which has a numerical value and a unit) (via sosa:hasResult)
* the time of the observation (via sosa:resultTime) and 
* potentially the sensor used to make the observation (via sosa:madeBySensor).

Please refer to the examples directory for concrete examples.

### Statistical data
To represent statistica data (e.g., agri indicators), we follow the [RDF data cube](https://www.w3.org/TR/vocab-data-cube/) model and approach.

Please use as example the FADN dataset that has been published as linked data in compliance with AIM using the RDF data cube as underlying model [here](https://www.foodie-cloud.org/describe/?url=https%3A%2F%2Fec.europa.eu%2Fagriculture%2Frica%2Fdatabase%2Freports%2Farchives%2Ffadn20200621.zip&sid=6943).

## Finding terms and retrieving annotations 
