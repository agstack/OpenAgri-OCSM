# OCSM
This repository contains the modules comprising all the layers of the Open Agri Common Semantic Model (OCSM), which is based on the Agriculture Information Model (AIM) and the Ploutos Common Semantic Model (PCSM)

The Agriculture Information Model (AIM) is a common vocabulary providing the basis for semantic interoperability across smart farming solutions. It defines data elements, including concepts, properties and relationships relevant to agri applications, as well as their associated semantics/meaning for information exchange. AIM follows a layered and modular approach, and is realised as a suite of ontologies implemented in line with best practices, reusing existing standards and well-scoped dominant models as much as possible and establishing alignments between them to enable their interoperability and the integration of existing data. In particular AIM includes 
* a meta-model layer defining the building blocks of AIM and enabling the back-and-forth conversion between datasets that are based on the property graph model and linked data datasets
* a cross-domain layer defining relevant concepts and properties that are common across multiple domains, and which enable the interoperability with existing standard models and vocabularies
* a domain layer defining agri-specific concepts and properties covering different aspects of interest of agri applications, and which enables the integration of relevant vocabularies in the sector.
* a pilot-specific layer defining additional concepts and properties that are of specific use for particular applications. 
* a metadata model that can be used to describe datasets, services or applications in agri-related projects/applications.

Ploutos Common Semantic Model (PCSM) also reuses some standard ontologies/vocabularies and defines a small set of additional classes and properties that cover agrifood supply chain actors as well as farm operations and treatment materials.

For the implementation of the OCSM, AIM has been extended and aligned with PCSM to cover those areas, which were previously not addressed in detail, in order to cover the needs of OpenAgri pilots and use cases. 


## Discussion of key terms
The main models reused and aligned by OCSM have concepts to represent a portion of land where crops or animals are grown, and since this is a major concept used in practically all agri applications, we provide here short definitions for them, and how they are aligned, so developers will be able to decide which one is 
more suited for their needs.


### General keywords and terms

