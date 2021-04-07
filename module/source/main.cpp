#include <GarrysMod/Lua/Interface.h>
#include <GarrysMod/InterfacePointers.hpp>
#include <GarrysMod/FactoryLoader.hpp>

namespace gkarts {

    SourceSDK::FactoryLoader engine_loader("engine");
    IServer* server = nullptr;

    GMOD_MODULE_OPEN() {
        
        server = InterfacePointers::Server();

        Msg("[G-Karts] Module Loaded");

        return 1;
    }

}
