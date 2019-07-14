const osc = require("osc"),
    WebSocket = require("ws");

const getIPAddresses = function () {
    const os = require("os"),
        interfaces = os.networkInterfaces(),
        ipAddresses = [];

    for (let deviceName in interfaces){
        const addresses = interfaces[deviceName];

        for (let i = 0; i < addresses.length; i++) {
            const addressInfo = addresses[i];

            if (addressInfo.family === "IPv4" && !addressInfo.internal) {
                ipAddresses.push(addressInfo.address);
            }
        }
    }

    return ipAddresses;
};

const udp = new osc.UDPPort({
    // This is the port we're listening on.
    localAddress: "127.0.0.1",
    localPort: 57121,

    // This is where sclang is listening for OSC messages.
    remoteAddress: "127.0.0.1",
    remotePort: 57120
});

udp.on("ready", function () {
    const ipAddresses = getIPAddresses();
    console.log("Listening for OSC over UDP.");
    ipAddresses.forEach(function (address) {
        console.log(" Host:", address + ", Port:", udp.options.localPort);
    });
    console.log("Broadcasting OSC over UDP to", udp.options.remoteAddress + ", Port:", udp.options.remotePort);
});

udp.open();

const wss = new WebSocket.Server({
    port: 8081
});

wss.on("connection", function (socket) {
    console.log("A Web Socket connection has been established!");
    const socketPort = new osc.WebSocketPort({
        socket: socket
    });

    const relay = new osc.Relay(udp, socketPort, {
        raw: true
    });
});
