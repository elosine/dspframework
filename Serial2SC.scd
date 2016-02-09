SerialPort.listDevices;
~kbs0 = Bus.control(s);
~ino = ArduinoSMS("/dev/tty.usbmodem1a131", 9600);

//ARDUINO
ino.action = { |msg|
	var sm = msg.split($:);
	if(sm[0]=="pot0",{
		var val = sm[1].asFloat.linlin( 0, 1024, 0.0, 1.0 );
		~kbs0.setSynchronous(val);
		};
	};