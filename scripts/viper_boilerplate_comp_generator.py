import json
import sys

def extract_and_save(input_file_path, output_file_path):
    # Open and load the input JSON file
    with open(input_file_path, 'r') as infile:
        data = json.load(infile)

    # Initialize a list to store the entries (to allow duplicates)
    extracted_entries = []

    # Iterate through the second-level entries
    for entry in data.values():
        # Check if the entry contains the "itemTplToClone" key
        if 'itemTplToClone' in entry:
            # Extract the value of "itemTplToClone"
            item_tpl = entry['itemTplToClone']
            # Create a new dictionary entry with the required sub-tags
            item_entry = {
                "ItemID": item_tpl,
                "Name": "",
                "TemplateType": "mod",
                "ModType": ""
            }
            # Append the entry to the list (allows duplicates)
            extracted_entries.append(item_entry)

    # Write the output manually to a text file
    with open(output_file_path, 'w') as outfile:
        outfile.write("{\n")
        for index, item in enumerate(extracted_entries):
            item_id = item["ItemID"]
            outfile.write(f'    "{item_id}": {{\n')
            outfile.write(f'        "ItemID": "{item["ItemID"]}",\n')
            outfile.write(f'        "Name": "{item["Name"]}",\n')
            outfile.write(f'        "TemplateType": "{item["TemplateType"]}",\n')
            outfile.write(f'        "ModType": "{item["ModType"]}"\n')
            outfile.write('    }')
            # Add a comma if it's not the last entry
            if index < len(extracted_entries) - 1:
                outfile.write(',')
            outfile.write('\n')
        outfile.write("}\n")

if __name__ == "__main__":
    # Get input and output file paths from command-line arguments
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_file_path> <output_file_path>")
        sys.exit(1)

    input_file_path = sys.argv[1]
    output_file_path = sys.argv[2]

    # Call the function to extract and save the JSON data
    extract_and_save(input_file_path, output_file_path)
