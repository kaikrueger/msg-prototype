#include <iostream>
#include "websocket-rails-client/websocket_rails.hpp"

int main(int argc, const char* argv[]) {

    if (argc != 3) {
        std::cout << "Usage:" << std::endl;
        std::cout << " ./client2 <sensor_uuid> <url>" << std::endl;
        return -1;
    }

    WebsocketRails dispatcher(argv[2]);

    dispatcher.connect();

    std::ostringstream channelId;
    channelId << "sensor-" << argv[1];

    Channel channel = dispatcher.subscribe(channelId.str());

    char c;
    std::cin >> c;

    dispatcher.disconnect();
}