* Your json-ld content will have *@graph* entry where you can define multiple objects
* All json-ld objects should have
	- *@id*  key to uniquely identify node objects that are being described in the document with IRIs (urn:demeter:ag:88acd214-f633-4db7-9560-0ca69abc1a4a, or https://myorganization.org/objects/88acd214-f633)
	- *@type* key to set the type of a node or the datatype of a typed value (from the context)
* Use (json-ld) attribute *identifier* to associate the identifier of the object in the application (instead of defining your own, e.g, tractorId, animalId, etc.)

### Farm related objects
To represent farm area levels (small farm can have only level 1 and level 3)

| Level   | OCSM term   | Saref4Agri |   SmartDataModels   |   foodie   |   Adapt   |
| --------|:----------:|:----------:|:----------:|:----------:|----------:|                   
| Level1  | Farm | Farm | AgriFarm | Holding | Farm |
| Level2  | Site | ---  | ---- | Site | --- |
| Level3 	| Parcel | Parcel | AgriParcel | Plot | Field |
| Level4  | ManagementZone | ---- | ManagementZone | --- |

```
- Level 1
>Reference JSON-LD concept: Farm 

**Saref4Agri:Farm = inspire:Holding = sdm:AgriFarm 
(saref4agri) A plot of land used for the scope of farming which can contain buildings and parcels. (JSON-LD concept: Farm)
(inspire) The whole area and all infrastructures included on it, covering the same or different sites, 
under the control of an operator to perform agricultural or aquaculture activities. (JSON-LD concept: Holding)
(SmartDataModels) Harmonised description of a generic farm made up of buildings and parcels. 
This entity is primarily associated with the agricultural vertical and related IoT applications. (JSON-LD concept: AgriFarm)

From FAO: The holding or farm is all the land being utilized in full or in part for agricultural purposes which is located in a single parish. The holding or farm may consist of one parcel of land or may be in several parcels. Where it comprises several parcels all parcels must be located within the same parish to be considered a single farm. Where parcels are located in several parishes, there will be as many farms as parishes. Where a holding straddles (i.e. on the border of) two parishes, the parish where the house/residence or the headquarters is located is to be regarded as the parish of location. A farm may comprise land in crops or it may be animals only. Where there are animals only, and no land dedicated to their rearing these are referred to as landless farms.

- Level 2 (e.g., LPIS)
Reference JSON-LD concept: Site 

**inspire/foodie:Site
(inspire/foodie) All land at the same or distinct geographic location under the management control of a holding covering activities, products and services. This includes all infrastructure, equipment and materials.
Land area used for a type of activity, e.g., arable land, grassland and vineyards. In particular NACE code, 
e.g., A1.1.1 - Growing of cereals (except rice), leguminous crops and oil seeds. 
LPIS data may be imported on the level of <Site> feature which is equal to LPIS farmer's block level.

- Level 3
Reference JSON-LD concept: Plot

**Saref4Agri:Parcel = foodie:Plot = sdm:AgriParcel
(saref4Agri) An area of land, which might be used for grazing animals or planting crops. The parcel is defined as an undividable logical area of land which contains homogeneous items (JSON-LD concept: Parcel)
(foodie) A continuous area of agricultural land with one type of crop species, cultivated by one user in one farming mode 
(conventional vs. transitional vs. organic farming) (JSON-LD concept: Plot)
(SmartDataModels) Harmonised description of a generic parcel of land. This entity is primarily associated with the agricultural vertical and related IoT applications." (JSON-LD concept: AgriParcel)

- Level 4
Reference JSON-LD concept: ManagementZone

**foodie:ManagementZone
(foodie) A spatial subset of a <Plot> that has specific properties like electric conductivity, organic matter, pH, soil texture, soil type or soil nutrients 

```
### Crops
To represent the crops

| OCSM term   | Saref4Agri |   SmartDataModels   |   foodie   |   Adapt   |
|:----------:|:----------:|:----------:|:----------:|----------:|                   
| Crop | Crop | AgriCrop | CropSpecies | CropZone |
| CropType | taxonomic_rank (taxrank vocabulary) | ---- | CropType | Crop |
| cropSpecies (property Crop->CropType) | has_rank (taxrank vocabulary) | ---- | cropSpecies | ---- |
| agroVocConcept (property to agrovoc concept) | ---- | agroVocConcept | ---- | ---- |
| eppoConcept (property to eppo concept) | ---- | ---- | ---- |

```
-- foodie:CropSpecies = saref4Agri:Crop = sdm:AgriCrop
Reference JSON-LD concept: Crop 
Reference JSON-LD property: hasAgriCrop (Parcel to Crop)

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
The range is a Geometry (e.g., Point, Polygon, MultiPolygon, etc.), which has associated the serialization of the geometry, typically using the property asWKT to provide the WKT serialization e.g., POLYGON((15.54 50.61,14.14 49.02,17.12 48.32,19.06 49.59,19.76 51.60,15.54 50.61)) (value of type wktLiteral), or asGeoJSON to provide the geojson serialization (value of type geoJSONLiteral)

- sdm:location (JSON-LD property: locationGeoJson) and sdm:landLocation (JSON-LD property: landLocation) - preferable not used to facilitate interoperability and linked data publication

```

### Measurements and observations

To represent measurements and observations (e.g., multiple observations/measurements over a period of time), we follow the [SOSA/SSN](https://www.w3.org/TR/vocab-ssn/) model and approach. This means that we model each of those observations as a SOSA:Observation, that has associated:
* feature of interest (e.g., Crop, Field, Tractor) (via sosa:hasFeatureOfInterest)
* the observed property (e.g., temperature, density, position) (via sosa:observedProperty)
* the result of the observation (which has a numerical value and a unit) (via sosa:hasResult)
* the time the observation was done (via sosa:resultTime) and potentially time that the result applies to(phenomenonTime) 
* the sensor used to make the observation (via sosa:madeBySensor).
* potentially the procedure used to carry out the observation (via sosa:usedProcedure)

To group multiple observations sharing some properties, e.g., same observed property or feature of interest, or sensor or time, we use the superclass sosa:ObservationCollection, and associate the corresponding observations via sosa:hasMember

Please refer to the examples directory for concrete examples.

### Statistical data
To represent statistica data (e.g., agri indicators), we follow the [RDF data cube](https://www.w3.org/TR/vocab-data-cube/) model and approach.

Please use as example the FADN dataset that has been published as linked data in compliance with AIM using the RDF data cube as underlying model [here](https://www.foodie-cloud.org/describe/?url=https%3A%2F%2Fec.europa.eu%2Fagriculture%2Frica%2Fdatabase%2Freports%2Farchives%2Ffadn20200621.zip&sid=6943).

## Finding terms and retrieving annotations 

## How to create your JSON-LD content using OCSM

JSON-LD is designed around the concept of a "context" to provide mappings from JSON to a shared/common model, allowing applications to use shortcut terms to communicate with one another more efficiently, but without losing accuracy.
The context links terms in a JSON document to elements in an ontology or vocabulary, e.g., OCSM.
So, in order to generate OCSM-based JSON-LD content, you need to define the @context in your JSON document, and reference OCSM context from there as follows:

```
{
  "@context": "https://w3id.org/ocsm/main-context.jsonld",
  ....
}
```

## How to validate your data is compliant with OCSM

### syntactic and OCSM terms validation

In order to make sure that all elements are valid OCSM elements you can use the json-ld playground: [https://json-ld.org/playground/](https://json-ld.org/playground/). 

For instance, you can load one of the examples mentioned above in the JSON-LD Playground [here](https://github.com/openagri-eu/OCSM/tree/main/examples).

This is not validating the semantics though, just that elements are resolvable, and that your json-ld is syntactically correct.

Note: OCSM context defines a default namespace that is used for those terms that are not found in OCSM: https://w3id.org/ocsm/default-context/ . Hence, if you identify terms in your applications that resolve to an URI starting with this namespace, consider searching for suitable terms from OCSM.

### semantics validation
The goal of semantic validation is to allow developers of tools/services to validate that the produced/consumed data in their components is fully compliant with OCSM semantics, reusing existing tools if possible.  

This can be carried out partially with the help of json schemas (e.g., without exploiting inference power of ontologies) or using [SHACL Shapes Graphs](https://www.w3.org/TR/shacl/). For the former, we provide alrady some json schemas. For the latter we would need to generate SHACL shapes for OCSM as we did for AIM. This, however, is still being in progress (tbd).

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
