cmake_minimum_required(VERSION 2.8)

MESSAGE(STSTUS "###################################")
MESSAGE(STATUS "operation system is ${CMAKE_SYSTEM}") 
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
ENDIF (CMAKE_SYSTEM_NAME MATCHES "Linux") 
    MESSAGE(STSTUS "###################################")


    set(THIRD_PARTY_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../../third-party)

    message(${THIRD_PARTY_ROOT})

    include_directories(./include
            ${THIRD_PARTY_ROOT}/libsrtp/include
            ${THIRD_PARTY_ROOT}/jsoncpp/${MARCH_NAME}/include
            )

    message(MARCH_NAME=${MARCH_NAME})

    set(SRC_LIST src/DepLibSRTP.cpp
        src/DepLibUV.cpp
    src/DepOpenSSL.cpp
    src/Logger.cpp
    src/Settings.cpp
    src/Worker.cpp
    src/Channel/Notifier.cpp
    src/Channel/Request.cpp
    src/Channel/UnixStreamSocket.cpp
    src/handles/SignalsHandler.cpp
    src/handles/TcpConnection.cpp
    src/handles/TcpServer.cpp
    src/handles/Timer.cpp
    src/handles/UdpSocket.cpp
    src/handles/UnixStreamSocket.cpp
	src/RTC/Codecs/Codecs.cpp
    src/RTC/Codecs/H264.cpp
    src/RTC/Codecs/VP8.cpp
    src/RTC/RemoteBitrateEstimator/InterArrival.cpp
    src/RTC/RemoteBitrateEstimator/OveruseDetector.cpp
    src/RTC/RemoteBitrateEstimator/OveruseEstimator.cpp
    src/RTC/RemoteBitrateEstimator/RemoteBitrateEstimatorAbsSendTime.cpp
    src/RTC/RemoteBitrateEstimator/RemoteBitrateEstimatorSingleStream.cpp
    src/RTC/RemoteBitrateEstimator/AimdRateControl.cpp
    src/RTC/RTCP/FeedbackPsTst.cpp
    src/RTC/RTCP/FeedbackPsVbcm.cpp
    src/RTC/RTCP/FeedbackRtp.cpp
    src/RTC/RTCP/FeedbackRtpEcn.cpp
    src/RTC/RTCP/FeedbackRtpNack.cpp
    src/RTC/RTCP/FeedbackRtpSrReq.cpp
    src/RTC/RTCP/FeedbackRtpTllei.cpp
    src/RTC/RTCP/FeedbackRtpTmmb.cpp
    src/RTC/RTCP/Packet.cpp
    src/RTC/RTCP/ReceiverReport.cpp
    src/RTC/RTCP/Sdes.cpp
    src/RTC/RTCP/SenderReport.cpp
    src/RTC/RTCP/Bye.cpp
    src/RTC/RTCP/CompoundPacket.cpp
    src/RTC/RTCP/Feedback.cpp
    src/RTC/RTCP/FeedbackPs.cpp
    src/RTC/RTCP/FeedbackPsAfb.cpp
    src/RTC/RTCP/FeedbackPsFir.cpp
    src/RTC/RTCP/FeedbackPsLei.cpp
    src/RTC/RTCP/FeedbackPsPli.cpp
    src/RTC/RTCP/FeedbackPsRemb.cpp
    src/RTC/RTCP/FeedbackPsRpsi.cpp
    src/RTC/RTCP/FeedbackPsSli.cpp
    src/RTC/RtpDictionaries/RtcpFeedback.cpp
    src/RTC/RtpDictionaries/RtcpParameters.cpp
    src/RTC/RtpDictionaries/RtpCodecMimeType.cpp
    src/RTC/RtpDictionaries/RtpCodecParameters.cpp
    src/RTC/RtpDictionaries/RtpEncodingParameters.cpp
    src/RTC/RtpDictionaries/RtpFecParameters.cpp
    src/RTC/RtpDictionaries/RtpHeaderExtensionParameters.cpp
    src/RTC/RtpDictionaries/RtpHeaderExtensionUri.cpp
    src/RTC/RtpDictionaries/RtpParameters.cpp
    src/RTC/RtpDictionaries/RtpRtxParameters.cpp
    src/RTC/RtpDictionaries/Media.cpp
    src/RTC/RtpDictionaries/Parameters.cpp
    src/RTC/StunMessage.cpp
    src/RTC/TcpConnection.cpp
    src/RTC/TcpServer.cpp
    src/RTC/Transport.cpp
    src/RTC/TransportTuple.cpp
    src/RTC/UdpSocket.cpp
    src/RTC/WebRtcTransport.cpp
    src/RTC/Consumer.cpp
    src/RTC/DtlsTransport.cpp
    src/RTC/IceCandidate.cpp
    src/RTC/IceServer.cpp
    src/RTC/NackGenerator.cpp
    src/RTC/PlainRtpTransport.cpp
    src/RTC/Producer.cpp
    src/RTC/Router.cpp
    src/RTC/RtpDataCounter.cpp
    src/RTC/RtpListener.cpp
    src/RTC/RtpMonitor.cpp
    src/RTC/RtpPacket.cpp
    src/RTC/RtpStream.cpp
    src/RTC/RtpStreamRecv.cpp
    src/RTC/RtpStreamSend.cpp
    src/RTC/SeqManager.cpp
    src/RTC/SrtpSession.cpp
	src/Utils/Crypto.cpp
	src/Utils/File.cpp
	src/Utils/IP.cpp
	)
	
add_library(libmediasoup ${SRC_LIST})	

link_libraries(mediasoup_test mediasoup
            srtp
			openssl
			netstring
			jsoncpp
			)
			
add_executable(mediasoup_test src/main.cpp)

 






	
