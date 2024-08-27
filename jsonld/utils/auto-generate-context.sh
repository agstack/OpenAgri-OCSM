# NOTE: generate RDF (run toRDF.sh first
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o demeter-core-context.jsonld https://w3id.org/demeter/core
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o crossDomain-context.jsonld https://w3id.org/demeter/crossDomain
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriCommon-context.jsonld https://w3id.org/demeter/agri/agriCommon #https://raw.githubusercontent.com/rapw3k/DEMETER/master/models/agriCommon.ttl
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriFeature-context.jsonld https://w3id.org/demeter/agri/agriFeature 
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriAlert-context.jsonld https://w3id.org/demeter/agri/agriAlert
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriCrop-context.jsonld https://w3id.org/demeter/agri/agriCrop
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriIntervention-context.jsonld https://w3id.org/demeter/agri/agriIntervention
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriPest-context.jsonld https://w3id.org/demeter/agri/agriPest
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriProduct-context.jsonld https://w3id.org/demeter/agri/agriProduct
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriProperty-context.jsonld https://w3id.org/demeter/agri/agriProperty
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o agriSystem-context.jsonld https://w3id.org/demeter/agri/agriSystem
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -v -o farmAnimal-context.jsonld https://w3id.org/demeter/agri/farmAnimal

java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -o livestockFeature-context.jsonld https://w3id.org/demeter/agri/ext/livestockFeature
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -o poultryFeeding-context-xxx.jsonld https://w3id.org/demeter/agri/ext/poultryFeeding
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -o fieldOperation-context.jsonld https://w3id.org/demeter/agri/ext/fieldOperation
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -o stressRecognition-context.jsonld https://w3id.org/demeter/agri/ext/stressRecognition
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -o transportCondition-context.jsonld https://w3id.org/demeter/agri/ext/transportCondition
java -jar /users/rap/GitRepositories/GitHub/owl2jsonld/target/uberjar/owl2jsonld-0.2.2-SNAPSHOT-standalone.jar -o nutrientMonitor-context.jsonld https://w3id.org/demeter/agri/ext/nutrientMonitor



####### GENERATE EXTENSIONS GUIDELINES
: '
1. SAVE ttl, COMMIT and PUSH
2. GENERATE jsonld
3. REMOVE the following terms, and double check by comparing with demeterAgriProfile-context.jsonld that shared terms are the same, 
    "name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    },
    ,
    "description" : {
      "@id" : "http://purl.org/dc/terms/description"
    }
4. SAVE jsonld, COMMIT and PUSH    
'

######### cross-domain postprocessing
## CHANGE in generated context
: '
		"foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
		}
		"wgs84.Point" : {
      "@id" : "http://www.w3.org/2003/01/geo/wgs84_pos#Point"
    }   
		"ssn.Property" : {
      "@id" : "http://www.w3.org/ns/ssn/Property"
    }    
		"dct.description" : {
      "@id" : "http://purl.org/dc/terms/description"
    }    
		"qb.Observation" : {
      "@id" : "http://purl.org/linked-data/cube#Observation"
    }
		"qu.QuantityKind" : {
      "@id" : "http://purl.oclc.org/NET/ssnx/qu/qu#QuantityKind"
    }

## ADD THE FOLLOWING TERMS    

    "sf.Geometry" : {
      "@id" : "http://www.opengis.net/ont/sf#Geometry"
    },
    "schema.Person" : {
      "@id" : "https://schema.org/Person"
    },
    "Observation" : {
      "@id" : "http://www.w3.org/ns/sosa/Observation"
    },
    "Point" : {
      "@id" : "http://www.opengis.net/ont/sf#Point"
    },   
    "schema.name" : {
      "@id" : "https://schema.org/name"
    },
    "QuantityKind" : {
      "@id" : "http://qudt.org/schema/qudt/QuantityKind"
    }
'
                         
######## agriCommon             
## CHANGE in generated context
: '
		"schema.name" : {
      "@id" : "https://schema.org/name"
    }
		"typeName" : {
      "@id" : "http://foodie-cloud.com/model/foodie#type",
      "@type" : "http://www.w3.org/2001/XMLSchema#string"
    }
		"propertyHasValue" : {
      "@id" : "https://saref.etsi.org/core/hasValue" (prev: "https://w3id.org/saref#hasValue")
    },
