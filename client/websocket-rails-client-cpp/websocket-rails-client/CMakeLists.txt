# -*- mode: cmake; -*-

#add_subdirectory(libs)
#
#set(client_SRCS channel.cpp
#	client.cpp
#	)

include_directories(${CMAKE_BINARY_DIR})
include_directories(${CMAKE_SOURCE_DIR})
include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
include_directories(${WEBSOCKETPP_INCLUDE_DIR})

set(websocket_SRCS channel.cpp
	websocket_connection.cpp
	websocket_rails.cpp
	event.cpp
	${CMAKE_BINARY_DIR}/jsonxx/jsonxx.cc)

set_source_files_properties(${websocket_SRCS} COMPILE_FLAGS "-std=c++0x -D_WEBSOCKETPP_CPP11_STL_")


add_library(websocket ${websocket_SRCS})

set(client_srcs client.cpp)
set_source_files_properties(${client_SRCS} COMPILE_FLAGS "-std=c++0x -D_WEBSOCKETPP_CPP11_STL_")

add_executable(client ${client_srcs})    
target_link_libraries(client websocket)
target_link_libraries(client ${Boost_LIBRARIES})



#gcc -c -D_WEBSOCKETPP_CPP11_STL_ -std=c++0x channel.cpp  -I"../.." -I"../../websocketpp"
#ar rf libwebsocket.a *.o /home/wagnerag/projects/rails/msg-prototype/client/jsonxx/jsonxx.o
#
#g++ -g -o client client.cpp -lstdc++ -std=c++0x -D_WEBSOCKETPP_CPP11_STL_ 
#-I"/home/wagnerag/projects/rails/msg-prototype/client/websocket-rails-client-cpp"
# -I"/home/wagnerag/projects/rails/msg-prototype/client" 
#-I"/home/wagnerag/projects/rails/msg-prototype/client/websocketpp" 
#-Llibs -lwebsocket -lboost_system -lboost_thread -lpthread -lrt
