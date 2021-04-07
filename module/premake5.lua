PROJECT_GENERATOR_VERSION = 2

printf("DIRECTORY:".. _MAIN_SCRIPT_DIR, "WORKING_DIRECTORY: " .. _WORKING_DIR);
include("garrysmod_common")
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