## ADD THE FOLLOWING TERMS        
   	"name" : {
      "@id" : "https://smartdatamodels.org/name"
    }
'    

######## agriFeature             
## CHANGE in generated context
: '
"foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    }
    
## ADD THE FOLLOWING TERMS            
   	"locationGeoJson" : {
      "@id" : "https://uri.etsi.org/ngsi-ld/location",
      "@type" : "@id"
    }
    "containsSite" : {
      "@id" : "http://inspire.ec.europa.eu/schemas/af/3.0#contains",
      "@type" : "@id"
    } 
'    

######## agriAlert
## CHANGE in generated context
: '
		"foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    }
		"alertValidFrom" : {
      "@id" : "https://smartdatamodels.org/dataModel.Weather/validFrom",
      "@type" : "http://www.w3.org/2001/XMLSchema#dateTime"
    }        
		"alertValidTo" : {
      "@id" : "https://smartdatamodels.org/dataModel.Weather/validTo",
      "@type" : "http://www.w3.org/2001/XMLSchema#dateTime"
    }        
		"typeName" : {
      "@id" : "http://foodie-cloud.com/model/foodie#type",
      "@type" : "http://www.w3.org/2001/XMLSchema#string"
    }
    
## ADD THE FOLLOWING TERMS            
   "validTo" : {
      "@id" : "http://portele.de/ont/inspire/baseInspire#validTo",
      "@type" : "http://www.w3.org/2001/XMLSchema#dateTime"
    },
    "validFrom" : {
      "@id" : "http://portele.de/ont/inspire/baseInspire#validFrom",
      "@type" : "http://www.w3.org/2001/XMLSchema#dateTime"
    } 
'   

######## agriCrop
## CHANGE in generated context
: '
		"foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    }
    
## ADD THE FOLLOWING TERMS            
   
'   

######## agriIntervention
## CHANGE in generated context
: '
		"foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    }    
    "totalQuantity" : {
      "@id" : "https://smartdatamodels.org/dataModel.Agrifood/quantity"
    }
    "typeName" : {
      "@id" : "http://foodie-cloud.com/model/foodie#type",
      "@type" : "http://www.w3.org/2001/XMLSchema#string"
    }
    
## ADD THE FOLLOWING TERMS            
   	"operationStatus" : {
      "@id" : "https://uri.etsi.org/ngsi-ld/status"
    }
    "quantity" : {
      "@id" : "http://foodie-cloud.com/model/foodie#quantity",
      "@type" : "@id"
    }
'   

######## agriPest
## CHANGE in generated context
: '
		"foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    }
    "dct.description" : {
      "@id" : "http://purl.org/dc/terms/description"
    }
    
## ADD THE FOLLOWING TERMS            
   
'  

######## agriProduct
## CHANGE in generated context
: '
		"composedPrimarilyOf" : {
      "@id" : "http://purl.obolibrary.org/obo/RO_0002473",
      "@type" : "@id"
    }
    "hasCountryOfOrigin" : {
      "@id" : "http://purl.obolibrary.org/obo/HANCESTRO_0308",
      "@type" : "@id"
    }
    "hasFoodSubstanceAnalog" : {
      "@id" : "http://purl.obolibrary.org/obo/FOODON_00001301",
      "@type" : "@id"
    }
    "hasComponent" : {
      "@id" : "http://purl.obolibrary.org/obo/RO_0002180",
      "@type" : "@id"
    }
    
## ADD THE FOLLOWING TERMS            
   
'   

######## agriProperty
## CHANGE in generated context
: '
		"propertyHasValue" : {
      "@id" : "https://saref.etsi.org/core/hasValue"
    }
    "saref.hasFeatureOfInterest" : {
      "@id" : "https://saref.etsi.org/core/hasFeatureOfInterest",
      "@type" : "@id"
    }
    "cf.Surface" : {
      "@id" : "http://purl.oclc.org/NET/ssnx/cf/cf-feature#Surface"
    }
    "dct.description" : {
      "@id" : "http://purl.org/dc/terms/description"
    }
    "saref.Property" : {
      "@id" : "https://saref.etsi.org/core/Property"
    }
