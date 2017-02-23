## Lightroom Plugin for converting Fuji in-camera ratings to standard format, which can then be read by Adobe and other software.

I have Fujifilm X-T2 and I have always wished there was a way to make the in-camera ratings readable by Lightroom. I prefer rating images on the go to spend less time afterwards going through the images in front of the screen.
This plugin started as a bash script, which suited my needs, but was not user friendly for other people to use, thus the work on plugin started.

**NOTE: This plugin is still work in progress, but it should work.**

### Prerequesites:
* Exiftool installed and binary placed in `/usr/local/bin/exiftool` (MAC) or `C:\Windows\exiftool.exe` (Windows). Tested with current latest version `10.43`;
* Lightroom. Minimum version still TBD.

### Usage:
* Clone repository;
* Open Lightroom and install the plugin. This can be done by opening `Plug-in Manager`, clicking `Add` and specifying the plugin directory `IncameraFujiRatingConverter.lrplugin`. Make sure there are no errors;
* The plugin must be used in `Library` view. Selected the images for which the ratings should be converted and execute the plugin which can be accessed from menu bar: `Library -> Plug-in Extras -> Convert Fuji incamera ratings`;
* After plugin executes, the ratings should appear.

**NOTE: The ratings cannot be recovered if they have already been rewritten inside Lightroom or in any other software**

This plugin also sets the rating for .RAF files by saving the metadata in .xmp sidecar file.

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

#### Bonus: Bash script which does the same thing as the plugin, but does not require Lightroom. For technical audience, works only on Mac and Linux.

#### Prerequesites:
* You must have exiftool installed and configured to be under path (if using Mac, `brew install exiftool` should do);
* This script works by reading the in-camera rating from JPG, so shooting JPG or JPG+RAF is necessary (when shooting JPG+RAF, the rating will also be synchronized from JPG to RAF file by creating .xmp sidecar file).

#### Usage:
* For easier usage, make sure the script `fixFujiRatings.sh` is in `PATH`. One way to do that is to place `fixFujiRatings.sh` script under `/usr/local/bin`. `mv fujiRatings.sh /usr/local/bin`. Or create a symbolic link.
* Make sure script is executable, run `sudo chmod +x /usr/local/bin/fixFujiRatings.sh`

##### Running the script:
`fixFujiRatings` (will run the script in current directory) or you can specify the path explicitly `fixFujiRatings <path-to-directory>`
