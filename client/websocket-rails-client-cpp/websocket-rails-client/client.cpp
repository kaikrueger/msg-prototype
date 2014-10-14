#include <iostream>
#include <websocket-rails-client/msgwebsocket.hpp>


int main(int argc, const char* argv[]) {

    if (argc != 4) {
        std::cout << "Usage:" << std::endl;
        std::cout << " ./client <sensor_uuid> <timestamp> <value>" << std::endl;
        return -1;
    }


    msgwebsocket dispatcher("wss://dev4-playground.mysmartgrid.de/websocket");

    // main loop
		do {
			// create a value
			float value = random() % 500;
			
			// get timestamp
			time_t timestamp;
			time(&timestamp);
			
			std::ostringstream os;
			os << "{\"sensor_uuid\": \"" << argv[1] << "\", \"timestamp\": " << timestamp << ", \"value\": " << value << "}";

			try {
				dispatcher.send_measurement(os.str());
      //jsonxx::Object measurement;
			//measurement.parse(os.str());
			//		Event post = dispatcher.trigger("measurements.post", measurement, boost::bind(post_success, _1), boost::bind(post_failure, _1));

				usleep(1000000);
			} catch( std::exception &e) {
					std::cout<< "Got en exception: " << e.what()<< std::endl;
					
				}
				
		} while(1);
		
//    dispatcher.disconnect();
}
