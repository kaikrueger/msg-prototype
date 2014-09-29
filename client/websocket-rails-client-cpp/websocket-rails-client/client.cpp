#include <iostream>
#include "websocket-rails-client/websocket_rails.hpp"

void on_open(jsonxx::Object data) {

    std::cout << "Function on_open called" << std::endl;
    std::cout << data.json() << std::endl;
}

void on_close(jsonxx::Object data) {

    std::cout << "Function on_close called" << std::endl;
    std::cout << data.json() << std::endl;
}

void on_fail(jsonxx::Object data) {

    std::cout << "Function on_fail called" << std::endl;
    std::cout << data.json() << std::endl;
}

void post_success(jsonxx::Object data) {

    std::cout << "Function post_success called" << std::endl;
    std::cout << data.json() << std::endl;
}

void post_failure(jsonxx::Object data) {

    std::cout << "Function post_failure called" << std::endl;
    std::cout << data.json() << std::endl;
}

int main(int argc, const char* argv[]) {

    if (argc != 4) {
        std::cout << "Missing arguments." << argc << std::endl;
        return -1;
    }

    std::ostringstream os;
    os << "{\"sensor_uuid\": \"" << argv[1] << "\", \"timestamp\": " << argv[2] << ", \"value\": " << argv[3] << "}";

    jsonxx::Object measurement;
    measurement.parse(os.str());

    WebsocketRails dispatcher("ws://localhost:3000/websocket");
    dispatcher.onOpen(boost::bind(on_open, _1));
    dispatcher.onClose(boost::bind(on_close, _1));
    dispatcher.onFail(boost::bind(on_fail, _1));

    dispatcher.connect();

    Event post = dispatcher.trigger("measurements.post", measurement, boost::bind(post_success, _1), boost::bind(post_failure, _1));

    /* Wait */
    char c;
    std::cin >> c;

    dispatcher.disconnect();
}
