
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

function createSensorGauge(sensorId, chartId, title, unit, min, max) {

    var gauge = createGauge(chartId, title, unit, min, max);

    createDispatcher(sensorId, function (measurement) {
        gauge.refresh(Number(measurement.value).toFixed(1));
    });
}

function createSensorLineChart(sensorId, chartId) {

    var chart = createLineChart(chartId);

    createDispatcher(sensorId, function (measurement) {

        chart.push([
            {
                time: getNowTimestamp(),
                y: measurement.value
            }
        ]);
    });
}

function createDashboardCharts() {

    createSensorLineChart("d4d4d4d4d4d4d4d4s1s1s1s1s1s1s1s1", "consumptionChart");
    createSensorLineChart("d4d4d4d4d4d4d4d4s2s2s2s2s2s2s2s2", "productionChart");
}

function createDemoCharts() {

    var sensorId = "d1d1d1d1d1d1d1d1s1s1s1s1s1s1s1s1";

    createSensorGauge(sensorId, "demoGauge", "Kettle", "W", 0, 600);
    createSensorLineChart(sensorId, "demoChart");
}