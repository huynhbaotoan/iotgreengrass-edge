#sudo apt install python3-pip
sudo apt install pipx

sudo mkdir -p /greengrass/v2

sudo chmod 755 /greengrass

sudo mv ~/FleetProvisioning/claim-certs /greengrass/v2

sudo mv ~/FleetProvisioning/AmazonRootCA1.pem /greengrass/v2

sudo apt-get update

sudo apt install default-jdk

sudo useradd --system --create-home ggc_user
sudo groupadd --system ggc_group

chmod u+x ~/FleetProvisioning/install_dependencies.sh
~/FleetProvisioning/install_dependencies.sh

java -jar ~/FleetProvisioning/GreengrassInstaller/lib/Greengrass.jar --version

sudo -E java -Droot="/greengrass/v2" -Dlog.store=FILE \
  -jar ~/FleetProvisioning/GreengrassInstaller/lib/Greengrass.jar \
  --trusted-plugin ~/FleetProvisioning/GreengrassInstaller/aws.greengrass.FleetProvisioningByClaim.jar \
  --init-config ~/FleetProvisioning/GreengrassInstaller/config.yaml \
  --component-default-user ggc_user:ggc_group \
  --setup-system-service true