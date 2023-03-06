s.boot;
thisProcess.openUDPPort(3000);
(
f = { |msg, time, addr|
    if(msg[0] != '/status.reply') {
        "time: % sender: %\nmessage: %\n".postf(time, addr, msg);
    }
};
thisProcess.addOSCRecvFunc(f);
);

OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off
