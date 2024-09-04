import json
import uuid
import sys

# Function to generate a UUID with a specific prefix
def generate_uuid(prefix):
    return f"urn:openagri:{prefix}:{uuid.uuid4()}"

# Function to convert irrigation data to JSON-LD format
def convert_irrigation_to_jsonld(irrigation_data):
    json_ld_data = {
        "@context": ["https://w3id.org/ocsm/main-context.jsonld"],
        "@graph": []
    }

    for entry in irrigation_data:
        base_id = generate_uuid("irrigation")
        amount_id = generate_uuid("irrigation:amount")
        system_id = generate_uuid("irrigation:system")
        parcel_id = generate_uuid("parcel")

        irrigation_entry = {
            "@id": base_id,
            "@type": "IrrigationOperation",
            "description": "irrigation description",
            "startedAt": entry.get("startDateTime", None),
            "endedAt": entry.get("endDateTime", None),
            "hasAppliedAmount": {
                "@id": amount_id,
                "@type": "QuantityValue",
                "numericValue": entry.get("waterQuantity", None),
                "unit": "http://qudt.org/vocab/unit/M3" if entry.get("unit") == "m3/Ha" else None
            },
            "usesIrrigationSystem": {
                "@id": system_id,
                "@type": "IrrigationSystem",
                "name": entry.get("irrigationSystem", None),
                "hasIrrigationType": entry.get("irrigationSystem", None)
            },
            "isOperatedOn": parcel_id
        }

        json_ld_data["@graph"].append(irrigation_entry)

    return json_ld_data

# Function to convert fertilization data to JSON-LD format
def convert_fertilization_to_jsonld(fertilizations_data):
    json_ld_data = {
        "@context": ["https://w3id.org/ocsm/main-context.jsonld"],
        "@graph": []
    }

    for entry in fertilizations_data:
        base_id = generate_uuid("fertilization")
        product_id = generate_uuid("fertilization:product")
        amount_id = generate_uuid("fertilization:amount")
        plan_id = generate_uuid("fertilization:plan")
        parcel_id = generate_uuid("parcel")

        # Determine the correct unit vocabulary term
        if entry.get("unit") == "kg" and entry.get("referenceDose") == "per plant":
            unit_vocab = "https://w3id.org/ocsm/KiloGM-PER-PLANT"
        elif entry.get("unit") == "liters" and entry.get("referenceDose") == "per hectare":
            unit_vocab = "https://w3id.org/ocsm/Litres-PER-Hectar"
        else:
            unit_vocab = None

        fertilization_entry = {
            "@id": base_id,
            "@type": "FertilizationOperation",
            "description": entry.get("fertilization_description", "No description provided"),
            "hasTimestamp": entry.get("date", None),
            "usesFertilizer": {
                "@id": product_id,
                "@type": "Fertilizer",
                "hasCommercialName": entry.get("product_name", None)
            },
            "hasAppliedAmount": {
                "@id": amount_id,
                "@type": "QuantityValue",
                "numericValue": entry.get("dose", None),
                "unit": unit_vocab
            },
            "plan": {
                "@id": plan_id,
                "@type": "TreatmentPlan",
                "description": entry.get("remarks", "No plan description provided")
            },
            "hasApplicationMethod": entry.get("fertilization_application_method", None),
            "operationType": entry.get("fertilization_application_method", None),
            "isOperatedOn": parcel_id
        }

        json_ld_data["@graph"].append(fertilization_entry)

    return json_ld_data

