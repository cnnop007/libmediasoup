cmake_minimum_required(VERSION 2.8)

include_directories(./include)
set(SRC_LIST DepLibSRTP.cpp
    DepLibUV.cpp
    DepOpenSSL.cpp
    Logger.cpp
    Settings.cpp
    Worker.cpp
    Channel/Notifier.cpp
    Channel/Request.cpp
    Channel/UnixStreamSocket.cpp
    handles/SignalHandler.cpp
    handles/TcpConnection.cpp
    handles/TcpServer.cpp
    handles/Timer.cpp
    handles/UdpSocket.cpp
    handles/UnixStreamSocket.cpp


	
