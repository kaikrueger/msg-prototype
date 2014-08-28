$(function () {

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

    function isBrowserIE() {

      if (navigator.appName == 'Microsoft Internet Explorer') {
        return true;

      } else if (navigator.appName == 'Netscape') {

        var re  = new RegExp("Trident/.*");
        if (re.exec(navigator.userAgent) != null) {
          return true;
        }
      }
      return false;
    }

    var browserIE = isBrowserIE();

    var now = Math.round(new Date() / 1000);
    var lineChart;

    if (!browserIE) {
      lineChart = $('#lineChart').epoch({
        type: 'time.line',
        label: "Frequency",
        data: [
            {
                label: 'Frequency',
                values: [
                    {time: now, y: 0.0}
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

    var gauge = new JustGage({
        id: "gauge",
        value: "0",
        min: 0,
        max: 1000,
        levelColors: [ "#2A4026", "#B6D96C", "#2A4026" ],
        levelColorsGradient: true,
        title: "Wasserkocher",
        label: "W"
    });

    if (window["WebSocket"]) {

        function updateCharts(measurement) {

            if (!browserIE) {
              var now = Math.round(new Date() / 1000);
              lineChart.push([
                  {time: now, y: measurement.value}
              ]);
            }
            gauge.refresh(Number(measurement.value).toFixed(1));
        }

        var dispatcher = new WebSocketRails(window.location.host + '/websocket');

        var channel = dispatcher.subscribe('measurements');

        channel.bind('create', updateCharts);
        channel.bind('update', updateCharts);

    } else {
        alert("Your Browser does not support WebSocket.");
    }
});
