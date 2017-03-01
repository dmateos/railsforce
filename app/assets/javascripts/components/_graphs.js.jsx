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
    console.log(this.props.options);
    return(
      <Chart container="chart" options={this.props.options} modules={[]}></Chart>
    )
  }
});
