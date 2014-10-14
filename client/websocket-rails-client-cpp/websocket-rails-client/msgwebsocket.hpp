#include <string>

#include "websocket-rails-client/websocket_rails.hpp"



class msgwebsocket {
	
public:
	msgwebsocket(const std::string &url);
	~msgwebsocket(){};
	
	void send_measurement(const std::string &value);

	void on_open(jsonxx::Object data);
	void on_close(jsonxx::Object data);
	void on_fail(jsonxx::Object data);
private:
	void _init();
	
	void post_success(jsonxx::Object data);
	void post_failure(jsonxx::Object data);
	
private:
	std::string _url;
	WebsocketRails::Ptr _dispatcher;
	//bool _isConnected;
	
};