## ADD THE FOLLOWING TERMS   
    "saref.Temperature" : {
      "@id" : "https://saref.etsi.org/core/Temperature"
    }
    "saref.FeatureOfInterest" : {
      "@id" : "https://saref.etsi.org/core/FeatureOfInterest"
    }
    "saref.hasProperty" : {
      "@id" : "https://saref.etsi.org/core/hasProperty",
      "@type" : "@id"
    }
    "saref.isPropertyOf" : {
      "@id" : "https://saref.etsi.org/core/isPropertyOf",
      "@type" : "@id"
    }
    "hasFeatureOfInterest" : {
      "@id" : "http://www.w3.org/ns/sosa/hasFeatureOfInterest",
      "@type" : "@id"
    }
    "saref.isFeatureOfInterestOf" : {
      "@id" : "https://saref.etsi.org/core/isFeatureOfInterestOf",
      "@type" : "@id"
    }
   
'  

######## agriSystem
## CHANGE in generated context
: '
		"foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    }
    "dct.description" : {
      "@id" : "http://purl.org/dc/terms/description"
    }
    
## ADD THE FOLLOWING TERMS            
   	"saref.Sensor" : {
      "@id" : "https://saref.etsi.org/core/Sensor"
    }
'  

######## farmAnimal
## CHANGE in generated context
: '
		"animalSpecies" : {
      "@id" : "https://smartdatamodels.org/dataModel.Agrifood/species"
    }
    "isMemberOfAnimalGroup" : {
      "@id" : "https://saref.etsi.org/saref4agri/isMemberOf",
      "@type" : "@id"
    }
    "foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    }
    "hasMemberAnimal" : {
      "@id" : "https://saref.etsi.org/saref4agri/hasMember",
      "@type" : "@id"
    }
    "dct.description" : {
      "@id" : "http://purl.org/dc/terms/description"
    }
## ADD THE FOLLOWING TERMS            
   	"FarmAnimal" : {
      "@id" : "https://smartdatamodels.org/dataModel.Agrifood/Animal"
    }
'  

######## full context
## CHANGE in generated context
: '
		"alertValidFrom" : {
      "@id" : "https://smartdatamodels.org/dataModel.Weather/validFrom",
      "@type" : "http://www.w3.org/2001/XMLSchema#dateTime"
    }
    "animalSpecies" : {
      "@id" : "https://smartdatamodels.org/dataModel.Agrifood/species"
    } 
    "saref.FeatureOfInterest" : {
      "@id" : "https://saref.etsi.org/core/FeatureOfInterest"
    }
    "composedPrimarilyOf" : {
      "@id" : "http://purl.obolibrary.org/obo/RO_0002473",
      "@type" : "@id"
    }
    "hasCountryOfOrigin" : {
      "@id" : "http://purl.obolibrary.org/obo/HANCESTRO_0308",
      "@type" : "@id"
    }
    "isMemberOfAnimalGroup" : {
      "@id" : "https://saref.etsi.org/saref4agri/isMemberOf",
      "@type" : "@id"
    }
    "schema.Person" : {
      "@id" : "https://schema.org/Person"
    }
    "foaf.name" : {
      "@id" : "http://xmlns.com/foaf/0.1/name"
    }
    "totalQuantity" : {
      "@id" : "https://smartdatamodels.org/dataModel.Agrifood/quantity"
    }
    "hasFoodSubstanceAnalog" : {
      "@id" : "http://purl.obolibrary.org/obo/FOODON_00001301",
      "@type" : "@id"
    }
    "wgs84.Point" : {
      "@id" : "http://www.w3.org/2003/01/geo/wgs84_pos#Point"
    }
    "hasComponent" : {
      "@id" : "http://purl.obolibrary.org/obo/RO_0002180",
      "@type" : "@id"
    }
    "alertValidTo" : {
      "@id" : "https://smartdatamodels.org/dataModel.Weather/validTo",
      "@type" : "http://www.w3.org/2001/XMLSchema#dateTime"
    }
    "typeName" : {
      "@id" : "http://foodie-cloud.com/model/foodie#type",
      "@type" : "http://www.w3.org/2001/XMLSchema#string"
    }
    "dct.description" : {
      "@id" : "http://purl.org/dc/terms/description"
    }
    "value" : {
      "@id" : "https://uri.etsi.org/ngsi-ld/hasValue"
    }
