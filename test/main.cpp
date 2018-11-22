#define MS_CLASS "main"
// #define MS_LOG_DEV

#include "common.hpp"
#include "Logger.hpp"
#include "MediaSoupError.hpp"
#include "Settings.hpp"
#include "Utils.hpp"
#include "Worker.hpp"
#include "Channel/UnixStreamSocket.hpp"
#include "RTC/TcpServer.hpp"
#include "RTC/UdpSocket.hpp"
#include <uv.h>
#include <cerrno>
#include <csignal>  // sigaction()
#include <cstdlib>  // std::_Exit(), std::genenv()
#include <iostream> // std::cout, std::cerr, std::endl
#include <map>
#include <string>

#ifndef _WIN32
#include <unistd.h> // getpid(), usleep()
#else


#endif //!_WIN32

#include "mediasoup_worker_api.hpp"

void exitSuccess()
{
    // Wait a bit so peding messages to stdout/Channel arrive to the main process.
    //usleep(100000);
    // And exit with success status.
    std::_Exit(EXIT_SUCCESS);
}

void exitWithError() {
    // Wait a bit so peding messages to stderr arrive to the main process.
    //apl_usleep(100000);
    // And exit with error status.
    std::_Exit(EXIT_FAILURE);

}

int main(int argc, char* argv[])
{

    Mediasoup_Init();

    std::string id = "test_123456";
    int channelFd = socket(AF_INET, SOCK_DGRAM, 0);

    // Set the Channel socket (this will be handled and deleted by the Worker).
    auto* channel = new Channel::UnixStreamSocket(channelFd);

    // Initialize the Logger.
    Logger::Init(id, channel);

    // Setup the configuration.
    try
    {
        Settings::SetConfiguration(argc, argv);
    }
    catch (const MediaSoupError& error)
    {
        MS_ERROR("configuration error: %s", error.what());

        return -1;
    }

    // Print the effective configuration.
    Settings::PrintConfiguration();

    //MS_DEBUG_TAG(info, "starting mediasoup-worker [pid:%ld]", (long)getpid());

#if defined(MS_LITTLE_ENDIAN)
    MS_DEBUG_TAG(info, "Little-Endian CPU detected");
#elif defined(MS_BIG_ENDIAN)
    MS_DEBUG_TAG(info, "Big-Endian CPU detected");
#endif

#if defined(INTPTR_MAX) && defined(INT32_MAX) && (INTPTR_MAX == INT32_MAX)
    MS_DEBUG_TAG(info, "32 bits architecture detected");
#elif defined(INTPTR_MAX) && defined(INT64_MAX) && (INTPTR_MAX == INT64_MAX)
    MS_DEBUG_TAG(info, "64 bits architecture detected");
#else
    MS_WARN_TAG(info, "can not determine whether the architecture is 32 or 64 bits");
#endif

    try
    {
        // Run the Worker.
        Worker worker(channel);

        // Worker ended.
        Mediasoup_Destroy();
        exitSuccess();
    }
    catch (const MediaSoupError& error)
    {
        MS_ERROR_STD("failure exit: %s", error.what());

        Mediasoup_Destroy();
        exitWithError();
    }
}



