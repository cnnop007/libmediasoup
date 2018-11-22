#define MS_CLASS "main"
// #define MS_LOG_DEV

#include "common.hpp"
#include "DepLibSRTP.hpp"
#include "DepLibUV.hpp"
#include "DepOpenSSL.hpp"
#include "Logger.hpp"
#include "MediaSoupError.hpp"
#include "Settings.hpp"
#include "Utils.hpp"
#include "Worker.hpp"
#include "Channel/UnixStreamSocket.hpp"
#include "RTC/DtlsTransport.hpp"
#include "RTC/SrtpSession.hpp"
#include "RTC/TcpServer.hpp"
#include "RTC/UdpSocket.hpp"
#include <uv.h>
#include <cerrno>
#include <csignal>  // sigaction()
#include <cstdlib>  // std::_Exit(), std::genenv()
#include <iostream> // std::cout, std::cerr, std::endl
#include <map>
#include <string>
#include <unistd.h> // getpid(), usleep()



static void ignoreSignals()
{
	MS_TRACE();

	int err;
	struct sigaction act;
	// clang-format off
	std::map<std::string, int> ignoredSignals =
	{
		{ "PIPE", SIGPIPE },
		{ "HUP",  SIGHUP  },
		{ "ALRM", SIGALRM },
		{ "USR1", SIGUSR2 },
		{ "USR2", SIGUSR1}
	};
	// clang-format on

	// Ignore clang-tidy cppcoreguidelines-pro-type-cstyle-cast.
	act.sa_handler = SIG_IGN; // NOLINT
	act.sa_flags   = 0;
	err            = sigfillset(&act.sa_mask);
	if (err != 0)
		MS_THROW_ERROR("sigfillset() failed: %s", std::strerror(errno));

	for (auto& ignoredSignal : ignoredSignals)
	{
		auto& sigName = ignoredSignal.first;
		int sigId     = ignoredSignal.second;

		err = sigaction(sigId, &act, nullptr);
		if (err != 0)
		{
			MS_THROW_ERROR("sigaction() failed for signal %s: %s", sigName.c_str(), std::strerror(errno));
		}
	}
}

int Mediasoup_Init()
{

	MS_TRACE();

    // Initialize libuv stuff (we need it for the Channel).
	DepLibUV::ClassInit();

	ignoreSignals();
	DepLibUV::PrintVersion();

	// Initialize static stuff.
	DepOpenSSL::ClassInit();
	DepLibSRTP::ClassInit();
	Utils::Crypto::ClassInit();
	RTC::UdpSocket::ClassInit();
	RTC::TcpServer::ClassInit();
	RTC::DtlsTransport::ClassInit();
	RTC::SrtpSession::ClassInit();

    return 0;
}

int Mediasoup_Destroy()
{
	MS_TRACE();

	// Free static stuff.
	RTC::DtlsTransport::ClassDestroy();
	Utils::Crypto::ClassDestroy();
	DepLibUV::ClassDestroy();
	DepLibSRTP::ClassDestroy();
	return 0;
}