options = {
    chart: {
      type: 'area',
      plotBorderWidth: 0,
    },

    title: {
        text: 'Monthly Average Temperature',
        x: -20 //center
    },
    subtitle: {
        text: 'Source: WorldClimate.com',
        x: -20
    },
    xAxis: {
      type: 'datetime'
    },
    yAxis: {
      gridLineWidth: 0.3,
    },
    tooltip: {
        valueSuffix: '°C'
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
    },
    series: [{
        name: 'Tokyo',
        lineWidth: 2,
        data: [7.0, 6.9, 9.5, 10.0, 5.5]
    }]
}

var Chart = React.createClass({
  componentDidMount() {
    if (this.props.modules) {
      this.props.modules.forEach(function (module) {
        module(Highcharts);
      });
     }
    // Set container which the chart should render to.
    this.chart = new Highcharts[this.props.type || "Chart"](
      this.props.container,
      this.props.options
    );

    this.timer = setInterval(this.tick, 1000);
  },

  tick() {
    var series = this.chart.series[0];
    var x = (new Date()).getTime();
    var y = Math.round(series.data.slice(-1)[0]['y'] + (Math.random() * 10 * (Math.round(Math.random()) * 2 - 1)));
    if(y < 0)
      y = -y;
    series.addPoint([x, y], true, true);
  },

  //Destroy chart before unmount.
  componentWillUnmount() {
    this.chart.destroy();
  },

  //Create the div which the chart will be rendered to.
  render() {
    return (
      <div id={this.props.container}> </div>
    )
  }
});

var ChartContainer = React.createClass({
  render() {
    return(
      <Chart container="chart" options={options} modules={[]}></Chart>
    )
  }
});
