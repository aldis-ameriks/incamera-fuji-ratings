--[[----------------------------------------------------------------------------

ADOBE SYSTEMS INCORPORATED
Copyright 2007 Adobe Systems Incorporated
All Rights Reserved.

NOTICE: Adobe permits you to use, modify, and distribute this file in accordance
with the terms of the Adobe license agreement accompanying it. If you have received
this file from a source other than Adobe, then your use, modification, or distribution
of it requires the prior written permission of Adobe.

--------------------------------------------------------------------------------

Info.lua

------------------------------------------------------------------------------]]

return {

  LrSdkVersion = 5.0,
  LrSdkMinimumVersion = 4.0, -- minimum SDK version required by this plug-in

  LrToolkitIdentifier = 'lv.ameriks.lightroom.library.incamerafujiratingconverter',
  LrPluginName = "Incamera Fuji Rating Converter",

  LrLibraryMenuItems = {
    {
      title = 'Convert Fuji incamera ratings',
      file = "IncameraFujiRatingConverter.lua"
    }
  },
  VERSION = { major=1, minor=0, revision=0, build=18701234, },
}
