# Develop AWS IoT Greengrass components

## 

Follow the structure of GreengrassComponents folder with 2 subfolders:
- artifiacts
- recipes

These contain all components developed.

## Creating Greengrass component artifacts
- Creating component artifacts: create a  folder to contain the component source code under artifacts folder. For example
```
    mkdir com.example.XXXX
    cd com.example.XXXX
```

- Create version folder and put the source code files into it. For example:
```
    mkdir majorversion.minorversion.xxx
    cd majorversion.minorversion.xxx
    touch xxx.py
```

## Creating a recipe for the component
- Create the recipe file for the component
```
    cd ../../../recipes
    touch com.example.XXXX-majorversion.minorversion.xxx.json
```

A hello world component file likes below

```
{
   "RecipeFormatVersion": "2020-01-25",
   "ComponentName": "com.example.XXXX",
   "ComponentVersion": "1.0.0",
   "ComponentDescription": "My AWS IoT Greengrass component.",
   "ComponentPublisher": "MyCompany",
   "ComponentConfiguration": {
      "DefaultConfiguration": {
         "Message": "world"
      }
   },
   "Manifests": [
      {
         "Platform": {
            "os": "linux"
         },
         "Lifecycle": {
            "Run": "python3 -u {artifacts:path}/hello_world.py '{configuration:/Message}'\n"
         }
      }
   ]
}
```

## Run and test the component on Greengrass device (edge)

- Run the command below to deploy and test on edge device

```
    sudo /greengrass/v2/bin/greengrass-cli deployment create \
        --recipeDir ~/GreengrassComponents/recipes \
        --artifactDir ~/GreengrassComponents/artifacts \
        --merge "com.example.XXXX=majorversion.minorversion.xxx"
```

- Verify with logs in greengrass core

```
    tail -F /tmp/Greengrass_XXX.log
```

## Publish the component

- Create a S3 bucket to upload the component to there.
- Update the recipe file: com.example.XXXX-majorversion.minorversion.xxx.json with the code below. Replace [YOUR BUCKET NAME] with the bucket name created above.

```
    {
    "RecipeFormatVersion": "2020-01-25",
    "ComponentName": "com.example.XXXX",
    "ComponentVersion": "majorversion.minorversion.xxx",
    "ComponentDescription": "My AWS IoT Greengrass component.",
    "ComponentPublisher": "MyCompany",
    "ComponentConfiguration": {
        "DefaultConfiguration": {
            "Message": "world"
        }
    },
    "Manifests": [
        {
            "Platform": {
                "os": "linux"
            },
            "Lifecycle": {
                "Run": "python3 -u {artifacts:path}/hello_world.py '{configuration:/Message}'\n"
            },
            "Artifacts": [
                {
                "URI": "s3://[BUCKET NAME]/artifacts/com.example.XXXX/majorversion.minorversion.xxx/hello_world.py"
                }
            ]
        }
    ]
    }
```

- Upload the component artifacts to S3
```
    aws s3 cp --recursive ./GreengrassComponents/ s3://$S3_BUCKET/
```

- Now that the component artifacts have been uploaded we will create the component definition in IoT Greengrass -> Components. To create your component definition run the following command.
```
    cd ./GreengrassComponents/recipes && aws greengrassv2 create-component-version  --inline-recipe fileb://com.example.XXXX-majorversion.minorversion.xxx.json --region $AWS_DEFAULT_REGION
```

- Your component is ready to deploy with Greengrass deployment


## References
- https://catalog.workshops.aws/greengrass/en-US/chapter4-createfirstcomp
- 