cmake_minimum_required(VERSION 2.8)

MESSAGE(STSTUS "###################################")
MESSAGE(STATUS "operation system is ${CMAKE_SYSTEM}") 

set(CMAKE_CXX_STANDARD 14)

IF (CMAKE_SYSTEM_NAME MATCHES "Linux") 
    MESSAGE(STATUS "current platform: Linux ")
ELSEIF (CMAKE_SYSTEM_NAME MATCHES "Windows") 
    MESSAGE(STATUS "current platform: Windows, ${CMAKE_SYSTEM_PROCESSOR}")
	add_definitions(-DEOS_WIN -DNOMINMAX -DMS_LITTLE_ENDIAN)
	set(MARCH_NAME "x64-windows-cl141")
ELSEIF (CMAKE_SYSTEM_NAME MATCHES "FreeBSD") 
    MESSAGE(STATUS "current platform: FreeBSD")
ELSE () 
    MESSAGE(STATUS "other platform: ${CMAKE_SYSTEM_NAME}")
ENDIF ()
    MESSAGE(STSTUS "###################################")


    set(THIRD_PARTY_ROOT $ENV{THIRD_PARTY_ROOT})
    set(MARCH_NAME mac)

    message(${THIRD_PARTY_ROOT})
    add_definitions(-DMS_LITTLE_ENDIAN)

    include_directories(worker-2.4.3/include
            worker-2.4.3/deps/netstring/netstring-c
            ${THIRD_PARTY_ROOT}/libsrtp/include
            ${THIRD_PARTY_ROOT}/jsoncpp/${MARCH_NAME}/include
            ${THIRD_PARTY_ROOT}/libuv/${MARCH_NAME}/include
            ${THIRD_PARTY_ROOT}/openssl/${MARCH_NAME}/include
            )

    message(MARCH_NAME=${MARCH_NAME})

    set(SRC_LIST worker-2.4.3/src/DepLibSRTP.cpp
    worker-2.4.3/src/DepLibUV.cpp
    worker-2.4.3/src/DepOpenSSL.cpp
    worker-2.4.3/src/Logger.cpp
    worker-2.4.3/src/Settings.cpp
    worker-2.4.3/src/Worker.cpp
    worker-2.4.3/src/Channel/Notifier.cpp
    worker-2.4.3/src/Channel/Request.cpp
    worker-2.4.3/src/Channel/UnixStreamSocket.cpp
    worker-2.4.3/src/handles/SignalsHandler.cpp
    worker-2.4.3/src/handles/TcpConnection.cpp
    worker-2.4.3/src/handles/TcpServer.cpp
    worker-2.4.3/src/handles/Timer.cpp
    worker-2.4.3/src/handles/UdpSocket.cpp
    worker-2.4.3/src/handles/UnixStreamSocket.cpp
	worker-2.4.3/src/RTC/Codecs/Codecs.cpp
    worker-2.4.3/src/RTC/Codecs/H264.cpp
    worker-2.4.3/src/RTC/Codecs/VP8.cpp
    worker-2.4.3/src/RTC/RemoteBitrateEstimator/InterArrival.cpp
    worker-2.4.3/src/RTC/RemoteBitrateEstimator/OveruseDetector.cpp
    worker-2.4.3/src/RTC/RemoteBitrateEstimator/OveruseEstimator.cpp
    worker-2.4.3/src/RTC/RemoteBitrateEstimator/RemoteBitrateEstimatorAbsSendTime.cpp
    worker-2.4.3/src/RTC/RemoteBitrateEstimator/RemoteBitrateEstimatorSingleStream.cpp
    worker-2.4.3/src/RTC/RemoteBitrateEstimator/AimdRateControl.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsTst.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsVbcm.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackRtp.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackRtpEcn.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackRtpNack.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackRtpSrReq.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackRtpTllei.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackRtpTmmb.cpp
    worker-2.4.3/src/RTC/RTCP/Packet.cpp
    worker-2.4.3/src/RTC/RTCP/ReceiverReport.cpp
    worker-2.4.3/src/RTC/RTCP/Sdes.cpp
    worker-2.4.3/src/RTC/RTCP/SenderReport.cpp
    worker-2.4.3/src/RTC/RTCP/Bye.cpp
    worker-2.4.3/src/RTC/RTCP/CompoundPacket.cpp
    worker-2.4.3/src/RTC/RTCP/Feedback.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPs.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsAfb.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsFir.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsLei.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsPli.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsRemb.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsRpsi.cpp
    worker-2.4.3/src/RTC/RTCP/FeedbackPsSli.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtcpFeedback.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtcpParameters.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtpCodecMimeType.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtpCodecParameters.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtpEncodingParameters.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtpFecParameters.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtpHeaderExtensionParameters.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtpHeaderExtensionUri.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtpParameters.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/RtpRtxParameters.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/Media.cpp
    worker-2.4.3/src/RTC/RtpDictionaries/Parameters.cpp
    worker-2.4.3/src/RTC/StunMessage.cpp
    worker-2.4.3/src/RTC/TcpConnection.cpp
    worker-2.4.3/src/RTC/TcpServer.cpp
    worker-2.4.3/src/RTC/Transport.cpp
    worker-2.4.3/src/RTC/TransportTuple.cpp
    worker-2.4.3/src/RTC/UdpSocket.cpp
    worker-2.4.3/src/RTC/WebRtcTransport.cpp
    worker-2.4.3/src/RTC/Consumer.cpp
    worker-2.4.3/src/RTC/DtlsTransport.cpp
    worker-2.4.3/src/RTC/IceCandidate.cpp
    worker-2.4.3/src/RTC/IceServer.cpp
    worker-2.4.3/src/RTC/NackGenerator.cpp
    worker-2.4.3/src/RTC/PlainRtpTransport.cpp
    worker-2.4.3/src/RTC/Producer.cpp
    worker-2.4.3/src/RTC/Router.cpp
    worker-2.4.3/src/RTC/RtpDataCounter.cpp
    worker-2.4.3/src/RTC/RtpListener.cpp
    worker-2.4.3/src/RTC/RtpMonitor.cpp
    worker-2.4.3/src/RTC/RtpPacket.cpp
    worker-2.4.3/src/RTC/RtpStream.cpp
    worker-2.4.3/src/RTC/RtpStreamRecv.cpp
    worker-2.4.3/src/RTC/RtpStreamSend.cpp
    worker-2.4.3/src/RTC/SeqManager.cpp
    worker-2.4.3/src/RTC/SrtpSession.cpp
	worker-2.4.3/src/Utils/Crypto.cpp
	worker-2.4.3/src/Utils/File.cpp
	worker-2.4.3/src/Utils/IP.cpp
    worker-2.4.3/deps/netstring/netstring-c/netstring.c
	)
	
add_library(mediasoup ${SRC_LIST})	

set(link_dirs $ENV{THIRD_PARTY_ROOT}/libsrtp/$ENV{MARCH_NAME}/lib
    $ENV{THIRD_PARTY_ROOT}/openssl/$ENV{MARCH_NAME}/lib
    $ENV{THIRD_PARTY_ROOT}/jsoncpp/$ENV{MARCH_NAME}/lib
    $ENV{THIRD_PARTY_ROOT}/libuv/$ENV{MARCH_NAME}/lib
    )
message(STATUS "link_dirs=${link_dirs}")
link_directories(${link_dirs})
add_executable(mediasoup_test worker-2.4.3/src/main.cpp)
target_link_libraries(mediasoup_test mediasoup
            srtp
			ssl
            crypto
            uv
			jsoncpp
			)
			

 






	
