# -*- mode: cmake; -*-

#add_subdirectory(libs)
#
#set(client_SRCS channel.cpp
#	client.cpp
#	)

include_directories(${CMAKE_BINARY_DIR})
include_directories(${CMAKE_SOURCE_DIR})
include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
include_directories(${OPENSSL_INCLUDE_DIR})
include_directories(${WEBSOCKETPP_INCLUDE_DIR})

set(websocket_SRCS channel.cpp
	websocket_connection.cpp
	websocket_rails.cpp
	event.cpp
	${CMAKE_BINARY_DIR}/jsonxx/jsonxx.cc)

set_source_files_properties(${websocket_SRCS} COMPILE_FLAGS "-std=c++0x -D_WEBSOCKETPP_CPP11_STL_")


add_library(websocket ${websocket_SRCS})

set(client_srcs client.cpp msgwebsocket.cpp)
set_source_files_properties(${client_SRCS} COMPILE_FLAGS "-std=c++0x -D_WEBSOCKETPP_CPP11_STL_")

add_executable(client ${client_srcs})    
target_link_libraries(client websocket)
target_link_libraries(client ${Boost_LIBRARIES} pthread)
target_link_libraries(client ${OPENSSL_SSL_LIBRARY} ${OPENSSL_CRYPTO_LIBRARY})

# # test for hxb2msg_bridge
# set(hxb2msg_bridge_src hxb2msg_bridge.cpp)
# set_source_files_properties(${hxb2msg_bridge_src} COMPILE_FLAGS "-std=c++0x -D_WEBSOCKETPP_CPP11_STL_")
# add_executable(hxb2msg_bridge ${hxb2msg_bridge_srcs})    
# target_link_libraries(hxb2msg_bridge websocket)
# target_link_libraries(hxb2msg_bridge 
#   hexanode
#   ${HXB_LIBRARIES}
#   ${LIBKLIO_LIBRARY}
#   ${Boost_LIBRARIES}
#   ${Boost_SYSTEM_LIBRARY}
# #  ${JSON_LIBRARY}
# #  ${CURL_LIBRARIES}
# #  ${SQLITE3_LIBRARIES}
#   ${GNUTLS_LIBRARIES}
#   ${OPENSSL_CRYPTO_LIBRARY}
#   pthread



#gcc -c -D_WEBSOCKETPP_CPP11_STL_ -std=c++0x channel.cpp  -I"../.." -I"../../websocketpp"
#ar rf libwebsocket.a *.o /home/wagnerag/projects/rails/msg-prototype/client/jsonxx/jsonxx.o
#
#g++ -g -o client client.cpp -lstdc++ -std=c++0x -D_WEBSOCKETPP_CPP11_STL_ 
#-I"/home/wagnerag/projects/rails/msg-prototype/client/websocket-rails-client-cpp"
# -I"/home/wagnerag/projects/rails/msg-prototype/client" 
#-I"/home/wagnerag/projects/rails/msg-prototype/client/websocketpp" 
#-Llibs -lwebsocket -lboost_system -lboost_thread -lpthread -lrt
