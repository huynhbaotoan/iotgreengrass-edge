# IoT Management System with IoT Greengrass in Edge devices

## Setup Jetson Edge Device

Follow the [guidance](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#prepare)  from Nvidia to setup:
- Download the [image](https://developer.nvidia.com/jetson-nano-sd-card-image)
- Write to microSD Card
- Setup and First Boot from this [link](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#setup)

## Setup configurations

Replace these values below in `config.yaml`
- Get the region to replace `region_REPLACED`
- Run 
    ```
    aws iot describe-endpoint --endpoint-type iot:Data-ATS
    ```
    get `endpointAddress` the result to replace `iotDataEndpoint_REPLACED`
- Run 
    ```
    aws iot describe-endpoint --endpoint-type iot:CredentialProvider
    ```
    get `endpointAddress` in the result to replace `iotCredentialEndpoint_REPLACED`
- Replace `TokenExchangeRoleAlias_REPLACED` and `FleetProvisionTemplate_REPLACED` with the outputs from Terraform results.
- Replace claim certs files appropriately for `claim_REPLACED`
- Get the thing group name and replace `device-group-name`
- Give the device name with `device-name`

In the future, this file can be generated from the backend which will combine with provisioning validation Lambda.

## Prepare USB

- Copy claim certificates from IaC into ./FleetProvisioning/claim-certs folder (3 files)
- Run these commands below
```
    cd ./FleetProvisioning
    curl -s https://d2s8p88vqu9w66.cloudfront.net/releases/greengrass-nucleus-latest.zip > greengrass-nucleus-latest.zip

    unzip greengrass-nucleus-latest.zip -d GreengrassInstaller && rm greengrass-nucleus-latest.zip

    curl -s https://d2s8p88vqu9w66.cloudfront.net/releases/aws-greengrass-FleetProvisioningByClaim/fleetprovisioningbyclaim-latest.jar > GreengrassInstaller/aws.greengrass.FleetProvisioningByClaim.jar

    cp ./config.yaml GreengrassInstaller/
```
- Copy FleetProvisioning folder to USB


## Setup AWS IoT Greengrass on Jetson

- Plug FleetProvisioning USB into Jetson device.
- Copy FleetProvisioning to the device.
- Run 
```
    cd FleetProvisioning
    chmod +x setup.sh
    ./setup.sh
```