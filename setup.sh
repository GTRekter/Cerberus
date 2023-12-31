#!/bin/bash

# This script utilizes the mapping provided by the Microsoft aztfexport tool and the new Terraform config-driven import workflow
# to generate the Terraform code for an entire Azure subscription with a simple execution. Please note that this script is still in
# the early stages of development and requires instructions to identify resources with the same provider and type. In such cases,
# it comments out the possible variations, allowing the user to delete incorrect entries. This script is a work in progress and aims
# to be helpful in the future.

# Function to download the map.json file from a specific URL if it doesn't already exist
download_map_file() {
    local file="map.json"
    local url="https://raw.githubusercontent.com/magodo/aztft/main/internal/resmap/map.json" 
    if [ ! -f "$file" ]; then
        echo "Downloading $file from $url..."  
        wget -O "$file" "$url"  
        echo "Download complete." 
    else
        echo "$file already exists."
    fi
}

# Function to retrieve Azure resources and format them as JSON
get_resources() {
    local resources=$(az resource list --query "[].{type: type, id: id, name: name}" --output json | jq -c '.[]')
    echo "$resources"
}

# Function to convert the map.json file to a suitable format for mapping resources
convert_map_json() {
    local file="map.json"

    if [ -f "$file" ]; then
        local converted_map=$(jq -r '
            keys[] as $tf_resource_name
            | .[$tf_resource_name].management_plane.provider as $provider
            | .[$tf_resource_name].management_plane.types as $types
            | { azure_types: [$types[] | ($provider + "/" + .)], terraform_type: $tf_resource_name }
        ' "$file")
        echo "$converted_map" | jq --slurp '.'
    else
        echo "Map file not found."
    fi
}

# Function to map Azure resources to Terraform imports based on the converted map
map_resources() {
    local converted_map=$1
    local resources=$2

    echo 'terraform {'
    echo '  required_providers {'
    echo '    azurerm = {'
    echo '      source  = "hashicorp/azurerm"'
    echo '      version = "3.61.0"'
    echo '    }'
    echo '  }'
    echo '}'
    echo 'provider "azurerm" {'
    echo '  features {}'
    echo '}'
    
    if [ -n "$converted_map" ]; then
        for resource in $resources; do
            local type=$(echo "$resource" | jq -r '.type')
            local id=$(echo "$resource" | jq -r '.id')
            local name=$(echo "$resource" | jq -r '.name')

            # local matched_providers=$(echo "$converted_map" | jq -r --arg type "$type" 'map(select(.azure_types[] | contains($type))) | .[].terraform_type')
            local matched_provider=$(echo "$converted_map" | jq -r --arg type "$type" 'map(select((.azure_types | join("/")) == $type)) | .[].terraform_type')

            if [ -n "$matched_provider" ]; then
                appendix=""
                if [[ $(echo "$matched_provider" | wc -l) -gt 1 ]]; then
                    echo "# Multiple matching entries found for resource:"
                    echo "# Resource Type: $type"
                    echo "# Resource ID: $id"
                    echo "# ---"
                    appendix="#"
                fi
                echo $appendix'import {'
                echo $appendix'  id = "'$id'"'
                echo $appendix'  to = '$matched_provider'.'$name''
                echo $appendix'}'
            else
                echo "# No matching entry found for resource:"
                echo "# Resource Type: $type"
                echo "# Resource ID: $id"
                echo "# ---"
            fi
        done
    else
        echo "Converted map not available."
    fi
}

# Download the map.json file
download_map_file

# Convert the map.json file to a suitable format
converted_map=$(convert_map_json)
echo "$converted_map"
echo "---"

# Retrieve Azure resources
resources=$(get_resources)
echo "$resources"
echo "---"

# Map the resources to Terraform imports and save the output in the terraform.tf file
map_resources "$converted_map" "$resources" > terraform.tf

# Initialize Terraform
terraform init

# Generate the Terraform configuration and save it in the autogenerated.tf file
terraform plan -generate-config-out autogenerated.tf
