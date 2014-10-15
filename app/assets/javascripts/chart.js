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
        titleFontColor: (name == null ? 'white' : 'gray'),
        label: unit
    });
}

function createLineChart(id, windowSize) {

    return $('#' + id).epoch({
        type: 'time.line',
        label: "Series",
        data: [
            {
                label: 'Series',
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
        windowSize: windowSize,
        historySize: windowSize,
        queueSize: windowSize
    });
}

function createDispatcher(id, onLoad, onUpdate, windowSize) {

    if (window["WebSocket"]) {

        var dispatcher = new WebSocketRails(window.location.host + '/websocket');

        var channel = dispatcher.subscribe('sensor-' + id);
        channel.bind('load', onLoad);
        channel.bind('create', onUpdate);
        channel.bind('update', onUpdate);

        var now = getNowTimestamp();

        dispatcher.trigger('measurements.load', {
            sensor_uuid: id,
            from: now - windowSize,
            to: now
        });

    } else {
        alert("Your Browser does not support WebSocket.");
    }
}

function createSensorGauge(sensorId, chartId, title, unit, min, max) {

    var gauge = createGauge(chartId, title, unit, min, max);

    var onLoad = function (measurements) {

        if (measurements.length > 0) {
            var timestamp = d3.max(d3.keys(measurements));
            gauge.refresh(Number(measurements[timestamp]).toFixed(1));
        }
    };

    var onUpdate = function (measurement) {
        gauge.refresh(Number(measurement.value).toFixed(1));
    };

    createDispatcher(sensorId, onLoad, onUpdate, 60 * 60);
}

function createSensorLineChart(sensorId, chartId) {

    var chart = createLineChart(chartId);

    var onLoad = function (measurements) {

        var values = [];
        for (var timestamp in measurements) {
            values.push({
                time: timestamp,
                y: parseFloat(measurements[timestamp])
            });
        }

        chart.update({
            data: {
                label: 'Frequency',
                values: values
            }
        });
    };

    var onUpdate = function (measurement) {
        chart.push([
            {
                time: getNowTimestamp(),
                y: measurement.value
            }
        ]);
    };

    createDispatcher(sensorId, onLoad, onUpdate, 60 * 60);
}

function createDemoCharts() {

    var sensorId = "d1d1d1d1d1d1d1d1s1s1s1s1s1s1s1s1";

    createSensorGauge(sensorId, "demoGauge", "Kettle", "W", 0, 600);
    createSensorLineChart(sensorId, "demoChart");
}