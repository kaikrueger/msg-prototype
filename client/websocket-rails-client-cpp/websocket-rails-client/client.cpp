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

void subscription_success(jsonxx::Object data) {

    std::cout << "Function subscription_success called" << std::endl;
    std::cout << data.json() << std::endl;
}

void subscription_failure(jsonxx::Object data) {

    std::cout << "Function subscription_failure called" << std::endl;
    std::cout << data.json() << std::endl;
}

void received_measurement(jsonxx::Object data) {

    std::cout << "Function received_measurement called" << std::endl;
    std::cout << data.json() << std::endl;
}

int main(int argc, const char* argv[]) {

    if (argc != 5) {
        std::cout << "Usage:" << std::endl;
        std::cout << " ./client <sensor_uuid> <timestamp> <value> <url>" << std::endl;
        return -1;
    }


    /* Create Dispatcher */

    WebsocketRails dispatcher(argv[4]);
    dispatcher.onOpen(boost::bind(on_open, _1));
    dispatcher.onClose(boost::bind(on_close, _1));
    dispatcher.onFail(boost::bind(on_fail, _1));

    dispatcher.connect();


    /* Subscribe to Channel */

    std::ostringstream channel_id;
    channel_id << "sensor-" << argv[1];
    std::cout << std::endl << "Subscribing channel: " << channel_id.str() << std::endl;

    Channel channel = dispatcher.subscribe(channel_id.str(), boost::bind(subscription_success, _1), boost::bind(subscription_failure, _1));
    channel.bind("create", boost::bind(received_measurement, _1));
    channel.bind("update", boost::bind(received_measurement, _1));

    std::cout << "Listening to channel: " << channel_id.str() << std::endl;


    /* Post Measurements */

    std::ostringstream measurement_str;
    measurement_str << "{\"sensor_uuid\": \"" << argv[1] << "\", \"timestamp\": " << argv[2] << ", \"value\": " << argv[3] << "}";

    jsonxx::Object measurement;
    measurement.parse(measurement_str.str());

    std::cout << std::endl << "Posting measurement: " << measurement_str.str() << std::endl;

    Event post = dispatcher.trigger("measurements.post", measurement, boost::bind(post_success, _1), boost::bind(post_failure, _1));


    /* Wait */
    char c;
    std::cin >> c;

    dispatcher.disconnect();
}
