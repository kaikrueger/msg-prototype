$(function () {

    var gauge1 = new JustGage({
        id: "gauge1",
        value: "0",
        min: 0,
        max: 1000,
        levelColors: [ "#2A4026", "#B6D96C", "#2A4026" ],
        levelColorsGradient: true,
        title: "Gauge 1",
        label: "MW"
    });

    if (window["WebSocket"]) {

        function updateCharts(measurement) {
            gauge1.refresh(Number(measurement.value).toFixed(1));
        }

        var dispatcher = new WebSocketRails('localhost:3000/websocket');
        var channel = dispatcher.subscribe('measurements');

        channel.bind('create', updateCharts);
        channel.bind('update', updateCharts);

    } else {
        alert("Your Browser does not support WebSocket.");
    }
});