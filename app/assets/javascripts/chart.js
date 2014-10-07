
function date2string(date) {
    var hr = date.getHours();
    var min = date.getMinutes();
    if (min < 10) {
        min = "0" + min;
    }
    var sec = date.getSeconds();
    if (sec < 10) {
        sec = "0" + sec;
    }
    return hr + ":" + min + ":" + sec;
}

function getNowTimestamp() {
    return Math.round(new Date() / 1000);
}

function createGauge(id, name, unit, min, max) {

    return new JustGage({
        id: id,
        value: "0",
        min: min,
        max: max,
        levelColors: [ "#2A4026", "#B6D96C", "#2A4026" ],
        levelColorsGradient: true,
        title: name,
        titleFontColor : (name == null ? 'white' : 'gray'),
        label: unit
    });
}

function createLineChart(id) {

    return $('#' + id).epoch({
        type: 'time.line',
        label: "Frequency",
        data: [
            {
                label: 'Frequency',
                values: [
                    {time: getNowTimestamp(), y: 0.0}
                ]
            }
        ],
        width: 300,
        height: 150,
        ticks: { time: 30 },
        tickFormats: {
            bottom: function (d) {
                return date2string(new Date(d * 1000));
            }
        },
        axes: ['left', 'bottom', 'right'],
        windowSize: 100,
        historySize: 20,
        queueSize: 60
    });
}

function createDispatcher(id, callback) {

    if (window["WebSocket"]) {

        var dispatcher = new WebSocketRails(window.location.host + '/websocket');
        var channel = dispatcher.subscribe("sensor-" + id);

        channel.bind('create', callback);
        channel.bind('update', callback);

    } else {
        alert("Your Browser does not support WebSocket.");
    }
}

function createHomeCharts() {

    var lineChart = createLineChart("lineChart");
    var gauge = createGauge("gauge", "Wasserkocher", "W");

    createDispatcher('00000000000000000000000000000000', function (measurement) {

        lineChart.push([
            {
                time: getNowTimestamp(),
                y: measurement.value
            }
        ]);
        gauge.refresh(Number(measurement.value).toFixed(1));
    });
}

function createSensorGauge(id, unit, min, max) {

        var gauge = createGauge("gauge" + id, null, unit, min, max);

        createDispatcher(id, function (measurement) {
            gauge.refresh(Number(measurement.value).toFixed(1));
        });
}