## ADD THE FOLLOWING TERMS     
		"sf.Geometry" : {
      "@id" : "http://www.opengis.net/ont/sf#Geometry"
    }
		"cf.Surface" : {
      "@id" : "http://purl.oclc.org/NET/ssnx/cf/cf-feature#Surface"
    } 
    "saref.Temperature" : {
      "@id" : "https://saref.etsi.org/core/Temperature"
    }
    "FeatureOfInterest" : {
      "@id" : "http://www.w3.org/ns/sosa/FeatureOfInterest"
    }      
    "FarmAnimal" : {
      "@id" : "https://smartdatamodels.org/dataModel.Agrifood/Animal"
    }
    "Point" : {
      "@id" : "http://www.opengis.net/ont/sf#Point"
    }
    "ssn.Property" : {
      "@id" : "http://www.w3.org/ns/ssn/Property"
    }
    "saref.Property" : {
      "@id" : "https://saref.etsi.org/core/Property"
    }
    "description" : {
      "@id" : "http://foodie-cloud.com/model/foodie#description",
      "@type" : "http://www.w3.org/2001/XMLSchema#string"
    }
   	"propertyHasValue" : {
      "@id" : "https://saref.etsi.org/core/hasValue"
    }
    "validFrom" : {
      "@id" : "http://portele.de/ont/inspire/baseInspire#validFrom",
      "@type" : "http://www.w3.org/2001/XMLSchema#dateTime"
    }
    "validTo" : {
      "@id" : "http://portele.de/ont/inspire/baseInspire#validTo",
      "@type" : "http://www.w3.org/2001/XMLSchema#dateTime"
    }
    "species" : {
      "@id" : "http://foodie-cloud.com/model/foodie#species",
      "@type" : "http://www.w3.org/2001/XMLSchema#string"
    }
    "operationStatus" : {
      "@id" : "https://uri.etsi.org/ngsi-ld/status"
    }
    "quantity" : {
      "@id" : "http://foodie-cloud.com/model/foodie#quantity",
      "@type" : "@id"
    }
    "name" : {
      "@id" : "https://smartdatamodels.org/name"
    }
    "schema.name" : {
      "@id" : "https://schema.org/name"
    }
    "containsSite" : {
      "@id" : "http://inspire.ec.europa.eu/schemas/af/3.0#contains",
      "@type" : "@id"
    }
    "locationGeoJson" : {
      "@id" : "https://uri.etsi.org/ngsi-ld/location",
      "@type" : "@id"
    }
    "saref.hasProperty" : {
      "@id" : "https://saref.etsi.org/core/hasProperty",
      "@type" : "@id"
    }
    "saref.hasFeatureOfInterest" : {
      "@id" : "https://saref.etsi.org/core/hasFeatureOfInterest",
      "@type" : "@id"
    }
    "saref.isFeatureOfInterestOf" : {
      "@id" : "https://saref.etsi.org/core/isFeatureOfInterestOf",
      "@type" : "@id"
    }
    "saref.isPropertyOf" : {
      "@id" : "https://saref.etsi.org/core/isPropertyOf",
      "@type" : "@id"
    }
    "qu.QuantityKind" : {
      "@id" : "http://purl.oclc.org/NET/ssnx/qu/qu#QuantityKind"
    }
    "hasMember" : {
      "@id" : "http://www.w3.org/ns/sosa/hasMember",
      "@type" : "@id"
    }
    "qb.Observation" : {
      "@id" : "http://purl.org/linked-data/cube#Observation"
    }
    "saref.Sensor" : {
      "@id" : "https://saref.etsi.org/core/Sensor"
    }
    "object" : {
      "@id" : "https://uri.etsi.org/ngsi-ld/hasObject",
      "@type" : "@id"
    }        
'  
    
    
######## core-ngsi-ld
## CHANGE in generated context
: '
		"value" : {
      "@id" : "https://uri.etsi.org/ngsi-ld/hasValue"
    }
    "object" : {
      "@id" : "https://uri.etsi.org/ngsi-ld/hasObject",
      "@type" : "@id"
    }
    
## ADD THE FOLLOWING TERMS            
   
'  


######## FIX object properties
## CHANGE in generated context
: '
		foaf
		geo
		wgs_84
		iso
		qu
		qudt
		qb
		sosa
		ssn
		foodie:productionAmount
    
## ADD THE FOLLOWING TERMS            
   
'  