PROJECT_GENERATOR_VERSION = 2

printf("DIRECTORY:".. _MAIN_SCRIPT_DIR);
printf( "WORKING_DIRECTORY: " .. _WORKING_DIR)
include("../module/garrysmod_common")
CreateWorkspace({name = "gkarts", abi_compatible = true})
	CreateProject({serverside = true, manual_files = true})
		IncludeLuaShared()
		IncludeHelpersExtended()
		IncludeSDKCommon()
		IncludeSDKTier0()
		IncludeSDKTier1()
		IncludeScanning()
		--IncludeDetouring()

		files({
			"source/**.cpp",
            "source/**.h",
		})