# Function to convert farm and parcel data to JSON-LD format
def convert_to_jsonld(farm_data_list, parcel_data_list):
    # Define the base context
    context = {
        "@context": [
            "https://w3id.org/ocsm/main-context.jsonld"
        ]
    }
    
    # Convert parcels
    def convert_parcel(parcel):
        parcel_id = f"urn:openagri:parcel:{uuid.uuid4()}"
        gis_data = parcel.get('gis', [{}])[0]
        
        return {
            "@id": parcel_id,
            "@type": "Vineyard",
            "identifier": parcel.get('parcelUniqueIdentifier', None),
            "description": parcel.get('description', None),
            "category": parcel.get('category', None),
            "validFrom": parcel.get('validFrom', None),
            "validTo": parcel.get('validTo', None),
            "inRegion": parcel.get('inRegion', None),
            "hasToponym": parcel.get('hasToponym', None),
            "area": parcel.get('parcel_area') * 10000 if parcel.get('parcel_area') else None,  # Convert Ha to m²
            "isNitroAarea": parcel.get('isNitroAarea', None),
            "isNatura2000Area": parcel.get('isNatura2000Area', None),
            "isPDOPGIArea": parcel.get('isPDOPGIArea', None),
            "isIrrigated": parcel.get('isIrrigated', None),
            "isCultivatedInLevels": parcel.get('isCultivatedInLevels', None),
            "isGroundSlope": parcel.get('isGroundSlope', None),
            "depiction": parcel.get('depiction', None),
            "hasGeometry": {
                "@id": f"urn:openagri:parcel:geo:{uuid.uuid4()}",
                "@type": "Polygon",
                "asWKT": gis_data.get('wkt', None)
            },
            "location": {
                "@id": f"urn:openagri:parcel:point:{uuid.uuid4()}",
                "@type": "Point",
                "lat": gis_data.get('latitude', None),
                "long": gis_data.get('longitude', None)
            },
            "usesIrrigationSystem": {
                "@id": f"urn:openagri:parcel:irrigation:{uuid.uuid4()}",
                "@type": "IrrigationSystem",
                "name": parcel.get('irrigation_system', None)
            },
            "hasIrrigationFlow": parcel.get('irrigation_supply_rate', None)
        }

    # Convert farms
    def convert_farm(farm):
        farm_id = f"urn:openagri:farm:{uuid.uuid4()}"
        return {
            "@id": farm_id,
            "@type": "Farm",
            "name": farm.get('farmName', None),
            "description": farm.get('description', None),
            "hasAdministrator": farm.get('farmAdministratorName', None),
            "contactPerson": {
                "@id": f"urn:openagri:farm:contact:{uuid.uuid4()}",
                "@type": "Person",
                "firstname": farm.get('farmContactPerson', None),
                "lastname": farm.get('farmContactPerson', None)
            },
            "telephone": farm.get('telephone', None),
            "vatID": farm.get('vatID', None),
            "address": {
                "@id": f"urn:openagri:farm:address:{uuid.uuid4()}",
                "@type": "Address",
                "adminUnitL1": farm.get('adminUnitL1', None),
                "adminUnitL2": farm.get('adminUnitL2', None),
                "addressArea": farm.get('addressArea', None),
                "municipality": farm.get('municipality', None),
                "community": farm.get('community', None),
                "locatorName": farm.get('locatorName', None)
            },
            "area": farm.get('totalFarmArea') * 10000 if farm.get('totalFarmArea') else None,  # Convert Ha to m²
            "hasAgriParcel": [
                convert_parcel(parcel) 
                for parcel in parcel_data_list 
                if parcel.get('parcelUniqueIdentifier') in farm.get('farm_parcel_ids', [])
            ]
        }

    # Combine context with farms data
    farm_jsonld = {
        **context,
        "@graph": [convert_farm(farm) for farm in farm_data_list]
    }
    
    return farm_jsonld

def main():
    # Read the input JSON file from argv[1]
    input_file = sys.argv[1]

    with open(input_file, 'r') as file:
        input_data = json.load(file)
    
    irrigation_data = input_data.get("irrigation_data", [])
    fertilizations_data = input_data.get("fertilizations_data", [])
    farm_data_list = input_data.get('farm_related_data', [])
    parcel_data_list = input_data.get('parcel_related_data', [])
    
    if irrigation_data or fertilizations_data or farm_data_list:
        choice = input("Data found. Choose output option:\n"
                       "1. Dump irrigation data to console\n"
                       "2. Dump fertilization data to console\n"
                       "3. Dump farm and parcel data to console\n"
                       "4. Write all data to separate files\n"
                       "5. Write all data into one file\n"
                       "Enter choice (1/2/3/4): ")

        if choice == '1' and irrigation_data:
            converted_data = convert_irrigation_to_jsonld(irrigation_data)
            print(json.dumps(converted_data, indent=4))
        elif choice == '2' and fertilizations_data:
            converted_data = convert_fertilization_to_jsonld(fertilizations_data)
            print(json.dumps(converted_data, indent=4))
        elif choice == '3' and farm_data_list:
            converted_data = convert_to_jsonld(farm_data_list, parcel_data_list)
            print(json.dumps(converted_data, indent=4))
        elif choice == '4':
            if irrigation_data:
                irrigation_output = convert_irrigation_to_jsonld(irrigation_data)
                with open('irrigation_output.jsonld', 'w') as irrig_file:
                    json.dump(irrigation_output, irrig_file, indent=4)
                print("Irrigation data written to irrigation_output.jsonld")

            if fertilizations_data:
                fertilization_output = convert_fertilization_to_jsonld(fertilizations_data)
                with open('fertilization_output.jsonld', 'w') as fert_file:
                    json.dump(fertilization_output, fert_file, indent=4)
                print("Fertilization data written to fertilization_output.jsonld")

            if farm_data_list:
                farm_output = convert_to_jsonld(farm_data_list, parcel_data_list)
                with open('farm_output.jsonld', 'w') as farm_file:
                    json.dump(farm_output, farm_file, indent=4)
                print("Farm data written to farm_output.jsonld")
        elif choice == '5':  # New choice for writing all data to one file
            combined_output = {
                "@context": ["https://w3id.org/ocsm/main-context.jsonld"],
                "@graph": []
            }

            if irrigation_data:
                combined_output["@graph"].extend(convert_irrigation_to_jsonld(irrigation_data)["@graph"])

            if fertilizations_data:
                combined_output["@graph"].extend(convert_fertilization_to_jsonld(fertilizations_data)["@graph"])

            if farm_data_list:
                combined_output["@graph"].extend(convert_to_jsonld(farm_data_list, parcel_data_list)["@graph"])

            with open('generic_farm_calendar_aim.jsonld', 'w') as combined_file:
                json.dump(combined_output, combined_file, indent=4)
            print("All data written to generic_farm_calendar_aim.jsonld")
        else:
            print("Invalid choice or no data for the selected option.")
    else:
        print("No recognizable data type found in the input file.")

if __name__ == "__main__":
    main()
