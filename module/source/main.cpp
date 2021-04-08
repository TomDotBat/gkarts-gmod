#include <GarrysMod/Lua/Interface.h>
#include <GarrysMod/InterfacePointers.hpp>
#include <GarrysMod/FactoryLoader.hpp>
#include <networkstringtabledefs.h>

namespace gkarts {

    SourceSDK::FactoryLoader engine_loader("engine");
   
    IVEngineServer* server = nullptr;
    IServer* iServer = nullptr;
    GMOD_MODULE_OPEN(){

        server = InterfacePointers::VEngineServer();
        iServer = InterfacePointers::Server();
        Msg("[G-Karts] Module Loaded?");
        INetworkStringTableContainer* net = gkarts::engine_loader.GetInterface<INetworkStringTableContainer>(
            INTERFACENAME_NETWORKSTRINGTABLESERVER
        );
        const int numTables = net->GetNumTables();
        for (int i = 0; i < numTables; i++) {
            INetworkStringTable* tbl = net->GetTable(i);
            Msg("[G-Karts]: %s", tbl->GetTableName());
        }
        Msg("[G-Karts] Module Loaded");
        return 1;
    }

}
