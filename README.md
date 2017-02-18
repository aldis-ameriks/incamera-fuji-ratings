## Script to convert Fuji in-camera ratings to ones readable by Adobe

#### Prerequesites:
* You must have exiftool installed and configured to be under path (if using Mac, `brew install exiftool` should do);
* This script works by reading the in-camera rating from JPG, so shooting JPG or JPG+RAF is necessary (when shooting JPG+RAF, the rating will also be synchronized from JPG to RAF file by creating .xmp sidecar file).

#### Usage:
* For easier usage, make sure the script `fixFujiRatings.sh` is in `PATH`. One way to do that is to place `fixFujiRatings.sh` script under `/usr/local/bin`. `mv fujiRatings.sh /usr/local/bin`.
* Make sure script is executable, run `sudo chmod +x /usr/local/bin/fixFujiRatings.sh`

##### Running the script:
`fixFujiRatings` (will run the script in current directory) or you can specify the path explicitly `fixFujiRatings <path-to-directory>`
