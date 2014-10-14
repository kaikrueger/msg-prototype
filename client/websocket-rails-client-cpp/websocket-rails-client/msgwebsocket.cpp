
#include <websocket-rails-client/msgwebsocket.hpp>

msgwebsocket::msgwebsocket(const std::string &url) 
		: _url(url)
													//, _isConnected(false)
{
	_dispatcher = WebsocketRails::Ptr(new WebsocketRails(_url));
	_init();
}

void msgwebsocket::_init() {
	std::cout << "Init called" << std::endl;
	_dispatcher->onOpen(boost::bind(&msgwebsocket::on_open, this, _1));
	_dispatcher->onClose(boost::bind(&msgwebsocket::on_close, this,_1));
	_dispatcher->onFail(boost::bind(&msgwebsocket::on_fail, this, _1));
	_dispatcher->connect();
}

void msgwebsocket::send_measurement(const std::string &value) {
	// check connection
	std::cout << "send measurement" << std::endl;
	if(!_dispatcher->isConnected()) {
		std::cout<< "   trying to connect..."<< std::endl;
		
		try {
			_dispatcher->reconnect();
			if(!_dispatcher->isConnected()) {
				std::cout<<">>>> NOT CONNECTED...\n";
				return;
			}
			
		}
		catch(std::exception &e) {
			std::cout<<"Except: "<< e.what() << std::endl;
		}
	}
	

	jsonxx::Object measurement;
	measurement.parse(value);
	Event post = _dispatcher->trigger("measurements.post", measurement, 
																	 boost::bind(&msgwebsocket::post_success, this, _1),
																	 boost::bind(&msgwebsocket::post_failure, this, _1));
}

void msgwebsocket::on_open(jsonxx::Object data) {

    std::cout << "Function on_open called" << std::endl;
    std::cout << data.json() << std::endl;
}

void msgwebsocket::on_close(jsonxx::Object data) {

    std::cout << "Function on_close called" << std::endl;
    std::cout << data.json() << std::endl;
}

void msgwebsocket::on_fail(jsonxx::Object data) {

    std::cout << "Function on_fail called" << std::endl;
    std::cout << data.json() << std::endl;
}

void msgwebsocket::post_success(jsonxx::Object data) {

    std::cout << "Function post_success called" << std::endl;
    std::cout << data.json() << std::endl;
}

void msgwebsocket::post_failure(jsonxx::Object data) {

    std::cout << "Function post_failure called" << std::endl;
    std::cout << data.json() << std::endl;
}
